-- Simple search behavior queries that will work even with empty tables

-- 1. Check table structure
DESCRIBE user_search_history;

-- 2. Count of search records
SELECT COUNT(*) as total_searches FROM user_search_history;

-- 3. Basic search analysis (will show structure even if empty)
SELECT 
    search_query,
    COUNT(*) as search_count,
    AVG(results_count) as avg_results,
    COUNT(clicked_song_id) as clicks
FROM user_search_history 
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
GROUP BY search_query
ORDER BY search_count DESC
LIMIT 10;