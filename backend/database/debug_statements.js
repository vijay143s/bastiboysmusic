const fs = require('fs');

const sql = fs.readFileSync('./schema.sql', 'utf8');

const statements = [];
let currentStatement = '';
let inDollarQuote = false;
let dollarQuoteTag = '';

const normalizedSQL = sql.replace(/\r\n/g, '\n').replace(/\r/g, '\n');
const lines = normalizedSQL.split('\n');

for (const line of lines) {
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
    if (stmt.length > 0) {
      statements.push(stmt);
    }
    currentStatement = '';
  }
}

// Add any remaining statement
if (currentStatement.trim().length > 0) {
  statements.push(currentStatement.trim());
}

console.log(`Found ${statements.length} statements\n`);

// Save each statement to a file
statements.forEach((stmt, i) => {
  const firstLine = stmt.split('\n')[0];
  console.log(`${i+1}. ${firstLine.substring(0, 60)}...`);
  
  if (stmt.trim().toUpperCase().startsWith('CREATE TABLE')) {
    fs.writeFileSync(`./debug_stmt_${i+1}.sql`, stmt, 'utf8');
    console.log(`   Saved to debug_stmt_${i+1}.sql`);
  }
});
