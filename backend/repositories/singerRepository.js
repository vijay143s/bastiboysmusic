const { pool } = require("../database/db.js");

const mapSingerRow = (row) => ({
  singerId: row.singer_id,
  singerName: row.singer_name
});

const createSinger = async ({ singerName }) => {
  const [result] = await pool.execute(
    `INSERT INTO singers (singer_name)
     VALUES ($1) RETURNING singer_id`,
    [singerName]
  );

  return findSingerById(result[0].singer_id);
};

const findSingerById = async (singerId) => {
  const [rows] = await pool.query(
    `SELECT singer_id, singer_name
     FROM singers WHERE singer_id = $1 LIMIT 1`,
    [singerId]
  );

  return rows[0] ? mapSingerRow(rows[0]) : null;
};

const getSingersBySong = async (songId) => {
  const [rows] = await pool.query(
    `SELECT DISTINCT singer_id, singer_name
     FROM singers ORDER BY singer_name`
  );

  return rows.map(mapSingerRow);
};

const getSongsBySinger = async (singer_name) => {
  const [rows] = await pool.query(
    `SELECT id, title
    FROM songs
    WHERE singer = $1
      OR EXISTS (
        SELECT 1 FROM unnest(string_to_array(COALESCE(singer, ''), ',')) AS value
        WHERE trim(value) = trim($1)
      )
    ORDER BY title`,
    [singer_name]
  );

  return rows.map(row => ({
    songId: row.id,
    songName: row.title,
  }));
};

const getAllSingers = async () => {
  const [rows] = await pool.query(
    `SELECT singer_id, singer_name
     FROM singers ORDER BY singer_name`
  );

  return rows.map(mapSingerRow);
};

const updateSinger = async (singerId, { singerName }) => {
  await pool.execute(
    `UPDATE singers SET singer_name = $1 WHERE singer_id = $2`,
    [singerName, singerId]
  );

  return findSingerById(singerId);
};

const deleteSingerById = async (singerId) => {
  await pool.execute(`DELETE FROM singers WHERE singer_id = $1`, [singerId]);
};

const deleteSingersBySong = async (songId) => {
  // No-op: singers table no longer has song relationship
};

const getTopSingers = async (limit = 10) => {
  const [rows] = await pool.query(
    `SELECT s.singer_id as singerid, s.singer_name as singername, COUNT(so.id) as songcount
     FROM singers s 
     LEFT JOIN songs so ON (
       so.singer = s.singer_name 
       OR EXISTS (
         SELECT 1 FROM unnest(string_to_array(COALESCE(so.singer, ''), ',')) AS value
         WHERE trim(value) = trim(s.singer_name)
       )
     )
     GROUP BY s.singer_id, s.singer_name 
     ORDER BY songcount DESC, s.singer_name ASC 
     LIMIT $1`,
    [limit]
  );

  return rows.map(row => ({
    singerId: row.singerid,
    singerName: row.singername,
    songCount: String(row.songcount)
  }));
};

const getSingersPaginated = async (page = 1, limit = 12) => {
  const offset = (page - 1) * limit;
  const [rows] = await pool.query(
    `SELECT singer_id as singerid, singer_name as singername FROM singers ORDER BY singer_name LIMIT $1 OFFSET $2`,
    [limit, offset]
  );

  const [countResult] = await pool.query(`SELECT COUNT(*) as total FROM singers`);
  const total = countResult[0].total;

  return {
    data: rows.map(row => ({
      singerId: row.singerid,
      singerName: row.singername,
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
const getSingersForSearch = async () => {
  const [rows] = await pool.query(
    `SELECT singer_id, singer_name FROM singers ORDER BY singer_name ASC`
  );

  return rows.map(row => ({
    singerId: row.singer_id,
    singerName: row.singer_name,
  }));
};

module.exports = {
  createSinger,
  findSingerById,
  getSingersBySong,
  getAllSingers,
  updateSinger,
  deleteSingerById,
  deleteSingersBySong,
  getSongsBySinger,
  getTopSingers,
  getSingersPaginated,
  getSingersForSearch,
};
