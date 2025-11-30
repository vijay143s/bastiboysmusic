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
     FROM songs WHERE singer = ? OR FIND_IN_SET(?, singer) > 0 ORDER BY created_at DESC`,
    [singerName, singerName]
  );

  return rows.map(mapSongRow);
};

module.exports = {
  createSong,
  updateSongThumbnail,
  getAllSongs,
  getSongsByAlbum,
  findSongById,
  deleteSongById,
  getSongsBySinger,
};
