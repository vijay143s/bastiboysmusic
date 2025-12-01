-- Database optimization indexes for improved performance
-- Run this SQL script to add indexes for faster queries

-- Albums table indexes
CREATE INDEX IF NOT EXISTS idx_albums_created_at ON albums(created_at);
CREATE INDEX IF NOT EXISTS idx_albums_year ON albums(year);
CREATE INDEX IF NOT EXISTS idx_albums_title ON albums(title);

-- Artists table indexes  
CREATE INDEX IF NOT EXISTS idx_artists_artist_name ON artists(artist_name);
CREATE INDEX IF NOT EXISTS idx_artists_album_id ON artists(album_id);
CREATE INDEX IF NOT EXISTS idx_artists_name_id ON artists(artist_name, artist_id);

-- Singers table indexes
CREATE INDEX IF NOT EXISTS idx_singers_singer_name ON singers(singer_name);
CREATE INDEX IF NOT EXISTS idx_singers_name_id ON singers(singer_name, singer_id);

-- Music Directors table indexes
CREATE INDEX IF NOT EXISTS idx_music_directors_director_name ON music_directors(director_name);
CREATE INDEX IF NOT EXISTS idx_music_directors_album_id ON music_directors(album_id);
CREATE INDEX IF NOT EXISTS idx_music_directors_name_id ON music_directors(director_name, director_id);

-- Songs table indexes
CREATE INDEX IF NOT EXISTS idx_songs_album ON songs(album);
CREATE INDEX IF NOT EXISTS idx_songs_singer ON songs(singer);
CREATE INDEX IF NOT EXISTS idx_songs_title ON songs(title);

-- Show current indexes
SHOW INDEX FROM albums;
SHOW INDEX FROM artists;
SHOW INDEX FROM singers;
SHOW INDEX FROM music_directors;
SHOW INDEX FROM songs;