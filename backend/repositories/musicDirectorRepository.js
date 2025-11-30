const { pool } = require("../database/db.js");

const mapMusicDirectorRow = (row) => ({
  directorId: row.director_id,
  directorName: row.director_name,
  albumId: row.album_id,
  albumName: row.album_name,
  createdAt: row.created_at,
  updatedAt: row.updated_at,
});

const createMusicDirector = async ({ directorName, albumId, albumName }) => {
  const [result] = await pool.execute(
    `INSERT INTO music_directors (director_name, album_id, album_name)
     VALUES (?, ?, ?)`,
    [directorName, albumId, albumName]
  );

  return findMusicDirectorById(result.insertId);
};

const findMusicDirectorById = async (directorId) => {
  const [rows] = await pool.query(
    `SELECT director_id, director_name, album_id, album_name
     FROM music_directors WHERE director_id = ? LIMIT 1`,
    [directorId]
  );

  return rows[0] ? mapMusicDirectorRow(rows[0]) : null;
};

const getMusicDirectorsByAlbum = async (albumId) => {
  const [rows] = await pool.query(
    `SELECT director_id, director_name, album_id, album_name, created_at, updated_at
     FROM music_directors WHERE album_id = ? ORDER BY created_at DESC`,
    [albumId]
  );

  return rows.map(mapMusicDirectorRow);
};

const getAlbumsByMusicDirector = async (directorId) => {
  const [rows] = await pool.query(
    `SELECT album_id, album_name
     FROM music_directors WHERE director_id = ? ORDER BY album_name`,
    [directorId]
  );

  return rows.map(mapMusicDirectorRow);
};

const getAlbumsByMusicDirectorName = async (directorName) => {
  const [rows] = await pool.query(
    `SELECT DISTINCT a.id, a.title, a.description, a.thumbnail_id, a.thumbnail_url, a.year, a.director, a.music_director, a.star_cast, a.created_at, a.updated_at
     FROM albums a 
     INNER JOIN music_directors md ON a.id = md.album_id 
     WHERE md.director_name = ? ORDER BY a.created_at DESC`,
    [directorName]
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

const getAllMusicDirectors = async () => {
  const [rows] = await pool.query(
    `SELECT director_id, director_name, album_id, album_name, created_at, updated_at
     FROM music_directors ORDER BY created_at DESC`
  );

  return rows.map(mapMusicDirectorRow);
};

const updateMusicDirector = async (directorId, { directorName, albumName }) => {
  await pool.execute(
    `UPDATE music_directors SET director_name = ?, album_name = ?, updated_at = NOW() WHERE director_id = ?`,
    [directorName, albumName, directorId]
  );

  return findMusicDirectorById(directorId);
};

const deleteMusicDirectorById = async (directorId) => {
  await pool.execute(`DELETE FROM music_directors WHERE director_id = ?`, [directorId]);
};

const deleteMusicDirectorsByAlbum = async (albumId) => {
  await pool.execute(`DELETE FROM music_directors WHERE album_id = ?`, [albumId]);
};

const getTopMusicDirectors = async (limit = 10) => {
  const [rows] = await pool.query(
    `SELECT director_id, director_name, COUNT(*) as album_count
     FROM music_directors GROUP BY director_id, director_name ORDER BY album_count DESC LIMIT ?`,
    [limit]
  );

  return rows.map(row => ({
    directorId: row.director_id,
    directorName: row.director_name,
    albumCount: row.album_count,
  }));
};

const getMusicDirectorsPaginated = async (page = 1, limit = 12) => {
  const offset = (page - 1) * limit;
  const [rows] = await pool.query(
    `SELECT director_id, director_name, COUNT(*) as album_count
     FROM music_directors GROUP BY director_id, director_name ORDER BY director_name LIMIT ? OFFSET ?`,
    [limit, offset]
  );

  const [countResult] = await pool.query(
    `SELECT COUNT(DISTINCT director_id) as total FROM music_directors`
  );
  const total = countResult[0].total;

  return {
    data: rows.map(row => ({
      directorId: row.director_id,
      directorName: row.director_name,
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

module.exports = {
  createMusicDirector,
  findMusicDirectorById,
  getMusicDirectorsByAlbum,
  getAllMusicDirectors,
  updateMusicDirector,
  deleteMusicDirectorById,
  deleteMusicDirectorsByAlbum,
  getTopMusicDirectors,
  getMusicDirectorsPaginated,
  getAlbumsByMusicDirector,
  getAlbumsByMusicDirectorName,
};
