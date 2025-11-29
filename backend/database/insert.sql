-- === Albums ===
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT * FROM (SELECT 'Ak Thaluka', 'Imported album Ak Thaluka', NULL, NULL) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Ak Thaluka') LIMIT 1;
SET @album_Ak_Thaluka = (SELECT id FROM albums WHERE title='Ak Thaluka' LIMIT 1);

INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT * FROM (SELECT 'Akhanda 2', 'Imported album Akhanda 2', NULL, NULL) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Akhanda 2') LIMIT 1;
SET @album_Akhanda_2 = (SELECT id FROM albums WHERE title='Akhanda 2' LIMIT 1);

INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT * FROM (SELECT 'Anaganaga Oka Roju', 'Imported album Anaganaga Oka Roju', NULL, NULL) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Anaganaga Oka Roju') LIMIT 1;
SET @album_Anaganaga_Oka_Roju = (SELECT id FROM albums WHERE title='Anaganaga Oka Roju' LIMIT 1);

INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT * FROM (SELECT 'Andra King Thaluka', 'Imported album Andra King Thaluka', NULL, NULL) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Andra King Thaluka') LIMIT 1;
SET @album_Andra_King_Thaluka = (SELECT id FROM albums WHERE title='Andra King Thaluka' LIMIT 1);

INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT * FROM (SELECT 'Arjun Son of Vyjayanthi', 'Imported album Arjun Son of Vyjayanthi', NULL, NULL) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Arjun Son of Vyjayanthi') LIMIT 1;
SET @album_Arjun_Son_of_Vyjayanthi = (SELECT id FROM albums WHERE title='Arjun Son of Vyjayanthi' LIMIT 1);

INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT * FROM (SELECT 'Bhairavam', 'Imported album Bhairavam', NULL, NULL) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Bhairavam') LIMIT 1;
SET @album_Bhairavam = (SELECT id FROM albums WHERE title='Bhairavam' LIMIT 1);

INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT * FROM (SELECT 'Biker', 'Imported album Biker', NULL, NULL) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Biker') LIMIT 1;
SET @album_Biker = (SELECT id FROM albums WHERE title='Biker' LIMIT 1);

-- === Songs ===
INSERT INTO songs (title, description, singer, thumbnail_id, thumbnail_url, audio_id, audio_url, album_id)
VALUES
('Nuvvunte Chaley', 'Imported from Ak Thaluka/Nuvvunte Chaley.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Ak%20Thaluka/Nuvvunte%20Chaley.mp3', @album_Ak_Thaluka),

('Jajikaya Jajikaya', 'Imported from Akhanda 2/Akhanda 2 - HQ/Jajikaya Jajikaya.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Akhanda%202/Akhanda%202%20-%20HQ/Jajikaya%20Jajikaya.mp3', @album_Akhanda_2),
('The Thaandavam (HQ)', 'Imported from Akhanda 2/Akhanda 2 - HQ/The Thaandavam.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Akhanda%202/Akhanda%202%20-%20HQ/The%20Thaandavam.mp3', @album_Akhanda_2),
('Jajikaya Jajikaya (Alt)', 'Imported from Akhanda 2/Akhanda 2/2-Jajikaya Jajikaya.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Akhanda%202/Akhanda%202/2-Jajikaya%20Jajikaya.mp3', @album_Akhanda_2),
('The Thaandavam', 'Imported from Akhanda 2/Akhanda 2/The Thaandavam.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Akhanda%202/Akhanda%202/The%20Thaandavam.mp3', @album_Akhanda_2),

('Bhimavaram Balma', 'Imported from Anaganaga Oka Roju/Bhimavaram Balma.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Anaganaga%20Oka%20Roju/Bhimavaram%20Balma.mp3', @album_Anaganaga_Oka_Roju),

('Chalu', 'Imported from Andra King Thaluka/Chalu.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Andra%20King%20Thaluka/Chalu.mp3', @album_Andra_King_Thaluka),
('Chinni Gundelo', 'Imported from Andra King Thaluka/Chinni Gundelo.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Andra%20King%20Thaluka/Chinni%20Gundelo.mp3', @album_Andra_King_Thaluka),
('First Day First Show', 'Imported from Andra King Thaluka/First Day First Show.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Andra%20King%20Thaluka/First%20Day%20First%20Show.mp3', @album_Andra_King_Thaluka),
('Padu Padu', 'Imported from Andra King Thaluka/Padu Padu.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Andra%20King%20Thaluka/Padu%20Padu.mp3', @album_Andra_King_Thaluka),
('Puppy Shame', 'Imported from Andra King Thaluka/Puppy Shame.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Andra%20King%20Thaluka/Puppy%20Shame.mp3', @album_Andra_King_Thaluka),
('Untold Emotions', 'Imported from Andra King Thaluka/Untold Emotions.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Andra%20King%20Thaluka/Untold%20Emotions.mp3', @album_Andra_King_Thaluka),

('Muchataga Bandhaale', 'Imported from Arjun Son of Vyjayanthi/Muchataga Bandhaale.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Arjun%20Son%20of%20Vyjayanthi/Muchataga%20Bandhaale.mp3', @album_Arjun_Son_of_Vyjayanthi),
('Nayaaldhi', 'Imported from Arjun Son of Vyjayanthi/Nayaaldhi.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Arjun%20Son%20of%20Vyjayanthi/Nayaaldhi.mp3', @album_Arjun_Son_of_Vyjayanthi),

('Bhairavam Theme', 'Imported from Bhairavam/Bhairavam Theme.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Bhairavam/Bhairavam%20Theme.mp3', @album_Bhairavam),
('Dum Damaare', 'Imported from Bhairavam/Dum Damaare.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Bhairavam/Dum%20Damaare.mp3', @album_Bhairavam),
('Oo Vennela', 'Imported from Bhairavam/Oo Vennela.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Bhairavam/Oo%20Vennela.mp3', @album_Bhairavam),

('Preety Baby', 'Imported from Biker/Preety Baby.mp3', 'Unknown', NULL, NULL, NULL, 'https://mp3teluguwap.net/mp3/2025/Biker/Preety%20Baby.mp3', @album_Biker);