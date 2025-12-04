-- Set admin user
UPDATE users SET role = 'admin' WHERE email = 'vijay@gmail.com';

-- Add featured column to songs table if it doesn't exist
ALTER TABLE songs ADD COLUMN IF NOT EXISTS is_featured BOOLEAN DEFAULT FALSE;

-- Add play_count column to songs table if it doesn't exist
ALTER TABLE songs ADD COLUMN IF NOT EXISTS play_count INT UNSIGNED DEFAULT 0;

-- Add year column to songs table if it doesn't exist  
ALTER TABLE songs ADD COLUMN IF NOT EXISTS year INT;

-- Rename audio_url to song_url for consistency (if needed)
-- ALTER TABLE songs CHANGE COLUMN audio_url song_url VARCHAR(500);