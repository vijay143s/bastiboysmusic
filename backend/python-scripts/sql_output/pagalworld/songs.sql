-- Songs INSERT statements
-- Generated from scraping data with data cleanup

INSERT IGNORE INTO songs (album_id, title, singer, thumbnail_url, audio_url) VALUES
(COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1), 'Ez Ez', NULL, 'https://pagalworldmusic.com/default.webp', 'https://pagalworldmusic.com/downloads/low/HFxcBAIEZ0A/HFxcBAIEZ0A.mp3'),
(COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1), 'Shararat', NULL, 'https://pagalworldmusic.com/default.webp', 'https://pagalworldmusic.com/downloads/low/Ozg,SDFFe2A/Ozg,SDFFe2A.mp3'),
(COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1), 'Run Down The City Monica', NULL, 'https://pagalworldmusic.com/default.webp', 'https://pagalworldmusic.com/downloads/low/Qww5Zi1DWEA/Qww5Zi1DWEA.mp3'),
(COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1), 'Gehra Hua', NULL, 'https://pagalworldmusic.com/default.webp', 'https://pagalworldmusic.com/downloads/low/QQ8jRRlhBEs/QQ8jRRlhBEs.mp3'),
(COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1), 'Ishq Jalakar Karvaan', NULL, 'https://pagalworldmusic.com/default.webp', 'https://pagalworldmusic.com/downloads/low/AiYsBg1IeEU/AiYsBg1IeEU.mp3'),
(COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1), 'Dhurandhar Title Track', NULL, 'https://pagalworldmusic.com/default.webp', 'https://pagalworldmusic.com/downloads/low/H1o-WDt9eEY/H1o-WDt9eEY.mp3');

