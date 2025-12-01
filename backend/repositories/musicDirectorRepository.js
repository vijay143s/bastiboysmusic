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
     VALUES ($1, $2, $3) RETURNING director_id`,
    [directorName, albumId, albumName]
  );

  return findMusicDirectorById(result[0].director_id);
};

const findMusicDirectorById = async (directorId) => {
  const [rows] = await pool.query(
    `SELECT director_id, director_name, album_id, album_name
     FROM music_directors WHERE director_id = $1 LIMIT 1`,
    [directorId]
  );

  return rows[0] ? mapMusicDirectorRow(rows[0]) : null;
};

const getMusicDirectorsByAlbum = async (albumId) => {
  const [rows] = await pool.query(
    `SELECT director_id, director_name, album_id, album_name, created_at, updated_at
     FROM music_directors WHERE album_id = $1 ORDER BY created_at DESC`,
    [albumId]
  );

  return rows.map(mapMusicDirectorRow);
};

const getAlbumsByMusicDirector = async (directorId) => {
  const [rows] = await pool.query(
    `SELECT album_id, album_name
     FROM music_directors WHERE director_id = $1 ORDER BY album_name`,
    [directorId]
  );

  return rows.map(mapMusicDirectorRow);
};

const getAlbumsByMusicDirectorName = async (directorName) => {
  const [rows] = await pool.query(
    `SELECT DISTINCT a.id, a.title, a.description, a.thumbnail_id, a.thumbnail_url, a.year, a.director, a.music_director, a.star_cast, a.created_at, a.updated_at
     FROM albums a 
     INNER JOIN music_directors md ON a.id = md.album_id 
     WHERE md.director_name = $1 ORDER BY a.created_at DESC`,
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
    `UPDATE music_directors SET director_name = $1, album_name = $2, updated_at = NOW() WHERE director_id = $3`,
    [directorName, albumName, directorId]
  );

  return findMusicDirectorById(directorId);
};

const deleteMusicDirectorById = async (directorId) => {
  await pool.execute(`DELETE FROM music_directors WHERE director_id = $1`, [directorId]);
};

const deleteMusicDirectorsByAlbum = async (albumId) => {
  await pool.execute(`DELETE FROM music_directors WHERE album_id = $1`, [albumId]);
};

const getTopMusicDirectors = async (limit = 10) => {
  const [rows] = await pool.query(
    `SELECT MIN(director_id) as directorid, director_name as directorname, COUNT(*) as albumcount
     FROM music_directors GROUP BY director_name ORDER BY albumcount DESC LIMIT $1`,
    [limit]
  );

  return rows.map(row => ({
    directorId: row.directorid,
    directorName: row.directorname,
    albumCount: String(row.albumcount),
  }));
};

const getMusicDirectorsPaginated = async (page = 1, limit = 12) => {
  const offset = (page - 1) * limit;
  const [rows] = await pool.query(
    `SELECT MIN(director_id) as directorid, director_name as directorname, COUNT(*) as albumcount
     FROM music_directors GROUP BY director_name ORDER BY directorname LIMIT $1 OFFSET $2`,
    [limit, offset]
  );

  const [countResult] = await pool.query(
    `SELECT COUNT(DISTINCT director_name) as total FROM music_directors`
  );
  const total = countResult[0].total;

  return {
    data: rows.map(row => ({
      directorId: row.directorid,
      directorName: row.directorname,
      albumCount: String(row.albumcount),
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
const getMusicDirectorsForSearch = async () => {
  const [rows] = await pool.query(
    `SELECT MIN(director_id) as directorid, director_name as directorname 
     FROM music_directors GROUP BY director_name ORDER BY director_name ASC`
  );

  return rows.map(row => ({
    directorId: row.directorid,
    directorName: row.directorname,
  }));
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
  getMusicDirectorsForSearch,
};
