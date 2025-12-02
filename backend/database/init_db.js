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
  
  // Smart SQL splitter that handles dollar-quoted strings (PostgreSQL functions)
  const statements = [];
  let currentStatement = '';
  let inDollarQuote = false;
  let dollarQuoteTag = '';
  
  const lines = sql.split('\n');
  for (const line of lines) {
    // Check for dollar-quote start/end
    const dollarMatches = line.match(/\$\$|\$[a-zA-Z_][a-zA-Z0-9_]*\$/g);
    if (dollarMatches) {
      for (const match of dollarMatches) {
        if (!inDollarQuote) {
          inDollarQuote = true;
          dollarQuoteTag = match;
        } else if (match === dollarQuoteTag) {
          inDollarQuote = false;
          dollarQuoteTag = '';
        }
      }
    }
    
    currentStatement += line + '\n';
    
    // Only split on semicolon if not inside dollar-quote
    if (!inDollarQuote && line.trim().endsWith(';')) {
      const stmt = currentStatement.trim();
      if (stmt.length > 0 && !stmt.startsWith('--')) {
        statements.push(stmt);
      }
      currentStatement = '';
    }
  }
  
  // Add any remaining statement
  if (currentStatement.trim().length > 0 && !currentStatement.trim().startsWith('--')) {
    statements.push(currentStatement.trim());
  }

  if (statements.length === 0) {
    console.warn(`⚠️  No statements found in ${filePath}`);
    return true;
  }

  console.log(`   Found ${statements.length} statements to execute`);

  // Execute statements individually for better error handling
  let executed = 0;
  let errors = 0;
  
  for (let i = 0; i < statements.length; i++) {
    const statement = statements[i];
    
    try {
      const result = await pool.query(statement);
      
      // Print results for SELECT queries
      const firstWord = statement.trim().toUpperCase().split(/\s+/)[0];
      if (firstWord === 'SELECT') {
        const rows = result[0];
        if (rows && rows.length > 0) {
          console.log(`\n📊 Results (${rows.length} rows):`);
          console.table(rows);
        } else {
          console.log('\n   No results returned');
        }
      }
      
      executed++;
      if (statements.length > 10) {
        process.stdout.write(`\r   Progress: ${executed}/${statements.length} statements (${errors} errors ignored)`);
      }
    } catch (error) {
      errors++;
      // Ignore "already exists" errors
      if (!error.message.includes('already exists')) {
        if (errors <= 5) {
          console.warn(`\n⚠️  Error at statement ${i + 1}: ${error.message}`);
        }
      }
      executed++;
      if (statements.length > 10) {
        process.stdout.write(`\r   Progress: ${executed}/${statements.length} statements (${errors} errors ignored)`);
      }
    }
  }

  if (statements.length > 10) {
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
