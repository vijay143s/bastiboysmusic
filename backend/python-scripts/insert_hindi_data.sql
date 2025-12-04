-- Generated SQL Insert Statements
-- Generated on: 2025-12-04T19:40:37.107229
-- Language: HINDI
-- Total Albums: 5
-- Total Songs: 15

-- ============================================================
-- IMPORTANT NOTES:
-- ============================================================
-- 1. This script assumes the database schema is already created
-- 2. Insert albums FIRST (before songs)
-- 3. Update song INSERT statements with correct album_id values
-- 4. This is generated from language page scraping (may lack full details)
-- 5. You may need to manually add singer, artist, and music_director data
-- ============================================================

SET FOREIGN_KEY_CHECKS=0;

-- ============================================================
-- ALBUMS INSERT
-- ============================================================

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

-- Total albums inserted: 5

-- ============================================================
-- SONGS INSERT
-- ============================================================
-- NOTE: You need to query album IDs from the albums table
-- and replace the placeholder album_id values below
-- Example query: SELECT id, title FROM albums;
-- ============================================================

-- Song: Tu Meri Main Tera Main Tera Tu Meri Title Track From Tu Meri Main Tera Main Tera Tu Meri
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'Tu Meri Main Tera Main Tera Tu Meri Title Track From Tu Meri Main Tera Main Tera Tu Meri',
    'Anvita Dutt Guptan | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song: Chal Musafir From Gustaakh Ishq
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'Chal Musafir From Gustaakh Ishq',
    'Armaan Malik | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song: Hey Penne
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'Hey Penne',
    'Neeraj Kumar | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song: Ishq Jalakar Karvaan From Dhurandhar
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'Ishq Jalakar Karvaan From Dhurandhar',
    'Irshad Kamil | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song: Rebel Saab From The Rajasaab Hindi
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'Rebel Saab From The Rajasaab Hindi',
    'Thaman S | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song: He Dil Pagal Pagal Hogaya From Chimera
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'He Dil Pagal Pagal Hogaya From Chimera',
    'Anuradha Bhat | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song: One In Crore From Mastiii 4
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'One In Crore From Mastiii 4',
    'Kanika Kapoor | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song: The Thaandavam From Akhanda 2 ThaandavamHindi
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'The Thaandavam From Akhanda 2 ThaandavamHindi',
    'Jubin Nautiyal | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song: Mehndi Laagi
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'Mehndi Laagi',
    'Moti Khan | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song: Nobody Came
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'Nobody Came',
    'Dhanda Nyoliwala | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song: They Call Him KING King Theme From King
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'They Call Him KING King Theme From King',
    'Anirudh Ravichander | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song: Sundara From Non Violence
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'Sundara From Non Violence',
    'Yuvan Shankar Raja | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song: Aakhri Salaam From De De Pyaar De 2
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'Aakhri Salaam From De De Pyaar De 2',
    'Sagar Bhatia | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song: Rasiya Balama From Mastiii 4
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'Rasiya Balama From Mastiii 4',
    'Sanjeev Chaturvedi | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Song: Chikiri Chikiri From Peddi Hindi
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    'Chikiri Chikiri From Peddi Hindi',
    'A.R. Rahman | Total songs = 1',
    NULL,
    NULL,
    NOW(),
    NOW()
);

-- Total songs inserted: 15

-- ============================================================
-- OPTIONAL: Singer, Artist, Music Director inserts
-- ============================================================
-- These require mapping from song metadata
-- Uncomment and modify as needed based on your requirements
-- ============================================================

SET FOREIGN_KEY_CHECKS=1;

-- End of generated script
