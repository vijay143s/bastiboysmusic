const { Pool } = require("pg");
const dotenv = require("dotenv");
const path = require("path");

// Load .env from backend directory
const envPath = path.resolve(__dirname, "..", ".env");
dotenv.config({ path: envPath });

const {
  DATABASE_URL,
  POSTGRES_HOST,
  POSTGRES_PORT,
  POSTGRES_USER,
  POSTGRES_PASSWORD,
  POSTGRES_DATABASE,
  POSTGRES_SSL,
} = process.env;

const connectionConfig = DATABASE_URL
  ? { 
      connectionString: DATABASE_URL,
      ssl: POSTGRES_SSL === "true" ? { rejectUnauthorized: false } : undefined
    }
  : {
      host: POSTGRES_HOST,
      port: POSTGRES_PORT ? Number(POSTGRES_PORT) : undefined,
      user: POSTGRES_USER,
      password: POSTGRES_PASSWORD,
      database: POSTGRES_DATABASE,
      ssl: POSTGRES_SSL === "true" ? { rejectUnauthorized: false } : undefined
    };

console.log("PostgreSQL Configuration:");
console.log(`  Host: ${DATABASE_URL ? "<database_url>" : POSTGRES_HOST}`);
console.log(`  Port: ${DATABASE_URL ? "n/a" : POSTGRES_PORT}`);
console.log(`  User: ${DATABASE_URL ? "embedded in DATABASE_URL" : POSTGRES_USER}`);

const nativePool = new Pool(connectionConfig);

const prepareStatement = (text = "", params = []) => {
  if (!params || params.length === 0) {
    return { text, values: [] };
  }

  let index = 0;
  const formattedText = text.replace(/\?/g, () => `$${++index}`);
  return { text: formattedText, values: params };
};

const inferPrimaryKey = (row = {}) => {
  if (!row || typeof row !== "object") return undefined;
  if (Object.prototype.hasOwnProperty.call(row, "id")) {
    return row.id;
  }

  const fallbackKey = Object.keys(row).find((key) => key.endsWith("_id"));
  return fallbackKey ? row[fallbackKey] : undefined;
};

const statementType = (text = "") => text.trim().split(/\s+/)[0]?.toUpperCase();

const runPgQuery = async (text, params) => {
  const { text: formattedText, values } = prepareStatement(text, params);
  return nativePool.query(formattedText, values);
};

const mysqlLikeQuery = async (text, params = []) => {
  const result = await runPgQuery(text, params);
  return [result.rows, result];
};

const mysqlLikeExecute = async (text, params = []) => {
  const type = statementType(text);
  let formattedText = text;
  let values = params;

  if (params && params.length > 0) {
    const formatted = prepareStatement(text, params);
    formattedText = formatted.text;
    values = formatted.values;
  }

  const shouldReturnInsertedRow = type === "INSERT" && !/returning/i.test(text);
  const finalSql = shouldReturnInsertedRow ? `${formattedText} RETURNING *` : formattedText;
  const result = await nativePool.query(finalSql, values);

  if (type === "SELECT") {
    return [result.rows, result];
  }

  if (type === "INSERT") {
    return [
      {
        insertId: inferPrimaryKey(result.rows[0]),
        rows: result.rows,
        affectedRows: result.rowCount,
      },
      result,
    ];
  }

  return [
    {
      rows: result.rows,
      affectedRows: result.rowCount,
    },
    result,
  ];
};

const pool = new Proxy(nativePool, {
  get(target, prop) {
    if (prop === "query") return mysqlLikeQuery;
    if (prop === "execute") return mysqlLikeExecute;
    if (prop === "getConnection") {
      return async () => {
        const client = await target.connect();
        return {
          ...client,
          ping: async () => client.query("SELECT 1"),
        };
      };
    }
    return Reflect.get(target, prop);
  },
});

const connectDb = async () => {
  try {
    console.log(
      `Attempting to connect to PostgreSQL at ${
        DATABASE_URL ? "DATABASE_URL" : `${POSTGRES_HOST}:${POSTGRES_PORT}`
      }...`
    );
    const connection = await pool.getConnection();
    try {
      await connection.ping();
      console.log("✓ PostgreSQL connected successfully!");
    } finally {
      connection.release();
    }
  } catch (error) {
    console.error("✗ PostgreSQL connection error:");
    console.error(`  Code: ${error.code}`);
    console.error(`  Message: ${error.message}`);
    console.error(`  Address: ${error.address || "N/A"}`);
    console.error(`  Port: ${error.port || POSTGRES_PORT || "N/A"}`);
    throw error;
  }
};

module.exports = { connectDb, pool };
