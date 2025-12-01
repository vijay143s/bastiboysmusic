SELECT 'users' AS table_name, COUNT(*) AS row_count FROM users
UNION ALL
SELECT 'albums' AS table_name, COUNT(*) AS row_count FROM albums
UNION ALL
SELECT 'songs' AS table_name, COUNT(*) AS row_count FROM songs
UNION ALL
SELECT 'artists' AS table_name, COUNT(*) AS row_count FROM artists
UNION ALL
SELECT 'singers' AS table_name, COUNT(*) AS row_count FROM singers
UNION ALL
SELECT 'music_directors' AS table_name, COUNT(*) AS row_count FROM music_directors
UNION ALL
SELECT 'user_playlists' AS table_name, COUNT(*) AS row_count FROM user_playlists
ORDER BY table_name;
