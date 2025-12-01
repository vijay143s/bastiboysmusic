const { pool } = require("../database/db.js");

const isSongInPlaylist = async (userId, songId) => {
  const [rows] = await pool.query(
    `SELECT 1 FROM user_playlists WHERE user_id = $1 AND song_id = $2 LIMIT 1`,
    [userId, songId]
  );

  return rows.length > 0;
};

const addSongToPlaylist = async (userId, songId) => {
  await pool.execute(
    `INSERT INTO user_playlists (user_id, song_id)
     VALUES ($1, $2)
     ON CONFLICT (user_id, song_id) DO UPDATE SET updated_at = NOW()`,
    [userId, songId]
  );
};

const removeSongFromPlaylist = async (userId, songId) => {
  await pool.execute(
    `DELETE FROM user_playlists WHERE user_id = $1 AND song_id = $2`,
    [userId, songId]
  );
};

module.exports = {
  isSongInPlaylist,
  addSongToPlaylist,
  removeSongFromPlaylist,
};
