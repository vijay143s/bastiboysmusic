const { pool } = require("../database/db.js");

const isSongInPlaylist = async (userId, songId) => {
  const [rows] = await pool.query(
    `SELECT 1 FROM user_playlists WHERE user_id = ? AND song_id = ? LIMIT 1`,
    [userId, songId]
  );

  return rows.length > 0;
};

const addSongToPlaylist = async (userId, songId) => {
  await pool.execute(
    `INSERT INTO user_playlists (user_id, song_id)
     VALUES (?, ?)
     ON DUPLICATE KEY UPDATE updated_at = NOW()` ,
    [userId, songId]
  );
};

const removeSongFromPlaylist = async (userId, songId) => {
  await pool.execute(
    `DELETE FROM user_playlists WHERE user_id = ? AND song_id = ?`,
    [userId, songId]
  );
};

module.exports = {
  isSongInPlaylist,
  addSongToPlaylist,
  removeSongFromPlaylist,
};
