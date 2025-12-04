-- Insert sample data for search behavior analysis demonstration
-- Note: This assumes you have at least some users and songs in the database

-- Insert sample search history data
INSERT IGNORE INTO user_search_history (user_id, search_query, results_count, clicked_song_id, created_at) VALUES
-- Recent searches with various patterns
(1, 'love songs', 15, 1, DATE_SUB(NOW(), INTERVAL 1 DAY)),
(1, 'romantic', 8, 2, DATE_SUB(NOW(), INTERVAL 2 DAY)),
(1, 'ar rahman', 12, 3, DATE_SUB(NOW(), INTERVAL 3 DAY)),
(2, 'sad songs', 10, 4, DATE_SUB(NOW(), INTERVAL 1 DAY)),
(2, 'melody', 20, 5, DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(3, 'dance', 25, NULL, DATE_SUB(NOW(), INTERVAL 2 HOUR)),
(3, 'party songs', 18, 6, DATE_SUB(NOW(), INTERVAL 5 HOUR)),
(NULL, 'hindi songs', 30, 7, DATE_SUB(NOW(), INTERVAL 1 DAY)), -- Anonymous search
(NULL, 'bollywood', 45, NULL, DATE_SUB(NOW(), INTERVAL 2 DAY)), -- Anonymous search no click
(4, 'old songs', 22, 8, DATE_SUB(NOW(), INTERVAL 3 DAY)),
(1, 'love', 5, NULL, DATE_SUB(NOW(), INTERVAL 4 DAY)), -- No click
(2, 'heart touching', 0, NULL, DATE_SUB(NOW(), INTERVAL 1 DAY)), -- No results
(5, 'classical', 8, 9, DATE_SUB(NOW(), INTERVAL 6 HOUR)),
(3, 'rock', 12, NULL, DATE_SUB(NOW(), INTERVAL 12 HOUR)),
(1, 'ar rahman hits', 15, 10, DATE_SUB(NOW(), INTERVAL 1 DAY));

-- Insert sample user interactions
INSERT IGNORE INTO user_interactions (user_id, song_id, interaction_type, created_at) VALUES
(1, 1, 'play', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(1, 1, 'complete', DATE_SUB(NOW(), INTERVAL 23 HOUR)),
(1, 2, 'play', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(2, 4, 'play', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(2, 5, 'play', DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(2, 5, 'complete', DATE_SUB(NOW(), INTERVAL 50 MINUTE)),
(3, 6, 'play', DATE_SUB(NOW(), INTERVAL 5 HOUR)),
(3, 6, 'skip', DATE_SUB(NOW(), INTERVAL 4 HOUR)),
(4, 8, 'play', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(5, 9, 'play', DATE_SUB(NOW(), INTERVAL 6 HOUR)),
(1, 10, 'play', DATE_SUB(NOW(), INTERVAL 1 DAY));

-- Insert sample listening history
INSERT IGNORE INTO user_listening_history (user_id, song_id, listen_duration_seconds, completion_percentage, source, created_at) VALUES
(1, 1, 210, 95.5, 'search', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(1, 2, 180, 85.2, 'search', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(2, 4, 150, 70.3, 'search', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(2, 5, 220, 98.1, 'search', DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(3, 6, 45, 20.1, 'search', DATE_SUB(NOW(), INTERVAL 5 HOUR)), -- Skipped early
(4, 8, 195, 88.9, 'search', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(5, 9, 175, 82.4, 'search', DATE_SUB(NOW(), INTERVAL 6 HOUR)),
(1, 10, 200, 91.2, 'search', DATE_SUB(NOW(), INTERVAL 1 DAY));

-- Insert sample skip data
INSERT IGNORE INTO song_skips (user_id, song_id, skip_position_seconds, reason, created_at) VALUES
(3, 6, 45, 'beginning', DATE_SUB(NOW(), INTERVAL 4 HOUR)),
(1, 3, 120, 'middle', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(2, 7, 30, 'beginning', DATE_SUB(NOW(), INTERVAL 1 DAY));

-- Update songs table with interaction counts (assuming some songs exist)
UPDATE songs SET 
    play_count = (SELECT COUNT(*) FROM user_interactions WHERE song_id = songs.id AND interaction_type = 'play'),
    skip_count = (SELECT COUNT(*) FROM song_skips WHERE song_id = songs.id),
    avg_completion_rate = (SELECT AVG(completion_percentage) FROM user_listening_history WHERE song_id = songs.id)
WHERE id IN (1,2,3,4,5,6,7,8,9,10);