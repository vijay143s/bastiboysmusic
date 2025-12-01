-- Drop existing tables if they exist (in reverse order of foreign key dependencies)
DROP TABLE IF EXISTS user_playlists;
DROP TABLE IF EXISTS singers;
DROP TABLE IF EXISTS music_directors;
DROP TABLE IF EXISTS artists;
DROP TABLE IF EXISTS songs;
DROP TABLE IF EXISTS albums;
DROP TABLE IF EXISTS users;

CREATE TABLE IF NOT EXISTS users (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(191) NOT NULL,
  email VARCHAR(191) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('user', 'admin') NOT NULL DEFAULT 'user',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Albums Table
CREATE TABLE IF NOT EXISTS albums (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) UNIQUE,
    description TEXT,
    thumbnail_id INT,
    thumbnail_url VARCHAR(500),
    year INT,
    director VARCHAR(255),
    music_director VARCHAR(255),
    star_cast TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Songs Table
CREATE TABLE IF NOT EXISTS songs (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    album_id INT UNSIGNED NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    singer VARCHAR(255),
    thumbnail_id INT,
    thumbnail_url VARCHAR(500),
    audio_id INT,
    audio_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (album_id) REFERENCES albums(id) ON DELETE CASCADE
);

-- Create Index for faster queries
CREATE INDEX idx_album_title ON albums(title);
CREATE INDEX idx_song_title ON songs(title);
CREATE INDEX idx_song_album ON songs(album_id);

-- Create Artists Table
CREATE TABLE IF NOT EXISTS artists (
    artist_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    artist_name VARCHAR(255),
    album_id INT UNSIGNED NOT NULL,
    album_name VARCHAR(255) ,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (album_id) REFERENCES albums(id) ON DELETE CASCADE,
    UNIQUE KEY unique_artist_album (artist_id, album_id)
);

-- Create Singers Table
CREATE TABLE IF NOT EXISTS singers (
    singer_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    singer_name VARCHAR(255) NOT NULL,
    UNIQUE KEY unique_singer_name (singer_name)
);

-- Create Music Directors Table
CREATE TABLE IF NOT EXISTS music_directors (
    director_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    director_name VARCHAR(255) NOT NULL,
    album_id INT UNSIGNED NOT NULL,
    album_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (album_id) REFERENCES albums(id) ON DELETE CASCADE,
    UNIQUE KEY unique_director_album (director_id, album_id)
);

-- Create Indexes for faster queries
CREATE INDEX idx_artist_album ON artists(album_id);
CREATE INDEX idx_artist_name ON artists(artist_name);
CREATE INDEX idx_singer_name ON singers(singer_name);
CREATE INDEX idx_director_album ON music_directors(album_id);
CREATE INDEX idx_director_name ON music_directors(director_name);

CREATE TABLE IF NOT EXISTS user_playlists (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  song_id INT UNSIGNED NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_playlist_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_playlist_song FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE,
  CONSTRAINT uniq_playlist UNIQUE (user_id, song_id)
);
