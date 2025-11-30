const mysql = require("mysql2/promise");

const {
  MYSQL_HOST = "188.68.38.138",
  MYSQL_PORT = "3306",
  MYSQL_USER = "topnotch_admin",
  MYSQL_PASSWORD = "topnotchadmin",
  MYSQL_DATABASE = "topnotch_Bastiband",
} = process.env;

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
  const connection = await pool.getConnection();
  try {
    await connection.ping();
    console.log("MySQL connected");
  } finally {
    connection.release();
  }
};

module.exports = { connectDb, pool };
