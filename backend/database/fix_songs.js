const fs = require('fs');

console.log('Reading all_songs.sql...');
const sql = fs.readFileSync('all_songs.sql', 'utf8');

// Extract all INSERT INTO songs statements
const songInserts = sql.match(/INSERT INTO songs \(album_id[^;]+;/g) || [];
console.log(`Found ${songInserts.length} song INSERT statements`);

// Fix each one: wrap the SELECT in a CASE to provide a default album_id
const fixed = songInserts.map(insert => {
  // Replace (SELECT id FROM albums WHERE title='X') with 
  // CASE WHEN EXISTS(SELECT 1 FROM albums WHERE title='X') THEN (SELECT id FROM albums WHERE title='X') ELSE 1 END
  return insert.replace(
    /\(\(SELECT id FROM albums WHERE title='([^']+)'\)\)/g,
    "(CASE WHEN EXISTS(SELECT 1 FROM albums WHERE title='$1') THEN (SELECT id FROM albums WHERE title='$1') ELSE 1 END)"
  );
});

// Rebuild the SQL file
let newSql = sql;
songInserts.forEach((original, i) => {
  newSql = newSql.replace(original, fixed[i]);
});

fs.writeFileSync('all_songs_safe.sql', newSql);
console.log('✅ Created all_songs_safe.sql with safe album_id fallbacks');
console.log('   Songs without matching albums will be assigned to album_id=1');
