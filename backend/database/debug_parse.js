const fs = require('fs');
const path = require('path');

function parseSQL(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');
  const lines = content.split('\n');
  
  const statements = [];
  let currentStatement = '';
  let inDollarQuote = false;
  let dollarQuoteTag = '';
  
  for (const line of lines) {
    // Skip comment-only lines
    if (line.trim().startsWith('--') && !inDollarQuote) {
      continue;
    }
    
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

  return statements;
}

const statements = parseSQL('./schema.sql');
console.log(`Found ${statements.length} statements:\n`);

statements.forEach((stmt, i) => {
  const firstLine = stmt.split('\n')[0];
  const type = stmt.trim().toUpperCase().split(/\s+/).slice(0, 3).join(' ');
  console.log(`${i + 1}. ${type}`);
  if (type.includes('CREATE TABLE')) {
    const match = stmt.match(/CREATE TABLE[^(]+([a-z_]+)/i);
    if (match) {
      console.log(`   Table: ${match[1]}`);
    }
  }
});
