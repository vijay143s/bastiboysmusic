-- Artists INSERT statements
-- Generated from scraping data with data cleanup

INSERT IGNORE INTO artists (artist_name, album_id, album_name) VALUES
('Hanumankind', COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1), 'Dhurandhar'),
('Irshad Kamil', COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1), 'Dhurandhar'),
('Jasmine Sandlas', COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1), 'Dhurandhar'),
('Reble', COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1), 'Dhurandhar');

