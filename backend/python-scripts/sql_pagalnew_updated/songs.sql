-- Songs INSERT statements

INSERT IGNORE INTO songs (album_id, title, singer, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    'Run Down The City Monica  Song  - Dhurandhar',
    '',
    'https://pagalnew.com/images/loading.svg',
    'https://pagalnew.com/320-download/52705',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    'Gehra Hua  Song  - Dhurandhar',
    '',
    'https://pagalnew.com/images/loading.svg',
    'https://pagalnew.com/320-download/52703',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    'Ishq Jalakar  Song  - Dhurandhar',
    '',
    'https://pagalnew.com/images/loading.svg',
    'https://pagalnew.com/320-download/52675',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    'Shararat  Song  - Dhurandhar',
    '',
    'https://pagalnew.com/images/loading.svg',
    'https://pagalnew.com/320-download/52706',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    'Ez Ez  Song  - Dhurandhar',
    '',
    'https://pagalnew.com/images/loading.svg',
    'https://pagalnew.com/320-download/52704',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    'Title Track  Song  - Dhurandhar',
    '',
    'https://pagalnew.com/images/loading.svg',
    'https://pagalnew.com/320-download/52483',
    NOW(), NOW());
