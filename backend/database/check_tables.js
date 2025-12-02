const {pool} = require('./db.js');

async function checkTables() {
  try {
    const [rows] = await pool.query("SELECT tablename FROM pg_tables WHERE schemaname = 'public' ORDER BY tablename");
    console.log('\n📊 Tables in database:');
    console.table(rows);
    
    // Check if songs table exists and has columns
    const [cols] = await pool.query(`
      SELECT column_name, data_type 
      FROM information_schema.columns 
      WHERE table_name = 'songs' 
      ORDER BY ordinal_position
    `);
    
    if (cols.length > 0) {
      console.log('\n📋 Songs table columns:');
      console.table(cols);
    } else {
      console.log('\n⚠️  Songs table does not exist');
    }
    
  } catch (error) {
    console.error('Error:', error.message);
  } finally {
    await pool.end();
  }
}

checkTables();
