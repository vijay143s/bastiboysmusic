-- === Albums ===
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Ak Thaluka' AS title, 'Imported album Ak Thaluka' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Ak Thaluka') LIMIT 1;
SET @album_Ak_Thaluka = (SELECT id FROM albums WHERE title='Ak Thaluka' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Akhanda 2' AS title, 'Imported album Akhanda 2' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Akhanda 2') LIMIT 1;
SET @album_Akhanda_2 = (SELECT id FROM albums WHERE title='Akhanda 2' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Anaganaga Oka Roju' AS title, 'Imported album Anaganaga Oka Roju' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Anaganaga Oka Roju') LIMIT 1;
SET @album_Anaganaga_Oka_Roju = (SELECT id FROM albums WHERE title='Anaganaga Oka Roju' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Andra King Thaluka' AS title, 'Imported album Andra King Thaluka' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Andra King Thaluka') LIMIT 1;
SET @album_Andra_King_Thaluka = (SELECT id FROM albums WHERE title='Andra King Thaluka' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Arjun Son of Vyjayanthi' AS title, 'Imported album Arjun Son of Vyjayanthi' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Arjun Son of Vyjayanthi') LIMIT 1;
SET @album_Arjun_Son_of_Vyjayanthi = (SELECT id FROM albums WHERE title='Arjun Son of Vyjayanthi' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Bhairavam' AS title, 'Imported album Bhairavam' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Bhairavam') LIMIT 1;
SET @album_Bhairavam = (SELECT id FROM albums WHERE title='Bhairavam' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Biker' AS title, 'Imported album Biker' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Biker') LIMIT 1;
SET @album_Biker = (SELECT id FROM albums WHERE title='Biker' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Champion' AS title, 'Imported album Champion' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Champion') LIMIT 1;
SET @album_Champion = (SELECT id FROM albums WHERE title='Champion' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Coolie' AS title, 'Imported album Coolie' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Coolie') LIMIT 1;
SET @album_Coolie = (SELECT id FROM albums WHERE title='Coolie' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Daaku Maharaj' AS title, 'Imported album Daaku Maharaj' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Daaku Maharaj') LIMIT 1;
SET @album_Daaku_Maharaj = (SELECT id FROM albums WHERE title='Daaku Maharaj' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Dude - Telugu' AS title, 'Imported album Dude - Telugu' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Dude - Telugu') LIMIT 1;
SET @album_Dude_Telugu = (SELECT id FROM albums WHERE title='Dude - Telugu' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Folk Songs' AS title, 'Imported album Folk Songs' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Folk Songs') LIMIT 1;
SET @album_Folk_Songs = (SELECT id FROM albums WHERE title='Folk Songs' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Good bad ugly' AS title, 'Imported album Good bad ugly' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Good bad ugly') LIMIT 1;
SET @album_Good_bad_ugly = (SELECT id FROM albums WHERE title='Good bad ugly' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Hara Hara Veera Mallu' AS title, 'Imported album Hara Hara Veera Mallu' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Hara Hara Veera Mallu') LIMIT 1;
SET @album_Hara_Hara_Veera_Mallu = (SELECT id FROM albums WHERE title='Hara Hara Veera Mallu' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Hari Hara Veera Mallu (2025)' AS title, 'Imported album Hari Hara Veera Mallu (2025)' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Hari Hara Veera Mallu (2025)') LIMIT 1;
SET @album_Hari_Hara_Veera_Mallu_2025 = (SELECT id FROM albums WHERE title='Hari Hara Veera Mallu (2025)' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Hit' AS title, 'Imported album Hit' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Hit') LIMIT 1;
SET @album_Hit = (SELECT id FROM albums WHERE title='Hit' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Hit 3' AS title, 'Imported album Hit 3' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Hit 3') LIMIT 1;
SET @album_Hit_3 = (SELECT id FROM albums WHERE title='Hit 3' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Idli Kadai' AS title, 'Imported album Idli Kadai' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Idli Kadai') LIMIT 1;
SET @album_Idli_Kadai = (SELECT id FROM albums WHERE title='Idli Kadai' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Idli Kadai (2025)' AS title, 'Imported album Idli Kadai (2025)' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Idli Kadai (2025)') LIMIT 1;
SET @album_Idli_Kadai_2025 = (SELECT id FROM albums WHERE title='Idli Kadai (2025)' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Jack' AS title, 'Imported album Jack' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Jack') LIMIT 1;
SET @album_Jack = (SELECT id FROM albums WHERE title='Jack' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Jagan' AS title, 'Imported album Jagan' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Jagan') LIMIT 1;
SET @album_Jagan = (SELECT id FROM albums WHERE title='Jagan' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Jana Nayagan' AS title, 'Imported album Jana Nayagan' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Jana Nayagan') LIMIT 1;
SET @album_Jana_Nayagan = (SELECT id FROM albums WHERE title='Jana Nayagan' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Junior' AS title, 'Imported album Junior' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Junior') LIMIT 1;
SET @album_Junior = (SELECT id FROM albums WHERE title='Junior' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Kannappa' AS title, 'Imported album Kannappa' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Kannappa') LIMIT 1;
SET @album_Kannappa = (SELECT id FROM albums WHERE title='Kannappa' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Kantara 2' AS title, 'Imported album Kantara 2' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Kantara 2') LIMIT 1;
SET @album_Kantara_2 = (SELECT id FROM albums WHERE title='Kantara 2' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Karuppu' AS title, 'Imported album Karuppu' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Karuppu') LIMIT 1;
SET @album_Karuppu = (SELECT id FROM albums WHERE title='Karuppu' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Kingdom' AS title, 'Imported album Kingdom' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Kingdom') LIMIT 1;
SET @album_Kingdom = (SELECT id FROM albums WHERE title='Kingdom' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Kishkindhapuri' AS title, 'Imported album Kishkindhapuri' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Kishkindhapuri') LIMIT 1;
SET @album_Kishkindhapuri = (SELECT id FROM albums WHERE title='Kishkindhapuri' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Kubera' AS title, 'Imported album Kubera' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Kubera') LIMIT 1;
SET @album_Kubera = (SELECT id FROM albums WHERE title='Kubera' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Laila' AS title, 'Imported album Laila' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Laila') LIMIT 1;
SET @album_Laila = (SELECT id FROM albums WHERE title='Laila' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Lik' AS title, 'Imported album Lik' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Lik') LIMIT 1;
SET @album_Lik = (SELECT id FROM albums WHERE title='Lik' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Madharaasi' AS title, 'Imported album Madharaasi' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Madharaasi') LIMIT 1;
SET @album_Madharaasi = (SELECT id FROM albums WHERE title='Madharaasi' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Madharasi 2025' AS title, 'Imported album Madharasi 2025' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Madharasi 2025') LIMIT 1;
SET @album_Madharasi_2025 = (SELECT id FROM albums WHERE title='Madharasi 2025' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Mana Shankara Varaprasad Garu' AS title, 'Imported album Mana Shankara Varaprasad Garu' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Mana Shankara Varaprasad Garu') LIMIT 1;
SET @album_Mana_Shankara_Varaprasad_Garu = (SELECT id FROM albums WHERE title='Mana Shankara Varaprasad Garu' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Mass Jathara' AS title, 'Imported album Mass Jathara' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Mass Jathara') LIMIT 1;
SET @album_Mass_Jathara = (SELECT id FROM albums WHERE title='Mass Jathara' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Mass Jathara (2025)' AS title, 'Imported album Mass Jathara (2025)' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Mass Jathara (2025)') LIMIT 1;
SET @album_Mass_Jathara_2025 = (SELECT id FROM albums WHERE title='Mass Jathara (2025)' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Mazaka' AS title, 'Imported album Mazaka' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Mazaka') LIMIT 1;
SET @album_Mazaka = (SELECT id FROM albums WHERE title='Mazaka' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'mb' AS title, 'Imported album mb' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='mb') LIMIT 1;
SET @album_mb = (SELECT id FROM albums WHERE title='mb' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Mirai' AS title, 'Imported album Mirai' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Mirai') LIMIT 1;
SET @album_Mirai = (SELECT id FROM albums WHERE title='Mirai' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Mirai (2015)' AS title, 'Imported album Mirai (2015)' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Mirai (2015)') LIMIT 1;
SET @album_Mirai_2015 = (SELECT id FROM albums WHERE title='Mirai (2015)' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Mowgli' AS title, 'Imported album Mowgli' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Mowgli') LIMIT 1;
SET @album_Mowgli = (SELECT id FROM albums WHERE title='Mowgli' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Nari Nari Nadumurari' AS title, 'Imported album Nari Nari Nadumurari' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Nari Nari Nadumurari') LIMIT 1;
SET @album_Nari_Nari_Nadumurari = (SELECT id FROM albums WHERE title='Nari Nari Nadumurari' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'OG' AS title, 'Imported album OG' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='OG') LIMIT 1;
SET @album_OG = (SELECT id FROM albums WHERE title='OG' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'OG (2025)' AS title, 'Imported album OG (2025)' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='OG (2025)') LIMIT 1;
SET @album_OG_2025 = (SELECT id FROM albums WHERE title='OG (2025)' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Parasakthi' AS title, 'Imported album Parasakthi' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Parasakthi') LIMIT 1;
SET @album_Parasakthi = (SELECT id FROM albums WHERE title='Parasakthi' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Peddi' AS title, 'Imported album Peddi' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Peddi') LIMIT 1;
SET @album_Peddi = (SELECT id FROM albums WHERE title='Peddi' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Premalu' AS title, 'Imported album Premalu' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Premalu') LIMIT 1;
SET @album_Premalu = (SELECT id FROM albums WHERE title='Premalu' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Pushpa 2 (2024)' AS title, 'Imported album Pushpa 2 (2024)' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Pushpa 2 (2024)') LIMIT 1;
SET @album_Pushpa_2_2024 = (SELECT id FROM albums WHERE title='Pushpa 2 (2024)' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Raju Weds RAmbai' AS title, 'Imported album Raju Weds RAmbai' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Raju Weds RAmbai') LIMIT 1;
SET @album_Raju_Weds_RAmbai = (SELECT id FROM albums WHERE title='Raju Weds RAmbai' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Retro (2025)' AS title, 'Imported album Retro (2025)' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Retro (2025)') LIMIT 1;
SET @album_Retro_2025 = (SELECT id FROM albums WHERE title='Retro (2025)' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Sankranthiki Vasthunnam (2025)' AS title, 'Imported album Sankranthiki Vasthunnam (2025)' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Sankranthiki Vasthunnam (2025)') LIMIT 1;
SET @album_Sankranthiki_Vasthunnam_2025 = (SELECT id FROM albums WHERE title='Sankranthiki Vasthunnam (2025)' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Telusu Kada (2025)' AS title, 'Imported album Telusu Kada (2025)' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Telusu Kada (2025)') LIMIT 1;
SET @album_Telusu_Kada_2025 = (SELECT id FROM albums WHERE title='Telusu Kada (2025)' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Thammdu' AS title, 'Imported album Thammdu' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Thammdu') LIMIT 1;
SET @album_Thammdu = (SELECT id FROM albums WHERE title='Thammdu' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'The Raja Saab' AS title, 'Imported album The Raja Saab' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='The Raja Saab') LIMIT 1;
SET @album_The_Raja_Saab = (SELECT id FROM albums WHERE title='The Raja Saab' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Thelusu Kadha' AS title, 'Imported album Thelusu Kadha' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Thelusu Kadha') LIMIT 1;
SET @album_Thelusu_Kadha = (SELECT id FROM albums WHERE title='Thelusu Kadha' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'They Call Him OG' AS title, 'Imported album They Call Him OG' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='They Call Him OG') LIMIT 1;
SET @album_They_Call_Him_OG = (SELECT id FROM albums WHERE title='They Call Him OG' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Thug Life' AS title, 'Imported album Thug Life' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Thug Life') LIMIT 1;
SET @album_Thug_Life = (SELECT id FROM albums WHERE title='Thug Life' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Thug life 2025' AS title, 'Imported album Thug life 2025' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Thug life 2025') LIMIT 1;
SET @album_Thug_life_2025 = (SELECT id FROM albums WHERE title='Thug life 2025' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Vidaamuyarchi' AS title, 'Imported album Vidaamuyarchi' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Vidaamuyarchi') LIMIT 1;
SET @album_Vidaamuyarchi = (SELECT id FROM albums WHERE title='Vidaamuyarchi' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'Vishwambhara' AS title, 'Imported album Vishwambhara' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='Vishwambhara') LIMIT 1;
SET @album_Vishwambhara = (SELECT id FROM albums WHERE title='Vishwambhara' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'War 2' AS title, 'Imported album War 2' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='War 2') LIMIT 1;
SET @album_War_2 = (SELECT id FROM albums WHERE title='War 2' LIMIT 1);
INSERT INTO albums (title, description, thumbnail_id, thumbnail_url)
SELECT 'War 2 (2025)' AS title, 'Imported album War 2 (2025)' AS description, NULL AS thumbnail_id, NULL AS thumbnail_url
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM albums WHERE title='War 2 (2025)') LIMIT 1;
SET @album_War_2_2025 = (SELECT id FROM albums WHERE title='War 2 (2025)' LIMIT 1);

-- === Songs ===
INSERT INTO songs (title, description, singer, thumbnail_id, thumbnail_url, audio_id, audio_url, album_id)
VALUES
(
  'Nuvvunte Chaley',
  'Imported from Ak Thaluka/Nuvvunte Chaley.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Ak%20Thaluka/Nuvvunte%20Chaley.mp3',
  @album_Ak_Thaluka
),

(
  'Jajikaya Jajikaya',
  'Imported from Akhanda 2/Akhanda 2 - HQ/Jajikaya Jajikaya.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Akhanda%202/Akhanda%202%20-%20HQ/Jajikaya%20Jajikaya.mp3',
  @album_Akhanda_2
),

(
  'Jajikaya Jajikaya (Alt)',
  'Imported from Akhanda 2/Akhanda 2/2-Jajikaya Jajikaya.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Akhanda%202/Akhanda%202/2-Jajikaya%20Jajikaya.mp3',
  @album_Akhanda_2
),

(
  'The Thaandavam',
  'Imported from Akhanda 2/Akhanda 2 - HQ/The Thaandavam.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Akhanda%202/Akhanda%202%20-%20HQ/The%20Thaandavam.mp3',
  @album_Akhanda_2
),

(
  'The Thaandavam (Alt)',
  'Imported from Akhanda 2/Akhanda 2/The Thaandavam.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Akhanda%202/Akhanda%202/The%20Thaandavam.mp3',
  @album_Akhanda_2
),

(
  'Bhimavaram Balma',
  'Imported from Anaganaga Oka Roju/Bhimavaram Balma.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Anaganaga%20Oka%20Roju/Bhimavaram%20Balma.mp3',
  @album_Anaganaga_Oka_Roju
),

(
  'Chalu',
  'Imported from Andra King Thaluka/Chalu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Andra%20King%20Thaluka/Chalu.mp3',
  @album_Andra_King_Thaluka
),

(
  'Chinni Gundelo',
  'Imported from Andra King Thaluka/Chinni Gundelo.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Andra%20King%20Thaluka/Chinni%20Gundelo.mp3',
  @album_Andra_King_Thaluka
),

(
  'First Day First Show',
  'Imported from Andra King Thaluka/First Day First Show.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Andra%20King%20Thaluka/First%20Day%20First%20Show.mp3',
  @album_Andra_King_Thaluka
),

(
  'Padu Padu',
  'Imported from Andra King Thaluka/Padu Padu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Andra%20King%20Thaluka/Padu%20Padu.mp3',
  @album_Andra_King_Thaluka
),

(
  'Puppy Shame',
  'Imported from Andra King Thaluka/Puppy Shame.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Andra%20King%20Thaluka/Puppy%20Shame.mp3',
  @album_Andra_King_Thaluka
),

(
  'Untold Emotions',
  'Imported from Andra King Thaluka/Untold Emotions.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Andra%20King%20Thaluka/Untold%20Emotions.mp3',
  @album_Andra_King_Thaluka
),

(
  'Muchataga Bandhaale',
  'Imported from Arjun Son of Vyjayanthi/Muchataga Bandhaale.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Arjun%20Son%20of%20Vyjayanthi/Muchataga%20Bandhaale.mp3',
  @album_Arjun_Son_of_Vyjayanthi
),

(
  'Nayaaldhi',
  'Imported from Arjun Son of Vyjayanthi/Nayaaldhi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Arjun%20Son%20of%20Vyjayanthi/Nayaaldhi.mp3',
  @album_Arjun_Son_of_Vyjayanthi
),

(
  'Bhairavam Theme',
  'Imported from Bhairavam/Bhairavam Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Bhairavam/Bhairavam%20Theme.mp3',
  @album_Bhairavam
),

(
  'Dum Damaare',
  'Imported from Bhairavam/Dum Damaare.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Bhairavam/Dum%20Damaare.mp3',
  @album_Bhairavam
),

(
  'Oo Vennela',
  'Imported from Bhairavam/Oo Vennela.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Bhairavam/Oo%20Vennela.mp3',
  @album_Bhairavam
),

(
  'Preety Baby',
  'Imported from Biker/Preety Baby.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Biker/Preety%20Baby.mp3',
  @album_Biker
),

(
  'Gira Gira Gingiraagirey',
  'Imported from Champion/Gira Gira Gingiraagirey.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Champion/Gira%20Gira%20Gingiraagirey.mp3',
  @album_Champion
),

(
  'Chikitu',
  'Imported from Coolie/Coolie Telugu/Chikitu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Coolie/Coolie%20Telugu/Chikitu.mp3',
  @album_Coolie
),

(
  'Chiku Vibe',
  'Imported from Coolie/Chiku Vibe.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Coolie/Chiku%20Vibe.mp3',
  @album_Coolie
),

(
  'I Am The Danger',
  'Imported from Coolie/I Am The Danger.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Coolie/I%20Am%20The%20Danger.mp3',
  @album_Coolie
),

(
  'Kokki',
  'Imported from Coolie/Kokki.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Coolie/Kokki.mp3',
  @album_Coolie
),

(
  'Mobsta',
  'Imported from Coolie/Mobsta.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Coolie/Mobsta.mp3',
  @album_Coolie
),

(
  'Monica',
  'Imported from Coolie/Coolie Telugu/Monica.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Coolie/Coolie%20Telugu/Monica.mp3',
  @album_Coolie
),

(
  'Monica (Alt)',
  'Imported from Coolie/Monica.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Coolie/Monica.mp3',
  @album_Coolie
),

(
  'Power House',
  'Imported from Coolie/Coolie Telugu/Power House.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Coolie/Coolie%20Telugu/Power%20House.mp3',
  @album_Coolie
),

(
  'Power House (Alt)',
  'Imported from Coolie/Power House.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Coolie/Power%20House.mp3',
  @album_Coolie
),

(
  'Power House Vibe',
  'Imported from Coolie/Power House Vibe.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Coolie/Power%20House%20Vibe.mp3',
  @album_Coolie
),

(
  'Uyirnaadi Nanbane',
  'Imported from Coolie/Uyirnaadi Nanbane.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Coolie/Uyirnaadi%20Nanbane.mp3',
  @album_Coolie
),

(
  'Chinni',
  'Imported from Daaku Maharaj/Daaku Maharaj - HQ/Chinni.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Daaku%20Maharaj/Daaku%20Maharaj%20-%20HQ/Chinni.mp3',
  @album_Daaku_Maharaj
),

(
  'Dabidi Dibidi',
  'Imported from Daaku Maharaj/Daaku Maharaj - HQ/Dabidi Dibidi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Daaku%20Maharaj/Daaku%20Maharaj%20-%20HQ/Dabidi%20Dibidi.mp3',
  @album_Daaku_Maharaj
),

(
  'Dabidi Dibidi (Alt)',
  'Imported from Daaku Maharaj/Daaku Maharaj/Dabidi Dibidi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Daaku%20Maharaj/Daaku%20Maharaj/Dabidi%20Dibidi.mp3',
  @album_Daaku_Maharaj
),

(
  'Sukka Neere',
  'Imported from Daaku Maharaj/Daaku Maharaj/Sukka Neere.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Daaku%20Maharaj/Daaku%20Maharaj/Sukka%20Neere.mp3',
  @album_Daaku_Maharaj
),

(
  'The Rage of Daaku',
  'Imported from Daaku Maharaj/Daaku Maharaj - HQ/The Rage of Daaku.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Daaku%20Maharaj/Daaku%20Maharaj%20-%20HQ/The%20Rage%20of%20Daaku.mp3',
  @album_Daaku_Maharaj
),

(
  'The Rage of Daaku (Alt)',
  'Imported from Daaku Maharaj/Daaku Maharaj/The Rage of Daaku.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Daaku%20Maharaj/Daaku%20Maharaj/The%20Rage%20of%20Daaku.mp3',
  @album_Daaku_Maharaj
),

(
  'Baagundu Po',
  'Imported from Dude - Telugu/Baagundu Po.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Dude%20-%20Telugu/Baagundu%20Po.mp3',
  @album_Dude_Telugu
),

(
  'Boom Boom',
  'Imported from Dude - Telugu/Boom Boom.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Dude%20-%20Telugu/Boom%20Boom.mp3',
  @album_Dude_Telugu
),

(
  'Boom Boom (Anthuleni Premani)',
  'Imported from Dude - Telugu/Boom Boom (Anthuleni Premani).mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Dude%20-%20Telugu/Boom%20Boom%20(Anthuleni%20Premani).mp3',
  @album_Dude_Telugu
),

(
  'Boom Boom (Ringtone)',
  'Imported from Dude - Telugu/Boom Boom (Ringtone).mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Dude%20-%20Telugu/Boom%20Boom%20(Ringtone).mp3',
  @album_Dude_Telugu
),

(
  'Boom Boom (Voilen)',
  'Imported from Dude - Telugu/Boom Boom (Voilen).mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Dude%20-%20Telugu/Boom%20Boom%20(Voilen).mp3',
  @album_Dude_Telugu
),

(
  'Nee Gunde Lona',
  'Imported from Dude - Telugu/Nee Gunde Lona.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Dude%20-%20Telugu/Nee%20Gunde%20Lona.mp3',
  @album_Dude_Telugu
),

(
  'Singari',
  'Imported from Dude - Telugu/Singari.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Dude%20-%20Telugu/Singari.mp3',
  @album_Dude_Telugu
),

(
  'Hara Hara Shambo Shankara',
  'Imported from Folk Songs/Hara Hara Shambo Shankara.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Folk%20Songs/Hara%20Hara%20Shambo%20Shankara.mp3',
  @album_Folk_Songs
),

(
  'Mangli Shivaratri Song 2025',
  'Imported from Folk Songs/Mangli Shivaratri Song 2025.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Folk%20Songs/Mangli%20Shivaratri%20Song%202025.mp3',
  @album_Folk_Songs
),

(
  'Yerra Yerrani Rumalu Gatti',
  'Imported from Folk Songs/Yerra Yerrani Rumalu Gatti.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Folk%20Songs/Yerra%20Yerrani%20Rumalu%20Gatti.mp3',
  @album_Folk_Songs
),

(
  'God Bless U',
  'Imported from Good bad ugly/God Bless U.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Good%20bad%20ugly/God%20Bless%20U.mp3',
  @album_Good_bad_ugly
),

(
  'OG Sambavam',
  'Imported from Good bad ugly/OG Sambavam.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Good%20bad%20ugly/OG%20Sambavam.mp3',
  @album_Good_bad_ugly
),

(
  'Asura Hananam',
  'Imported from Hara Hara Veera Mallu/Hara Hara Veera Mallu/Asura Hananam.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Hara%20Hara%20Veera%20Mallu/Hara%20Hara%20Veera%20Mallu/Asura%20Hananam.mp3',
  @album_Hara_Hara_Veera_Mallu
),

(
  'Evaradi Evaradi',
  'Imported from Hara Hara Veera Mallu/Hara Hara Veera Mallu/Evaradi Evaradi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Hara%20Hara%20Veera%20Mallu/Hara%20Hara%20Veera%20Mallu/Evaradi%20Evaradi.mp3',
  @album_Hara_Hara_Veera_Mallu
),

(
  'Maata Vinaali',
  'Imported from Hara Hara Veera Mallu/Hara Hara Veera Mallu - HQ/Maata Vinaali.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Hara%20Hara%20Veera%20Mallu/Hara%20Hara%20Veera%20Mallu%20-%20HQ/Maata%20Vinaali.mp3',
  @album_Hara_Hara_Veera_Mallu
),

(
  'Puli Meka',
  'Imported from Hara Hara Veera Mallu/Hara Hara Veera Mallu/Puli Meka.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Hara%20Hara%20Veera%20Mallu/Hara%20Hara%20Veera%20Mallu/Puli%20Meka.mp3',
  @album_Hara_Hara_Veera_Mallu
),

(
  'Salasala Marige',
  'Imported from Hara Hara Veera Mallu/Hara Hara Veera Mallu/Salasala Marige.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Hara%20Hara%20Veera%20Mallu/Hara%20Hara%20Veera%20Mallu/Salasala%20Marige.mp3',
  @album_Hara_Hara_Veera_Mallu
),

(
  'Taara Taara',
  'Imported from Hara Hara Veera Mallu/Hara Hara Veera Mallu - HQ/Taara Taara.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Hara%20Hara%20Veera%20Mallu/Hara%20Hara%20Veera%20Mallu%20-%20HQ/Taara%20Taara.mp3',
  @album_Hara_Hara_Veera_Mallu
),

(
  'Kollagottinadhiro',
  'Imported from Hari Hara Veera Mallu (2025)/Hari Hara Veera Mallu (2025) - HQ/Kollagottinadhiro.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Hari%20Hara%20Veera%20Mallu%20(2025)/Hari%20Hara%20Veera%20Mallu%20(2025)%20-%20HQ/Kollagottinadhiro.mp3',
  @album_Hari_Hara_Veera_Mallu_2025
),

(
  'Maata Vinaali',
  'Imported from Hari Hara Veera Mallu (2025)/Hari Hara Veera Mallu (2025) - HQ/Maata Vinaali.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Hari%20Hara%20Veera%20Mallu%20(2025)/Hari%20Hara%20Veera%20Mallu%20(2025)%20-%20HQ/Maata%20Vinaali.mp3',
  @album_Hari_Hara_Veera_Mallu_2025
),

(
  'Poratame 3.O',
  'Imported from Hit/Poratame 3.O.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Hit/Poratame%203.O.mp3',
  @album_Hit
),

(
  'Abki Baar Arjun Sarkaar',
  'Imported from Hit 3/Abki Baar Arjun Sarkaar.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Hit%203/Abki%20Baar%20Arjun%20Sarkaar.mp3',
  @album_Hit_3
),

(
  'Prema Velluva',
  'Imported from Hit 3/Prema Velluva.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Hit%203/Prema%20Velluva.mp3',
  @album_Hit_3
),

(
  'Thanu',
  'Imported from Hit 3/Thanu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Hit%203/Thanu.mp3',
  @album_Hit_3
),

(
  'Enna Sogam',
  'Imported from Idli Kadai/Enna Sogam.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Idli%20Kadai/Enna%20Sogam.mp3',
  @album_Idli_Kadai
),

(
  'Enjaami Thandhaane',
  'Imported from Idli Kadai (2025)/Enjaami Thandhaane.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Idli%20Kadai%20(2025)/Enjaami%20Thandhaane.mp3',
  @album_Idli_Kadai_2025
),

(
  'Ethana Saami',
  'Imported from Idli Kadai (2025)/Ethana Saami.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Idli%20Kadai%20(2025)/Ethana%20Saami.mp3',
  @album_Idli_Kadai_2025
),

(
  'Kulasamy Kaaval Kaaka',
  'Imported from Idli Kadai (2025)/Kulasamy Kaaval Kaaka.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Idli%20Kadai%20(2025)/Kulasamy%20Kaaval%20Kaaka.mp3',
  @album_Idli_Kadai_2025
),

(
  'My Heartu Spinning',
  'Imported from Idli Kadai (2025)/My Heartu Spinning.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Idli%20Kadai%20(2025)/My%20Heartu%20Spinning.mp3',
  @album_Idli_Kadai_2025
),

(
  'Yen Paattan Saami Varum',
  'Imported from Idli Kadai (2025)/Yen Paattan Saami Varum.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Idli%20Kadai%20(2025)/Yen%20Paattan%20Saami%20Varum.mp3',
  @album_Idli_Kadai_2025
),

(
  'Kiss',
  'Imported from Jack/Kiss.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Jack/Kiss.mp3',
  @album_Jack
),

(
  'Pablo Neruda',
  'Imported from Jack/Pablo Neruda.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Jack/Pablo%20Neruda.mp3',
  @album_Jack
),

(
  'Jagan Agenda Song',
  'Imported from Jagan/Jagan Agenda Song.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Jagan/Jagan%20Agenda%20Song.mp3',
  @album_Jagan
),

(
  'Thalapathy Kacheri',
  'Imported from Jana Nayagan/Jana Nayagan 320 Kbps/Thalapathy Kacheri.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Jana%20Nayagan/Jana%20Nayagan%20320%20Kbps/Thalapathy%20Kacheri.mp3',
  @album_Jana_Nayagan
),

(
  'Thalapathy Kacheri (Alt)',
  'Imported from Jana Nayagan/Thalapathy Kacheri.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Jana%20Nayagan/Thalapathy%20Kacheri.mp3',
  @album_Jana_Nayagan
),

(
  'Viral Vayyari',
  'Imported from Junior/Viral Vayyari.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Junior/Viral%20Vayyari.mp3',
  @album_Junior
),

(
  'Love',
  'Imported from Kannappa/Love.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Kannappa/Love.mp3',
  @album_Kannappa
),

(
  'Shiva Shiva Shankara',
  'Imported from Kannappa/Shiva Shiva Shankara.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Kannappa/Shiva%20Shiva%20Shankara.mp3',
  @album_Kannappa
),

(
  'Brahmakalasha',
  'Imported from Kantara 2/Brahmakalasha.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Kantara%202/Brahmakalasha.mp3',
  @album_Kantara_2
),

(
  'Rebel',
  'Imported from Kantara 2/Rebel.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Kantara%202/Rebel.mp3',
  @album_Kantara_2
),

(
  'God Mode',
  'Imported from Karuppu/God Mode.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Karuppu/God%20Mode.mp3',
  @album_Karuppu
),

(
  'Anna Antene',
  'Imported from Kingdom/Anna Antene.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Kingdom/Anna%20Antene.mp3',
  @album_Kingdom
),

(
  'Hridayam Lopala',
  'Imported from Kingdom/Hridayam Lopala.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Kingdom/Hridayam%20Lopala.mp3',
  @album_Kingdom
),

(
  'Ragile Ragile',
  'Imported from Kingdom/Ragile Ragile.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Kingdom/Ragile%20Ragile.mp3',
  @album_Kingdom
),

(
  'Undipove Naathone',
  'Imported from Kishkindhapuri/Undipove Naathone.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Kishkindhapuri/Undipove%20Naathone.mp3',
  @album_Kishkindhapuri
),

(
  'Anaganaga Kadha',
  'Imported from Kubera/Anaganaga Kadha.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Kubera/Anaganaga%20Kadha.mp3',
  @album_Kubera
),

(
  'Kadha Kadha Kadhai',
  'Imported from Kubera/Kubera - Tamil/Kadha Kadha Kadhai.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Kubera/Kubera%20-%20Tamil/Kadha%20Kadha%20Kadhai.mp3',
  @album_Kubera
),

(
  'Naa Koduka',
  'Imported from Kubera/Naa Koduka.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Kubera/Naa%20Koduka.mp3',
  @album_Kubera
),

(
  'Pippi Pippi Dum Dum',
  'Imported from Kubera/Kubera - Tamil/Pippi Pippi Dum Dum.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Kubera/Kubera%20-%20Tamil/Pippi%20Pippi%20Dum%20Dum.mp3',
  @album_Kubera
),

(
  'Poyiraa Mama',
  'Imported from Kubera/Poyiraa Mama.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Kubera/Poyiraa%20Mama.mp3',
  @album_Kubera
),

(
  'Poyivaa Nanba',
  'Imported from Kubera/Kubera - Tamil/Poyivaa Nanba.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Kubera/Kubera%20-%20Tamil/Poyivaa%20Nanba.mp3',
  @album_Kubera
),

(
  'Atak Matak',
  'Imported from Laila/Atak Matak.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Laila/Atak%20Matak.mp3',
  @album_Laila
),

(
  'Icchukundam Baby',
  'Imported from Laila/Icchukundam Baby.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Laila/Icchukundam%20Baby.mp3',
  @album_Laila
),

(
  'Oho Rathamma',
  'Imported from Laila/Oho Rathamma.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Laila/Oho%20Rathamma.mp3',
  @album_Laila
),

(
  'Sonu Model',
  'Imported from Laila/Sonu Model.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Laila/Sonu%20Model.mp3',
  @album_Laila
),

(
  'Dheema',
  'Imported from Lik/Dheema.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Lik/Dheema.mp3',
  @album_Lik
),

(
  'Dheema (Vocals Only)',
  'Imported from Lik/Dheema (Vocals Only).mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Lik/Dheema%20(Vocals%20Only).mp3',
  @album_Lik
),

(
  'Pattuma',
  'Imported from Lik/Pattuma.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Lik/Pattuma.mp3',
  @album_Lik
),

(
  'kkkkkm',
  'Imported from Madharaasi/kkkkkm.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Madharaasi/kkkkkm.mp3',
  @album_Madharaasi
),

(
  'Salambala',
  'Imported from Madharaasi/Salambala.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Madharaasi/Salambala.mp3',
  @album_Madharaasi
),

(
  'Animal Instinct',
  'Imported from Madharasi 2025/Animal Instinct.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Madharasi%202025/Animal%20Instinct.mp3',
  @album_Madharasi_2025
),

(
  'Madharaasi Flow',
  'Imported from Madharasi 2025/Madharaasi Flow.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Madharasi%202025/Madharaasi%20Flow.mp3',
  @album_Madharasi_2025
),

(
  'Madharaasi Theme',
  'Imported from Madharasi 2025/Madharaasi Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Madharasi%202025/Madharaasi%20Theme.mp3',
  @album_Madharasi_2025
),

(
  'Mudinja Thodra',
  'Imported from Madharasi 2025/Mudinja Thodra.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Madharasi%202025/Mudinja%20Thodra.mp3',
  @album_Madharasi_2025
),

(
  'Thangapoovey',
  'Imported from Madharasi 2025/Thangapoovey.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Madharasi%202025/Thangapoovey.mp3',
  @album_Madharasi_2025
),

(
  'Unadhu Enadhu',
  'Imported from Madharasi 2025/Unadhu Enadhu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Madharasi%202025/Unadhu%20Enadhu.mp3',
  @album_Madharasi_2025
),

(
  'Usara Uruvi',
  'Imported from Madharasi 2025/Usara Uruvi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Madharasi%202025/Usara%20Uruvi.mp3',
  @album_Madharasi_2025
),

(
  'Vazhiyiraen',
  'Imported from Madharasi 2025/Vazhiyiraen.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Madharasi%202025/Vazhiyiraen.mp3',
  @album_Madharasi_2025
),

(
  'Meesaala Pilla',
  'Imported from Mana Shankara Varaprasad Garu/Mana Shankar Vara Prasad Garu (HQ)/Meesaala Pilla.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mana%20Shankara%20Varaprasad%20Garu/Mana%20Shankar%20Vara%20Prasad%20Garu%20(HQ)/Meesaala%20Pilla.mp3',
  @album_Mana_Shankara_Varaprasad_Garu
),

(
  'Meesaala Pilla (Alt)',
  'Imported from Mana Shankara Varaprasad Garu/Mana Shankar Varaprasad Garu/Meesaala Pilla.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mana%20Shankara%20Varaprasad%20Garu/Mana%20Shankar%20Varaprasad%20Garu/Meesaala%20Pilla.mp3',
  @album_Mana_Shankara_Varaprasad_Garu
),

(
  'Meesaala Pilla (Promo)',
  'Imported from Mana Shankara Varaprasad Garu/Meesaala Pilla (Promo).mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mana%20Shankara%20Varaprasad%20Garu/Meesaala%20Pilla%20(Promo).mp3',
  @album_Mana_Shankara_Varaprasad_Garu
),

(
  'Tu Mera Lover',
  'Imported from Mass Jathara/Mass Jathara - HQ/Tu Mera Lover.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mass%20Jathara/Mass%20Jathara%20-%20HQ/Tu%20Mera%20Lover.mp3',
  @album_Mass_Jathara
),

(
  'Tu Mera Lover (Alt)',
  'Imported from Mass Jathara/Mass Jathara/Tu Mera Lover.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mass%20Jathara/Mass%20Jathara/Tu%20Mera%20Lover.mp3',
  @album_Mass_Jathara
),

(
  'Hudiyo Hudiyo',
  'Imported from Mass Jathara (2025)/Mass Jathara (2025) - HQ/Hudiyo Hudiyo.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mass%20Jathara%20(2025)/Mass%20Jathara%20(2025)%20-%20HQ/Hudiyo%20Hudiyo.mp3',
  @album_Mass_Jathara_2025
),

(
  'Hudiyo Hudiyo (Alt)',
  'Imported from Mass Jathara (2025)/Mass Jathara (2025)/Hudiyo Hudiyo.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mass%20Jathara%20(2025)/Mass%20Jathara%20(2025)/Hudiyo%20Hudiyo.mp3',
  @album_Mass_Jathara_2025
),

(
  'Ole Ole',
  'Imported from Mass Jathara (2025)/Mass Jathara (2025) - HQ/Ole Ole.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mass%20Jathara%20(2025)/Mass%20Jathara%20(2025)%20-%20HQ/Ole%20Ole.mp3',
  @album_Mass_Jathara_2025
),

(
  'Ole Ole (Alt)',
  'Imported from Mass Jathara (2025)/Mass Jathara (2025)/Ole Ole.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mass%20Jathara%20(2025)/Mass%20Jathara%20(2025)/Ole%20Ole.mp3',
  @album_Mass_Jathara_2025
),

(
  'Super Duper',
  'Imported from Mass Jathara (2025)/Mass Jathara (2025) - HQ/Super Duper.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mass%20Jathara%20(2025)/Mass%20Jathara%20(2025)%20-%20HQ/Super%20Duper.mp3',
  @album_Mass_Jathara_2025
),

(
  'Super Duper (Alt)',
  'Imported from Mass Jathara (2025)/Mass Jathara (2025)/Super Duper.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mass%20Jathara%20(2025)/Mass%20Jathara%20(2025)/Super%20Duper.mp3',
  @album_Mass_Jathara_2025
),

(
  'Baby Maa',
  'Imported from Mazaka/Baby Maa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mazaka/Baby%20Maa.mp3',
  @album_Mazaka
),

(
  'Bachelors Anthem',
  'Imported from Mazaka/Bachelors Anthem.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mazaka/Bachelors%20Anthem.mp3',
  @album_Mazaka
),

(
  'Pagili',
  'Imported from Mazaka/Pagili.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mazaka/Pagili.mp3',
  @album_Mazaka
),

(
  'Sommasilli Pothunnave',
  'Imported from Mazaka/Sommasilli Pothunnave.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mazaka/Sommasilli%20Pothunnave.mp3',
  @album_Mazaka
),

(
  'GlobeTrotter',
  'Imported from mb/GlobeTrotter.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/mb/GlobeTrotter.mp3',
  @album_mb
),

(
  'Vibe Undi',
  'Imported from Mirai/Vibe Undi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mirai/Vibe%20Undi.mp3',
  @album_Mirai
),

(
  'Jaitreya',
  'Imported from Mirai (2015)/Jaitreya.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mirai%20(2015)/Jaitreya.mp3',
  @album_Mirai_2015
),

(
  'The Mother',
  'Imported from Mirai (2015)/The Mother.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mirai%20(2015)/The%20Mother.mp3',
  @album_Mirai_2015
),

(
  'Sayyare',
  'Imported from Mowgli/Sayyare.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Mowgli/Sayyare.mp3',
  @album_Mowgli
),

(
  'Darsanamey',
  'Imported from Nari Nari Nadumurari/Darsanamey.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Nari%20Nari%20Nadumurari/Darsanamey.mp3',
  @album_Nari_Nari_Nadumurari
),

(
  'Fire Storm',
  'Imported from OG/Fire Storm.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/OG/Fire%20Storm.mp3',
  @album_OG
),

(
  'Fire Storm (Alt)',
  'Imported from OG/OG 320 Kbps/Fire Storm.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/OG/OG%20320%20Kbps/Fire%20Storm.mp3',
  @album_OG
),

(
  'Guns And Roses',
  'Imported from OG (2025)/Guns And Roses.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/OG%20(2025)/Guns%20And%20Roses.mp3',
  @album_OG_2025
),

(
  'In The Streets Of Fire',
  'Imported from OG (2025)/In The Streets Of Fire.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/OG%20(2025)/In%20The%20Streets%20Of%20Fire.mp3',
  @album_OG_2025
),

(
  'Kiss Kiss Bang Bang',
  'Imported from OG (2025)/Kiss Kiss Bang Bang.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/OG%20(2025)/Kiss%20Kiss%20Bang%20Bang.mp3',
  @album_OG_2025
),

(
  'Suvvi Suvvi',
  'Imported from OG (2025)/2-Suvvi Suvvi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/OG%20(2025)/2-Suvvi%20Suvvi.mp3',
  @album_OG_2025
),

(
  'Suvvi Suvvi (Alt)',
  'Imported from OG (2025)/Suvvi Suvvi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/OG%20(2025)/Suvvi%20Suvvi.mp3',
  @album_OG_2025
),

(
  'Trance of OMI',
  'Imported from OG (2025)/Trance of OMI.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/OG%20(2025)/Trance%20of%20OMI.mp3',
  @album_OG_2025
),

(
  'Washi O Washi',
  'Imported from OG (2025)/Washi O Washi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/OG%20(2025)/Washi%20O%20Washi.mp3',
  @album_OG_2025
),

(
  'Adi Alaye',
  'Imported from Parasakthi/Adi Alaye.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Parasakthi/Adi%20Alaye.mp3',
  @album_Parasakthi
),

(
  'Ratnamala',
  'Imported from Parasakthi/Parasakthi - Telugu/Ratnamala.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Parasakthi/Parasakthi%20-%20Telugu/Ratnamala.mp3',
  @album_Parasakthi
),

(
  'Ratnamala (Alt)',
  'Imported from Parasakthi/Ratnamala.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Parasakthi/Ratnamala.mp3',
  @album_Parasakthi
),

(
  'Singaaraala Seethaakoka',
  'Imported from Parasakthi/Parasakthi - Telugu/Singaaraala Seethaakoka.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Parasakthi/Parasakthi%20-%20Telugu/Singaaraala%20Seethaakoka.mp3',
  @album_Parasakthi
),

(
  'Chikiri Chikiri',
  'Imported from Peddi/Chikiri Chikiri.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Peddi/Chikiri%20Chikiri.mp3',
  @album_Peddi
),

(
  'Chikiri Chikiri (Alt)',
  'Imported from Peddi/Peddi - Hindi/Chikiri Chikiri.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Peddi/Peddi%20-%20Hindi/Chikiri%20Chikiri.mp3',
  @album_Peddi
),

(
  'Chikiri Chikiri (Alt 2)',
  'Imported from Peddi/Peddi - HQ/Chikiri Chikiri.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Peddi/Peddi%20-%20HQ/Chikiri%20Chikiri.mp3',
  @album_Peddi
),

(
  'Chikiri Chikiri (Alt 3)',
  'Imported from Peddi/Peddi/Chikiri Chikiri.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Peddi/Peddi/Chikiri%20Chikiri.mp3',
  @album_Peddi
),

(
  'Chikiri Chikiri (Promo)',
  'Imported from Peddi/Chikiri Chikiri (Promo)mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Peddi/Chikiri%20Chikiri%20(Promo)mp3',
  @album_Peddi
),

(
  'Are Ningiloni Chukkale (Ringtone)',
  'Imported from Premalu/Are Ningiloni Chukkale (Ringtone).mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Premalu/Are%20Ningiloni%20Chukkale%20(Ringtone).mp3',
  @album_Premalu
),

(
  'Chinni Gunde (Female Tone)',
  'Imported from Premalu/Chinni Gunde (Female Tone).mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Premalu/Chinni%20Gunde%20(Female%20Tone).mp3',
  @album_Premalu
),

(
  'Chitti Guvva',
  'Imported from Premalu/Chitti Guvva.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Premalu/Chitti%20Guvva.mp3',
  @album_Premalu
),

(
  'Premalo',
  'Imported from Premalu/Premalo.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Premalu/Premalo.mp3',
  @album_Premalu
),

(
  'Premalo (Ringtone)',
  'Imported from Premalu/Premalo (Ringtone).mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Premalu/Premalo%20(Ringtone).mp3',
  @album_Premalu
),

(
  'Vela Vela Vennalantha (Ringtone)',
  'Imported from Premalu/Vela Vela Vennalantha (Ringtone).mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Premalu/Vela%20Vela%20Vennalantha%20(Ringtone).mp3',
  @album_Premalu
),

(
  'Dammunte Pattukora',
  'Imported from Pushpa 2 (2024)/Dammunte Pattukora.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Dammunte%20Pattukora.mp3',
  @album_Pushpa_2_2024
),

(
  'Emotional Theme',
  'Imported from Pushpa 2 (2024)/Pushpa 2 - OST/Emotional Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20-%20OST/Emotional%20Theme.mp3',
  @album_Pushpa_2_2024
),

(
  'Final Battle',
  'Imported from Pushpa 2 (2024)/Pushpa 2 - OST/Final Battle.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20-%20OST/Final%20Battle.mp3',
  @album_Pushpa_2_2024
),

(
  'Gango Renuka Thalli',
  'Imported from Pushpa 2 (2024)/Pushpa 2 (2024) - HQ/Gango Renuka Thalli.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20(2024)%20-%20HQ/Gango%20Renuka%20Thalli.mp3',
  @album_Pushpa_2_2024
),

(
  'Gango Renuka Thalli (Alt)',
  'Imported from Pushpa 2 (2024)/Pushpa 2 (2024)/Gango Renuka Thalli.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20(2024)/Gango%20Renuka%20Thalli.mp3',
  @album_Pushpa_2_2024
),

(
  'Kissik',
  'Imported from Pushpa 2 (2024)/Pushpa 2 (2024) - HQ/Kissik.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20(2024)%20-%20HQ/Kissik.mp3',
  @album_Pushpa_2_2024
),

(
  'Kissik (Alt)',
  'Imported from Pushpa 2 (2024)/Pushpa 2 (2024)/Kissik.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20(2024)/Kissik.mp3',
  @album_Pushpa_2_2024
),

(
  'Peelings',
  'Imported from Pushpa 2 (2024)/Pushpa 2 (2024) - HQ/Peelings.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20(2024)%20-%20HQ/Peelings.mp3',
  @album_Pushpa_2_2024
),

(
  'Peelings (Alt)',
  'Imported from Pushpa 2 (2024)/Pushpa 2 (2024)/Peelings.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20(2024)/Peelings.mp3',
  @album_Pushpa_2_2024
),

(
  'Pushpa Pushpa',
  'Imported from Pushpa 2 (2024)/Pushpa 2 (2024) - HQ/Pushpa Pushpa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20(2024)%20-%20HQ/Pushpa%20Pushpa.mp3',
  @album_Pushpa_2_2024
),

(
  'Pushpa Pushpa (Alt)',
  'Imported from Pushpa 2 (2024)/Pushpa 2 (2024)/Pushpa Pushpa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20(2024)/Pushpa%20Pushpa.mp3',
  @album_Pushpa_2_2024
),

(
  'Pushpa Vs Shekhawat',
  'Imported from Pushpa 2 (2024)/Pushpa 2 - OST/Pushpa Vs Shekhawat.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20-%20OST/Pushpa%20Vs%20Shekhawat.mp3',
  @album_Pushpa_2_2024
),

(
  'PushpaS Entry Theme',
  'Imported from Pushpa 2 (2024)/Pushpa 2 - OST/PushpaS Entry Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20-%20OST/PushpaS%20Entry%20Theme.mp3',
  @album_Pushpa_2_2024
),

(
  'PushpaS Power Theme',
  'Imported from Pushpa 2 (2024)/Pushpa 2 - OST/PushpaS Power Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20-%20OST/PushpaS%20Power%20Theme.mp3',
  @album_Pushpa_2_2024
),

(
  'PushpaS Thandav',
  'Imported from Pushpa 2 (2024)/Pushpa 2 - OST/PushpaS Thandav.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20-%20OST/PushpaS%20Thandav.mp3',
  @album_Pushpa_2_2024
),

(
  'Shekhawat Theme',
  'Imported from Pushpa 2 (2024)/Pushpa 2 - OST/Shekhawat Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20-%20OST/Shekhawat%20Theme.mp3',
  @album_Pushpa_2_2024
),

(
  'Sooseki',
  'Imported from Pushpa 2 (2024)/Pushpa 2 (2024) - HQ/Sooseki.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20(2024)%20-%20HQ/Sooseki.mp3',
  @album_Pushpa_2_2024
),

(
  'Sooseki (Alt)',
  'Imported from Pushpa 2 (2024)/Pushpa 2 (2024)/Sooseki.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Pushpa%202%20(2024)/Pushpa%202%20(2024)/Sooseki.mp3',
  @album_Pushpa_2_2024
),

(
  'Ala Ala',
  'Imported from Raju Weds RAmbai/Ala Ala.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Raju%20Weds%20RAmbai/Ala%20Ala.mp3',
  @album_Raju_Weds_RAmbai
),

(
  'Rambai Neemeedha Naku',
  'Imported from Raju Weds RAmbai/Rambai Neemeedha Naku.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Raju%20Weds%20RAmbai/Rambai%20Neemeedha%20Naku.mp3',
  @album_Raju_Weds_RAmbai
),

(
  'Kanimaa',
  'Imported from Retro (2025)/Kanimaa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Retro%20(2025)/Kanimaa.mp3',
  @album_Retro_2025
),

(
  'Kannadi Poove',
  'Imported from Retro (2025)/Kannadi Poove.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Retro%20(2025)/Kannadi%20Poove.mp3',
  @album_Retro_2025
),

(
  'The One',
  'Imported from Retro (2025)/The One.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Retro%20(2025)/The%20One.mp3',
  @album_Retro_2025
),

(
  'Blockbuster Pongal',
  'Imported from Sankranthiki Vasthunnam (2025)/Sankranthiki Vasthunnam (2025)/Blockbuster Pongal.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Sankranthiki%20Vasthunnam%20(2025)/Sankranthiki%20Vasthunnam%20(2025)/Blockbuster%20Pongal.mp3',
  @album_Sankranthiki_Vasthunnam_2025
),

(
  'Blockbuster Pongal (Alt)',
  'Imported from Sankranthiki Vasthunnam (2025)/Sankranthiki Vasthunnam - HQ/Blockbuster Pongal.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Sankranthiki%20Vasthunnam%20(2025)/Sankranthiki%20Vasthunnam%20-%20HQ/Blockbuster%20Pongal.mp3',
  @album_Sankranthiki_Vasthunnam_2025
),

(
  'Chinna Raju',
  'Imported from Sankranthiki Vasthunnam (2025)/Sankranthiki Vasthunnam (2025)/Chinna Raju.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Sankranthiki%20Vasthunnam%20(2025)/Sankranthiki%20Vasthunnam%20(2025)/Chinna%20Raju.mp3',
  @album_Sankranthiki_Vasthunnam_2025
),

(
  'Godari Gattu',
  'Imported from Sankranthiki Vasthunnam (2025)/Sankranthiki Vasthunnam (2025)/Godari Gattu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Sankranthiki%20Vasthunnam%20(2025)/Sankranthiki%20Vasthunnam%20(2025)/Godari%20Gattu.mp3',
  @album_Sankranthiki_Vasthunnam_2025
),

(
  'Godari Gattu (Alt)',
  'Imported from Sankranthiki Vasthunnam (2025)/Sankranthiki Vasthunnam - HQ/Godari Gattu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Sankranthiki%20Vasthunnam%20(2025)/Sankranthiki%20Vasthunnam%20-%20HQ/Godari%20Gattu.mp3',
  @album_Sankranthiki_Vasthunnam_2025
),

(
  'Guruvarya',
  'Imported from Sankranthiki Vasthunnam (2025)/Sankranthiki Vasthunnam (2025)/Guruvarya.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Sankranthiki%20Vasthunnam%20(2025)/Sankranthiki%20Vasthunnam%20(2025)/Guruvarya.mp3',
  @album_Sankranthiki_Vasthunnam_2025
),

(
  'Lallayire',
  'Imported from Sankranthiki Vasthunnam (2025)/Sankranthiki Vasthunnam (2025)/Lallayire.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Sankranthiki%20Vasthunnam%20(2025)/Sankranthiki%20Vasthunnam%20(2025)/Lallayire.mp3',
  @album_Sankranthiki_Vasthunnam_2025
),

(
  'Meenu',
  'Imported from Sankranthiki Vasthunnam (2025)/Sankranthiki Vasthunnam (2025)/Meenu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Sankranthiki%20Vasthunnam%20(2025)/Sankranthiki%20Vasthunnam%20(2025)/Meenu.mp3',
  @album_Sankranthiki_Vasthunnam_2025
),

(
  'Meenu (Alt)',
  'Imported from Sankranthiki Vasthunnam (2025)/Sankranthiki Vasthunnam - HQ/Meenu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Sankranthiki%20Vasthunnam%20(2025)/Sankranthiki%20Vasthunnam%20-%20HQ/Meenu.mp3',
  @album_Sankranthiki_Vasthunnam_2025
),

(
  'Babai',
  'Imported from Telusu Kada (2025)/Babai.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Telusu%20Kada%20(2025)/Babai.mp3',
  @album_Telusu_Kada_2025
),

(
  'Sogasu Chudatharama',
  'Imported from Telusu Kada (2025)/Sogasu Chudatharama.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Telusu%20Kada%20(2025)/Sogasu%20Chudatharama.mp3',
  @album_Telusu_Kada_2025
),

(
  'Bhuu Antuu Bhuutham',
  'Imported from Thammdu/Bhuu Antuu Bhuutham.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Thammdu/Bhuu%20Antuu%20Bhuutham.mp3',
  @album_Thammdu
),

(
  'Jai Bagalaamukhii',
  'Imported from Thammdu/Jai Bagalaamukhii.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Thammdu/Jai%20Bagalaamukhii.mp3',
  @album_Thammdu
),

(
  'Rebel Saab',
  'Imported from The Raja Saab/The Raja Saab - HQ/Rebel Saab.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/The%20Raja%20Saab/The%20Raja%20Saab%20-%20HQ/Rebel%20Saab.mp3',
  @album_The_Raja_Saab
),

(
  'Rebel Saab (Alt)',
  'Imported from The Raja Saab/The Raja Saab/Rebel Saab.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/The%20Raja%20Saab/The%20Raja%20Saab/Rebel%20Saab.mp3',
  @album_The_Raja_Saab
),

(
  'Mallika Gandha',
  'Imported from Thelusu Kadha/Mallika Gandha.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Thelusu%20Kadha/Mallika%20Gandha.mp3',
  @album_Thelusu_Kadha
),

(
  'Suvvi Suvvi',
  'Imported from They Call Him OG/Suvvi Suvvi.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/They%20Call%20Him%20OG/Suvvi%20Suvvi.mp3',
  @album_They_Call_Him_OG
),

(
  'Jinguchaa',
  'Imported from Thug Life/Jinguchaa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Thug%20Life/Jinguchaa.mp3',
  @album_Thug_Life
),

(
  'Anju Vanna Poove',
  'Imported from Thug life 2025/Anju Vanna Poove.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Thug%20life%202025/Anju%20Vanna%20Poove.mp3',
  @album_Thug_life_2025
),

(
  'Anju Vanna Poove (Reprise)',
  'Imported from Thug life 2025/Anju Vanna Poove (Reprise).mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Thug%20life%202025/Anju%20Vanna%20Poove%20(Reprise).mp3',
  @album_Thug_life_2025
),

(
  'Engeyo',
  'Imported from Thug life 2025/Engeyo.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Thug%20life%202025/Engeyo.mp3',
  @album_Thug_life_2025
),

(
  'Jinguchaa',
  'Imported from Thug life 2025/Jinguchaa.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Thug%20life%202025/Jinguchaa.mp3',
  @album_Thug_life_2025
),

(
  'Lets Play',
  'Imported from Thug life 2025/Lets Play.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Thug%20life%202025/Lets%20Play.mp3',
  @album_Thug_life_2025
),

(
  'Muththa Mazhai',
  'Imported from Thug life 2025/Muththa Mazhai.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Thug%20life%202025/Muththa%20Mazhai.mp3',
  @album_Thug_life_2025
),

(
  'O Maara',
  'Imported from Thug life 2025/O Maara.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Thug%20life%202025/O%20Maara.mp3',
  @album_Thug_life_2025
),

(
  'Sugar Baby',
  'Imported from Thug life 2025/Sugar Baby.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Thug%20life%202025/Sugar%20Baby.mp3',
  @album_Thug_life_2025
),

(
  'Vinveli Nayaga',
  'Imported from Thug life 2025/Vinveli Nayaga.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Thug%20life%202025/Vinveli%20Nayaga.mp3',
  @album_Thug_life_2025
),

(
  'Pathikichu',
  'Imported from Vidaamuyarchi/Pathikichu.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Vidaamuyarchi/Pathikichu.mp3',
  @album_Vidaamuyarchi
),

(
  'Sawadeeka',
  'Imported from Vidaamuyarchi/Sawadeeka.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Vidaamuyarchi/Sawadeeka.mp3',
  @album_Vidaamuyarchi
),

(
  'Thaniye',
  'Imported from Vidaamuyarchi/Thaniye.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Vidaamuyarchi/Thaniye.mp3',
  @album_Vidaamuyarchi
),

(
  'Rama Raama',
  'Imported from Vishwambhara/Vishwambhara - HQ/Rama Raama.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Vishwambhara/Vishwambhara%20-%20HQ/Rama%20Raama.mp3',
  @album_Vishwambhara
),

(
  'Rama Raama (Alt)',
  'Imported from Vishwambhara/Vishwambhara/Rama Raama.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/Vishwambhara/Vishwambhara/Rama%20Raama.mp3',
  @album_Vishwambhara
),

(
  'Aavan Jaavan',
  'Imported from War 2/War 2 - Hindi/Aavan Jaavan.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202/War%202%20-%20Hindi/Aavan%20Jaavan.mp3',
  @album_War_2
),

(
  'Oopiri Ooyalaga',
  'Imported from War 2/Oopiri Ooyalaga.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202/Oopiri%20Ooyalaga.mp3',
  @album_War_2
),

(
  'Janaab E Aali',
  'Imported from War 2 (2025)/War 2 Hindi/2-Janaab E Aali.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/War%202%20Hindi/2-Janaab%20E%20Aali.mp3',
  @album_War_2_2025
),

(
  'Janaab E Aali (Alt)',
  'Imported from War 2 (2025)/War 2 Hindi/Janaab E Aali.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/War%202%20Hindi/Janaab%20E%20Aali.mp3',
  @album_War_2_2025
),

(
  'Jeete Jeete',
  'Imported from War 2 (2025)/War 2 Hindi/Jeete Jeete.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/War%202%20Hindi/Jeete%20Jeete.mp3',
  @album_War_2_2025
),

(
  'Kabir Theme Reloaded',
  'Imported from War 2 (2025)/War 2 Hindi/Kabir Theme Reloaded.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/War%202%20Hindi/Kabir%20Theme%20Reloaded.mp3',
  @album_War_2_2025
),

(
  'Kabir Theme Reloaded (Alt)',
  'Imported from War 2 (2025)/War 2 Telugu/Kabir Theme Reloaded.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/War%202%20Telugu/Kabir%20Theme%20Reloaded.mp3',
  @album_War_2_2025
),

(
  'Nuvvunte Naatho',
  'Imported from War 2 (2025)/War 2 Telugu/Nuvvunte Naatho.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/War%202%20Telugu/Nuvvunte%20Naatho.mp3',
  @album_War_2_2025
),

(
  'Raghu and Kaboo Theme',
  'Imported from War 2 (2025)/War 2 Hindi/Raghu and Kaboo Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/War%202%20Hindi/Raghu%20and%20Kaboo%20Theme.mp3',
  @album_War_2_2025
),

(
  'Raghu Kaboo Theme',
  'Imported from War 2 (2025)/War 2 Telugu/Raghu Kaboo Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/War%202%20Telugu/Raghu%20Kaboo%20Theme.mp3',
  @album_War_2_2025
),

(
  'Salam Anali',
  'Imported from War 2 (2025)/Salam Anali.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/Salam%20Anali.mp3',
  @album_War_2_2025
),

(
  'Shaitan',
  'Imported from War 2 (2025)/War 2 Hindi/Shaitan.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/War%202%20Hindi/Shaitan.mp3',
  @album_War_2_2025
),

(
  'Shaitan (Alt)',
  'Imported from War 2 (2025)/War 2 Telugu/Shaitan.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/War%202%20Telugu/Shaitan.mp3',
  @album_War_2_2025
),

(
  'Tripping High',
  'Imported from War 2 (2025)/War 2 Hindi/Tripping High.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/War%202%20Hindi/Tripping%20High.mp3',
  @album_War_2_2025
),

(
  'Tripping High (Alt)',
  'Imported from War 2 (2025)/War 2 Telugu/Tripping High.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/War%202%20Telugu/Tripping%20High.mp3',
  @album_War_2_2025
),

(
  'War Theme',
  'Imported from War 2 (2025)/War 2 Hindi/War Theme.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/War%202%20Hindi/War%20Theme.mp3',
  @album_War_2_2025
),

(
  'War Theme 2.o',
  'Imported from War 2 (2025)/War 2 Telugu/War Theme 2.o.mp3',
  'Unknown',
  NULL,
  NULL,
  NULL,
  'https://mp3teluguwap.net/mp3/2025/War%202%20(2025)/War%202%20Telugu/War%20Theme%202.o.mp3',
  @album_War_2_2025
);
