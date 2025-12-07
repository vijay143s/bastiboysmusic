-- DELETE statements for language-specific full reload
-- Deleting all TAMIL language data

START TRANSACTION;

-- Delete songs from this language's albums
DELETE FROM songs
WHERE album_id IN (
  SELECT id FROM albums WHERE language = 'tamil'
);

-- Delete albums with language = tamil
DELETE FROM albums
WHERE language = 'tamil';

COMMIT;

-- All data for language deleted. New data will be inserted next.
