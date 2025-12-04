-- Insert sample data to test interaction tracking

-- First, let's ensure we have at least one user and one song
INSERT IGNORE INTO users (id, name, email, password_hash, role) VALUES 
(1, 'Test User', 'test@example.com', 'hashed_password', 'user');

-- Insert a sample song if none exists
INSERT IGNORE INTO albums (id, title, year) VALUES (1, 'Test Album', 2023);
INSERT IGNORE INTO songs (id, album_id, title, singer) VALUES (1, 1, 'Test Song', 'Test Artist');

-- Now insert sample interaction data
INSERT INTO user_search_history (user_id, search_query, results_count, clicked_song_id, created_at) VALUES
(1, 'test search', 5, 1, NOW()),
(1, 'love songs', 10, NULL, DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(NULL, 'anonymous search', 8, 1, DATE_SUB(NOW(), INTERVAL 2 HOUR));

INSERT INTO user_interactions (user_id, song_id, interaction_type, created_at) VALUES
(1, 1, 'play', NOW()),
(1, 1, 'complete', DATE_SUB(NOW(), INTERVAL 5 MINUTE));

INSERT INTO user_listening_history (user_id, song_id, listen_duration_seconds, completion_percentage, source, created_at) VALUES
(1, 1, 180, 85.5, 'search', NOW());

-- Check if data was inserted
SELECT 'user_search_history' as table_name, COUNT(*) as count FROM user_search_history
UNION ALL
SELECT 'user_interactions', COUNT(*) FROM user_interactions  
UNION ALL
SELECT 'user_listening_history', COUNT(*) FROM user_listening_history;