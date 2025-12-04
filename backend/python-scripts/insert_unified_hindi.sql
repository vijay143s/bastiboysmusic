-- Unified SQL Insert Statements
-- Generated on: 2025-12-04T19:56:18.619959
-- Language: HINDI
-- Total Items: 20 (Albums: 5, Songs: 15)

-- ============================================================
-- EXECUTION INSTRUCTIONS:
-- ============================================================
-- 1. Backup your database first
-- 2. Execute this script in your MySQL client
-- 3. Albums will be inserted first (auto_increment ID)
-- 4. Songs will be linked to albums using COALESCE
-- 5. If album doesn't exist, will default to album_id = 1
-- ============================================================

SET FOREIGN_KEY_CHECKS=0;

-- ============================================================
-- ALBUMS INSERT
-- ============================================================

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Dhurandhar',
    'Reble | Total songs = 6',
    'https://pagalworldmusic.com/downloads/cover/4578394/4578394.jpg',
    2025,
    NULL,
    'Song Com Download',
    'hindi',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'De De Pyaar De 2 Deluxe Album',
    'Yo Yo Honey Singh | Total songs = 6',
    'https://pagalworldmusic.com/downloads/cover/4578106/4578106.jpg',
    2025,
    NULL,
    'Song Com Download',
    'hindi',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Ek Deewane Ki Deewaniyat',
    'Prince Dubey | Total songs = 2',
    'https://pagalworldmusic.com/downloads/cover/4578100/4578100.jpg',
    2025,
    NULL,
    'Song Com Download',
    'hindi',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Tere Ishk Mein',
    'A.R. Rahman | Total songs = 8',
    'https://pagalworldmusic.com/downloads/cover/4577878/4577878.jpg',
    2025,
    NULL,
    'Song Com Download',
    'hindi',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    '120 Bahadur Original Motion Picture Soundtrack',
    'Javed Akhtar | Total songs = 4',
    'https://pagalworldmusic.com/downloads/cover/4577760/4577760.jpg',
    2025,
    NULL,
    'Song Com Download',
    'hindi',
    NOW(),
    NOW()
);

-- Total albums inserted: 5

-- ============================================================
-- SONGS INSERT (with album lookup using COALESCE)
-- ============================================================
-- Album ID is looked up by title, defaults to 1 if not found
-- ============================================================

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'Tu Meri Main Tera Main Tera Tu Meri Title Track From Tu Meri Main Tera Main Tera Tu Meri',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4578388/4578388.jpg',
    '/download.php?title=Tu+Meri+Main+Tera+Main+Tera+Tu+Meri+Title+Track+From+Tu+Meri+Main+Tera+Main+Tera+Tu+Meri-320kbps&path=downloads%2Fhigh%2FJhgDUB5ZWWo%2FJhgDUB5ZWWo.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'Chal Musafir From Gustaakh Ishq',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4578387/4578387.jpg',
    '/download.php?title=Chal+Musafir+From+Gustaakh+Ishq-320kbps&path=downloads%2Fhigh%2FNS8vSQFhdEc%2FNS8vSQFhdEc.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'Hey Penne',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4578340/4578340.jpg',
    '/download.php?title=Hey+Penne-320kbps&path=downloads%2Fhigh%2FFj0bdB5CUmw%2FFj0bdB5CUmw.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'Ishq Jalakar Karvaan From Dhurandhar',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4578219/4578219.jpg',
    '/download.php?title=Ishq+Jalakar+Karvaan+From+Dhurandhar-320kbps&path=downloads%2Fhigh%2FBgcpSRBAe3k%2FBgcpSRBAe3k.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'Rebel Saab From The Rajasaab Hindi',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4578218/4578218.jpg',
    '/download.php?title=Rebel+Saab+From+The+Rajasaab+Hindi-320kbps&path=downloads%2Fhigh%2FNFgfCRJWRgA%2FNFgfCRJWRgA.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'He Dil Pagal Pagal Hogaya From Chimera',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4578217/4578217.jpg',
    '/download.php?title=He+Dil+Pagal+Pagal+Hogaya+From+Chimera-320kbps&path=downloads%2Fhigh%2FChscR0B4WQc%2FChscR0B4WQc.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'One In Crore From Mastiii 4',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4577987/4577987.jpg',
    '/download.php?title=One+In+Crore+From+Mastiii+4-320kbps&path=downloads%2Fhigh%2FGDkdfBhKbVY%2FGDkdfBhKbVY.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'The Thaandavam From Akhanda 2 ThaandavamHindi',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4577986/4577986.jpg',
    '/download.php?title=The+Thaandavam+From+Akhanda+2+ThaandavamHindi-320kbps&path=downloads%2Fhigh%2FM14xUzpcbWU%2FM14xUzpcbWU.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'Mehndi Laagi',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4577960/4577960.jpg',
    '/download.php?title=Mehndi+Laagi-320kbps&path=downloads%2Fhigh%2FIh86ewFzUFk%2FIh86ewFzUFk.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'Nobody Came',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4577959/4577959.jpg',
    '/download.php?title=Nobody+Came-320kbps&path=downloads%2Fhigh%2FJjwAdBZiDnk%2FJjwAdBZiDnk.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'They Call Him KING King Theme From King',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4577869/4577869.jpg',
    '/download.php?title=They+Call+Him+KING+King+Theme+From+King-320kbps&path=downloads%2Fhigh%2FCTgzdEZbXkk%2FCTgzdEZbXkk.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'Sundara From Non Violence',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4577868/4577868.jpg',
    '/download.php?title=Sundara+From+Non+Violence-320kbps&path=downloads%2Fhigh%2FIkUMVRlVf3c%2FIkUMVRlVf3c.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'Aakhri Salaam From De De Pyaar De 2',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4577803/4577803.jpg',
    '/download.php?title=Aakhri+Salaam+From+De+De+Pyaar+De+2-320kbps&path=downloads%2Fhigh%2FNjocXCR6elg%2FNjocXCR6elg.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'Rasiya Balama From Mastiii 4',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4577802/4577802.jpg',
    '/download.php?title=Rasiya+Balama+From+Mastiii+4-320kbps&path=downloads%2Fhigh%2FGxszVyt3AGM%2FGxszVyt3AGM.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 's' LIMIT 1), 1),
    'Chikiri Chikiri From Peddi Hindi',
    'Load More',
    'https://pagalworldmusic.com/downloads/cover/4577755/4577755.jpg',
    '/download.php?title=Chikiri+Chikiri+From+Peddi+Hindi-320kbps&path=downloads%2Fhigh%2FEQUTeS1DdQo%2FEQUTeS1DdQo.mp3',
    NOW(),
    NOW()
);

-- Total songs inserted: 15

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check albums inserted
SELECT COUNT(*) as album_count FROM albums WHERE created_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE);

-- Check songs inserted
SELECT COUNT(*) as song_count FROM songs WHERE created_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE);

-- Check album-song relationships
SELECT 
    a.id,
    a.title as album,
    COUNT(s.id) as song_count
FROM albums a
LEFT JOIN songs s ON a.id = s.album_id
WHERE a.created_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
GROUP BY a.id, a.title
ORDER BY a.title;

SET FOREIGN_KEY_CHECKS=1;

-- End of script
