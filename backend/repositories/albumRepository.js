const { pool } = require("../database/db.js");

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
  createdAt: row.created_at,
  updatedAt: row.updated_at,
});

const createAlbum = async ({ title, description, thumbnail, year, director, musicDirector, starCast }) => {
  const [result] = await pool.execute(
    `INSERT INTO albums (title, description, thumbnail_id, thumbnail_url, year, director, music_director, star_cast)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
    [title, description, thumbnail?.id ?? null, thumbnail?.url ?? null, year ?? null, director ?? null, musicDirector ?? null, starCast ?? null]
  );

  return findAlbumById(result.insertId);
};

const findAlbumById = async (id) => {
  const [rows] = await pool.query(
    `SELECT id, title, description, thumbnail_id, thumbnail_url, year, director, music_director, star_cast, created_at, updated_at
     FROM albums WHERE id = ? LIMIT 1`,
    [id]
  );

  return rows[0] ? mapAlbumRow(rows[0]) : null;
};

const getAllAlbums = async () => {
  const [rows] = await pool.query(
    `SELECT id, title, description, thumbnail_id, thumbnail_url, year, director, music_director, star_cast, created_at, updated_at
     FROM albums ORDER BY created_at DESC`
  );

  return rows.map(mapAlbumRow);
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
const getLatestAlbumsSmart = async (limit = 10) => {
  // Get the max year
  const [maxYearResult] = await pool.query(
    `SELECT MAX(year) as maxYear FROM albums WHERE year IS NOT NULL`
  );
  const maxYear = maxYearResult[0]?.maxYear;
  
  if (!maxYear) {
    return { albums: [], maxYear: null, currentYear: new Date().getFullYear() };
  }

  const currentYear = new Date().getFullYear();
  const yearsToFetch = maxYear === currentYear ? [maxYear] : [maxYear, maxYear - 1];

  const [rows] = await pool.query(
    `SELECT DISTINCT a.id, a.title, a.description, a.thumbnail_id, a.thumbnail_url, a.year
     FROM albums a
     INNER JOIN songs s ON a.id = s.album_id
     WHERE a.year IN (?) AND s.audio_url IS NOT NULL
     ORDER BY a.year DESC, a.created_at DESC 
     LIMIT ?`,
    [yearsToFetch, limit]
  );

  return {
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
};

const getAlbumsPaginated = async (page = 1, limit = 12) => {
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

  return {
    data: albumsData,
    pagination: {
      page,
      limit,
      total,
      pages: Math.ceil(total / limit),
    },
  };
};

// Optimized search - returns only essential data for search functionality including thumbnails
const getAlbumsForSearch = async () => {
  const [rows] = await pool.query(
    `SELECT id, title, description, thumbnail_id, thumbnail_url, year FROM albums ORDER BY title ASC`
  );

  return rows.map(row => ({
    _id: row.id,
    title: row.title,
    description: row.description,
    year: row.year,
    thumbnail: {
      id: row.thumbnail_id,
      url: row.thumbnail_url,
    },
  }));
};

module.exports = {
  createAlbum,
  findAlbumById,
  getAllAlbums,
  getLatestAlbums,
  getLatestAlbumsSmart,
  getAlbumsPaginated,
  getAlbumsForSearch,
};
