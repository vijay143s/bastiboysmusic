-- Test a simple search behavior query with the sample data
SELECT 
    search_query,
    COUNT(*) as search_count,
    AVG(results_count) as avg_results,
    COUNT(DISTINCT user_id) as unique_users,
    COUNT(clicked_song_id) as clicks,
    ROUND((COUNT(clicked_song_id) / COUNT(*)) * 100, 2) as click_through_rate
FROM user_search_history 
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
GROUP BY search_query
ORDER BY search_count DESC
LIMIT 10;