-- Search Behavior Analysis Queries

-- 1. Most Popular Search Terms (Last 30 Days)
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
LIMIT 20;

-- 2. Search Trends by Day (Last 14 Days)
SELECT 
    DATE(created_at) as search_date,
    COUNT(*) as total_searches,
    COUNT(DISTINCT user_id) as unique_searchers,
    COUNT(DISTINCT search_query) as unique_queries,
    AVG(results_count) as avg_results_per_search,
    SUM(CASE WHEN clicked_song_id IS NOT NULL THEN 1 ELSE 0 END) as total_clicks
FROM user_search_history 
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 14 DAY)
GROUP BY DATE(created_at)
ORDER BY search_date DESC;

-- 3. User Search Behavior Patterns
SELECT 
    u.name,
    u.email,
    COUNT(*) as total_searches,
    COUNT(DISTINCT search_query) as unique_queries,
    COUNT(DISTINCT DATE(ush.created_at)) as active_search_days,
    AVG(results_count) as avg_results,
    COUNT(clicked_song_id) as total_clicks,
    ROUND((COUNT(clicked_song_id) / COUNT(*)) * 100, 2) as click_through_rate,
    MAX(ush.created_at) as last_search_date
FROM user_search_history ush
JOIN users u ON ush.user_id = u.id
GROUP BY ush.user_id, u.name, u.email
ORDER BY total_searches DESC
LIMIT 50;

-- 4. Most Clicked Songs from Search
SELECT 
    s.title as song_title,
    s.file_name,
    al.title as album_name,
    COUNT(*) as click_count,
    COUNT(DISTINCT ush.user_id) as unique_users_clicked,
    GROUP_CONCAT(DISTINCT ush.search_query SEPARATOR '; ') as search_queries_used
FROM user_search_history ush
JOIN songs s ON ush.clicked_song_id = s.id
LEFT JOIN albums al ON s.album_id = al.id
WHERE ush.clicked_song_id IS NOT NULL
GROUP BY s.id, s.title, s.file_name, al.title
ORDER BY click_count DESC
LIMIT 20;

-- 5. Search Query Length Analysis
SELECT 
    CASE 
        WHEN LENGTH(search_query) <= 10 THEN 'Short (≤10 chars)'
        WHEN LENGTH(search_query) <= 25 THEN 'Medium (11-25 chars)'
        WHEN LENGTH(search_query) <= 50 THEN 'Long (26-50 chars)'
        ELSE 'Very Long (>50 chars)'
    END as query_length_category,
    COUNT(*) as search_count,
    AVG(results_count) as avg_results,
    COUNT(clicked_song_id) as clicks,
    ROUND((COUNT(clicked_song_id) / COUNT(*)) * 100, 2) as click_through_rate
FROM user_search_history
GROUP BY 
    CASE 
        WHEN LENGTH(search_query) <= 10 THEN 'Short (≤10 chars)'
        WHEN LENGTH(search_query) <= 25 THEN 'Medium (11-25 chars)'
        WHEN LENGTH(search_query) <= 50 THEN 'Long (26-50 chars)'
        ELSE 'Very Long (>50 chars)'
    END
ORDER BY search_count DESC;

-- 6. Search Success Rate Analysis (Queries that led to song plays)
SELECT 
    ush.search_query,
    COUNT(*) as search_count,
    COUNT(DISTINCT ush.user_id) as unique_searchers,
    COUNT(ush.clicked_song_id) as clicks,
    COUNT(ulh.id) as subsequent_plays,
    ROUND((COUNT(ulh.id) / COUNT(*)) * 100, 2) as play_success_rate
FROM user_search_history ush
LEFT JOIN user_listening_history ulh ON (
    ush.clicked_song_id = ulh.song_id 
    AND ush.user_id = ulh.user_id 
    AND ulh.created_at BETWEEN ush.created_at AND DATE_ADD(ush.created_at, INTERVAL 1 HOUR)
)
WHERE ush.created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
GROUP BY ush.search_query
HAVING search_count >= 3
ORDER BY play_success_rate DESC, search_count DESC
LIMIT 25;

-- 7. Anonymous vs Registered User Search Behavior
SELECT 
    CASE 
        WHEN user_id IS NULL THEN 'Anonymous'
        ELSE 'Registered'
    END as user_type,
    COUNT(*) as total_searches,
    COUNT(DISTINCT search_query) as unique_queries,
    AVG(results_count) as avg_results,
    COUNT(clicked_song_id) as total_clicks,
    ROUND((COUNT(clicked_song_id) / COUNT(*)) * 100, 2) as click_through_rate,
    ROUND(AVG(LENGTH(search_query)), 2) as avg_query_length
FROM user_search_history
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
GROUP BY 
    CASE 
        WHEN user_id IS NULL THEN 'Anonymous'
        ELSE 'Registered'
    END;

-- 8. Search Behavior by Hour of Day
SELECT 
    HOUR(created_at) as search_hour,
    COUNT(*) as search_count,
    COUNT(DISTINCT user_id) as unique_users,
    AVG(results_count) as avg_results,
    COUNT(clicked_song_id) as clicks,
    ROUND((COUNT(clicked_song_id) / COUNT(*)) * 100, 2) as click_through_rate
FROM user_search_history
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)
GROUP BY HOUR(created_at)
ORDER BY search_hour;

-- 9. Zero Results Search Queries (Queries that need attention)
SELECT 
    search_query,
    COUNT(*) as search_count,
    COUNT(DISTINCT user_id) as unique_users_affected,
    MAX(created_at) as last_searched
FROM user_search_history
WHERE results_count = 0
GROUP BY search_query
ORDER BY search_count DESC
LIMIT 20;

-- 10. Search to Play Conversion Analysis
SELECT 
    DATE(ush.created_at) as search_date,
    COUNT(*) as total_searches,
    COUNT(ush.clicked_song_id) as searches_with_clicks,
    COUNT(CASE WHEN ulh.id IS NOT NULL THEN 1 END) as searches_leading_to_plays,
    ROUND((COUNT(ush.clicked_song_id) / COUNT(*)) * 100, 2) as click_rate,
    ROUND((COUNT(CASE WHEN ulh.id IS NOT NULL THEN 1 END) / COUNT(*)) * 100, 2) as conversion_to_play_rate
FROM user_search_history ush
LEFT JOIN user_listening_history ulh ON (
    ush.clicked_song_id = ulh.song_id 
    AND ush.user_id = ulh.user_id 
    AND ulh.created_at BETWEEN ush.created_at AND DATE_ADD(ush.created_at, INTERVAL 2 HOUR)
)
WHERE ush.created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
GROUP BY DATE(ush.created_at)
ORDER BY search_date DESC;