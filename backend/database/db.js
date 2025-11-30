const mysql = require("mysql2/promise");
const dotenv = require("dotenv");
const path = require("path");

// Load .env from backend directory
const envPath = path.resolve(__dirname, "..", ".env");
dotenv.config({ path: envPath });

const {
  MYSQL_HOST,
  MYSQL_PORT,
  MYSQL_USER,
  MYSQL_PASSWORD,
  MYSQL_DATABASE,
} = process.env;

console.log("Database Configuration:");
console.log(`  Host: ${MYSQL_HOST}`);
console.log(`  Port: ${MYSQL_PORT}`);
console.log(`  User: ${MYSQL_USER}`);

const pool = mysql.createPool({
  host: MYSQL_HOST,
  port: Number(MYSQL_PORT),
  user: MYSQL_USER,
  password: MYSQL_PASSWORD,
  database: MYSQL_DATABASE,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

const connectDb = async () => {
  try {
    console.log(`Attempting to connect to MySQL at ${MYSQL_HOST}:${MYSQL_PORT}...`);
    const connection = await pool.getConnection();
    try {
      await connection.ping();
      console.log("✓ MySQL connected successfully!");
    } finally {
      connection.release();
    }
  } catch (error) {
    console.error("✗ MySQL connection error:");
    console.error(`  Code: ${error.code}`);
    console.error(`  Message: ${error.message}`);
    console.error(`  Address: ${error.address || "N/A"}`);
    console.error(`  Port: ${error.port || "N/A"}`);
    throw error;
  }
};

module.exports = { connectDb, pool };
