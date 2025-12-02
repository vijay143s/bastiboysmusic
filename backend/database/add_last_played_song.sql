-- Add last_played_song_id column to users table
ALTER TABLE users ADD COLUMN IF NOT EXISTS last_played_song_id INT UNSIGNED NULL;
ALTER TABLE users ADD CONSTRAINT fk_users_last_played_song 
  FOREIGN KEY (last_played_song_id) REFERENCES songs(id) ON DELETE SET NULL;
