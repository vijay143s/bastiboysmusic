const { pool } = require("../database/db.js");
const { cacheManager } = require("../utils/cacheManager.js");

const mapAlbumRow = (row) => ({
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
  language: row.language,
  createdAt: row.created_at,
  updatedAt: row.updated_at,
});

const createAlbum = async ({ title, description, thumbnail, year, director, musicDirector, starCast, language }) => {
  const [result] = await pool.execute(
    `INSERT INTO albums (title, description, thumbnail_id, thumbnail_url, year, director, music_director, star_cast, language)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
    [title, description, thumbnail?.id ?? null, thumbnail?.url ?? null, year ?? null, director ?? null, musicDirector ?? null, starCast ?? null, language ?? null]
  );

  // Invalidate caches when new album is added
  cacheManager.invalidateAlbumsCaches();
  cacheManager.invalidateArtistsCaches();
  cacheManager.invalidateDirectorsCaches();

  return findAlbumById(result.insertId);
};

const findAlbumById = async (id) => {
  const [rows] = await pool.query(
    `SELECT id, title, description, thumbnail_id, thumbnail_url, year, director, music_director, star_cast, language, created_at, updated_at
     FROM albums WHERE id = ? LIMIT 1`,
    [id]
  );

  return rows[0] ? mapAlbumRow(rows[0]) : null;
};

const getAllAlbums = async (language = null) => {
  // Generate cache key
  const cacheKey = cacheManager.generateKey('albums:all', { language: language || 'all' });

  // Check cache first
  const cached = cacheManager.get(cacheKey);
  if (cached) {
    return cached;
  }

  let query = `SELECT id, title, description, thumbnail_id, thumbnail_url, year, director, music_director, star_cast, language, created_at, updated_at
     FROM albums`;
  const params = [];

  if (language) {
    query += ` WHERE language = ?`;
    params.push(language);
  }

  query += ` ORDER BY created_at DESC`;

  const [rows] = await pool.query(query, params);
  const result = rows.map(mapAlbumRow);

  // Cache for 1 hour
  cacheManager.set(cacheKey, result, 60 * 60 * 1000);

  return result;
};

const getLatestAlbums = async (year, limit = 10) => {
  const [rows] = await pool.query(
    `SELECT id, title, description, thumbnail_id, thumbnail_url, year
     FROM albums WHERE year = ? ORDER BY created_at DESC LIMIT ?`,
    [year, limit]
  );

  return rows.map(row => ({
    id: row.id,
    title: row.title,
    description: row.description,
    year: row.year,
    thumbnail: {
      id: row.thumbnail_id,
      url: row.thumbnail_url,
    },
  }));
};

// Get albums from max year and previous year (for Latest Albums section)
const getLatestAlbumsSmart = async (limit = 10, language = null) => {
  // Generate cache key
  const cacheKey = cacheManager.generateKey('albums:latest-smart', { limit, language: language || 'all' });

  // Check cache
  const cached = cacheManager.get(cacheKey);
  if (cached) {
    return cached;
  }

  // Get the max year
  let maxYearQuery = `SELECT MAX(year) as maxYear FROM albums WHERE year IS NOT NULL`;
  let maxYearParams = [];

  if (language) {
    maxYearQuery += ` AND language = ?`;
    maxYearParams.push(language);
  }

  const [maxYearResult] = await pool.query(maxYearQuery, maxYearParams);
  const maxYear = maxYearResult[0]?.maxYear;

  if (!maxYear) {
    return { albums: [], maxYear: null, currentYear: new Date().getFullYear() };
  }

  const currentYear = new Date().getFullYear();
  const yearsToFetch = maxYear === currentYear ? [maxYear] : [maxYear, maxYear - 1];

  let query = `SELECT DISTINCT a.id, a.title, a.description, a.thumbnail_id, a.thumbnail_url, a.year
     FROM albums a
     INNER JOIN songs s ON a.id = s.album_id
     WHERE a.year IN (?) AND s.audio_url IS NOT NULL`;
  let params = [yearsToFetch];

  if (language) {
    query += ` AND a.language = ?`;
    params.push(language);
  }

  query += ` ORDER BY a.year DESC, a.created_at DESC 
     LIMIT ?`;
  params.push(limit);

  const [rows] = await pool.query(query, params);

  const result = {
    albums: rows.map(row => ({
      id: row.id,
      title: row.title,
      description: row.description,
      year: row.year,
      thumbnail: {
        id: row.thumbnail_id,
        url: row.thumbnail_url,
      },
    })),
    maxYear,
    currentYear,
    years: yearsToFetch
  };

  // Cache for 1 hour
  cacheManager.set(cacheKey, result, 60 * 60 * 1000);

  return result;
};

const getAlbumsPaginated = async (page = 1, limit = 12) => {
  // Try to get from cache
  const cacheKey = cacheManager.generateKey('albums:paginated', { page, limit });
  const cached = cacheManager.get(cacheKey);

  if (cached) {
    return cached;
  }

  const offset = (page - 1) * limit;
  const [rows] = await pool.query(
    `SELECT id, title, description, thumbnail_id, thumbnail_url
     FROM albums ORDER BY created_at DESC LIMIT ? OFFSET ?`,
    [limit, offset]
  );

  // Map rows with only essential fields for listing
  const albumsData = rows.map(row => ({
    id: row.id,
    title: row.title,
    description: row.description,
    thumbnail: {
      id: row.thumbnail_id,
      url: row.thumbnail_url,
    },
  }));

  const [countResult] = await pool.query(`SELECT COUNT(*) as total FROM albums`);
  const total = countResult[0].total;

  const result = {
    data: albumsData,
    pagination: {
      page,
      limit,
      total,
      pages: Math.ceil(total / limit),
    },
  };

  // Cache for 30 seconds (high traffic list)
  cacheManager.set(cacheKey, result, 30 * 1000);

  return result;
};

// Optimized search - returns only essential data for search functionality including thumbnails
const getAlbumsForSearch = async () => {
  const cacheKey = 'albums:search:all';
  const cached = cacheManager.get(cacheKey);

  if (cached) {
    return cached;
  }

  const [rows] = await pool.query(
    `SELECT id, title, description, thumbnail_id, thumbnail_url, year FROM albums ORDER BY title ASC`
  );

  const result = rows.map(row => ({
    _id: row.id,
    title: row.title,
    description: row.description,
    year: row.year,
    thumbnail: {
      id: row.thumbnail_id,
      url: row.thumbnail_url,
    },
  }));

  // Cache for 1 hour (search data changes infrequently)
  cacheManager.set(cacheKey, result, 60 * 60 * 1000);

  return result;
};

// Get distinct languages from albums
const getDistinctLanguages = async () => {
  const [rows] = await pool.query(
    `SELECT DISTINCT language FROM albums WHERE language IS NOT NULL ORDER BY language ASC`
  );

  return rows.map(row => row.language).filter(lang => lang !== null && lang !== '');
};

module.exports = {
  createAlbum,
  findAlbumById,
  getAllAlbums,
  getLatestAlbums,
  getLatestAlbumsSmart,
  getAlbumsPaginated,
  getAlbumsForSearch,
  getDistinctLanguages,
};
