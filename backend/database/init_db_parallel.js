const fs = require("fs/promises");
const path = require("path");
const { pool } = require("./db.js");

const BATCH_SIZE = 5; // Number of queries per batch (increased from 5)
const PARALLEL_BATCHES = 100; // Number of batches to run in parallel (increased from 20)

const fileExists = async (absolutePath) => {
  try {
    await fs.access(absolutePath);
    return true;
  } catch {
    return false;
  }
};

const parseSqlStatements = (sql) => {
  const statements = [];
  let currentStatement = '';
  let inDollarQuote = false;
  let dollarQuoteTag = '';
  
  // Normalize line endings to \n
  const normalizedSQL = sql.replace(/\r\n/g, '\n').replace(/\r/g, '\n');
  const lines = normalizedSQL.split('\n');
  
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
      // Skip empty statements and comment-only statements
      const hasCode = stmt.length > 0 && stmt.split('\n').some(l => {
        const trimmed = l.trim();
        return trimmed.length > 0 && !trimmed.startsWith('--');
      });
      if (hasCode) {
        statements.push(stmt);
      }
      currentStatement = '';
    }
  }
  
  // Add any remaining statement
  const remainingStmt = currentStatement.trim();
  const hasCode = remainingStmt.length > 0 && remainingStmt.split('\n').some(l => {
    const trimmed = l.trim();
    return trimmed.length > 0 && !trimmed.startsWith('--');
  });
  if (hasCode) {
    statements.push(remainingStmt);
  }

  return statements;
};

const executeBatch = async (batch, batchIndex, totalBatches) => {
  const results = {
    executed: 0,
    errors: 0,
    batchIndex
  };

  // Execute queries directly in parallel without transaction for better speed
  const promises = batch.map(async (statement) => {
    try {
      await pool.query(statement);
      return { success: true };
    } catch (error) {
      // Only log significant errors
      const firstWord = statement.trim().toUpperCase().split(/\s+/)[0];
      if (firstWord === 'CREATE' || 
          (!error.message.includes('already exists') && 
           !error.message.includes('does not exist') &&
           !error.message.includes('duplicate key'))) {
        console.warn(`\n⚠️  Batch ${batchIndex + 1} error: ${error.message.substring(0, 100)}`);
      }
      return { success: false };
    }
  });

  const batchResults = await Promise.all(promises);
  
  batchResults.forEach(result => {
    if (result.success) {
      results.executed++;
    } else {
      results.errors++;
    }
  });

  return results;
};

const runSqlFileParallel = async (filePath) => {
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

  console.log(`📄 Executing ${path.basename(filePath)} in parallel...`);
  
  const statements = parseSqlStatements(sql);

  if (statements.length === 0) {
    console.warn(`⚠️  No statements found in ${filePath}`);
    return true;
  }

  console.log(`   Found ${statements.length} statements to execute`);
  console.log(`   Configuration: ${PARALLEL_BATCHES} parallel batches of ${BATCH_SIZE} queries each`);
  
  // Separate schema creation statements from data insertion statements
  const schemaStatements = [];
  const dataStatements = [];
  
  statements.forEach(stmt => {
    const firstWord = stmt.trim().toUpperCase().split(/\s+/)[0];
    if (firstWord === 'CREATE' || firstWord === 'ALTER' || firstWord === 'DROP') {
      schemaStatements.push(stmt);
    } else {
      dataStatements.push(stmt);
    }
  });

  console.log(`   Schema statements: ${schemaStatements.length}`);
  console.log(`   Data statements: ${dataStatements.length}`);

  // Execute schema statements first (sequentially for safety)
  if (schemaStatements.length > 0) {
    console.log(`\n🔧 Executing schema statements sequentially...`);
    let schemaErrors = 0;
    for (let i = 0; i < schemaStatements.length; i++) {
      try {
        await pool.query(schemaStatements[i]);
        process.stdout.write(`\r   Progress: ${i + 1}/${schemaStatements.length}`);
      } catch (error) {
        schemaErrors++;
        if (!error.message.includes('already exists') && !error.message.includes('does not exist')) {
          console.warn(`\n⚠️  Schema error at statement ${i + 1}: ${error.message}`);
        }
      }
    }
    console.log(`\n✅ Schema statements completed (${schemaErrors} errors ignored)`);
  }

  // Execute data statements in parallel batches
  if (dataStatements.length > 0) {
    console.log(`\n⚡ Executing data statements in parallel batches...`);
    
    // Split data statements into batches
    const batches = [];
    for (let i = 0; i < dataStatements.length; i += BATCH_SIZE) {
      batches.push(dataStatements.slice(i, i + BATCH_SIZE));
    }
    
    console.log(`   Created ${batches.length} batches`);
    
    let totalExecuted = 0;
    let totalErrors = 0;
    const startTime = Date.now();
    
    // Process batches in chunks of PARALLEL_BATCHES
    for (let i = 0; i < batches.length; i += PARALLEL_BATCHES) {
      const batchChunk = batches.slice(i, i + PARALLEL_BATCHES);
      const batchPromises = batchChunk.map((batch, index) => 
        executeBatch(batch, i + index, batches.length)
      );
      
      const results = await Promise.all(batchPromises);
      
      results.forEach(result => {
        totalExecuted += result.executed;
        totalErrors += result.errors;
      });
      
      const processed = Math.min(i + PARALLEL_BATCHES, batches.length);
      const percentage = ((processed / batches.length) * 100).toFixed(1);
      const elapsed = ((Date.now() - startTime) / 1000).toFixed(1);
      process.stdout.write(`\r   Progress: ${processed}/${batches.length} batches (${percentage}%) | ${totalExecuted} executed | ${totalErrors} errors | ${elapsed}s`);
    }
    
    const totalTime = ((Date.now() - startTime) / 1000).toFixed(2);
    console.log(`\n✅ Data statements completed in ${totalTime}s`);
    console.log(`   Total executed: ${totalExecuted}`);
    console.log(`   Total errors: ${totalErrors}`);
    console.log(`   Average speed: ${(totalExecuted / totalTime).toFixed(0)} statements/second`);
  }
  
  console.log(`\n🎉 Finished ${path.basename(filePath)}`);
  return true;
};

const initDatabaseParallel = async (sqlFiles = []) => {
  if (!sqlFiles.length) {
    console.error("❌ Please provide at least one SQL file");
    return false;
  }

  let success = true;

  try {
    for (const relativePath of sqlFiles) {
      const result = await runSqlFileParallel(relativePath);
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

  console.log("\n🎉 Database initialization completed successfully!");
};

if (require.main === module) {
  const files = process.argv.slice(2);
  
  if (files.length === 0) {
    console.log("Usage: node init_db_parallel.js <sql_file1> [sql_file2] ...");
    console.log("Example: node init_db_parallel.js all_songs.sql");
    process.exit(1);
  }
  
  initDatabaseParallel(files)
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error.message || error);
      process.exit(1);
    });
}

module.exports = { initDatabaseParallel, runSqlFileParallel };
