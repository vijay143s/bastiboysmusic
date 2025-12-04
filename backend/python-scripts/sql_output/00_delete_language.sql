-- DELETE statements for language-specific full reload
-- Deleting all HINDI language data

START TRANSACTION;

-- Delete songs from this language's albums
DELETE FROM songs
WHERE album_id IN (
  SELECT id FROM albums WHERE language = 'hindi'
);

-- Delete albums with language = hindi
DELETE FROM albums
WHERE language = 'hindi';

COMMIT;

-- All data for language deleted. New data will be inserted next.
