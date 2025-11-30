const { pool } = require("../database/db.js");

const mapAlbumRow = (row) => ({
  id: row.id,
  title: row.title,
  description: row.description,
  thumbnail: {
    id: row.thumbnail_id,
    url: row.thumbnail_url,
  },
  createdAt: row.created_at,
  updatedAt: row.updated_at,
});

const createAlbum = async ({ title, description, thumbnail }) => {
  const [result] = await pool.execute(
    `INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
     VALUES (?, ?, ?, ?)`,
    [title, description, thumbnail?.id ?? null, thumbnail?.url ?? null]
  );

  return findAlbumById(result.insertId);
};

const findAlbumById = async (id) => {
  const [rows] = await pool.query(
    `SELECT id, title, description, thumbnail_id, thumbnail_url, created_at, updated_at
     FROM albums WHERE id = ? LIMIT 1`,
    [id]
  );

  return rows[0] ? mapAlbumRow(rows[0]) : null;
};

const getAllAlbums = async () => {
  const [rows] = await pool.query(
    `SELECT id, title, description, thumbnail_id, thumbnail_url, created_at, updated_at
     FROM albums ORDER BY created_at DESC`
  );

  return rows.map(mapAlbumRow);
};

module.exports = {
  createAlbum,
  findAlbumById,
  getAllAlbums,
};
