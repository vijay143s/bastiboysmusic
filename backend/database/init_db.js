const fs = require("fs/promises");
const path = require("path");
const { pool } = require("./db.js");

const DEFAULT_SQL_FILES = ["select.sql"];

const fileExists = async (absolutePath) => {
  try {
    await fs.access(absolutePath);
    return true;
  } catch {
    return false;
  }
};

const runSqlFile = async (filePath) => {
  const absolutePath = path.resolve(__dirname, filePath);

  if (!(await fileExists(absolutePath))) {
    console.warn(`⚠️  Skipping ${filePath} (file not found)`);
    return true;
  }

  const sql = await fs.readFile(absolutePath, "utf-8");
  if (!sql.trim()) {
    console.warn(`⚠️  Skipping ${filePath} (file is empty)`);
    return true;
  }

  console.log(`📄 Executing ${path.basename(filePath)}...`);
  
  // Split by semicolons and filter out empty statements
  const statements = sql
    .split(";")
    .map((stmt) => stmt.trim())
    .filter((stmt) => stmt.length > 0);

  if (statements.length === 0) {
    console.warn(`⚠️  No statements found in ${filePath}`);
    return true;
  }

  console.log(`   Found ${statements.length} statements to execute`);

  // Execute in batches to avoid timeout/memory issues
  const BATCH_SIZE = 100;
  let executed = 0;

  let errors = 0;
  
  for (let i = 0; i < statements.length; i += BATCH_SIZE) {
    const batch = statements.slice(i, i + BATCH_SIZE);
    const batchSql = batch.join(";\n") + ";";
    
    try {
      const result = await pool.query(batchSql);
      
      // Print results for SELECT queries
      const firstStatement = batch[0].trim().toUpperCase();
      if (firstStatement.startsWith('SELECT') || firstStatement.includes('SELECT')) {
        const rows = result[0];
        if (rows && rows.length > 0) {
          console.log(`\n📊 Results (${rows.length} rows):`);
          console.table(rows);
        } else {
          console.log('\n   No results returned');
        }
      }
      
      executed += batch.length;
      if (statements.length > BATCH_SIZE) {
        process.stdout.write(`\r   Progress: ${executed}/${statements.length} statements (${errors} errors ignored)`);
      }
    } catch (error) {
      errors++;
      if (errors <= 5) {
        console.warn(`\n⚠️  Error at statement ${i + 1} (ignored): ${error.message}`);
      }
      executed += batch.length;
      if (statements.length > BATCH_SIZE) {
        process.stdout.write(`\r   Progress: ${executed}/${statements.length} statements (${errors} errors ignored)`);
      }
    }
  }

  if (statements.length > BATCH_SIZE) {
    console.log(); // New line after progress indicator
  }
  
  if (errors > 0) {
    console.log(`⚠️  Completed with ${errors} errors ignored`);
  }
  
  console.log(`✅ Finished ${path.basename(filePath)}`);
  return true;
};

const initDatabase = async (sqlFiles = []) => {
  const filesToRun = sqlFiles.length ? sqlFiles : DEFAULT_SQL_FILES;
  let success = true;

  try {
    for (const relativePath of filesToRun) {
      const result = await runSqlFile(relativePath);
      if (!result) {
        success = false;
      }
    }
  } catch (error) {
    success = false;
    console.error("❌ Database initialization failed:", error.message);
  } finally {
    try {
      await pool.end();
    } catch (endError) {
      console.warn("⚠️  Failed to close database connection pool:", endError.message);
    }
  }

  if (!success) {
    throw new Error("Database initialization failed");
  }

  console.log("🎉 Database initialization completed successfully!");
};

if (require.main === module) {
  const files = process.argv.slice(2);
  initDatabase(files)
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error.message || error);
      process.exit(1);
    });
}

module.exports = { initDatabase, runSqlFile };
