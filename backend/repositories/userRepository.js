const { pool } = require("../database/db.js");

const mapUserRow = (row) => ({
  id: row.id,
  name: row.name,
  email: row.email,
  role: row.role,
  passwordHash: row.password_hash,
  lastPlayedSongId: row.last_played_song_id,
  createdAt: row.created_at,
  updatedAt: row.updated_at,
});

const findUserByEmail = async (email) => {
  const [rows] = await pool.query(
    `SELECT id, name, email, role, password_hash, last_played_song_id, created_at, updated_at
     FROM users WHERE email = ? LIMIT 1`,
    [email]
  );

  return rows[0] ? mapUserRow(rows[0]) : null;
};

const findUserById = async (id) => {
  const [rows] = await pool.query(
    `SELECT id, name, email, role, password_hash, last_played_song_id, created_at, updated_at
     FROM users WHERE id = ? LIMIT 1`,
    [id]
  );

  return rows[0] ? mapUserRow(rows[0]) : null;
};

const createUser = async ({ name, email, passwordHash, role = "user" }) => {
  const [result] = await pool.execute(
    `INSERT INTO users (name, email, password_hash, role)
     VALUES (?, ?, ?, ?)` ,
    [name, email, passwordHash, role]
  );

  return findUserById(result.insertId);
};

const getUserPlaylistIds = async (userId) => {
  const [rows] = await pool.query(
    `SELECT song_id FROM user_playlists WHERE user_id = ? ORDER BY id DESC`,
    [userId]
  );

  return rows.map((row) => String(row.song_id));
};

const getUserWithPlaylist = async (id) => {
  const user = await findUserById(id);
  if (!user) return null;

  const playlist = await getUserPlaylistIds(id);
  return { ...user, playlist };
};

const getAllUsersWithPlaylistSongs = async () => {
  const [rows] = await pool.query(
    `SELECT 
        u.id AS user_id,
        u.name AS user_name,
        u.email AS user_email,
        up.created_at AS saved_at,
        s.id AS song_id,
        s.title AS song_title,
        s.description AS song_description,
        s.singer AS song_singer,
        s.thumbnail_id AS song_thumbnail_id,
        s.thumbnail_url AS song_thumbnail_url,
        s.audio_id AS song_audio_id,
        s.audio_url AS song_audio_url,
        s.album_id AS song_album_id,
        (SELECT COUNT(*) FROM user_playlists WHERE user_id = u.id) AS playlist_count
      FROM users u
      LEFT JOIN user_playlists up ON up.user_id = u.id
      LEFT JOIN songs s ON s.id = up.song_id
      WHERE (SELECT COUNT(*) FROM user_playlists WHERE user_id = u.id) > 0
      ORDER BY playlist_count DESC, u.name ASC, up.created_at DESC`
  );

  const playlistMap = new Map();

  rows.forEach((row) => {
    if (!playlistMap.has(row.user_id)) {
      playlistMap.set(row.user_id, {
        user: {
          id: row.user_id,
          name: row.user_name,
          email: row.user_email,
        },
        songs: [],
      });
    }

    if (row.song_id) {
      playlistMap.get(row.user_id).songs.push({
        id: row.song_id,
        title: row.song_title,
        description: row.song_description,
        singer: row.song_singer,
        thumbnail: {
          id: row.song_thumbnail_id,
          url: row.song_thumbnail_url,
        },
        audio: {
          id: row.song_audio_id,
          url: row.song_audio_url,
        },
        albumId: row.song_album_id,
        savedAt: row.saved_at,
      });
    }
  });

  return Array.from(playlistMap.values());
};

const updateLastPlayedSong = async (userId, songId) => {
  await pool.query(
    `UPDATE users SET last_played_song_id = ? WHERE id = ?`,
    [songId, userId]
  );
};

module.exports = {
  findUserByEmail,
  findUserById,
  createUser,
  getUserPlaylistIds,
  getUserWithPlaylist,
  getAllUsersWithPlaylistSongs,
  updateLastPlayedSong,
};
