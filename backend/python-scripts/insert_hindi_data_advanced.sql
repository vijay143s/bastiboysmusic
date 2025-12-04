-- Generated SQL Insert Statements (Advanced)
-- Generated on: 2025-12-04T19:41:21.995627
-- Language: HINDI
-- Total Albums: 5
-- Total Songs: 15

-- ============================================================
-- EXECUTION STEPS:
-- ============================================================
-- 1. Backup your database before running this script
-- 2. Run this script in a transaction (BEGIN; ... COMMIT;)
-- 3. Verify counts after execution
-- 4. Manually add singer, artist, and music_director data
-- ============================================================

SET FOREIGN_KEY_CHECKS=0;
START TRANSACTION;

-- ============================================================
-- ALBUMS INSERT
-- ============================================================

-- Album 1
INSERT INTO albums (
    title,
    description,
    thumbnail_url,
    language,
    created_at,
    updated_at
) VALUES (
    'Dhurandhar',
    'Reble | Total songs = 6',
    NULL,
    'hindi',
    NOW(),
    NOW()
);

-- Album 2
INSERT INTO albums (
    title,
    description,
    thumbnail_url,
    language,
    created_at,
    updated_at
) VALUES (
    'De De Pyaar De 2 Deluxe Album',
    'Yo Yo Honey Singh | Total songs = 6',
    NULL,
    'hindi',
    NOW(),
    NOW()
);

-- Album 3
INSERT INTO albums (
    title,
    description,
    thumbnail_url,
    language,
    created_at,
    updated_at
) VALUES (
    'Ek Deewane Ki Deewaniyat',
    'Prince Dubey | Total songs = 2',
    NULL,
    'hindi',
    NOW(),
    NOW()
);

-- Album 4
INSERT INTO albums (
    title,
    description,
    thumbnail_url,
    language,
    created_at,
    updated_at
) VALUES (
    'Tere Ishk Mein',
    'A.R. Rahman | Total songs = 8',
    NULL,
    'hindi',
    NOW(),
    NOW()
);

-- Album 5
INSERT INTO albums (
    title,
    description,
    thumbnail_url,
    language,
    created_at,
    updated_at
) VALUES (
    '120 Bahadur Original Motion Picture Soundtrack',
    'Javed Akhtar | Total songs = 4',
    NULL,
    'hindi',
    NOW(),
    NOW()
);

-- Total albums: 5

-- ============================================================
-- SONGS INSERT
-- ============================================================

-- Song 1
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- Album: Dhurandhar
    'Tu Meri Main Tera Main Tera Tu Meri Title Track From Tu Meri Main Tera Main Tera Tu Meri',
    'Anvita Dutt Guptan | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song 2
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- Album: Dhurandhar
    'Chal Musafir From Gustaakh Ishq',
    'Armaan Malik | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song 3
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    3,  -- Album: Ek Deewane Ki Deewaniyat
    'Hey Penne',
    'Neeraj Kumar | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song 4
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- Album: Dhurandhar
    'Ishq Jalakar Karvaan From Dhurandhar',
    'Irshad Kamil | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song 5
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    4,  -- Album: Tere Ishk Mein
    'Rebel Saab From The Rajasaab Hindi',
    'Thaman S | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song 6
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- Album: Dhurandhar
    'He Dil Pagal Pagal Hogaya From Chimera',
    'Anuradha Bhat | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song 7
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    4,  -- Album: Tere Ishk Mein
    'One In Crore From Mastiii 4',
    'Kanika Kapoor | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song 8
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    2,  -- Album: De De Pyaar De 2 Deluxe Album
    'The Thaandavam From Akhanda 2 ThaandavamHindi',
    'Jubin Nautiyal | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song 9
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- Album: Dhurandhar
    'Mehndi Laagi',
    'Moti Khan | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song 10
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- Album: Dhurandhar
    'Nobody Came',
    'Dhanda Nyoliwala | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song 11
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    3,  -- Album: Ek Deewane Ki Deewaniyat
    'They Call Him KING King Theme From King',
    'Anirudh Ravichander | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song 12
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- Album: Dhurandhar
    'Sundara From Non Violence',
    'Yuvan Shankar Raja | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song 13
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    2,  -- Album: De De Pyaar De 2 Deluxe Album
    'Aakhri Salaam From De De Pyaar De 2',
    'Sagar Bhatia | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song 14
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- Album: Dhurandhar
    'Rasiya Balama From Mastiii 4',
    'Sanjeev Chaturvedi | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song 15
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    3,  -- Album: Ek Deewane Ki Deewaniyat
    'Chikiri Chikiri From Peddi Hindi',
    'A.R. Rahman | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Total songs: 15

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Verify albums inserted
SELECT COUNT(*) as album_count FROM albums WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 MINUTE);

-- Verify songs inserted
SELECT COUNT(*) as song_count FROM songs WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 MINUTE);

-- Verify song-album relationships
SELECT 
    a.title as album,
    COUNT(s.id) as song_count
FROM albums a
LEFT JOIN songs s ON a.id = s.album_id
WHERE a.created_at >= DATE_SUB(NOW(), INTERVAL 1 MINUTE)
GROUP BY a.id, a.title
ORDER BY a.title;

COMMIT;
SET FOREIGN_KEY_CHECKS=1;

-- End of script
