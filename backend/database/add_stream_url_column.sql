-- Add stream_url column to songs table if it doesn't exist
ALTER TABLE songs 
ADD COLUMN IF NOT EXISTS stream_url VARCHAR(500) AFTER audio_url;

-- This migration adds stream_url column for pre-generated Pagal World stream URLs
-- 
-- stream_url will be populated DURING scraping for pagalworldmusic.com URLs only:
-- - For pagalworldmusic.com: stream_url = /api/audio/stream?url=<encoded-url>
-- - For other domains (sentunes.online, etc): stream_url = NULL (audio_url used directly)
--
-- No need to update existing rows - the scraper will populate new stream_url values
-- as new songs are scraped with the updated scraper.py
