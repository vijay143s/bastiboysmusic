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
     VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING id`,
    [title, description, thumbnail?.id ?? null, thumbnail?.url ?? null, year ?? null, director ?? null, musicDirector ?? null, starCast ?? null]
  );

  return findAlbumById(result[0].id);
};

const findAlbumById = async (id) => {
  const [rows] = await pool.query(
    `SELECT id, title, description, thumbnail_id, thumbnail_url, year, director, music_director, star_cast, created_at, updated_at
     FROM albums WHERE id = $1 LIMIT 1`,
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
    `SELECT id, title, description, thumbnail_id, thumbnail_url
     FROM albums WHERE year = $1 ORDER BY created_at DESC LIMIT $2`,
    [year, limit]
  );

  return rows.map(row => ({
    id: row.id,
    title: row.title,
    description: row.description,
    thumbnail: {
      id: row.thumbnail_id,
      url: row.thumbnail_url,
    },
  }));
};

const getAlbumsByYearValue = async (year, limit = 50) => {
  const [rows] = await pool.query(
    `SELECT id, title, description, thumbnail_id, thumbnail_url, year
     FROM albums WHERE year = $1 ORDER BY title ASC LIMIT $2`,
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

const getAlbumsPaginated = async (page = 1, limit = 12) => {
  const offset = (page - 1) * limit;
  const [rows] = await pool.query(
    `SELECT id, title, description, thumbnail_id, thumbnail_url
     FROM albums ORDER BY created_at DESC LIMIT $1 OFFSET $2`,
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
    `SELECT id, title, description, thumbnail_id, thumbnail_url FROM albums ORDER BY title ASC`
  );

  return rows.map(row => ({
    _id: row.id,
    title: row.title,
    description: row.description,
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
  getAlbumsByYearValue,
  getAlbumsPaginated,
  getAlbumsForSearch,
};
