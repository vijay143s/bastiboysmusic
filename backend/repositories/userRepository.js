import { pool } from "../database/db.js";

const mapUserRow = (row) => ({
  id: row.id,
  name: row.name,
  email: row.email,
  role: row.role,
  passwordHash: row.password_hash,
  createdAt: row.created_at,
  updatedAt: row.updated_at,
});

export const findUserByEmail = async (email) => {
  const [rows] = await pool.query(
    `SELECT id, name, email, role, password_hash, created_at, updated_at
     FROM users WHERE email = ? LIMIT 1`,
    [email]
  );

  return rows[0] ? mapUserRow(rows[0]) : null;
};

export const findUserById = async (id) => {
  const [rows] = await pool.query(
    `SELECT id, name, email, role, password_hash, created_at, updated_at
     FROM users WHERE id = ? LIMIT 1`,
    [id]
  );

  return rows[0] ? mapUserRow(rows[0]) : null;
};

export const createUser = async ({ name, email, passwordHash, role = "user" }) => {
  const [result] = await pool.execute(
    `INSERT INTO users (name, email, password_hash, role)
     VALUES (?, ?, ?, ?)` ,
    [name, email, passwordHash, role]
  );

  return findUserById(result.insertId);
};

export const getUserPlaylistIds = async (userId) => {
  const [rows] = await pool.query(
    `SELECT song_id FROM user_playlists WHERE user_id = ? ORDER BY id DESC`,
    [userId]
  );

  return rows.map((row) => String(row.song_id));
};

export const getUserWithPlaylist = async (id) => {
  const user = await findUserById(id);
  if (!user) return null;

  const playlist = await getUserPlaylistIds(id);
  return { ...user, playlist };
};
