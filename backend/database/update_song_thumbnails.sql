-- Update songs thumbnail_url from albums thumbnail_url based on album_id join
UPDATE songs s
INNER JOIN albums a ON s.album_id = a.id
SET s.thumbnail_url = a.thumbnail_url
WHERE s.thumbnail_url IS NULL OR s.thumbnail_url = '';

-- Or if you want to update ALL songs with album thumbnail (overwrite existing):
UPDATE songs s
INNER JOIN albums a ON s.album_id = a.id
SET s.thumbnail_url = a.thumbnail_url;

-- Verify the update
SELECT 
  s.id,
  s.title,
  s.album_id,
  s.thumbnail_url,
  a.title as album_title,
  a.thumbnail_url as album_thumbnail
FROM songs s
INNER JOIN albums a ON s.album_id = a.id
LIMIT 10;
