-- === Albums ===
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Aa Okkati Adakku' AS title, 'Imported album Aa Okkati Adakku' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Aa Okkati Adakku') LIMIT 1;
SET @album_Aa_Okkati_Adakku = (SELECT id FROM albums WHERE title='Aa Okkati Adakku' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Amaran' AS title, 'Imported album Amaran' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Amaran') LIMIT 1;
SET @album_Amaran = (SELECT id FROM albums WHERE title='Amaran' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Amma Paata' AS title, 'Imported album Amma Paata' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Amma Paata') LIMIT 1;
SET @album_Amma_Paata = (SELECT id FROM albums WHERE title='Amma Paata' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Appudo Ippudo yeppudo' AS title, 'Imported album Appudo Ippudo yeppudo' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Appudo Ippudo yeppudo') LIMIT 1;
SET @album_Appudo_Ippudo_yeppudo = (SELECT id FROM albums WHERE title='Appudo Ippudo yeppudo' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'ARM' AS title, 'Imported album ARM' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='ARM') LIMIT 1;
SET @album_ARM = (SELECT id FROM albums WHERE title='ARM' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Bachala Malli' AS title, 'Imported album Bachala Malli' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Bachala Malli') LIMIT 1;
SET @album_Bachala_Malli = (SELECT id FROM albums WHERE title='Bachala Malli' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Bhaje Vaayu Vegam' AS title, 'Imported album Bhaje Vaayu Vegam' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Bhaje Vaayu Vegam') LIMIT 1;
SET @album_Bhaje_Vaayu_Vegam = (SELECT id FROM albums WHERE title='Bhaje Vaayu Vegam' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Bharatiyudu 2' AS title, 'Imported album Bharatiyudu 2' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Bharatiyudu 2') LIMIT 1;
SET @album_Bharatiyudu_2 = (SELECT id FROM albums WHERE title='Bharatiyudu 2' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Bhimaa' AS title, 'Imported album Bhimaa' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Bhimaa') LIMIT 1;
SET @album_Bhimaa = (SELECT id FROM albums WHERE title='Bhimaa' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Coolie' AS title, 'Imported album Coolie' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Coolie') LIMIT 1;
SET @album_Coolie = (SELECT id FROM albums WHERE title='Coolie' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Devara' AS title, 'Imported album Devara' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Devara') LIMIT 1;
SET @album_Devara = (SELECT id FROM albums WHERE title='Devara' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Devara (2024)' AS title, 'Imported album Devara (2024)' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Devara (2024)') LIMIT 1;
SET @album_Devara_2024 = (SELECT id FROM albums WHERE title='Devara (2024)' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Double Ismart' AS title, 'Imported album Double Ismart' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Double Ismart') LIMIT 1;
SET @album_Double_Ismart = (SELECT id FROM albums WHERE title='Double Ismart' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Eagle' AS title, 'Imported album Eagle' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Eagle') LIMIT 1;
SET @album_Eagle = (SELECT id FROM albums WHERE title='Eagle' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Family Star' AS title, 'Imported album Family Star' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Family Star') LIMIT 1;
SET @album_Family_Star = (SELECT id FROM albums WHERE title='Family Star' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Gaami' AS title, 'Imported album Gaami' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Gaami') LIMIT 1;
SET @album_Gaami = (SELECT id FROM albums WHERE title='Gaami' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Game Changer' AS title, 'Imported album Game Changer' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Game Changer') LIMIT 1;
SET @album_Game_Changer = (SELECT id FROM albums WHERE title='Game Changer' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Gang Of Godavari' AS title, 'Imported album Gang Of Godavari' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Gang Of Godavari') LIMIT 1;
SET @album_Gang_Of_Godavari = (SELECT id FROM albums WHERE title='Gang Of Godavari' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Goat' AS title, 'Imported album Goat' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Goat') LIMIT 1;
SET @album_Goat = (SELECT id FROM albums WHERE title='Goat' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Guntur Karam' AS title, 'Imported album Guntur Karam' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Guntur Karam') LIMIT 1;
SET @album_Guntur_Karam = (SELECT id FROM albums WHERE title='Guntur Karam' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Hanuman' AS title, 'Imported album Hanuman' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Hanuman') LIMIT 1;
SET @album_Hanuman = (SELECT id FROM albums WHERE title='Hanuman' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Indian 2' AS title, 'Imported album Indian 2' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Indian 2') LIMIT 1;
SET @album_Indian_2 = (SELECT id FROM albums WHERE title='Indian 2' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Kalki' AS title, 'Imported album Kalki' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Kalki') LIMIT 1;
SET @album_Kalki = (SELECT id FROM albums WHERE title='Kalki' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Kalki 2989 AD' AS title, 'Imported album Kalki 2989 AD' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Kalki 2989 AD') LIMIT 1;
SET @album_Kalki_2989_AD = (SELECT id FROM albums WHERE title='Kalki 2989 AD' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Kanguva' AS title, 'Imported album Kanguva' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Kanguva') LIMIT 1;
SET @album_Kanguva = (SELECT id FROM albums WHERE title='Kanguva' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Love Me (2024)' AS title, 'Imported album Love Me (2024)' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Love Me (2024)') LIMIT 1;
SET @album_Love_Me_2024 = (SELECT id FROM albums WHERE title='Love Me (2024)' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Lucky Bhaskar' AS title, 'Imported album Lucky Bhaskar' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Lucky Bhaskar') LIMIT 1;
SET @album_Lucky_Bhaskar = (SELECT id FROM albums WHERE title='Lucky Bhaskar' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Mad Square' AS title, 'Imported album Mad Square' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Mad Square') LIMIT 1;
SET @album_Mad_Square = (SELECT id FROM albums WHERE title='Mad Square' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Manamey' AS title, 'Imported album Manamey' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Manamey') LIMIT 1;
SET @album_Manamey = (SELECT id FROM albums WHERE title='Manamey' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Matka' AS title, 'Imported album Matka' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Matka') LIMIT 1;
SET @album_Matka = (SELECT id FROM albums WHERE title='Matka' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Mechanic Rocky' AS title, 'Imported album Mechanic Rocky' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Mechanic Rocky') LIMIT 1;
SET @album_Mechanic_Rocky = (SELECT id FROM albums WHERE title='Mechanic Rocky' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Mr Bachan' AS title, 'Imported album Mr Bachan' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Mr Bachan') LIMIT 1;
SET @album_Mr_Bachan = (SELECT id FROM albums WHERE title='Mr Bachan' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Ooru Peru Bhairavakona' AS title, 'Imported album Ooru Peru Bhairavakona' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Ooru Peru Bhairavakona') LIMIT 1;
SET @album_Ooru_Peru_Bhairavakona = (SELECT id FROM albums WHERE title='Ooru Peru Bhairavakona' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Operation Valentine' AS title, 'Imported album Operation Valentine' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Operation Valentine') LIMIT 1;
SET @album_Operation_Valentine = (SELECT id FROM albums WHERE title='Operation Valentine' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Pushpa 2 (2024)' AS title, 'Imported album Pushpa 2 (2024)' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Pushpa 2 (2024)') LIMIT 1;
SET @album_Pushpa_2_2024 = (SELECT id FROM albums WHERE title='Pushpa 2 (2024)' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Pushpa2' AS title, 'Imported album Pushpa2' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Pushpa2') LIMIT 1;
SET @album_Pushpa2 = (SELECT id FROM albums WHERE title='Pushpa2' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Raayan' AS title, 'Imported album Raayan' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Raayan') LIMIT 1;
SET @album_Raayan = (SELECT id FROM albums WHERE title='Raayan' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Rathnam' AS title, 'Imported album Rathnam' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Rathnam') LIMIT 1;
SET @album_Rathnam = (SELECT id FROM albums WHERE title='Rathnam' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Robinhood' AS title, 'Imported album Robinhood' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Robinhood') LIMIT 1;
SET @album_Robinhood = (SELECT id FROM albums WHERE title='Robinhood' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Sankranthiki Vasthunnam' AS title, 'Imported album Sankranthiki Vasthunnam' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Sankranthiki Vasthunnam') LIMIT 1;
SET @album_Sankranthiki_Vasthunnam = (SELECT id FROM albums WHERE title='Sankranthiki Vasthunnam' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Saripodha Sanivaram' AS title, 'Imported album Saripodha Sanivaram' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Saripodha Sanivaram') LIMIT 1;
SET @album_Saripodha_Sanivaram = (SELECT id FROM albums WHERE title='Saripodha Sanivaram' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Thandel' AS title, 'Imported album Thandel' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Thandel') LIMIT 1;
SET @album_Thandel = (SELECT id FROM albums WHERE title='Thandel' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'The Greatest of All Time' AS title, 'Imported album The Greatest of All Time' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='The Greatest of All Time') LIMIT 1;
SET @album_The_Greatest_of_All_Time = (SELECT id FROM albums WHERE title='The Greatest of All Time' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Tillu Square' AS title, 'Imported album Tillu Square' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Tillu Square') LIMIT 1;
SET @album_Tillu_Square = (SELECT id FROM albums WHERE title='Tillu Square' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Vettaiyan' AS title, 'Imported album Vettaiyan' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Vettaiyan') LIMIT 1;
SET @album_Vettaiyan = (SELECT id FROM albums WHERE title='Vettaiyan' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Vettaiyan (2024)' AS title, 'Imported album Vettaiyan (2024)' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Vettaiyan (2024)') LIMIT 1;
SET @album_Vettaiyan_2024 = (SELECT id FROM albums WHERE title='Vettaiyan (2024)' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Viswam' AS title, 'Imported album Viswam' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Viswam') LIMIT 1;
SET @album_Viswam = (SELECT id FROM albums WHERE title='Viswam' LIMIT 1);

-- === Songs ===
INSERT INTO songs (title, description, singer, thumbnail_id, thumbnail_url, audio_id, audio_url, album_id)
VALUES
(
  'Oh Madam',
  'Imported from Aa Okkati Adakku/Oh Madam.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Aa%20Okkati%20Adakku/Oh%20Madam.mp3',
  @album_Aa_Okkati_Adakku
),

(
  'Azadi',
  'Imported from Amaran/Amaran (2024)/Azadi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Amaran/Amaran%20(2024)/Azadi.mp3',
  @album_Amaran
),

(
  'Azadi (Alt)',
  'Imported from Amaran/Azadi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Amaran/Azadi.mp3',
  @album_Amaran
),

(
  'Hey Minnale',
  'Imported from Amaran/Amaran (2024)/Hey Minnale.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Amaran/Amaran%20(2024)/Hey%20Minnale.mp3',
  @album_Amaran
),

(
  'Hey Minnale (Alt)',
  'Imported from Amaran/Hey Minnale.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Amaran/Hey%20Minnale.mp3',
  @album_Amaran
),

(
  'Sai Pallavis Intro',
  'Imported from Amaran/Amaran (2024)/Sai Pallavis Intro.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Amaran/Amaran%20(2024)/Sai%20Pallavis%20Intro.mp3',
  @album_Amaran
),

(
  'Sai Pallavis Intro (Alt)',
  'Imported from Amaran/Sai Pallavis Intro.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Amaran/Sai%20Pallavis%20Intro.mp3',
  @album_Amaran
),

(
  'Uyirey',
  'Imported from Amaran/Amaran (2024)/Uyirey.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Amaran/Amaran%20(2024)/Uyirey.mp3',
  @album_Amaran
),

(
  'Uyirey (Alt)',
  'Imported from Amaran/Uyirey.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Amaran/Uyirey.mp3',
  @album_Amaran
),

(
  'Vennilavu Saaral',
  'Imported from Amaran/Amaran (2024)/Vennilavu Saaral.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Amaran/Amaran%20(2024)/Vennilavu%20Saaral.mp3',
  @album_Amaran
),

(
  'Vennilavu Saaral (Alt)',
  'Imported from Amaran/Vennilavu Saaral.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Amaran/Vennilavu%20Saaral.mp3',
  @album_Amaran
),

(
  'Amma Paata',
  'Imported from Amma Paata/Amma Paata.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Amma%20Paata/Amma%20Paata.mp3',
  @album_Amma_Paata
),

(
  'Amma Paata Tone',
  'Imported from Amma Paata/Amma Paata Tone.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Amma%20Paata/Amma%20Paata%20Tone.mp3',
  @album_Amma_Paata
),

(
  'Hey Taara',
  'Imported from Appudo Ippudo yeppudo/1-Hey Taara.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Appudo%20Ippudo%20yeppudo/1-Hey%20Taara.mp3',
  @album_Appudo_Ippudo_yeppudo
),

(
  'Neetho Ila',
  'Imported from Appudo Ippudo yeppudo/Neetho Ila.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Appudo%20Ippudo%20yeppudo/Neetho%20Ila.mp3',
  @album_Appudo_Ippudo_yeppudo
),

(
  'Ambaraala Veedhilo',
  'Imported from ARM/Ambaraala Veedhilo.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/ARM/Ambaraala%20Veedhilo.mp3',
  @album_ARM
),

(
  'Ambaraala Veedhilo Tone',
  'Imported from ARM/Ambaraala Veedhilo Tone.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/ARM/Ambaraala%20Veedhilo%20Tone.mp3',
  @album_ARM
),

(
  'Angu Vaana Konilu',
  'Imported from ARM/Angu Vaana Konilu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/ARM/Angu%20Vaana%20Konilu.mp3',
  @album_ARM
),

(
  'Ade Nenu Asalu Lenu',
  'Imported from Bachala Malli/Ade Nenu Asalu Lenu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Bachala%20Malli/Ade%20Nenu%20Asalu%20Lenu.mp3',
  @album_Bachala_Malli
),

(
  'Maa Oori Jatharalo',
  'Imported from Bachala Malli/Maa Oori Jatharalo.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Bachala%20Malli/Maa%20Oori%20Jatharalo.mp3',
  @album_Bachala_Malli
),

(
  'Set Ayyindhe',
  'Imported from Bhaje Vaayu Vegam/Set Ayyindhe.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Bhaje%20Vaayu%20Vegam/Set%20Ayyindhe.mp3',
  @album_Bhaje_Vaayu_Vegam
),

(
  'Calendar',
  'Imported from Bharatiyudu 2/Calendar.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Bharatiyudu%202/Calendar.mp3',
  @album_Bharatiyudu_2
),

(
  'Chengaluya',
  'Imported from Bharatiyudu 2/Chengaluya.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Bharatiyudu%202/Chengaluya.mp3',
  @album_Bharatiyudu_2
),

(
  'Come Back Indian',
  'Imported from Bharatiyudu 2/Come Back Indian.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Bharatiyudu%202/Come%20Back%20Indian.mp3',
  @album_Bharatiyudu_2
),

(
  'Souraa',
  'Imported from Bharatiyudu 2/Souraa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Bharatiyudu%202/Souraa.mp3',
  @album_Bharatiyudu_2
),

(
  'Thatha Vasthaade',
  'Imported from Bharatiyudu 2/Thatha Vasthaade.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Bharatiyudu%202/Thatha%20Vasthaade.mp3',
  @album_Bharatiyudu_2
),

(
  'Zaga Zaga',
  'Imported from Bharatiyudu 2/Zaga Zaga.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Bharatiyudu%202/Zaga%20Zaga.mp3',
  @album_Bharatiyudu_2
),

(
  'Galli Soundullo',
  'Imported from Bhimaa/Galli Soundullo.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Bhimaa/Galli%20Soundullo.mp3',
  @album_Bhimaa
),

(
  'Yedo Yedo Maaya',
  'Imported from Bhimaa/Yedo Yedo Maaya.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Bhimaa/Yedo%20Yedo%20Maaya.mp3',
  @album_Bhimaa
),

(
  'Chikitu',
  'Imported from Coolie/Chikitu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Coolie/Chikitu.mp3',
  @album_Coolie
),

(
  'Coolie Disco',
  'Imported from Coolie/Coolie Disco.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Coolie/Coolie%20Disco.mp3',
  @album_Coolie
),

(
  'All Hail The Tiger',
  'Imported from Devara/All Hail The Tiger.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara/All%20Hail%20The%20Tiger.mp3',
  @album_Devara
),

(
  'ayu1',
  'Imported from Devara/ayu1.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara/ayu1.mp3',
  @album_Devara
),

(
  'Ayudha Pooja',
  'Imported from Devara/Devara - HQ/Ayudha Pooja.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara/Devara%20-%20HQ/Ayudha%20Pooja.mp3',
  @album_Devara
),

(
  'Ayudha Pooja (Alt)',
  'Imported from Devara/Devara/Ayudha Pooja.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara/Devara/Ayudha%20Pooja.mp3',
  @album_Devara
),

(
  'ayupu',
  'Imported from Devara/ayupu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara/ayupu.mp3',
  @album_Devara
),

(
  'Chuttamalle',
  'Imported from Devara/Devara - HQ/Chuttamalle.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara/Devara%20-%20HQ/Chuttamalle.mp3',
  @album_Devara
),

(
  'Chuttamalle (Alt)',
  'Imported from Devara/Devara/Chuttamalle.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara/Devara/Chuttamalle.mp3',
  @album_Devara
),

(
  'Daavudi',
  'Imported from Devara/Devara - HQ/Daavudi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara/Devara%20-%20HQ/Daavudi.mp3',
  @album_Devara
),

(
  'Daavudi (Alt)',
  'Imported from Devara/Devara/Daavudi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara/Devara/Daavudi.mp3',
  @album_Devara
),

(
  'Fear',
  'Imported from Devara/Devara - HQ/Fear.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara/Devara%20-%20HQ/Fear.mp3',
  @album_Devara
),

(
  'Fear (Alt)',
  'Imported from Devara/Devara/Fear.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara/Devara/Fear.mp3',
  @album_Devara
),

(
  'Red Sea',
  'Imported from Devara/Red Sea.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara/Red%20Sea.mp3',
  @album_Devara
),

(
  'All Hail The Tiger',
  'Imported from Devara (2024)/Devara (2024) - HQ/All Hail The Tiger.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara%20(2024)/Devara%20(2024)%20-%20HQ/All%20Hail%20The%20Tiger.mp3',
  @album_Devara_2024
),

(
  'All Hail The Tiger (Alt)',
  'Imported from Devara (2024)/Devara (2024)/All Hail The Tiger.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara%20(2024)/Devara%20(2024)/All%20Hail%20The%20Tiger.mp3',
  @album_Devara_2024
),

(
  'Ayudha Pooja',
  'Imported from Devara (2024)/Devara (2024) - HQ/Ayudha Pooja.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara%20(2024)/Devara%20(2024)%20-%20HQ/Ayudha%20Pooja.mp3',
  @album_Devara_2024
),

(
  'Ayudha Pooja (Alt)',
  'Imported from Devara (2024)/Devara (2024)/Ayudha Pooja.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara%20(2024)/Devara%20(2024)/Ayudha%20Pooja.mp3',
  @album_Devara_2024
),

(
  'Chuttamalle',
  'Imported from Devara (2024)/Devara (2024) - HQ/Chuttamalle.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara%20(2024)/Devara%20(2024)%20-%20HQ/Chuttamalle.mp3',
  @album_Devara_2024
),

(
  'Chuttamalle (Alt)',
  'Imported from Devara (2024)/Devara (2024)/Chuttamalle.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara%20(2024)/Devara%20(2024)/Chuttamalle.mp3',
  @album_Devara_2024
),

(
  'Daavudi',
  'Imported from Devara (2024)/Devara (2024) - HQ/Daavudi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara%20(2024)/Devara%20(2024)%20-%20HQ/Daavudi.mp3',
  @album_Devara_2024
),

(
  'Daavudi (Alt)',
  'Imported from Devara (2024)/Devara (2024)/Daavudi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara%20(2024)/Devara%20(2024)/Daavudi.mp3',
  @album_Devara_2024
),

(
  'Fear',
  'Imported from Devara (2024)/Devara (2024) - HQ/Fear.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara%20(2024)/Devara%20(2024)%20-%20HQ/Fear.mp3',
  @album_Devara_2024
),

(
  'Fear (Alt)',
  'Imported from Devara (2024)/Devara (2024)/Fear.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara%20(2024)/Devara%20(2024)/Fear.mp3',
  @album_Devara_2024
),

(
  'Red Sea',
  'Imported from Devara (2024)/Devara (2024) - HQ/Red Sea.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara%20(2024)/Devara%20(2024)%20-%20HQ/Red%20Sea.mp3',
  @album_Devara_2024
),

(
  'Red Sea (Alt)',
  'Imported from Devara (2024)/Devara (2024)/Red Sea.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Devara%20(2024)/Devara%20(2024)/Red%20Sea.mp3',
  @album_Devara_2024
),

(
  'Big Bull',
  'Imported from Double Ismart/Double Ismart/Big Bull.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Double%20Ismart/Double%20Ismart/Big%20Bull.mp3',
  @album_Double_Ismart
),

(
  'Big Bull (Alt)',
  'Imported from Double Ismart/Double Smart - HQ/Big Bull.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Double%20Ismart/Double%20Smart%20-%20HQ/Big%20Bull.mp3',
  @album_Double_Ismart
),

(
  'Kya Lafda',
  'Imported from Double Ismart/Double Ismart/Kya Lafda.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Double%20Ismart/Double%20Ismart/Kya%20Lafda.mp3',
  @album_Double_Ismart
),

(
  'Kya Lafda (Alt)',
  'Imported from Double Ismart/Double Smart - HQ/Kya Lafda.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Double%20Ismart/Double%20Smart%20-%20HQ/Kya%20Lafda.mp3',
  @album_Double_Ismart
),

(
  'Maar Muntha Chod Chinta',
  'Imported from Double Ismart/Double Ismart/Maar Muntha Chod Chinta.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Double%20Ismart/Double%20Ismart/Maar%20Muntha%20Chod%20Chinta.mp3',
  @album_Double_Ismart
),

(
  'Maar Muntha Chod Chinta (Alt)',
  'Imported from Double Ismart/Double Smart - HQ/Maar Muntha Chod Chinta.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Double%20Ismart/Double%20Smart%20-%20HQ/Maar%20Muntha%20Chod%20Chinta.mp3',
  @album_Double_Ismart
),

(
  'Mother',
  'Imported from Double Ismart/Double Ismart/Mother.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Double%20Ismart/Double%20Ismart/Mother.mp3',
  @album_Double_Ismart
),

(
  'Mother (Alt)',
  'Imported from Double Ismart/Double Smart - HQ/Mother.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Double%20Ismart/Double%20Smart%20-%20HQ/Mother.mp3',
  @album_Double_Ismart
),

(
  'Steppamaar',
  'Imported from Double Ismart/Double Ismart/Steppamaar.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Double%20Ismart/Double%20Ismart/Steppamaar.mp3',
  @album_Double_Ismart
),

(
  'Steppamaar (Alt)',
  'Imported from Double Ismart/Double Smart - HQ/Steppamaar.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Double%20Ismart/Double%20Smart%20-%20HQ/Steppamaar.mp3',
  @album_Double_Ismart
),

(
  'Eagles On His Way',
  'Imported from Eagle/Eagle/Eagles On His Way.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Eagle/Eagle/Eagles%20On%20His%20Way.mp3',
  @album_Eagle
),

(
  'Garudam',
  'Imported from Eagle/Eagle - HQ/Garudam.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Eagle/Eagle%20-%20HQ/Garudam.mp3',
  @album_Eagle
),

(
  'Garudam (Alt)',
  'Imported from Eagle/Eagle/Garudam.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Eagle/Eagle/Garudam.mp3',
  @album_Eagle
),

(
  'Hey Garuda',
  'Imported from Eagle/Eagle/Hey Garuda.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Eagle/Eagle/Hey%20Garuda.mp3',
  @album_Eagle
),

(
  'd',
  'Imported from Family Star/d.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Family%20Star/d.mp3',
  @album_Family_Star
),

(
  'Dekhore Dekho',
  'Imported from Family Star/Family Star - HQ/Dekhore Dekho.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Family%20Star/Family%20Star%20-%20HQ/Dekhore%20Dekho.mp3',
  @album_Family_Star
),

(
  'Dekhore Dekho (Alt)',
  'Imported from Family Star/Family Star/Dekhore Dekho.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Family%20Star/Family%20Star/Dekhore%20Dekho.mp3',
  @album_Family_Star
),

(
  'DonT Judge Me',
  'Imported from Family Star/Family Star/DonT Judge Me.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Family%20Star/Family%20Star/DonT%20Judge%20Me.mp3',
  @album_Family_Star
),

(
  'Kalyani Vaccha Vacchaa',
  'Imported from Family Star/Family Star - HQ/Kalyani Vaccha Vacchaa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Family%20Star/Family%20Star%20-%20HQ/Kalyani%20Vaccha%20Vacchaa.mp3',
  @album_Family_Star
),

(
  'Kalyani Vaccha Vacchaa (Alt)',
  'Imported from Family Star/Family Star/Kalyani Vaccha Vacchaa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Family%20Star/Family%20Star/Kalyani%20Vaccha%20Vacchaa.mp3',
  @album_Family_Star
),

(
  'Madhuramu Kadha',
  'Imported from Family Star/Family Star - HQ/Madhuramu Kadha.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Family%20Star/Family%20Star%20-%20HQ/Madhuramu%20Kadha.mp3',
  @album_Family_Star
),

(
  'Madhuramu Kadha (Alt)',
  'Imported from Family Star/Family Star/Madhuramu Kadha.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Family%20Star/Family%20Star/Madhuramu%20Kadha.mp3',
  @album_Family_Star
),

(
  'Nandanandanaa',
  'Imported from Family Star/Family Star - HQ/Nandanandanaa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Family%20Star/Family%20Star%20-%20HQ/Nandanandanaa.mp3',
  @album_Family_Star
),

(
  'Nandanandanaa (Alt)',
  'Imported from Family Star/Family Star/Nandanandanaa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Family%20Star/Family%20Star/Nandanandanaa.mp3',
  @album_Family_Star
),

(
  'Gamyaanne',
  'Imported from Gaami/Gamyaanne.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Gaami/Gamyaanne.mp3',
  @album_Gaami
),

(
  'Shivam - The Sprit Of Gaami',
  'Imported from Gaami/Shivam - The Sprit Of Gaami.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Gaami/Shivam%20-%20The%20Sprit%20Of%20Gaami.mp3',
  @album_Gaami
),

(
  'Arugu Meedha',
  'Imported from Game Changer/Game Changer - HQ/Arugu Meedha.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Game%20Changer/Game%20Changer%20-%20HQ/Arugu%20Meedha.mp3',
  @album_Game_Changer
),

(
  'Dhop',
  'Imported from Game Changer/Game Changer - HQ/Dhop.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Game%20Changer/Game%20Changer%20-%20HQ/Dhop.mp3',
  @album_Game_Changer
),

(
  'Jaragandi',
  'Imported from Game Changer/Game Changer - HQ/Jaragandi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Game%20Changer/Game%20Changer%20-%20HQ/Jaragandi.mp3',
  @album_Game_Changer
),

(
  'Jaragandi (Alt)',
  'Imported from Game Changer/Jaragandi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Game%20Changer/Jaragandi.mp3',
  @album_Game_Changer
),

(
  'Konda Devara',
  'Imported from Game Changer/Game Changer - HQ/Konda Devara.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Game%20Changer/Game%20Changer%20-%20HQ/Konda%20Devara.mp3',
  @album_Game_Changer
),

(
  'Koparap',
  'Imported from Game Changer/Game Changer - HQ/Koparap.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Game%20Changer/Game%20Changer%20-%20HQ/Koparap.mp3',
  @album_Game_Changer
),

(
  'Naanaa Hyraanaa',
  'Imported from Game Changer/Game Changer - HQ/Naanaa Hyraanaa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Game%20Changer/Game%20Changer%20-%20HQ/Naanaa%20Hyraanaa.mp3',
  @album_Game_Changer
),

(
  'Naanaa Hyraanaa (Alt)',
  'Imported from Game Changer/Game Changer/Naanaa Hyraanaa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Game%20Changer/Game%20Changer/Naanaa%20Hyraanaa.mp3',
  @album_Game_Changer
),

(
  'Raa Macha Macha',
  'Imported from Game Changer/Game Changer - HQ/Raa Macha Macha.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Game%20Changer/Game%20Changer%20-%20HQ/Raa%20Macha%20Macha.mp3',
  @album_Game_Changer
),

(
  'Raa Macha Macha (Alt)',
  'Imported from Game Changer/Game Changer/Raa Macha Macha.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Game%20Changer/Game%20Changer/Raa%20Macha%20Macha.mp3',
  @album_Game_Changer
),

(
  'Raa Macha Macha (Alt 2)',
  'Imported from Game Changer/Promo/Raa Macha Macha.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Game%20Changer/Promo/Raa%20Macha%20Macha.mp3',
  @album_Game_Changer
),

(
  'un',
  'Imported from Game Changer/un.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Game%20Changer/un.mp3',
  @album_Game_Changer
),

(
  'Unpredictable',
  'Imported from Game Changer/Game Changer - HQ/Unpredictable.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Game%20Changer/Game%20Changer%20-%20HQ/Unpredictable.mp3',
  @album_Game_Changer
),

(
  'Motha',
  'Imported from Gang Of Godavari/Motha.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Gang%20Of%20Godavari/Motha.mp3',
  @album_Gang_Of_Godavari
),

(
  'Ayyo Paapam Saaru',
  'Imported from Goat/Ayyo Paapam Saaru.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Goat/Ayyo%20Paapam%20Saaru.mp3',
  @album_Goat
),

(
  'Spark',
  'Imported from Goat/Goat - HQ/Spark.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Goat/Goat%20-%20HQ/Spark.mp3',
  @album_Goat
),

(
  'Spark (Alt)',
  'Imported from Goat/Goat/Spark.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Goat/Goat/Spark.mp3',
  @album_Goat
),

(
  'Amma',
  'Imported from Guntur Karam/Guntur Karam - HQ/Amma.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Guntur%20Karam/Guntur%20Karam%20-%20HQ/Amma.mp3',
  @album_Guntur_Karam
),

(
  'Amma (Alt)',
  'Imported from Guntur Karam/Guntur Karam/Amma.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Guntur%20Karam/Guntur%20Karam/Amma.mp3',
  @album_Guntur_Karam
),

(
  'Dum Masala',
  'Imported from Guntur Karam/Guntur Karam - HQ/Dum Masala.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Guntur%20Karam/Guntur%20Karam%20-%20HQ/Dum%20Masala.mp3',
  @album_Guntur_Karam
),

(
  'Dum Masala (Alt)',
  'Imported from Guntur Karam/Guntur Karam/Dum Masala.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Guntur%20Karam/Guntur%20Karam/Dum%20Masala.mp3',
  @album_Guntur_Karam
),

(
  'Kurchi Madathapetti',
  'Imported from Guntur Karam/Guntur Karam - HQ/Kurchi Madathapetti.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Guntur%20Karam/Guntur%20Karam%20-%20HQ/Kurchi%20Madathapetti.mp3',
  @album_Guntur_Karam
),

(
  'Kurchi Madathapetti (Alt)',
  'Imported from Guntur Karam/Guntur Karam/Kurchi Madathapetti.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Guntur%20Karam/Guntur%20Karam/Kurchi%20Madathapetti.mp3',
  @album_Guntur_Karam
),

(
  'Mawaa Enthaina',
  'Imported from Guntur Karam/Guntur Karam - HQ/Mawaa Enthaina.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Guntur%20Karam/Guntur%20Karam%20-%20HQ/Mawaa%20Enthaina.mp3',
  @album_Guntur_Karam
),

(
  'Mawaa Enthaina (Alt)',
  'Imported from Guntur Karam/Guntur Karam/Mawaa Enthaina.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Guntur%20Karam/Guntur%20Karam/Mawaa%20Enthaina.mp3',
  @album_Guntur_Karam
),

(
  'Oh My Baby',
  'Imported from Guntur Karam/Guntur Karam - HQ/Oh My Baby.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Guntur%20Karam/Guntur%20Karam%20-%20HQ/Oh%20My%20Baby.mp3',
  @album_Guntur_Karam
),

(
  'Oh My Baby (Alt)',
  'Imported from Guntur Karam/Guntur Karam/Oh My Baby.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Guntur%20Karam/Guntur%20Karam/Oh%20My%20Baby.mp3',
  @album_Guntur_Karam
),

(
  'Ramana Aei',
  'Imported from Guntur Karam/Guntur Karam - HQ/Ramana Aei.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Guntur%20Karam/Guntur%20Karam%20-%20HQ/Ramana%20Aei.mp3',
  @album_Guntur_Karam
),

(
  'Ramana Aei (Alt)',
  'Imported from Guntur Karam/Guntur Karam/Ramana Aei.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Guntur%20Karam/Guntur%20Karam/Ramana%20Aei.mp3',
  @album_Guntur_Karam
),

(
  'Anjanadri Theme',
  'Imported from Hanuman/Anjanadri Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Hanuman/Anjanadri%20Theme.mp3',
  @album_Hanuman
),

(
  'Avakaya Anjaneya',
  'Imported from Hanuman/Avakaya Anjaneya.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Hanuman/Avakaya%20Anjaneya.mp3',
  @album_Hanuman
),

(
  'Hanuman Chalisa',
  'Imported from Hanuman/Hanuman Chalisa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Hanuman/Hanuman%20Chalisa.mp3',
  @album_Hanuman
),

(
  'Poolamme Pilla',
  'Imported from Hanuman/Poolamme Pilla.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Hanuman/Poolamme%20Pilla.mp3',
  @album_Hanuman
),

(
  'Raghunandana',
  'Imported from Hanuman/Raghunandana.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Hanuman/Raghunandana.mp3',
  @album_Hanuman
),

(
  'Sri Ramadootha Stotram',
  'Imported from Hanuman/Sri Ramadootha Stotram.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Hanuman/Sri%20Ramadootha%20Stotram.mp3',
  @album_Hanuman
),

(
  'Super Hero Hanu Man',
  'Imported from Hanuman/Super Hero Hanu Man.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Hanuman/Super%20Hero%20Hanu%20Man.mp3',
  @album_Hanuman
),

(
  'Neelorpam',
  'Imported from Indian 2/Neelorpam.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Indian%202/Neelorpam.mp3',
  @album_Indian_2
),

(
  'Paaraa',
  'Imported from Indian 2/Paaraa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Indian%202/Paaraa.mp3',
  @album_Indian_2
),

(
  'Bhairava Anthem',
  'Imported from Kalki/Bhairava Anthem.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kalki/Bhairava%20Anthem.mp3',
  @album_Kalki
),

(
  'Bhairava Anthem',
  'Imported from Kalki 2989 AD/Kalki 2989 AD - HQ/Bhairava Anthem.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kalki%202989%20AD/Kalki%202989%20AD%20-%20HQ/Bhairava%20Anthem.mp3',
  @album_Kalki_2989_AD
),

(
  'Bujji Theme',
  'Imported from Kalki 2989 AD/Kalki 2989 AD/Bujji Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kalki%202989%20AD/Kalki%202989%20AD/Bujji%20Theme.mp3',
  @album_Kalki_2989_AD
),

(
  'Hope of Shambala',
  'Imported from Kalki 2989 AD/Kalki 2989 AD - HQ/Hope of Shambala.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kalki%202989%20AD/Kalki%202989%20AD%20-%20HQ/Hope%20of%20Shambala.mp3',
  @album_Kalki_2989_AD
),

(
  'keeeeeeee',
  'Imported from Kalki 2989 AD/keeeeeeee.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kalki%202989%20AD/keeeeeeee.mp3',
  @album_Kalki_2989_AD
),

(
  'Keshava Madhava',
  'Imported from Kalki 2989 AD/Kalki 2989 AD/Keshava Madhava.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kalki%202989%20AD/Kalki%202989%20AD/Keshava%20Madhava.mp3',
  @album_Kalki_2989_AD
),

(
  'Ta Takkara',
  'Imported from Kalki 2989 AD/Kalki 2989 AD - HQ/Ta Takkara.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kalki%202989%20AD/Kalki%202989%20AD%20-%20HQ/Ta%20Takkara.mp3',
  @album_Kalki_2989_AD
),

(
  'Ta Takkara (Alt)',
  'Imported from Kalki 2989 AD/Kalki 2989 AD/Ta Takkara.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kalki%202989%20AD/Kalki%202989%20AD/Ta%20Takkara.mp3',
  @album_Kalki_2989_AD
),

(
  'Theme of Kalki',
  'Imported from Kalki 2989 AD/Kalki 2989 AD - HQ/Theme of Kalki.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kalki%202989%20AD/Kalki%202989%20AD%20-%20HQ/Theme%20of%20Kalki.mp3',
  @album_Kalki_2989_AD
),

(
  'themememmmee',
  'Imported from Kalki 2989 AD/themememmmee.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kalki%202989%20AD/themememmmee.mp3',
  @album_Kalki_2989_AD
),

(
  'Fire',
  'Imported from Kanguva/Kanguva - HQ/Fire.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kanguva/Kanguva%20-%20HQ/Fire.mp3',
  @album_Kanguva
),

(
  'Fire (Alt)',
  'Imported from Kanguva/Kanguva/Fire.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kanguva/Kanguva/Fire.mp3',
  @album_Kanguva
),

(
  'Kanguva Title Theme',
  'Imported from Kanguva/Kanguva - HQ/Kanguva Title Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kanguva/Kanguva%20-%20HQ/Kanguva%20Title%20Theme.mp3',
  @album_Kanguva
),

(
  'Kanguva Title Theme (Alt)',
  'Imported from Kanguva/Kanguva Title Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kanguva/Kanguva%20Title%20Theme.mp3',
  @album_Kanguva
),

(
  'Mannippu',
  'Imported from Kanguva/Kanguva - HQ/Mannippu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kanguva/Kanguva%20-%20HQ/Mannippu.mp3',
  @album_Kanguva
),

(
  'Thalaivane',
  'Imported from Kanguva/Kanguva - HQ/Thalaivane.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kanguva/Kanguva%20-%20HQ/Thalaivane.mp3',
  @album_Kanguva
),

(
  'Thalaivane (Alt)',
  'Imported from Kanguva/Thalaivane .mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kanguva/Thalaivane%20.mp3',
  @album_Kanguva
),

(
  'Yolo',
  'Imported from Kanguva/Kanguva - HQ/Yolo.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Kanguva/Kanguva%20-%20HQ/Yolo.mp3',
  @album_Kanguva
),

(
  'Aatagadhara',
  'Imported from Love Me (2024)/Aatagadhara.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Love%20Me%20(2024)/Aatagadhara.mp3',
  @album_Love_Me_2024
),

(
  'Ghost Love',
  'Imported from Love Me (2024)/Ghost Love.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Love%20Me%20(2024)/Ghost%20Love.mp3',
  @album_Love_Me_2024
),

(
  'Kothaga Kotha Kothaga',
  'Imported from Love Me (2024)/Kothaga Kotha Kothaga.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Love%20Me%20(2024)/Kothaga%20Kotha%20Kothaga.mp3',
  @album_Love_Me_2024
),

(
  'Like Share Subscribe',
  'Imported from Love Me (2024)/Like Share Subscribe.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Love%20Me%20(2024)/Like%20Share%20Subscribe.mp3',
  @album_Love_Me_2024
),

(
  'Raavaali Raa',
  'Imported from Love Me (2024)/Raavaali Raa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Love%20Me%20(2024)/Raavaali%20Raa.mp3',
  @album_Love_Me_2024
),

(
  'Raavaali Raa (Vaishnavi Version)',
  'Imported from Love Me (2024)/Raavaali Raa (Vaishnavi Version).mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Love%20Me%20(2024)/Raavaali%20Raa%20(Vaishnavi%20Version).mp3',
  @album_Love_Me_2024
),

(
  'Stupid Heart',
  'Imported from Love Me (2024)/Stupid Heart.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Love%20Me%20(2024)/Stupid%20Heart.mp3',
  @album_Love_Me_2024
),

(
  'Lucky Baskhar',
  'Imported from Lucky Bhaskar/Lucky Baskhar.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Lucky%20Bhaskar/Lucky%20Baskhar.mp3',
  @album_Lucky_Bhaskar
),

(
  'Nijamaa Kalaa',
  'Imported from Lucky Bhaskar/Nijamaa Kalaa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Lucky%20Bhaskar/Nijamaa%20Kalaa.mp3',
  @album_Lucky_Bhaskar
),

(
  'Srimathi Garu',
  'Imported from Lucky Bhaskar/Srimathi Garu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Lucky%20Bhaskar/Srimathi%20Garu.mp3',
  @album_Lucky_Bhaskar
),

(
  'Balu Gani Intilona',
  'Imported from Mad Square/Balu Gani Intilona.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mad%20Square/Balu%20Gani%20Intilona.mp3',
  @album_Mad_Square
),

(
  'Konte Konte',
  'Imported from Mad Square/Konte Konte.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mad%20Square/Konte%20Konte.mp3',
  @album_Mad_Square
),

(
  'Laddu Gaani Pelli',
  'Imported from Mad Square/Laddu Gaani Pelli.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mad%20Square/Laddu%20Gaani%20Pelli.mp3',
  @album_Mad_Square
),

(
  'Swathi Reddy',
  'Imported from Mad Square/Swathi Reddy.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mad%20Square/Swathi%20Reddy.mp3',
  @album_Mad_Square
),

(
  'Vaccharroi',
  'Imported from Mad Square/Vaccharroi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mad%20Square/Vaccharroi.mp3',
  @album_Mad_Square
),

(
  'Ika Na Maate',
  'Imported from Manamey/Ika Na Maate.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Manamey/Ika%20Na%20Maate.mp3',
  @album_Manamey
),

(
  'Le Le Raja',
  'Imported from Matka/Le Le Raja.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Matka/Le%20Le%20Raja.mp3',
  @album_Matka
),

(
  'Rama Talkies Ramp',
  'Imported from Matka/Rama Talkies Ramp.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Matka/Rama%20Talkies%20Ramp.mp3',
  @album_Matka
),

(
  'Thassadiyya',
  'Imported from Matka/Thassadiyya.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Matka/Thassadiyya.mp3',
  @album_Matka
),

(
  'Gulledu Gulledu',
  'Imported from Mechanic Rocky/Gulledu Gulledu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mechanic%20Rocky/Gulledu%20Gulledu.mp3',
  @album_Mechanic_Rocky
),

(
  'I Hate U My Daddy',
  'Imported from Mechanic Rocky/I Hate U My Daddy.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mechanic%20Rocky/I%20Hate%20U%20My%20Daddy.mp3',
  @album_Mechanic_Rocky
),

(
  'Oo Pillo',
  'Imported from Mechanic Rocky/Oo Pillo.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mechanic%20Rocky/Oo%20Pillo.mp3',
  @album_Mechanic_Rocky
),

(
  'akk',
  'Imported from Mr Bachan/akk.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mr%20Bachan/akk.mp3',
  @album_Mr_Bachan
),

(
  'Jikki',
  'Imported from Mr Bachan/Mr Bachan - HQ/Jikki.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mr%20Bachan/Mr%20Bachan%20-%20HQ/Jikki.mp3',
  @album_Mr_Bachan
),

(
  'Jikki (Alt)',
  'Imported from Mr Bachan/Mr Bachan/Jikki.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mr%20Bachan/Mr%20Bachan/Jikki.mp3',
  @album_Mr_Bachan
),

(
  'Nallanchu Thellacheera',
  'Imported from Mr Bachan/Mr Bachan - HQ/Nallanchu Thellacheera.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mr%20Bachan/Mr%20Bachan%20-%20HQ/Nallanchu%20Thellacheera.mp3',
  @album_Mr_Bachan
),

(
  'Nallanchu Thellacheera (Alt)',
  'Imported from Mr Bachan/Mr Bachan/Nallanchu Thellacheera.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mr%20Bachan/Mr%20Bachan/Nallanchu%20Thellacheera.mp3',
  @album_Mr_Bachan
),

(
  'Reppal Dappul',
  'Imported from Mr Bachan/Mr Bachan - HQ/Reppal Dappul.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mr%20Bachan/Mr%20Bachan%20-%20HQ/Reppal%20Dappul.mp3',
  @album_Mr_Bachan
),

(
  'Reppal Dappul (Alt)',
  'Imported from Mr Bachan/Mr Bachan/Reppal Dappul.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mr%20Bachan/Mr%20Bachan/Reppal%20Dappul.mp3',
  @album_Mr_Bachan
),

(
  'Sitar',
  'Imported from Mr Bachan/Mr Bachan - HQ/Sitar.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mr%20Bachan/Mr%20Bachan%20-%20HQ/Sitar.mp3',
  @album_Mr_Bachan
),

(
  'Sitar (Alt)',
  'Imported from Mr Bachan/Mr Bachan/Sitar.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Mr%20Bachan/Mr%20Bachan/Sitar.mp3',
  @album_Mr_Bachan
),

(
  'Haromhara',
  'Imported from Ooru Peru Bhairavakona/Haromhara.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Ooru%20Peru%20Bhairavakona/Haromhara.mp3',
  @album_Ooru_Peru_Bhairavakona
),

(
  'Idi Bairavakona',
  'Imported from Ooru Peru Bhairavakona/Idi Bairavakona.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Ooru%20Peru%20Bhairavakona/Idi%20Bairavakona.mp3',
  @album_Ooru_Peru_Bhairavakona
),

(
  'Kill The Devil',
  'Imported from Ooru Peru Bhairavakona/Kill The Devil.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Ooru%20Peru%20Bhairavakona/Kill%20The%20Devil.mp3',
  @album_Ooru_Peru_Bhairavakona
),

(
  'Annee Nuvve Ammaku',
  'Imported from Operation Valentine/Annee Nuvve Ammaku.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Operation%20Valentine/Annee%20Nuvve%20Ammaku.mp3',
  @album_Operation_Valentine
),

(
  'Gaganaala',
  'Imported from Operation Valentine/Gaganaala.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Operation%20Valentine/Gaganaala.mp3',
  @album_Operation_Valentine
),

(
  'Vande Mataram',
  'Imported from Operation Valentine/Vande Mataram.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Operation%20Valentine/Vande%20Mataram.mp3',
  @album_Operation_Valentine
),

(
  'Gango Renuka Thalli',
  'Imported from Pushpa 2 (2024)/Pushpa 2 - HQ/Gango Renuka Thalli.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa%202%20(2024)/Pushpa%202%20-%20HQ/Gango%20Renuka%20Thalli.mp3',
  @album_Pushpa_2_2024
),

(
  'Gango Renuka Thalli (Alt)',
  'Imported from Pushpa 2 (2024)/Pushpa 2/Gango Renuka Thalli.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa%202%20(2024)/Pushpa%202/Gango%20Renuka%20Thalli.mp3',
  @album_Pushpa_2_2024
),

(
  'Kissik',
  'Imported from Pushpa 2 (2024)/Pushpa 2 - HQ/Kissik.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa%202%20(2024)/Pushpa%202%20-%20HQ/Kissik.mp3',
  @album_Pushpa_2_2024
),

(
  'Kissik (Alt)',
  'Imported from Pushpa 2 (2024)/Pushpa 2/Kissik.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa%202%20(2024)/Pushpa%202/Kissik.mp3',
  @album_Pushpa_2_2024
),

(
  'paaaaaraaaan',
  'Imported from Pushpa 2 (2024)/paaaaaraaaan.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa%202%20(2024)/paaaaaraaaan.mp3',
  @album_Pushpa_2_2024
),

(
  'paran',
  'Imported from Pushpa 2 (2024)/paran.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa%202%20(2024)/paran.mp3',
  @album_Pushpa_2_2024
),

(
  'Peelings',
  'Imported from Pushpa 2 (2024)/Pushpa 2 - HQ/Peelings.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa%202%20(2024)/Pushpa%202%20-%20HQ/Peelings.mp3',
  @album_Pushpa_2_2024
),

(
  'Peelings (Alt)',
  'Imported from Pushpa 2 (2024)/Pushpa 2/Peelings.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa%202%20(2024)/Pushpa%202/Peelings.mp3',
  @album_Pushpa_2_2024
),

(
  'tomp3 (mp3cut.net)',
  'Imported from Pushpa 2 (2024)/tomp3 (mp3cut.net).mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa%202%20(2024)/tomp3%20(mp3cut.net).mp3',
  @album_Pushpa_2_2024
),

(
  'Angaaron',
  'Imported from Pushpa2/Pushpa2 - Hindi/Angaaron.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa2/Pushpa2%20-%20Hindi/Angaaron.mp3',
  @album_Pushpa2
),

(
  'Kissik',
  'Imported from Pushpa2/Pushpa 2 - Tamil/Kissik.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa2/Pushpa%202%20-%20Tamil/Kissik.mp3',
  @album_Pushpa2
),

(
  'Kissik (Alt)',
  'Imported from Pushpa2/Pushpa2 - Hindi/Kissik.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa2/Pushpa2%20-%20Hindi/Kissik.mp3',
  @album_Pushpa2
),

(
  'Kissik (Alt 2)',
  'Imported from Pushpa2/Pushpa2 - HQ/Kissik.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa2/Pushpa2%20-%20HQ/Kissik.mp3',
  @album_Pushpa2
),

(
  'Peelings',
  'Imported from Pushpa2/Pushpa 2 - Tamil/Peelings.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa2/Pushpa%202%20-%20Tamil/Peelings.mp3',
  @album_Pushpa2
),

(
  'Peelings (Alt)',
  'Imported from Pushpa2/Pushpa2 - Hindi/Peelings.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa2/Pushpa2%20-%20Hindi/Peelings.mp3',
  @album_Pushpa2
),

(
  'Pushpa Pushpa',
  'Imported from Pushpa2/Pushpa2 - Hindi/Pushpa Pushpa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa2/Pushpa2%20-%20Hindi/Pushpa%20Pushpa.mp3',
  @album_Pushpa2
),

(
  'Pushpa Pushpa (Alt)',
  'Imported from Pushpa2/Pushpa2 - HQ/Pushpa Pushpa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa2/Pushpa2%20-%20HQ/Pushpa%20Pushpa.mp3',
  @album_Pushpa2
),

(
  'Pushpa Pushpa (Alt 2)',
  'Imported from Pushpa2/Pushpa2/Pushpa Pushpa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa2/Pushpa2/Pushpa%20Pushpa.mp3',
  @album_Pushpa2
),

(
  'Pushpa Pushpa (Promo)',
  'Imported from Pushpa2/Pushpa Pushpa (Promo).mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa2/Pushpa%20Pushpa%20(Promo).mp3',
  @album_Pushpa2
),

(
  'Sooseki',
  'Imported from Pushpa2/Pushpa2 - HQ/Sooseki.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa2/Pushpa2%20-%20HQ/Sooseki.mp3',
  @album_Pushpa2
),

(
  'Sooseki (Alt)',
  'Imported from Pushpa2/Pushpa2/Sooseki.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa2/Pushpa2/Sooseki.mp3',
  @album_Pushpa2
),

(
  'tomp3.cc - KISSIK Lyrical Video Pushpa 2 The Rule Allu Arjun Sukumar Sreeleela DSP',
  'Imported from Pushpa2/tomp3.cc - KISSIK Lyrical Video  Pushpa 2 The Rule  Allu Arjun  Sukumar  Sreeleela  DSP.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Pushpa2/tomp3.cc%20-%20KISSIK%20Lyrical%20Video%20%20Pushpa%202%20The%20Rule%20%20Allu%20Arjun%20%20Sukumar%20%20Sreeleela%20%20DSP.mp3',
  @album_Pushpa2
),

(
  'Adangaatha Asuran',
  'Imported from Raayan/Raayan/Adangaatha Asuran.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Raayan/Raayan/Adangaatha%20Asuran.mp3',
  @album_Raayan
),

(
  'odath',
  'Imported from Raayan/odath.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Raayan/odath.mp3',
  @album_Raayan
),

(
  'Odatha Da Odatha Da',
  'Imported from Raayan/Raayan/Odatha Da Odatha Da.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Raayan/Raayan/Odatha%20Da%20Odatha%20Da.mp3',
  @album_Raayan
),

(
  'Oh Raaya',
  'Imported from Raayan/Raayan/Oh Raaya.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Raayan/Raayan/Oh%20Raaya.mp3',
  @album_Raayan
),

(
  'oh raya',
  'Imported from Raayan/oh raya.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Raayan/oh%20raya.mp3',
  @album_Raayan
),

(
  'Raayan Rumble',
  'Imported from Raayan/Raayan/Raayan Rumble.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Raayan/Raayan/Raayan%20Rumble.mp3',
  @album_Raayan
),

(
  'rayan rum',
  'Imported from Raayan/rayan rum.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Raayan/rayan%20rum.mp3',
  @album_Raayan
),

(
  'Water Packet',
  'Imported from Raayan/Raayan/Water Packet.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Raayan/Raayan/Water%20Packet.mp3',
  @album_Raayan
),

(
  'Dont Worry Da Machi',
  'Imported from Rathnam/Dont Worry Da Machi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Rathnam/Dont%20Worry%20Da%20Machi.mp3',
  @album_Rathnam
),

(
  'Adhi Dha Surprisu',
  'Imported from Robinhood/Adhi Dha Surprisu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Robinhood/Adhi%20Dha%20Surprisu.mp3',
  @album_Robinhood
),

(
  'One More Time',
  'Imported from Robinhood/One More Time.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Robinhood/One%20More%20Time.mp3',
  @album_Robinhood
),

(
  'Wherever You Go',
  'Imported from Robinhood/Wherever You Go.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Robinhood/Wherever%20You%20Go.mp3',
  @album_Robinhood
),

(
  'Blockbuster Pongal',
  'Imported from Sankranthiki Vasthunnam/Sankranthiki Vasthunnam - HQ/Blockbuster Pongal.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Sankranthiki%20Vasthunnam/Sankranthiki%20Vasthunnam%20-%20HQ/Blockbuster%20Pongal.mp3',
  @album_Sankranthiki_Vasthunnam
),

(
  'Blockbuster Pongal (Alt)',
  'Imported from Sankranthiki Vasthunnam/Sankranthiki Vasthunnam/Blockbuster Pongal.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Sankranthiki%20Vasthunnam/Sankranthiki%20Vasthunnam/Blockbuster%20Pongal.mp3',
  @album_Sankranthiki_Vasthunnam
),

(
  'Chinna Raju',
  'Imported from Sankranthiki Vasthunnam/Sankranthiki Vasthunnam/Chinna Raju.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Sankranthiki%20Vasthunnam/Sankranthiki%20Vasthunnam/Chinna%20Raju.mp3',
  @album_Sankranthiki_Vasthunnam
),

(
  'Godari Gattu',
  'Imported from Sankranthiki Vasthunnam/Sankranthiki Vasthunnam - HQ/Godari Gattu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Sankranthiki%20Vasthunnam/Sankranthiki%20Vasthunnam%20-%20HQ/Godari%20Gattu.mp3',
  @album_Sankranthiki_Vasthunnam
),

(
  'Godari Gattu (Alt)',
  'Imported from Sankranthiki Vasthunnam/Sankranthiki Vasthunnam/Godari Gattu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Sankranthiki%20Vasthunnam/Sankranthiki%20Vasthunnam/Godari%20Gattu.mp3',
  @album_Sankranthiki_Vasthunnam
),

(
  'Guruvarya',
  'Imported from Sankranthiki Vasthunnam/Sankranthiki Vasthunnam/Guruvarya.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Sankranthiki%20Vasthunnam/Sankranthiki%20Vasthunnam/Guruvarya.mp3',
  @album_Sankranthiki_Vasthunnam
),

(
  'Lallayire',
  'Imported from Sankranthiki Vasthunnam/Sankranthiki Vasthunnam/Lallayire.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Sankranthiki%20Vasthunnam/Sankranthiki%20Vasthunnam/Lallayire.mp3',
  @album_Sankranthiki_Vasthunnam
),

(
  'Meenu',
  'Imported from Sankranthiki Vasthunnam/Sankranthiki Vasthunnam - HQ/Meenu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Sankranthiki%20Vasthunnam/Sankranthiki%20Vasthunnam%20-%20HQ/Meenu.mp3',
  @album_Sankranthiki_Vasthunnam
),

(
  'Meenu (Alt)',
  'Imported from Sankranthiki Vasthunnam/Sankranthiki Vasthunnam/Meenu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Sankranthiki%20Vasthunnam/Sankranthiki%20Vasthunnam/Meenu.mp3',
  @album_Sankranthiki_Vasthunnam
),

(
  'Bhaga Bhaga',
  'Imported from Saripodha Sanivaram/Bhaga Bhaga.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Saripodha%20Sanivaram/Bhaga%20Bhaga.mp3',
  @album_Saripodha_Sanivaram
),

(
  'Dimbhaka',
  'Imported from Saripodha Sanivaram/Dimbhaka.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Saripodha%20Sanivaram/Dimbhaka.mp3',
  @album_Saripodha_Sanivaram
),

(
  'Garam Garam',
  'Imported from Saripodha Sanivaram/Garam Garam.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Saripodha%20Sanivaram/Garam%20Garam.mp3',
  @album_Saripodha_Sanivaram
),

(
  'Laalijo Raagam',
  'Imported from Saripodha Sanivaram/Laalijo Raagam.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Saripodha%20Sanivaram/Laalijo%20Raagam.mp3',
  @album_Saripodha_Sanivaram
),

(
  'Malupero',
  'Imported from Saripodha Sanivaram/Malupero.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Saripodha%20Sanivaram/Malupero.mp3',
  @album_Saripodha_Sanivaram
),

(
  'Not A Teaser',
  'Imported from Saripodha Sanivaram/Not A Teaser.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Saripodha%20Sanivaram/Not%20A%20Teaser.mp3',
  @album_Saripodha_Sanivaram
),

(
  'Samavarthi',
  'Imported from Saripodha Sanivaram/Samavarthi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Saripodha%20Sanivaram/Samavarthi.mp3',
  @album_Saripodha_Sanivaram
),

(
  'Sarimapa',
  'Imported from Saripodha Sanivaram/Sarimapa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Saripodha%20Sanivaram/Sarimapa.mp3',
  @album_Saripodha_Sanivaram
),

(
  'Shiva Thandavame',
  'Imported from Saripodha Sanivaram/Shiva Thandavame.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Saripodha%20Sanivaram/Shiva%20Thandavame.mp3',
  @album_Saripodha_Sanivaram
),

(
  'Ullaasam',
  'Imported from Saripodha Sanivaram/Ullaasam.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Saripodha%20Sanivaram/Ullaasam.mp3',
  @album_Saripodha_Sanivaram
),

(
  'Unchained',
  'Imported from Saripodha Sanivaram/Unchained.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Saripodha%20Sanivaram/Unchained.mp3',
  @album_Saripodha_Sanivaram
),

(
  'Veta Vinodham',
  'Imported from Saripodha Sanivaram/Veta Vinodham.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Saripodha%20Sanivaram/Veta%20Vinodham.mp3',
  @album_Saripodha_Sanivaram
),

(
  '32',
  'Imported from Thandel/32.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Thandel/32.mp3',
  @album_Thandel
),

(
  'Aazaadi',
  'Imported from Thandel/Thandel - 320 Kbps/Aazaadi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Thandel/Thandel%20-%20320%20Kbps/Aazaadi.mp3',
  @album_Thandel
),

(
  'Bujji Thalli',
  'Imported from Thandel/Thandel - HQ/Bujji Thalli.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Thandel/Thandel%20-%20HQ/Bujji%20Thalli.mp3',
  @album_Thandel
),

(
  'Bujji Thalli (Sad Version)',
  'Imported from Thandel/Thandel - 320 Kbps/Bujji Thalli (Sad Version).mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Thandel/Thandel%20-%20320%20Kbps/Bujji%20Thalli%20(Sad%20Version).mp3',
  @album_Thandel
),

(
  'Bujji Thalli tone 1',
  'Imported from Thandel/Tones/Bujji Thalli tone 1.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Thandel/Tones/Bujji%20Thalli%20tone%201.mp3',
  @album_Thandel
),

(
  'Bujji Thalli Voilin',
  'Imported from Thandel/Tones/Bujji Thalli Voilin.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Thandel/Tones/Bujji%20Thalli%20Voilin.mp3',
  @album_Thandel
),

(
  'Hilesso Hilessa',
  'Imported from Thandel/Thandel - 320 Kbps/Hilesso Hilessa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Thandel/Thandel%20-%20320%20Kbps/Hilesso%20Hilessa.mp3',
  @album_Thandel
),

(
  'Hilesso Hilessa (Alt)',
  'Imported from Thandel/Thandel - HQ/Hilesso Hilessa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Thandel/Thandel%20-%20HQ/Hilesso%20Hilessa.mp3',
  @album_Thandel
),

(
  'Naa bujji Thalli',
  'Imported from Thandel/Tones/Naa bujji Thalli.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Thandel/Tones/Naa%20bujji%20Thalli.mp3',
  @album_Thandel
),

(
  'Namo Namah Shivaya',
  'Imported from Thandel/Thandel - 320 Kbps/Namo Namah Shivaya.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Thandel/Thandel%20-%20320%20Kbps/Namo%20Namah%20Shivaya.mp3',
  @album_Thandel
),

(
  'Namo Namah Shivaya (Alt)',
  'Imported from Thandel/Thandel - HQ/Namo Namah Shivaya.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Thandel/Thandel%20-%20HQ/Namo%20Namah%20Shivaya.mp3',
  @album_Thandel
),

(
  'Nee Kosam Vechundhe',
  'Imported from Thandel/Tones/Nee Kosam Vechundhe.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Thandel/Tones/Nee%20Kosam%20Vechundhe.mp3',
  @album_Thandel
),

(
  'Chinna Chinna Kangal',
  'Imported from The Greatest of All Time/Chinna Chinna Kangal.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/The%20Greatest%20of%20All%20Time/Chinna%20Chinna%20Kangal.mp3',
  @album_The_Greatest_of_All_Time
),

(
  'Chinna Chinna Kangal (Alt)',
  'Imported from The Greatest of All Time/The Greatest of All Time/Chinna Chinna Kangal.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/The%20Greatest%20of%20All%20Time/The%20Greatest%20of%20All%20Time/Chinna%20Chinna%20Kangal.mp3',
  @album_The_Greatest_of_All_Time
),

(
  'Matta',
  'Imported from The Greatest of All Time/The Greatest of All Time - HQ/Matta.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/The%20Greatest%20of%20All%20Time/The%20Greatest%20of%20All%20Time%20-%20HQ/Matta.mp3',
  @album_The_Greatest_of_All_Time
),

(
  'Matta (Alt)',
  'Imported from The Greatest of All Time/The Greatest of All Time/Matta.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/The%20Greatest%20of%20All%20Time/The%20Greatest%20of%20All%20Time/Matta.mp3',
  @album_The_Greatest_of_All_Time
),

(
  'Whistle Podu',
  'Imported from The Greatest of All Time/The Greatest of All Time - HQ/Whistle Podu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/The%20Greatest%20of%20All%20Time/The%20Greatest%20of%20All%20Time%20-%20HQ/Whistle%20Podu.mp3',
  @album_The_Greatest_of_All_Time
),

(
  'Whistle Podu (Alt)',
  'Imported from The Greatest of All Time/The Greatest of All Time/Whistle Podu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/The%20Greatest%20of%20All%20Time/The%20Greatest%20of%20All%20Time/Whistle%20Podu.mp3',
  @album_The_Greatest_of_All_Time
),

(
  'Dj Tillu Revamp',
  'Imported from Tillu Square/Dj Tillu Revamp.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Tillu%20Square/Dj%20Tillu%20Revamp.mp3',
  @album_Tillu_Square
),

(
  'Oh My Lilly',
  'Imported from Tillu Square/Oh My Lilly.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Tillu%20Square/Oh%20My%20Lilly.mp3',
  @album_Tillu_Square
),

(
  'Hunter Vantaar',
  'Imported from Vettaiyan/Vettaiyan - HQ/Hunter Vantaar.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Vettaiyan/Vettaiyan%20-%20HQ/Hunter%20Vantaar.mp3',
  @album_Vettaiyan
),

(
  'Manasilaayo',
  'Imported from Vettaiyan/Manasilaayo.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Vettaiyan/Manasilaayo.mp3',
  @album_Vettaiyan
),

(
  'Manasilaayo (Alt)',
  'Imported from Vettaiyan/Vettaiyan - HQ/Manasilaayo.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Vettaiyan/Vettaiyan%20-%20HQ/Manasilaayo.mp3',
  @album_Vettaiyan
),

(
  'Battery Theme',
  'Imported from Vettaiyan (2024)/Vettaiyan - HQ/Battery Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Vettaiyan%20(2024)/Vettaiyan%20-%20HQ/Battery%20Theme.mp3',
  @album_Vettaiyan_2024
),

(
  'Big B Theme',
  'Imported from Vettaiyan (2024)/Vettaiyan - HQ/Big B Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Vettaiyan%20(2024)/Vettaiyan%20-%20HQ/Big%20B%20Theme.mp3',
  @album_Vettaiyan_2024
),

(
  'Clean Shot',
  'Imported from Vettaiyan (2024)/Vettaiyan - HQ/Clean Shot.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Vettaiyan%20(2024)/Vettaiyan%20-%20HQ/Clean%20Shot.mp3',
  @album_Vettaiyan_2024
),

(
  'Hands Up',
  'Imported from Vettaiyan (2024)/Vettaiyan - HQ/Hands Up.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Vettaiyan%20(2024)/Vettaiyan%20-%20HQ/Hands%20Up.mp3',
  @album_Vettaiyan_2024
),

(
  'Hunter Vantaar',
  'Imported from Vettaiyan (2024)/Vettaiyan - HQ/Hunter Vantaar.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Vettaiyan%20(2024)/Vettaiyan%20-%20HQ/Hunter%20Vantaar.mp3',
  @album_Vettaiyan_2024
),

(
  'Manasilaayo',
  'Imported from Vettaiyan (2024)/Vettaiyan - HQ/Manasilaayo.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Vettaiyan%20(2024)/Vettaiyan%20-%20HQ/Manasilaayo.mp3',
  @album_Vettaiyan_2024
),

(
  'Uchathila',
  'Imported from Vettaiyan (2024)/Vettaiyan - HQ/Uchathila.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Vettaiyan%20(2024)/Vettaiyan%20-%20HQ/Uchathila.mp3',
  @album_Vettaiyan_2024
),

(
  'Uchathila (Alt)',
  'Imported from Vettaiyan (2024)/Vettaiyan/Uchathila.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Vettaiyan%20(2024)/Vettaiyan/Uchathila.mp3',
  @album_Vettaiyan_2024
),

(
  'Vaazh Veesum',
  'Imported from Vettaiyan (2024)/Vettaiyan - HQ/Vaazh Veesum.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Vettaiyan%20(2024)/Vettaiyan%20-%20HQ/Vaazh%20Veesum.mp3',
  @album_Vettaiyan_2024
),

(
  'Vettaiyan Theme',
  'Imported from Vettaiyan (2024)/Vettaiyan - HQ/Vettaiyan Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Vettaiyan%20(2024)/Vettaiyan%20-%20HQ/Vettaiyan%20Theme.mp3',
  @album_Vettaiyan_2024
),

(
  'Gunguru Gunguru',
  'Imported from Viswam/Gunguru Gunguru.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Viswam/Gunguru%20Gunguru.mp3',
  @album_Viswam
),

(
  'Mondi Thalli Pilla Nuvvu',
  'Imported from Viswam/Mondi Thalli Pilla Nuvvu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Viswam/Mondi%20Thalli%20Pilla%20Nuvvu.mp3',
  @album_Viswam
),

(
  'Moroccan Maguva',
  'Imported from Viswam/Moroccan Maguva.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Viswam/Moroccan%20Maguva.mp3',
  @album_Viswam
),

(
  'Vastanu Vastanule',
  'Imported from Viswam/Vastanu Vastanule.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2024/Viswam/Vastanu%20Vastanule.mp3',
  @album_Viswam
);
