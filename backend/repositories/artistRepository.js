const { pool } = require("../database/db.js");
const { cacheManager } = require("../utils/cacheManager.js");

const mapArtistRow = (row) => ({
  artistId: row.artist_id,
  artistName: row.artist_name,
  albumId: row.album_id,
  albumName: row.album_name,
  createdAt: row.created_at,
  updatedAt: row.updated_at,
});

const createArtist = async ({ artistName, albumId, albumName }) => {
  const [result] = await pool.execute(
    `INSERT INTO artists (artist_name, album_id, album_name)
     VALUES (?, ?, ?)`,
    [artistName, albumId, albumName]
  );

  return findArtistById(result.insertId);
};

const findArtistById = async (artistId) => {
  const [rows] = await pool.query(
    `SELECT artist_id, artist_name, album_id, album_name
     FROM artists WHERE artist_id = ? LIMIT 1`,
    [artistId]
  );

  return rows[0] ? mapArtistRow(rows[0]) : null;
};

const getArtistsByAlbum = async (albumId) => {
  const [rows] = await pool.query(
    `SELECT artist_id, artist_name, album_id, album_name, created_at, updated_at
     FROM artists WHERE album_id = ? ORDER BY created_at DESC`,
    [albumId]
  );

  return rows.map(mapArtistRow);
};


const getAlbumsByArtist = async (artistId) => {
  // Get the artist name for any artist_id that matches this artist
  // This handles the case where MIN(artist_id) is used in listings
  const [artistRows] = await pool.query(
    `SELECT DISTINCT artist_name 
     FROM artists 
     WHERE artist_id = ? 
        OR artist_name IN (SELECT artist_name FROM artists WHERE artist_id = ?) 
     LIMIT 1`,
    [artistId, artistId]
  );
  
  if (!artistRows.length) {
    return [];
  }
  
  const artistName = artistRows[0].artist_name;
  
  // Then get all albums by this artist name
  const [rows] = await pool.query(
    `SELECT DISTINCT a.id, a.title, a.description, a.thumbnail_id, a.thumbnail_url, a.year, a.director, a.music_director, a.star_cast, a.created_at, a.updated_at
     FROM albums a 
     INNER JOIN artists ar ON a.id = ar.album_id 
     WHERE ar.artist_name = ? 
     ORDER BY a.year DESC, a.created_at DESC`,
    [artistName]
  );

  return rows.map(row => ({
    id: row.id,
    title: row.title,
    description: row.description,
    thumbnail: {
      id: row.thumbnail_id,
      url: row.thumbnail_url,
    },
    year: row.year,
    director: row.director,
    musicDirector: row.music_director,
    starCast: row.star_cast,
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  }));
};

const getAllArtists = async () => {
  const [rows] = await pool.query(
    `SELECT artist_id, artist_name, album_id, album_name
     FROM artists order BY artist_name `
  );

  return rows.map(mapArtistRow);
};

const updateArtist = async (artistId, { artistName, albumName }) => {
  await pool.execute(
    `UPDATE artists SET artist_name = ?, album_name = ?, updated_at = NOW() WHERE artist_id = ?`,
    [artistName, albumName, artistId]
  );

  return findArtistById(artistId);
};

const deleteArtistById = async (artistId) => {
  await pool.execute(`DELETE FROM artists WHERE artist_id = ?`, [artistId]);
};

const deleteArtistsByAlbum = async (albumId) => {
  await pool.execute(`DELETE FROM artists WHERE album_id = ?`, [albumId]);
};

const getTopArtists = async (limit = 10, language = null) => {
  // Generate cache key
  const cacheKey = cacheManager.generateKey('artists:top', { limit, language: language || 'all' });
  
  // Check cache
  const cached = cacheManager.get(cacheKey);
  if (cached) {
    return cached;
  }

  let query = `SELECT MIN(a.artist_id) as artistId, a.artist_name, COUNT(*) as album_count
     FROM artists a`;
  let params = [];
  
  if (language) {
    query += ` LEFT JOIN albums alb ON a.album_id = alb.id
     WHERE alb.language = ?`;
    params.push(language);
  }
  
  query += ` GROUP BY a.artist_name ORDER BY album_count DESC LIMIT ?`;
  params.push(limit);
  
  const [rows] = await pool.query(query, params);

  const result = rows.map(row => ({
    artistId: row.artistId,
    artistName: row.artist_name,
    albumCount: row.album_count,
  }));
  
  // Cache for 2 hours
  cacheManager.set(cacheKey, result, 2 * 60 * 60 * 1000);

  return result;
};

const getArtistsPaginated = async (page = 1, limit = 12) => {
  const offset = (page - 1) * limit;
  const [rows] = await pool.query(
    `SELECT MIN(artist_id) as artist_id, artist_name, COUNT(*) as album_count
     FROM artists GROUP BY artist_name ORDER BY artist_name LIMIT ? OFFSET ?`,
    [limit, offset]
  );

  const [countResult] = await pool.query(
    `SELECT COUNT(DISTINCT artist_name) as total FROM artists`
  );
  const total = countResult[0].total;

  return {
    data: rows.map(row => ({
      artistId: row.artist_id,
      artistName: row.artist_name,
      albumCount: row.album_count,
    })),
    pagination: {
      page,
      limit,
      total,
      pages: Math.ceil(total / limit),
    },
  };
};

// Optimized search - returns only essential data for search functionality
// Supports optional query and limit with relevance ordering
const getArtistsForSearch = async (query = null, limit = null) => {
  if (query && typeof query === 'string' && query.trim().length > 0) {
    const q = `%${query.trim()}%`;
    const [rows] = await pool.query(
      `SELECT MIN(artist_id) as artist_id, artist_name,
              CASE 
                WHEN LOWER(artist_name) = LOWER(?) THEN 0
                WHEN LOWER(artist_name) LIKE LOWER(CONCAT(?, '%')) THEN 1
                WHEN LOWER(artist_name) LIKE LOWER(?) THEN 2
                ELSE 3
              END AS relevance
       FROM artists 
       WHERE artist_name LIKE ?
       GROUP BY artist_name 
       ORDER BY relevance ASC, artist_name ASC
       ${limit ? 'LIMIT ?' : ''}`,
      limit ? [query.trim(), query.trim(), q, q, limit] : [query.trim(), query.trim(), q, q]
    );

    return rows.map(row => ({
      artistId: row.artist_id,
      artistName: row.artist_name,
    }));
  }

  const [rows] = await pool.query(
    `SELECT MIN(artist_id) as artist_id, artist_name 
     FROM artists GROUP BY artist_name ORDER BY artist_name ASC`
  );

  return rows.map(row => ({
    artistId: row.artist_id,
    artistName: row.artist_name,
  }));
};

module.exports = {
  createArtist,
  findArtistById,
  getArtistsByAlbum,
  getAllArtists,
  updateArtist,
  deleteArtistById,
  deleteArtistsByAlbum,
  getAlbumsByArtist,
  getTopArtists,
  getArtistsPaginated,
  getArtistsForSearch,
};
