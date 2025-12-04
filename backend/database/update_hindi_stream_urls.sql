-- DEPRECATED: Use Python script instead
-- python backend/python-scripts/update_hindi_stream_urls.py
--
-- This SQL file is kept for reference only.
-- The nested REPLACE approach exceeds MariaDB's nested function limit.
-- The Python script (update_hindi_stream_urls.py) handles URL encoding properly
-- and is much more reliable.

-- To run the Python update:
-- cd backend/python-scripts
-- python update_hindi_stream_urls.py

-- For manual inspection, you can use this query to see which songs need updating:
SELECT 
  s.id,
  s.title,
  s.audio_url,
  s.stream_url,
  a.title as album_title,
  a.language
FROM songs s
INNER JOIN albums a ON s.album_id = a.id
WHERE a.language = 'hindi'
  AND s.audio_url LIKE '%pagalworldmusic.com%'
  AND (s.stream_url IS NULL OR s.stream_url = '')
LIMIT 10;
