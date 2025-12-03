-- User Interaction Tracking Tables for Recommendation Engine
-- Drop existing tables if they exist
DROP TABLE IF EXISTS user_interactions;
DROP TABLE IF EXISTS user_listening_history;
DROP TABLE IF EXISTS user_search_history;
DROP TABLE IF EXISTS song_skips;

-- Track all user interactions with songs (plays, likes, skips)
CREATE TABLE IF NOT EXISTS user_interactions (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  song_id INT UNSIGNED NOT NULL,
  interaction_type ENUM('play', 'like', 'skip', 'complete') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE,
  INDEX idx_user_song (user_id, song_id),
  INDEX idx_interaction_type (interaction_type),
  INDEX idx_created_at (created_at)
);

-- Track detailed listening history with duration
CREATE TABLE IF NOT EXISTS user_listening_history (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  song_id INT UNSIGNED NOT NULL,
  listen_duration_seconds INT UNSIGNED DEFAULT 0,
  completion_percentage DECIMAL(5,2) DEFAULT 0,
  source VARCHAR(100) DEFAULT 'unknown', -- 'album', 'playlist', 'search', 'queue', 'artist'
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE,
  INDEX idx_user_history (user_id, created_at),
  INDEX idx_song_history (song_id, created_at),
  INDEX idx_completion (completion_percentage)
);

-- Track search queries for trend analysis
CREATE TABLE IF NOT EXISTS user_search_history (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED,
  search_query VARCHAR(500) NOT NULL,
  results_count INT UNSIGNED DEFAULT 0,
  clicked_song_id INT UNSIGNED,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
  FOREIGN KEY (clicked_song_id) REFERENCES songs(id) ON DELETE SET NULL,
  INDEX idx_user_searches (user_id, created_at),
  INDEX idx_search_query (search_query(255)),
  INDEX idx_created_at (created_at)
);

-- Track song skip patterns
CREATE TABLE IF NOT EXISTS song_skips (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  song_id INT UNSIGNED NOT NULL,
  skip_position_seconds INT UNSIGNED DEFAULT 0,
  reason VARCHAR(100), -- 'beginning', 'middle', 'end'
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE,
  INDEX idx_user_skips (user_id, song_id),
  INDEX idx_skip_patterns (song_id, created_at)
);

-- Add columns to existing songs table for interaction metrics (if not exists)
ALTER TABLE songs 
ADD COLUMN IF NOT EXISTS play_count INT UNSIGNED DEFAULT 0,
ADD COLUMN IF NOT EXISTS skip_count INT UNSIGNED DEFAULT 0,
ADD COLUMN IF NOT EXISTS like_count INT UNSIGNED DEFAULT 0,
ADD COLUMN IF NOT EXISTS avg_completion_rate DECIMAL(5,2) DEFAULT 0;

-- Create indexes on songs for better recommendation queries
CREATE INDEX IF NOT EXISTS idx_song_play_count ON songs(play_count DESC);
CREATE INDEX IF NOT EXISTS idx_song_like_count ON songs(like_count DESC);
CREATE INDEX IF NOT EXISTS idx_song_skip_count ON songs(skip_count ASC);
CREATE INDEX IF NOT EXISTS idx_song_completion_rate ON songs(avg_completion_rate DESC);

-- Add last_played column to user_playlists for recency tracking
ALTER TABLE user_playlists 
ADD COLUMN IF NOT EXISTS last_played_at TIMESTAMP NULL,
ADD COLUMN IF NOT EXISTS play_count INT UNSIGNED DEFAULT 0;
