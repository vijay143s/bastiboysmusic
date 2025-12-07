-- Disable FK checks to allow truncation
SET FOREIGN_KEY_CHECKS=0;

-- 1. Truncate Tables (Clean Slate)
TRUNCATE TABLE user_playlists;
TRUNCATE TABLE singers;
TRUNCATE TABLE music_directors;
TRUNCATE TABLE artists;
TRUNCATE TABLE songs;
TRUNCATE TABLE albums;

-- 2. Restore ALBUMS
INSERT INTO albums (
    id, title, description, thumbnail_id, thumbnail_url, 
    year, director, music_director, star_cast, 
    created_at, updated_at
)
SELECT 
    id, title, description, thumbnail_id, thumbnail_url, 
    year, director, music_director, star_cast, 
    created_at, updated_at
FROM albums_backup;

-- 3. Restore SONGS
-- Note: 'stream_url' is missing in backup, mapping 'audio_url' to it if needed, or leaving NULL.
-- 'language' and Oracle columns are left NULL/Default.
INSERT INTO songs (
    id, album_id, title, description, singer, 
    thumbnail_id, thumbnail_url, audio_id, audio_url, 
    created_at, updated_at, 
    play_count, skip_count, like_count, avg_completion_rate
)
SELECT 
    id, album_id, title, description, singer, 
    thumbnail_id, thumbnail_url, audio_id, audio_url, 
    created_at, updated_at, 
    play_count, skip_count, like_count, avg_completion_rate
FROM songs_backup;

-- 4. Restore OTHER Tables (if backups exist and match schema)
-- Check if artists_backup exists
INSERT INTO artists (artist_id, artist_name, album_id, album_name, created_at, updated_at)
SELECT artist_id, artist_name, album_id, album_name, created_at, updated_at FROM artists_backup;

INSERT INTO music_directors (director_id, director_name, album_id, album_name, created_at, updated_at)
SELECT director_id, director_name, album_id, album_name, created_at, updated_at FROM music_directors_backup;

-- 5. Repopulate SINGERS from Songs
INSERT IGNORE INTO singers (singer_name)
SELECT DISTINCT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(singer, ',', numbers.n), ',', -1)) AS singer_name
FROM (SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) numbers 
INNER JOIN songs ON CHAR_LENGTH(singer) - CHAR_LENGTH(REPLACE(singer, ',', '')) >= numbers.n - 1
WHERE singer IS NOT NULL AND singer != '';

-- Also ensure simple distinct insert if the splitter above is too complex/slow or fails (redundancy)
INSERT IGNORE INTO singers (singer_name)
SELECT DISTINCT singer FROM songs WHERE singer IS NOT NULL AND singer NOT LIKE '%,%';

-- Re-enable FK checks
SET FOREIGN_KEY_CHECKS=1;
