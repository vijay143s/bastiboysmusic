const mysql = require("mysql2/promise");
const dotenv = require("dotenv");
const path = require("path");

// Load .env from backend directory
const envPath = path.resolve(__dirname, "..", ".env");
dotenv.config({ path: envPath });

const {
  DB_HOST,
  DB_PORT,
  DB_USER,
  DB_PASSWORD,
  DB_DATABASE,
  MYSQL_HOST,
  MYSQL_PORT,
  MYSQL_USER,
  MYSQL_PASSWORD,
  MYSQL_DATABASE
} = process.env;

const pool = mysql.createPool({
  host: DB_HOST || MYSQL_HOST || 'localhost',
  port: Number(DB_PORT || MYSQL_PORT || 3306),
  user: DB_USER || MYSQL_USER,
  password: DB_PASSWORD || MYSQL_PASSWORD,
  database: DB_DATABASE || MYSQL_DATABASE,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

const connectDb = async () => {
  try {
    const connection = await pool.getConnection();
    try {
      await connection.ping();
    } finally {
      connection.release();
    }
  } catch (error) {
    throw error;
  }
};

// Helper function to execute queries
const execute = async (query, params) => {
  const [rows] = await pool.execute(query, params);
  return [rows];
};

module.exports = { connectDb, pool, execute };
