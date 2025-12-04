-- Check if tables have data
SELECT 'user_search_history' as table_name, COUNT(*) as row_count FROM user_search_history
UNION ALL
SELECT 'user_interactions' as table_name, COUNT(*) as row_count FROM user_interactions
UNION ALL
SELECT 'user_listening_history' as table_name, COUNT(*) as row_count FROM user_listening_history
UNION ALL
SELECT 'song_skips' as table_name, COUNT(*) as row_count FROM song_skips;