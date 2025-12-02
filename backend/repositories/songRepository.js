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
    `SELECT s.id, s.title, s.description, s.singer, s.thumbnail_id, s.thumbnail_url, s.audio_id, s.audio_url, s.album_id, s.created_at, s.updated_at
     FROM songs s
     LEFT JOIN albums a ON s.album_id = a.id
     WHERE s.audio_url IS NOT NULL 
     ORDER BY a.year DESC, s.created_at DESC`
  );

  return rows.map(mapSongRow);
};

const getSongsByAlbum = async (albumId) => {
  const [rows] = await pool.query(
    `SELECT s.id, s.title, s.description, s.singer, s.thumbnail_id, s.thumbnail_url, s.audio_id, s.audio_url, s.album_id, s.created_at, s.updated_at
     FROM songs s
     LEFT JOIN albums a ON s.album_id = a.id
     WHERE s.album_id = ? AND s.audio_url IS NOT NULL 
     ORDER BY a.year DESC, s.created_at DESC`,
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
    `SELECT s.id, s.title, s.description, s.singer, s.thumbnail_id, s.thumbnail_url, s.audio_id, s.audio_url, s.album_id, s.created_at, s.updated_at
     FROM songs s
     LEFT JOIN albums a ON s.album_id = a.id
     WHERE (s.singer = ? OR FIND_IN_SET(?, s.singer) > 0) AND s.audio_url IS NOT NULL 
     ORDER BY a.year DESC, s.created_at DESC`,
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
    WHERE s.audio_url IS NOT NULL
    ORDER BY a.year DESC, s.created_at DESC
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
    SELECT DISTINCT YEAR(created_at) as year 
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
      a.title as album_name,
      a.year
    FROM songs s
    LEFT JOIN albums a ON s.album_id = a.id
    WHERE YEAR(s.created_at) = ? AND s.audio_url IS NOT NULL
    ORDER BY a.year DESC, s.created_at DESC
    LIMIT ? OFFSET ?
  `, [year, limit, offset]);

  // Get total count for this year
  const [countResult] = await pool.query(`
    SELECT COUNT(*) as total
    FROM songs s
    WHERE YEAR(s.created_at) = ? AND s.audio_url IS NOT NULL
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

// Update play count for a song
const incrementPlayCount = async (songId) => {
  await pool.execute(
    `UPDATE songs SET play_count = COALESCE(play_count, 0) + 1 WHERE id = ?`,
    [songId]
  );
};

// Get top played songs
const getTopPlayedSongs = async (limit = 20, offset = 0) => {
  const [rows] = await pool.query(`
    SELECT 
      s.id, 
      s.title, 
      s.singer,
      s.thumbnail_url,
      s.album_id,
      s.play_count,
      a.title as album_name,
      a.year as album_year
    FROM songs s
    LEFT JOIN albums a ON s.album_id = a.id
    WHERE s.audio_url IS NOT NULL
    ORDER BY s.play_count DESC, a.year DESC
    LIMIT ? OFFSET ?
  `, [limit, offset]);

  const [countResult] = await pool.query(`SELECT COUNT(*) as total FROM songs WHERE audio_url IS NOT NULL`);
  const total = countResult[0].total;

  return {
    songs: rows.map(row => ({
      _id: row.id,
      id: row.id,
      title: row.title,
      singer: row.singer,
      thumbnail: {
        url: row.thumbnail_url
      },
      album: row.album_id,
      albumName: row.album_name,
      albumYear: row.album_year,
      playCount: row.play_count || 0
    })),
    total,
    hasMore: offset + rows.length < total,
    nextOffset: offset + rows.length
  };
};

// Get top years by song/album count
const getTopYears = async () => {
  const [rows] = await pool.query(`
    SELECT 
      a.year,
      COUNT(DISTINCT a.id) as album_count,
      COUNT(s.id) as song_count
    FROM albums a
    LEFT JOIN songs s ON s.album_id = a.id
    WHERE a.year IS NOT NULL
    GROUP BY a.year
    ORDER BY song_count DESC, album_count DESC
    LIMIT 10
  `);

  return rows.map(row => ({
    year: row.year,
    albumCount: row.album_count,
    songCount: row.song_count
  }));
};

// Get albums by year with songs
const getAlbumsByYear = async (year) => {
  const [albums] = await pool.query(`
    SELECT 
      a.id,
      a.title,
      a.description,
      a.thumbnail_url,
      a.year,
      a.director,
      a.music_director,
      a.star_cast
    FROM albums a
    WHERE a.year = ?
    ORDER BY a.title ASC
  `, [year]);

  // Get songs for each album
  const albumsWithSongs = await Promise.all(
    albums.map(async (album) => {
      const [songs] = await pool.query(`
        SELECT 
          s.id,
          s.title,
          s.singer,
          s.thumbnail_url,
          s.audio_url,
          s.play_count
        FROM songs s
        LEFT JOIN albums a ON s.album_id = a.id
        WHERE s.album_id = ? AND s.audio_url IS NOT NULL
        ORDER BY a.year DESC, s.title ASC
      `, [album.id]);

      return {
        _id: album.id,
        id: album.id,
        title: album.title,
        description: album.description,
        thumbnail: {
          url: album.thumbnail_url
        },
        year: album.year,
        director: album.director,
        musicDirector: album.music_director,
        starCast: album.star_cast,
        songs: songs.map(song => ({
          _id: song.id,
          id: song.id,
          title: song.title,
          singer: song.singer,
          thumbnail: {
            url: song.thumbnail_url
          },
          audio: {
            url: song.audio_url
          },
          playCount: song.play_count || 0
        }))
      };
    })
  );

  return albumsWithSongs;
};

// Get queue songs ordered by year with batch loading
const getQueueSongsByYearBatch = async (limit = 1000, offset = 0) => {
  const [rows] = await pool.query(`
    SELECT 
      s.id, 
      s.title, 
      s.singer,
      s.thumbnail_url,
      s.audio_url,
      s.album_id,
      a.title as album_name,
      a.year
    FROM songs s
    LEFT JOIN albums a ON s.album_id = a.id
    WHERE s.audio_url IS NOT NULL
    ORDER BY a.year DESC, s.created_at DESC
    LIMIT ? OFFSET ?
  `, [limit, offset]);

  const [countResult] = await pool.query(`SELECT COUNT(*) as total FROM songs WHERE audio_url IS NOT NULL`);
  const total = countResult[0].total;

  return {
    songs: rows.map(row => ({
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
      album: row.album_id,
      albumName: row.album_name,
      year: row.year
    })),
    total,
    hasMore: offset + rows.length < total,
    nextOffset: offset + rows.length
  };
};

// Search songs across all fields
const searchSongs = async (searchTerm, limit = 50, offset = 0, year = null) => {
  const searchPattern = `%${searchTerm}%`;
  
  try {
    // Build WHERE clause with enhanced search (title, description, singer, album name, year)
    let whereClause = `WHERE s.audio_url IS NOT NULL AND (
      s.title LIKE ? OR 
      s.description LIKE ? OR 
      s.singer LIKE ? OR 
      a.title LIKE ? OR 
      a.year LIKE ?
    )`;
    const params = [searchPattern, searchPattern, searchPattern, searchPattern, searchPattern];
    
    if (year) {
      whereClause += ` AND a.year = ?`;
      params.push(year);
    }

    // Enhanced search query with album name and year search
    const searchQuery = `
      SELECT s.id as _id, s.title, s.description as artist, s.singer,
             s.thumbnail_url as thumbnail, s.audio_url as audio, s.album_id as album,
             a.title as albumName, a.year, s.created_at as createdAt, s.updated_at as updatedAt
      FROM songs s 
      LEFT JOIN albums a ON s.album_id = a.id
      ${whereClause}
      ORDER BY a.year DESC, s.created_at DESC
      LIMIT ? OFFSET ?
    `;
    
    // Count query for total results
    const countQuery = `
      SELECT COUNT(*) as total
      FROM songs s 
      LEFT JOIN albums a ON s.album_id = a.id
      ${whereClause}
    `;
    
    const searchParams = [...params, limit, offset];
    const [rows] = await pool.execute(searchQuery, searchParams);
    
    const [totalResult] = await pool.execute(countQuery, params);
    
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
  findSongByIdForPlayer,
  searchSongs,
  incrementPlayCount,
  getTopPlayedSongs,
  getTopYears,
  getAlbumsByYear,
  getQueueSongsByYearBatch,
};
