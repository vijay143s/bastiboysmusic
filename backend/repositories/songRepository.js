const { pool } = require("../database/db.js");

const mapSongRow = (row) => ({
  id: row.id,
  title: row.title,
  description: row.description,
  singer: row.singer,
  thumbnail: {
    id: row.thumbnail_id,
    url: row.thumbnail_url,
  },
  audio: {
    id: row.audio_id,
    url: row.audio_url,
  },
  albumId: row.album_id,
  createdAt: row.created_at,
  updatedAt: row.updated_at,
});

const createSong = async ({
  title,
  description,
  singer,
  thumbnail,
  audio,
  albumId,
}) => {
  const [result] = await pool.execute(
    `INSERT INTO songs (title, description, singer, thumbnail_id, thumbnail_url, audio_id, audio_url, album_id)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?)` ,
    [
      title,
      description,
      singer,
      thumbnail?.id ?? null,
      thumbnail?.url ?? null,
      audio?.id ?? null,
      audio?.url ?? null,
      albumId,
    ]
  );

  return findSongById(result.insertId);
};

const updateSongThumbnail = async (songId, thumbnail) => {
  await pool.execute(
    `UPDATE songs SET thumbnail_id = ?, thumbnail_url = ?, updated_at = NOW() WHERE id = ?`,
    [thumbnail?.id ?? null, thumbnail?.url ?? null, songId]
  );

  return findSongById(songId);
};

const getAllSongs = async () => {
  const [rows] = await pool.query(
    `SELECT id, title, description, singer, thumbnail_id, thumbnail_url, audio_id, audio_url, album_id, created_at, updated_at
     FROM songs ORDER BY created_at DESC`
  );

  return rows.map(mapSongRow);
};

const getSongsByAlbum = async (albumId) => {
  const [rows] = await pool.query(
    `SELECT id, title, description, singer, thumbnail_id, thumbnail_url, audio_id, audio_url, album_id, created_at, updated_at
     FROM songs WHERE album_id = ? ORDER BY created_at DESC`,
    [albumId]
  );

  return rows.map(mapSongRow);
};

const findSongById = async (id) => {
  const [rows] = await pool.query(
    `SELECT id, title, description, singer, thumbnail_id, thumbnail_url, audio_id, audio_url, album_id, created_at, updated_at
     FROM songs WHERE id = ? LIMIT 1`,
    [id]
  );

  return rows[0] ? mapSongRow(rows[0]) : null;
};

const deleteSongById = async (id) => {
  await pool.execute(`DELETE FROM songs WHERE id = ?`, [id]);
};

const getSongsBySinger = async (singerName) => {
  const [rows] = await pool.query(
    `SELECT id, title, description, singer, thumbnail_id, thumbnail_url, audio_id, audio_url, album_id, created_at, updated_at
     FROM songs 
     WHERE singer = ? 
       OR EXISTS (
         SELECT 1 
         FROM unnest(string_to_array(COALESCE(singer, ''), ',')) AS value
         WHERE trim(value) = trim(?)
       )
     ORDER BY created_at DESC`,
    [singerName, singerName]
  );

  return rows.map(mapSongRow);
};

// Optimized function for queue - only returns essential data
const getQueueSongs = async () => {
  const [rows] = await pool.query(`
    SELECT 
      s.id, 
      s.title, 
      s.singer,
      s.thumbnail_url,
      s.album_id,
      a.title as album_name
    FROM songs s
    LEFT JOIN albums a ON s.album_id = a.id
    ORDER BY s.created_at DESC
  `);

  return rows.map(row => ({
    _id: row.id,
    title: row.title,
    singer: row.singer,
    thumbnail: {
      url: row.thumbnail_url
    },
    album: row.album_id, // Keep the album ID for compatibility
    albumName: row.album_name // Add album name directly
  }));
};

// Get available years for pagination
const getAvailableYears = async () => {
  const [rows] = await pool.query(`
    SELECT DISTINCT EXTRACT(YEAR FROM created_at)::int as year 
    FROM songs 
    ORDER BY year DESC
  `);

  return rows.map(row => row.year);
};

// Year-based paginated queue function with offset support
const getQueueSongsByYear = async (year, limit = 50, offset = 0) => {
  const [rows] = await pool.query(`
    SELECT 
      s.id, 
      s.title, 
      s.singer,
      s.thumbnail_url,
      s.album_id,
      s.created_at,
      a.title as album_name
    FROM songs s
    LEFT JOIN albums a ON s.album_id = a.id
    WHERE EXTRACT(YEAR FROM s.created_at)::int = ?
    ORDER BY s.created_at DESC
    LIMIT ? OFFSET ?
  `, [year, limit, offset]);

  // Get total count for this year
  const [countResult] = await pool.query(`
    SELECT COUNT(*) as total
    FROM songs s
    WHERE EXTRACT(YEAR FROM s.created_at)::int = ?
  `, [year]);

  const total = countResult[0].total;

  return {
    year: year,
    songs: rows.map(row => ({
      _id: row.id,
      title: row.title,
      singer: row.singer,
      thumbnail: {
        url: row.thumbnail_url
      },
      album: row.album_id,
      albumName: row.album_name,
      createdAt: row.created_at
    })),
    count: rows.length,
    total: total,
    hasMore: offset + rows.length < total,
    nextOffset: offset + rows.length
  };
};

// Optimized function for single song player - only returns essential playback data
const findSongByIdForPlayer = async (id) => {
  const [rows] = await pool.query(`
    SELECT 
      s.id,
      s.title,
      s.singer,
      s.thumbnail_url,
      s.audio_url,
      s.album_id
    FROM songs s
    WHERE s.id = ? LIMIT 1
  `, [id]);

  if (!rows[0]) return null;

  const row = rows[0];
  return {
    _id: row.id,
    id: row.id,
    title: row.title,
    singer: row.singer,
    thumbnail: {
      url: row.thumbnail_url
    },
    audio: {
      url: row.audio_url
    },
    album: String(row.album_id)
  };
};

// Search songs across all fields
const searchSongs = async (searchTerm, limit = 50, offset = 0) => {
  const searchPattern = `%${searchTerm}%`;
  
  try {
    // Simplified search query matching the existing structure used in getQueueSongs
    const searchQuery = `
      SELECT s.id as _id, s.title, s.description as artist, s.singer,
             s.thumbnail_url as thumbnail, s.audio_url as audio, s.album_id as album,
             s.created_at as createdAt, s.updated_at as updatedAt
      FROM songs s 
      WHERE s.title LIKE ? 
         OR s.description LIKE ? 
         OR s.singer LIKE ?
      ORDER BY s.created_at DESC
      LIMIT ? OFFSET ?
    `;
    
    // Count query for total results
    const countQuery = `
      SELECT COUNT(*) as total
      FROM songs s 
      WHERE s.title LIKE ? 
         OR s.description LIKE ? 
         OR s.singer LIKE ?
    `;
    
    const [rows] = await pool.execute(searchQuery, [
      searchPattern, searchPattern, searchPattern, // for WHERE clause
      limit, offset
    ]);
    
    const [totalResult] = await pool.execute(countQuery, [
      searchPattern, searchPattern, searchPattern
    ]);
    
    const hasMore = offset + limit < totalResult[0].total;
    
    return {
      songs: rows,
      total: totalResult[0].total,
      hasMore,
      nextOffset: hasMore ? offset + limit : null
    };
  } catch (error) {
    console.error('Search songs error:', error);
    throw error;
  }
};

// Get top years with song counts for Years section
const getTopYears = async (limit = 10) => {
  const [rows] = await pool.execute(`
    SELECT 
      a.year as year,
      COUNT(s.id) as songCount
    FROM songs s
    INNER JOIN albums a ON s.album_id = a.id
    WHERE a.year IS NOT NULL AND a.year > 0
    GROUP BY a.year
    ORDER BY a.year DESC, songCount DESC
    LIMIT ?
  `, [limit]);

  return rows.map(row => ({
    year: row.year,
    songCount: row.songCount
  }));
};

// Get songs by year with pagination for Years section
const getSongsByYear = async (year, page = 1, limit = 20) => {
  const offset = (page - 1) * limit;
  
  const [rows] = await pool.execute(`
    SELECT 
      s.id, s.title, s.description, s.singer, s.thumbnail_id, s.thumbnail_url, 
      s.audio_id, s.audio_url, s.album_id, s.created_at, s.updated_at,
      a.title as album_name, a.year as album_year
    FROM songs s
    INNER JOIN albums a ON s.album_id = a.id
    WHERE a.year = ?
    ORDER BY s.created_at DESC
    LIMIT ? OFFSET ?
  `, [year, limit, offset]);

  // Get total count for this year
  const [countRows] = await pool.execute(`
    SELECT COUNT(*) as total
    FROM songs s
    INNER JOIN albums a ON s.album_id = a.id
    WHERE a.year = ?
  `, [year]);

  const total = countRows[0].total;
  const totalPages = Math.ceil(total / limit);
  const hasNext = page < totalPages;
  const hasPrev = page > 1;

  return {
    data: rows.map(row => ({ 
      _id: row.id,
      title: row.title,
      singer: row.singer,
      thumbnail: {
        url: row.thumbnail_url
      },
      album: row.album_id,
      albumName: row.album_name,
      createdAt: row.created_at
    })),
    pagination: {
      currentPage: page,
      totalPages: totalPages,
      totalItems: total,
      hasNext: hasNext,
      hasPrev: hasPrev,
      limit: limit
    }
  };
};

module.exports = {
  createSong,
  updateSongThumbnail,
  getAllSongs,
  getSongsByAlbum,
  findSongById,
  deleteSongById,
  getSongsBySinger,
  getQueueSongs,
  getAvailableYears,
  getQueueSongsByYear,
  getTopYears,
  getSongsByYear,
  findSongByIdForPlayer,
  searchSongs,
};
