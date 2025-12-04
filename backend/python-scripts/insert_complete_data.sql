-- Complete SQL Insert Statements
-- Generated from Pagal World Extended Scraper
-- Total Albums: 14
-- Total Songs: 66

-- ============================================================
-- EXECUTION INSTRUCTIONS:
-- ============================================================
-- 1. Backup your database
-- 2. Execute this entire script in your MySQL client
-- 3. Albums are inserted first (with AUTO_INCREMENT ID)
-- 4. Songs are linked using COALESCE with album titles
-- 5. All audio URLs are absolute (include domain)
-- ============================================================

SET FOREIGN_KEY_CHECKS=0;
START TRANSACTION;

-- ============================================================
-- ALBUMS INSERT STATEMENTS
-- ============================================================

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Dhurandhar',
    'Dhurandhar Album Mp3 Songs Pagalworld Music Song Com Download Including Bollywood, Punjabi, And New Releases ',
    'https://pagalworldmusic.com/downloads/cover/4578394/4578394.jpg',
    NULL,
    NULL,
    'Song Com Download',
    'hindi',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'De De Pyaar De 2 Deluxe Album',
    'De De Pyaar De 2 Deluxe Album Album Mp3 Songs Pagalworld Music Song Com Download Including Bollywood, Punjabi, And New Releases ',
    'https://pagalworldmusic.com/downloads/cover/4578106/4578106.jpg',
    NULL,
    NULL,
    'Song Com Download',
    'hindi',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Ek Deewane Ki Deewaniyat',
    'Ek Deewane Ki Deewaniyat Album Mp3 Songs Pagalworld Music Song Com Download Including Bollywood, Punjabi, And New Releases ',
    'https://pagalworldmusic.com/downloads/cover/4578100/4578100.jpg',
    NULL,
    NULL,
    'Song Com Download',
    'hindi',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Tere Ishk Mein',
    'Tere Ishk Mein Album Mp3 Songs Pagalworld Music Song Com Download Including Bollywood, Punjabi, And New Releases ',
    'https://pagalworldmusic.com/downloads/cover/4577878/4577878.jpg',
    NULL,
    NULL,
    'Song Com Download',
    'hindi',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    '120 Bahadur Original Motion Picture Soundtrack',
    '120 Bahadur Original Motion Picture Soundtrack Album Mp3 Songs Pagalworld Music Song Com Download Including Bollywood, Punjabi, And New Releases ',
    'https://pagalworldmusic.com/downloads/cover/4577760/4577760.jpg',
    NULL,
    NULL,
    'Song Com Download',
    'hindi',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Antarrashtriya',
    'Antarrashtriya Album Mp3 Songs Pagalworld Music Song Com Download Including Bollywood, Punjabi, And New Releases ',
    'https://pagalworldmusic.com/downloads/cover/4578151/4578151.jpg',
    NULL,
    NULL,
    'Song Com Download',
    'marathi',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Tere Ishk Mein Tamil',
    'Tere Ishk Mein Tamil Album Mp3 Songs Pagalworld Music Song Com Download Including Bollywood, Punjabi, And New Releases ',
    'https://pagalworldmusic.com/downloads/cover/4578417/4578417.jpg',
    NULL,
    NULL,
    'Song Com Download',
    'tamil',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Revolver Rita Original Motion Picture Soundtrack',
    'Revolver Rita Original Motion Picture Soundtrack Album Mp3 Songs Pagalworld Music Song Com Download Including Bollywood, Punjabi, And New Releases ',
    'https://pagalworldmusic.com/downloads/cover/4578404/4578404.jpg',
    NULL,
    NULL,
    'Song Com Download',
    'tamil',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Theeyavar Kulai Nadunga Original Motion Picture Soundtrack',
    'Theeyavar Kulai Nadunga Original Motion Picture Soundtrack Album Mp3 Songs Pagalworld Music Song Com Download Including Bollywood, Punjabi, And New Releases ',
    'https://pagalworldmusic.com/downloads/cover/4578398/4578398.jpg',
    NULL,
    NULL,
    'Song Com Download',
    'tamil',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Mangai',
    'Mangai Album Mp3 Songs Pagalworld Music Song Com Download Including Bollywood, Punjabi, And New Releases ',
    'https://pagalworldmusic.com/downloads/cover/4578224/4578224.jpg',
    NULL,
    NULL,
    'Song Com Download',
    'tamil',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Akhanda 2 Thaandavam',
    'Akhanda 2 Thaandavam Album Mp3 Songs Pagalworld Music Song Com Download Including Bollywood, Punjabi, And New Releases ',
    'https://pagalworldmusic.com/downloads/cover/4578452/4578452.jpg',
    NULL,
    NULL,
    'Song Com Download',
    'telugu',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Andhra King Taluka',
    'Andhra King Taluka Album Mp3 Songs Pagalworld Music Song Com Download Including Bollywood, Punjabi, And New Releases ',
    'https://pagalworldmusic.com/downloads/cover/4578443/4578443.jpg',
    NULL,
    NULL,
    'Song Com Download',
    'telugu',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Tere Ishk Mein Telugu',
    'Tere Ishk Mein Telugu Album Mp3 Songs Pagalworld Music Song Com Download Including Bollywood, Punjabi, And New Releases ',
    'https://pagalworldmusic.com/downloads/cover/4578435/4578435.jpg',
    NULL,
    NULL,
    'Song Com Download',
    'telugu',
    NOW(),
    NOW()
);

INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    'Premante',
    'Premante Album Mp3 Songs Pagalworld Music Song Com Download Including Bollywood, Punjabi, And New Releases ',
    'https://pagalworldmusic.com/downloads/cover/4578237/4578237.jpg',
    NULL,
    NULL,
    'Song Com Download',
    'telugu',
    NOW(),
    NOW()
);

-- Total albums: 14

-- ============================================================
-- SONGS INSERT STATEMENTS (with album lookup using COALESCE)
-- ============================================================
-- Songs are linked to albums by title lookup
-- If album not found, defaults to album_id = 1
-- ============================================================

-- Song 1: Tu Meri Main Tera Main Tera Tu Meri Title Track From Tu Meri Main Tera Main Tera Tu Meri (Album: Tu Meri Main Tera Main Tera Tu Meri Title Track From Tu Meri Main Tera Main Tera Tu Meri)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Tu Meri Main Tera Main Tera Tu Meri Title Track From Tu Meri Main Tera Main Tera Tu Meri' LIMIT 1), 1),
    'Tu Meri Main Tera Main Tera Tu Meri Title Track From Tu Meri Main Tera Main Tera Tu Meri',
    'Anvita Dutt Guptan',
    'https://pagalworldmusic.com/downloads/cover/4578388/4578388.jpg',
    'https://pagalworldmusic.com/download.php?title=Tu+Meri+Main+Tera+Main+Tera+Tu+Meri+Title+Track+From+Tu+Meri+Main+Tera+Main+Tera+Tu+Meri-320kbps&path=downloads%2Fhigh%2FJhgDUB5ZWWo%2FJhgDUB5ZWWo.mp3',
    'Download Tu Meri Main Tera Main Tera Tu Meri Title Track From Tu Meri Main Tera Main Tera Tu Meri By Anvita Dutt Guptan From Tu Meri Main Tera Main Tera Tu Meri Title Track From Tu Meri Main Tera Main Tera Tu Meri Released By SaReGaMA India Ltd In Hindi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 2: Chal Musafir From Gustaakh Ishq (Album: Chal Musafir From Gustaakh Ishq)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Chal Musafir From Gustaakh Ishq' LIMIT 1), 1),
    'Chal Musafir From Gustaakh Ishq',
    'Armaan Malik',
    'https://pagalworldmusic.com/downloads/cover/4578387/4578387.jpg',
    'https://pagalworldmusic.com/download.php?title=Chal+Musafir+From+Gustaakh+Ishq-320kbps&path=downloads%2Fhigh%2FNS8vSQFhdEc%2FNS8vSQFhdEc.mp3',
    'Download Chal Musafir From Gustaakh Ishq By Armaan Malik From Chal Musafir From Gustaakh Ishq Released By Zee Music Company In Hindi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 3: Hey Penne (Album: Haal Original Motion Picture Soundtrack)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Haal Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Hey Penne',
    'Vinayak Sasikumar',
    'https://pagalworldmusic.com/downloads/cover/4578340/4578340.jpg',
    'https://pagalworldmusic.com/download.php?title=Hey+Penne-320kbps&path=downloads%2Fhigh%2FFj0bdB5CUmw%2FFj0bdB5CUmw.mp3',
    'Download Hey Penne By Vinayak Sasikumar From Haal Original Motion Picture Soundtrack Released By Think Music In Malayalam Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 4: Ishq Jalakar Karvaan From Dhurandhar (Album: Ishq Jalakar Karvaan From Dhurandhar)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Ishq Jalakar Karvaan From Dhurandhar' LIMIT 1), 1),
    'Ishq Jalakar Karvaan From Dhurandhar',
    'Irshad Kamil',
    'https://pagalworldmusic.com/downloads/cover/4578219/4578219.jpg',
    'https://pagalworldmusic.com/download.php?title=Ishq+Jalakar+Karvaan+From+Dhurandhar-320kbps&path=downloads%2Fhigh%2FBgcpSRBAe3k%2FBgcpSRBAe3k.mp3',
    'Download Ishq Jalakar Karvaan From Dhurandhar By Irshad Kamil From Ishq Jalakar Karvaan From Dhurandhar Released By SaReGaMA India Ltd In Hindi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 5: Rebel Saab From The Rajasaab Hindi (Album: Rebel Saab From The Rajasaab Hindi)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Rebel Saab From The Rajasaab Hindi' LIMIT 1), 1),
    'Rebel Saab From The Rajasaab Hindi',
    'Thaman S',
    'https://pagalworldmusic.com/downloads/cover/4578218/4578218.jpg',
    'https://pagalworldmusic.com/download.php?title=Rebel+Saab+From+The+Rajasaab+Hindi-320kbps&path=downloads%2Fhigh%2FNFgfCRJWRgA%2FNFgfCRJWRgA.mp3',
    'Download Rebel Saab From The Rajasaab Hindi By Thaman S From Rebel Saab From The Rajasaab Hindi Released By T-Series In Hindi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 6: He Dil Pagal Pagal Hogaya From Chimera (Album: He Dil Pagal Pagal Hogaya From Chimera Hindi)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'He Dil Pagal Pagal Hogaya From Chimera Hindi' LIMIT 1), 1),
    'He Dil Pagal Pagal Hogaya From Chimera',
    'Anuradha Bhat',
    'https://pagalworldmusic.com/downloads/cover/4578217/4578217.jpg',
    'https://pagalworldmusic.com/download.php?title=He+Dil+Pagal+Pagal+Hogaya+From+Chimera-320kbps&path=downloads%2Fhigh%2FChscR0B4WQc%2FChscR0B4WQc.mp3',
    'Download He Dil Pagal Pagal Hogaya From Chimera By Anuradha Bhat From He Dil Pagal Pagal Hogaya From Chimera Hindi Released By MRT Music In Hindi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 7: One In Crore From Mastiii 4 (Album: One In Crore From Mastiii 4)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'One In Crore From Mastiii 4' LIMIT 1), 1),
    'One In Crore From Mastiii 4',
    'Kanika Kapoor',
    'https://pagalworldmusic.com/downloads/cover/4577987/4577987.jpg',
    'https://pagalworldmusic.com/download.php?title=One+In+Crore+From+Mastiii+4-320kbps&path=downloads%2Fhigh%2FGDkdfBhKbVY%2FGDkdfBhKbVY.mp3',
    'Download One In Crore From Mastiii 4 By Kanika Kapoor From One In Crore From Mastiii 4 Released By Zee Music Company In Hindi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 8: The Thaandavam From Akhanda 2 ThaandavamHindi (Album: The Thaandavam From Akhanda 2 ThaandavamHindi)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'The Thaandavam From Akhanda 2 ThaandavamHindi' LIMIT 1), 1),
    'The Thaandavam From Akhanda 2 ThaandavamHindi',
    'Jubin Nautiyal',
    'https://pagalworldmusic.com/downloads/cover/4577986/4577986.jpg',
    'https://pagalworldmusic.com/download.php?title=The+Thaandavam+From+Akhanda+2+ThaandavamHindi-320kbps&path=downloads%2Fhigh%2FM14xUzpcbWU%2FM14xUzpcbWU.mp3',
    'Download The Thaandavam From Akhanda 2 ThaandavamHindi By Jubin Nautiyal From The Thaandavam From Akhanda 2 ThaandavamHindi Released By Aditya Music (India) Pvt Ltd In Hindi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 9: Mehndi Laagi (Album: Mehndi Laagi)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Mehndi Laagi' LIMIT 1), 1),
    'Mehndi Laagi',
    'Moti Khan',
    'https://pagalworldmusic.com/downloads/cover/4577960/4577960.jpg',
    'https://pagalworldmusic.com/download.php?title=Mehndi+Laagi-320kbps&path=downloads%2Fhigh%2FIh86ewFzUFk%2FIh86ewFzUFk.mp3',
    'Download Mehndi Laagi By Moti Khan From Mehndi Laagi Released By Ultra Music In Hindi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 10: Nobody Came (Album: Nobody Came)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Nobody Came' LIMIT 1), 1),
    'Nobody Came',
    'Dhanda Nyoliwala',
    'https://pagalworldmusic.com/downloads/cover/4577959/4577959.jpg',
    'https://pagalworldmusic.com/download.php?title=Nobody+Came-320kbps&path=downloads%2Fhigh%2FJjwAdBZiDnk%2FJjwAdBZiDnk.mp3',
    'Download Nobody Came By Dhanda Nyoliwala From Nobody Came Released By Fararmy Productions In Hindi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 11: They Call Him KING King Theme From King (Album: They Call Him KING King Theme From King)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'They Call Him KING King Theme From King' LIMIT 1), 1),
    'They Call Him KING King Theme From King',
    'Anirudh Ravichander',
    'https://pagalworldmusic.com/downloads/cover/4577869/4577869.jpg',
    'https://pagalworldmusic.com/download.php?title=They+Call+Him+KING+King+Theme+From+King-320kbps&path=downloads%2Fhigh%2FCTgzdEZbXkk%2FCTgzdEZbXkk.mp3',
    'Download They Call Him KING King Theme From King By Anirudh Ravichander From They Call Him KING King Theme From King Released By T-Series In Hindi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 12: Sundara From Non Violence (Album: Sundara From Non Violence)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Sundara From Non Violence' LIMIT 1), 1),
    'Sundara From Non Violence',
    'Yuvan Shankar Raja',
    'https://pagalworldmusic.com/downloads/cover/4577868/4577868.jpg',
    'https://pagalworldmusic.com/download.php?title=Sundara+From+Non+Violence-320kbps&path=downloads%2Fhigh%2FIkUMVRlVf3c%2FIkUMVRlVf3c.mp3',
    'Download Sundara From Non Violence By Yuvan Shankar Raja From Sundara From Non Violence Released By T-Series In Hindi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 13: Aakhri Salaam From De De Pyaar De 2 (Album: Aakhri Salaam From De De Pyaar De 2)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Aakhri Salaam From De De Pyaar De 2' LIMIT 1), 1),
    'Aakhri Salaam From De De Pyaar De 2',
    'Sagar Bhatia',
    'https://pagalworldmusic.com/downloads/cover/4577803/4577803.jpg',
    'https://pagalworldmusic.com/download.php?title=Aakhri+Salaam+From+De+De+Pyaar+De+2-320kbps&path=downloads%2Fhigh%2FNjocXCR6elg%2FNjocXCR6elg.mp3',
    'Download Aakhri Salaam From De De Pyaar De 2 By Sagar Bhatia From Aakhri Salaam From De De Pyaar De 2 Released By T-Series In Hindi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 14: Rasiya Balama From Mastiii 4 (Album: Rasiya Balama From Mastiii 4)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Rasiya Balama From Mastiii 4' LIMIT 1), 1),
    'Rasiya Balama From Mastiii 4',
    'Sanjeev Chaturvedi',
    'https://pagalworldmusic.com/downloads/cover/4577802/4577802.jpg',
    'https://pagalworldmusic.com/download.php?title=Rasiya+Balama+From+Mastiii+4-320kbps&path=downloads%2Fhigh%2FGxszVyt3AGM%2FGxszVyt3AGM.mp3',
    'Download Rasiya Balama From Mastiii 4 By Sanjeev Chaturvedi From Rasiya Balama From Mastiii 4 Released By Zee Music Company In Hindi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 15: Chikiri Chikiri From Peddi Hindi (Album: Chikiri Chikiri From Peddi Hindi)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Chikiri Chikiri From Peddi Hindi' LIMIT 1), 1),
    'Chikiri Chikiri From Peddi Hindi',
    'A.R. Rahman',
    'https://pagalworldmusic.com/downloads/cover/4577755/4577755.jpg',
    'https://pagalworldmusic.com/download.php?title=Chikiri+Chikiri+From+Peddi+Hindi-320kbps&path=downloads%2Fhigh%2FEQUTeS1DdQo%2FEQUTeS1DdQo.mp3',
    'Download Chikiri Chikiri From Peddi Hindi By A.R. Rahman From Chikiri Chikiri From Peddi Hindi Released By T-Series In Hindi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 16: Aye Chedva From Kairee (Album: Aye Chedva From Kairee)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Aye Chedva From Kairee' LIMIT 1), 1),
    'Aye Chedva From Kairee',
    'Manohar Golambre',
    'https://pagalworldmusic.com/downloads/cover/4578307/4578307.jpg',
    'https://pagalworldmusic.com/download.php?title=Aye+Chedva+From+Kairee-320kbps&path=downloads%2Fhigh%2FKjc7fBFoe0s%2FKjc7fBFoe0s.mp3',
    'Download Aye Chedva From Kairee By Manohar Golambre From Aye Chedva From Kairee Released By Ultra Music In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 17: Zat Pat Pata Pat (Album: Zat Pat Pata Pat)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Zat Pat Pata Pat' LIMIT 1), 1),
    'Zat Pat Pata Pat',
    'Danny Pandit',
    'https://pagalworldmusic.com/downloads/cover/4578306/4578306.jpg',
    'https://pagalworldmusic.com/download.php?title=Zat+Pat+Pata+Pat-320kbps&path=downloads%2Fhigh%2FGVgyYkEAb0k%2FGVgyYkEAb0k.mp3',
    'Download Zat Pat Pata Pat By Danny Pandit From Zat Pat Pata Pat Released By SaReGaMA India Ltd In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 18: Sur Tech Chedata From Asa Mee Ashi Mee (Album: Sur Tech Chedata From Asa Mee Ashi Mee)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Sur Tech Chedata From Asa Mee Ashi Mee' LIMIT 1), 1),
    'Sur Tech Chedata From Asa Mee Ashi Mee',
    'Shripad Arun Joshi',
    'https://pagalworldmusic.com/downloads/cover/4578305/4578305.jpg',
    'https://pagalworldmusic.com/download.php?title=Sur+Tech+Chedata+From+Asa+Mee+Ashi+Mee-320kbps&path=downloads%2Fhigh%2FEV8NQR9Iegc%2FEV8NQR9Iegc.mp3',
    'Download Sur Tech Chedata From Asa Mee Ashi Mee By Shripad Arun Joshi From Sur Tech Chedata From Asa Mee Ashi Mee Released By Zee Music Company In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 19: Kshanbhar (Album: Kshanbhar)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Kshanbhar' LIMIT 1), 1),
    'Kshanbhar',
    'Ajay Kesbhat',
    'https://pagalworldmusic.com/downloads/cover/4578304/4578304.jpg',
    'https://pagalworldmusic.com/download.php?title=Kshanbhar-320kbps&path=downloads%2Fhigh%2FKiE5dUNYUHY%2FKiE5dUNYUHY.mp3',
    'Download Kshanbhar By Ajay Kesbhat From Kshanbhar Released By Ajay Kesbhat In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 20: Porancha Ranga Original Soundtrack From Ekaki (Album: Porancha Ranga Original Soundtrack From Ekaki)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Porancha Ranga Original Soundtrack From Ekaki' LIMIT 1), 1),
    'Porancha Ranga Original Soundtrack From Ekaki',
    'Ashish Chanchlani',
    'https://pagalworldmusic.com/downloads/cover/4578303/4578303.jpg',
    'https://pagalworldmusic.com/download.php?title=Porancha+Ranga+Original+Soundtrack+From+Ekaki-320kbps&path=downloads%2Fhigh%2FPBIOdg4dXEQ%2FPBIOdg4dXEQ.mp3',
    'Download Porancha Ranga Original Soundtrack From Ekaki By Ashish Chanchlani From Porancha Ranga Original Soundtrack From Ekaki Released By One Mind Music In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 21: Malhari From Gondhal (Album: Malhari From Gondhal)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Malhari From Gondhal' LIMIT 1), 1),
    'Malhari From Gondhal',
    'Abhijeet Kosambi',
    'https://pagalworldmusic.com/downloads/cover/4578247/4578247.jpg',
    'https://pagalworldmusic.com/download.php?title=Malhari+From+Gondhal-320kbps&path=downloads%2Fhigh%2FPwI6BjZ1GkU%2FPwI6BjZ1GkU.mp3',
    'Download Malhari From Gondhal By Abhijeet Kosambi From Malhari From Gondhal Released By Davakhar Films In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 22: Narali Pophlichya Baga From Kairee (Album: Narali Pophlichya Baga From Kairee)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Narali Pophlichya Baga From Kairee' LIMIT 1), 1),
    'Narali Pophlichya Baga From Kairee',
    'Manohar Golambre',
    'https://pagalworldmusic.com/downloads/cover/4578246/4578246.jpg',
    'https://pagalworldmusic.com/download.php?title=Narali+Pophlichya+Baga+From+Kairee-320kbps&path=downloads%2Fhigh%2FBgIbe0J%2CT0E%2FBgIbe0J%2CT0E.mp3',
    'Download Narali Pophlichya Baga From Kairee By Manohar Golambre From Narali Pophlichya Baga From Kairee Released By Ultra Music In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 23: PROUD (Album: PROUD)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'PROUD' LIMIT 1), 1),
    'PROUD',
    'SAMBATA',
    'https://pagalworldmusic.com/downloads/cover/4578245/4578245.jpg',
    'https://pagalworldmusic.com/download.php?title=PROUD-320kbps&path=downloads%2Fhigh%2FFycdYid1BnE%2FFycdYid1BnE.mp3',
    'Download PROUD By SAMBATA From PROUD Released By Universal Music India Pvt Ltd. In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 24: Ho Aai From Uttar (Album: Ho Aai From Uttar)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Ho Aai From Uttar' LIMIT 1), 1),
    'Ho Aai From Uttar',
    'Radhika Bhide',
    'https://pagalworldmusic.com/downloads/cover/4578152/4578152.jpg',
    'https://pagalworldmusic.com/download.php?title=Ho+Aai+From+Uttar-320kbps&path=downloads%2Fhigh%2FPyAdZCt6VQc%2FPyAdZCt6VQc.mp3',
    'Download Ho Aai From Uttar By Radhika Bhide From Ho Aai From Uttar Released By Zee Music Company In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 25: Dream Wali Girl (Album: Dream Wali Girl)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Dream Wali Girl' LIMIT 1), 1),
    'Dream Wali Girl',
    'Rohit Raut',
    'https://pagalworldmusic.com/downloads/cover/4578012/4578012.jpg',
    'https://pagalworldmusic.com/download.php?title=Dream+Wali+Girl-320kbps&path=downloads%2Fhigh%2FBQcqfRZiZXQ%2FBQcqfRZiZXQ.mp3',
    'Download Dream Wali Girl By Rohit Raut From Dream Wali Girl Released By SNOWBERRY MUSIC In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 26: Lover (Album: Lover)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Lover' LIMIT 1), 1),
    'Lover',
    'Crown J',
    'https://pagalworldmusic.com/downloads/cover/4578011/4578011.jpg',
    'https://pagalworldmusic.com/download.php?title=Lover-320kbps&path=downloads%2Fhigh%2FHCkvcEB0flE%2FHCkvcEB0flE.mp3',
    'Download Lover By Crown J From Lover Released By T-Series In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 27: Chandwa Nabhatla (Album: Chandwa Nabhatla)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Chandwa Nabhatla' LIMIT 1), 1),
    'Chandwa Nabhatla',
    'Abhay Jodhpurkar',
    'https://pagalworldmusic.com/downloads/cover/4578010/4578010.jpg',
    'https://pagalworldmusic.com/download.php?title=Chandwa+Nabhatla-320kbps&path=downloads%2Fhigh%2FJzk4eQZAc1A%2FJzk4eQZAc1A.mp3',
    'Download Chandwa Nabhatla By Abhay Jodhpurkar From Chandwa Nabhatla Released By Chaitali Studios In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 28: 96 (Album: 96)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = '96' LIMIT 1), 1),
    '96',
    'Brahmaa',
    'https://pagalworldmusic.com/downloads/cover/4577910/4577910.jpg',
    'https://pagalworldmusic.com/download.php?title=96-320kbps&path=downloads%2Fhigh%2FFj0vQitdBH8%2FFj0vQitdBH8.mp3',
    'Download 96 By Brahmaa From 96 Released By Vinmayi Music In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 29: Raanjai (Album: Raanjai)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Raanjai' LIMIT 1), 1),
    'Raanjai',
    'Onkarswaroop',
    'https://pagalworldmusic.com/downloads/cover/4577909/4577909.jpg',
    'https://pagalworldmusic.com/download.php?title=Raanjai-320kbps&path=downloads%2Fhigh%2FRCMsfQJye2o%2FRCMsfQJye2o.mp3',
    'Download Raanjai By Onkarswaroop From Raanjai Released By GME Music In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 30: Ishkacha Utara (Album: Ishkacha Utara)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Ishkacha Utara' LIMIT 1), 1),
    'Ishkacha Utara',
    'Keval Walanj',
    'https://pagalworldmusic.com/downloads/cover/4577813/4577813.jpg',
    'https://pagalworldmusic.com/download.php?title=Ishkacha+Utara-320kbps&path=downloads%2Fhigh%2FOxsMf00CTWo%2FOxsMf00CTWo.mp3',
    'Download Ishkacha Utara By Keval Walanj From Ishkacha Utara Released By Koo Koo TV Entertainment Pvt. Ltd. In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 31: Haldi Kunkvala Yayach Ha From Smart Sunbai (Album: Haldi Kunkvala Yayach Ha From Smart Sunbai)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Haldi Kunkvala Yayach Ha From Smart Sunbai' LIMIT 1), 1),
    'Haldi Kunkvala Yayach Ha From Smart Sunbai',
    'Aditi Dravid',
    'https://pagalworldmusic.com/downloads/cover/4577812/4577812.jpg',
    'https://pagalworldmusic.com/download.php?title=Haldi+Kunkvala+Yayach+Ha+From+Smart+Sunbai-320kbps&path=downloads%2Fhigh%2FEhw7ciZ-en4%2FEhw7ciZ-en4.mp3',
    'Download Haldi Kunkvala Yayach Ha From Smart Sunbai By Aditi Dravid From Haldi Kunkvala Yayach Ha From Smart Sunbai Released By Ultra Music In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 32: Tuzyasathi Kaay Pan (Album: Tuzyasathi Kaay Pan)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Tuzyasathi Kaay Pan' LIMIT 1), 1),
    'Tuzyasathi Kaay Pan',
    'Aarya Ambekar',
    'https://pagalworldmusic.com/downloads/cover/4577811/4577811.jpg',
    'https://pagalworldmusic.com/download.php?title=Tuzyasathi+Kaay+Pan-320kbps&path=downloads%2Fhigh%2FAg4fREV1Wn8%2FAg4fREV1Wn8.mp3',
    'Download Tuzyasathi Kaay Pan By Aarya Ambekar From Tuzyasathi Kaay Pan Released By T-Series In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 33: Tiraki Najar (Album: Tiraki Najar)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Tiraki Najar' LIMIT 1), 1),
    'Tiraki Najar',
    'Nitin Gayakwad',
    'https://pagalworldmusic.com/downloads/cover/4577689/4577689.jpg',
    'https://pagalworldmusic.com/download.php?title=Tiraki+Najar-320kbps&path=downloads%2Fhigh%2FSRsCaSJHBVI%2FSRsCaSJHBVI.mp3',
    'Download Tiraki Najar By Nitin Gayakwad From Tiraki Najar Released By GME Music In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 34: Avatarli Tarka (Album: Avatarli Tarka)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Avatarli Tarka' LIMIT 1), 1),
    'Avatarli Tarka',
    'Rohit Raut',
    'https://pagalworldmusic.com/downloads/cover/4577688/4577688.jpg',
    'https://pagalworldmusic.com/download.php?title=Avatarli+Tarka-320kbps&path=downloads%2Fhigh%2FRwsmST4Eflg%2FRwsmST4Eflg.mp3',
    'Download Avatarli Tarka By Rohit Raut From Avatarli Tarka Released By NRITYAASHISH PRODUCTIONS In Marathi Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 35: Pattuma From Love Insurance Kompany (Album: Pattuma From Love Insurance Kompany)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Pattuma From Love Insurance Kompany' LIMIT 1), 1),
    'Pattuma From Love Insurance Kompany',
    'Anirudh Ravichander',
    'https://pagalworldmusic.com/downloads/cover/4578408/4578408.jpg',
    'https://pagalworldmusic.com/download.php?title=Pattuma+From+Love+Insurance+Kompany-320kbps&path=downloads%2Fhigh%2FASQJBB59QQc%2FASQJBB59QQc.mp3',
    'Download Pattuma From Love Insurance Kompany By Anirudh Ravichander From Pattuma From Love Insurance Kompany Released By Sony Music Entertainment India Pvt. Ltd. In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 36: Aalapikkey Ummak From Vaa Vaathiyaar (Album: Aalapikkey Ummak From Vaa Vaathiyaar)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Aalapikkey Ummak From Vaa Vaathiyaar' LIMIT 1), 1),
    'Aalapikkey Ummak From Vaa Vaathiyaar',
    'Kelithee',
    'https://pagalworldmusic.com/downloads/cover/4578407/4578407.jpg',
    'https://pagalworldmusic.com/download.php?title=Aalapikkey+Ummak+From+Vaa+Vaathiyaar-320kbps&path=downloads%2Fhigh%2FPV09Rj1XDwI%2FPV09Rj1XDwI.mp3',
    'Download Aalapikkey Ummak From Vaa Vaathiyaar By Kelithee From Aalapikkey Ummak From Vaa Vaathiyaar Released By Think Music In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 37: Mannichiru From Sirai (Album: Mannichiru From Sirai)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Mannichiru From Sirai' LIMIT 1), 1),
    'Mannichiru From Sirai',
    'Sathyaprakash D',
    'https://pagalworldmusic.com/downloads/cover/4578406/4578406.jpg',
    'https://pagalworldmusic.com/download.php?title=Mannichiru+From+Sirai-320kbps&path=downloads%2Fhigh%2FICA0WhVZAV8%2FICA0WhVZAV8.mp3',
    'Download Mannichiru From Sirai By Sathyaprakash D From Mannichiru From Sirai Released By Seven Screen Studio In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 38: Vasthara From Kombuseevi (Album: Vasthara From Kombuseevi)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Vasthara From Kombuseevi' LIMIT 1), 1),
    'Vasthara From Kombuseevi',
    'Super Subu',
    'https://pagalworldmusic.com/downloads/cover/4578405/4578405.jpg',
    'https://pagalworldmusic.com/download.php?title=Vasthara+From+Kombuseevi-320kbps&path=downloads%2Fhigh%2FNy0%2CQiJiW3s%2FNy0%2CQiJiW3s.mp3',
    'Download Vasthara From Kombuseevi By Super Subu From Vasthara From Kombuseevi Released By SaReGaMA India Ltd In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 39: Manasu Valikithu From Pookie Original Motion Picture Soundtrack (Album: Manasu Valikithu From Pookie Original Motion Picture Soundtrack)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Manasu Valikithu From Pookie Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Manasu Valikithu From Pookie Original Motion Picture Soundtrack',
    'Vijay Antony',
    'https://pagalworldmusic.com/downloads/cover/4578401/4578401.jpg',
    'https://pagalworldmusic.com/download.php?title=Manasu+Valikithu+From+Pookie+Original+Motion+Picture+Soundtrack-320kbps&path=downloads%2Fhigh%2FGAA%2CVh1fWGc%2FGAA%2CVh1fWGc.mp3',
    'Download Manasu Valikithu From Pookie Original Motion Picture Soundtrack By Vijay Antony From Manasu Valikithu From Pookie Original Motion Picture Soundtrack Released By Vijay Antony Pictures In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 40: Noodhana Noodhana From Niram (Album: Noodhana Noodhana From Niram)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Noodhana Noodhana From Niram' LIMIT 1), 1),
    'Noodhana Noodhana From Niram',
    'Pa. Vijay',
    'https://pagalworldmusic.com/downloads/cover/4578400/4578400.jpg',
    'https://pagalworldmusic.com/download.php?title=Noodhana+Noodhana+From+Niram-320kbps&path=downloads%2Fhigh%2FSSEfRBFyenU%2FSSEfRBFyenU.mp3',
    'Download Noodhana Noodhana From Niram By Pa. Vijay From Noodhana Noodhana From Niram Released By Zee Music Company In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 41: Emkoney From Draupathi 2 (Album: Emkoney From Draupathi 2 Tamil)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Emkoney From Draupathi 2 Tamil' LIMIT 1), 1),
    'Emkoney From Draupathi 2',
    'Chinmayi',
    'https://pagalworldmusic.com/downloads/cover/4578399/4578399.jpg',
    'https://pagalworldmusic.com/download.php?title=Emkoney+From+Draupathi+2-320kbps&path=downloads%2Fhigh%2FRjsbUBYHD2I%2FRjsbUBYHD2I.mp3',
    'Download Emkoney From Draupathi 2 By Chinmayi From Emkoney From Draupathi 2 Tamil Released By Lahari Music In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 42: Ratnamala From Parasakthi Tamil (Album: Ratnamala From Parasakthi Tamil)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Ratnamala From Parasakthi Tamil' LIMIT 1), 1),
    'Ratnamala From Parasakthi Tamil',
    'Jayashree Mathimaran',
    'https://pagalworldmusic.com/downloads/cover/4578230/4578230.jpg',
    'https://pagalworldmusic.com/download.php?title=Ratnamala+From+Parasakthi+Tamil-320kbps&path=downloads%2Fhigh%2FRS4%2CUCBkUwc%2FRS4%2CUCBkUwc.mp3',
    'Download Ratnamala From Parasakthi Tamil By Jayashree Mathimaran From Ratnamala From Parasakthi Tamil Released By SaReGaMA India Ltd In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 43: Dashamakan Title Promo Tamil (Album: Dashamakan Title Promo Tamil)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Dashamakan Title Promo Tamil' LIMIT 1), 1),
    'Dashamakan Title Promo Tamil',
    'Britto Michael',
    'https://pagalworldmusic.com/downloads/cover/4578229/4578229.jpg',
    'https://pagalworldmusic.com/download.php?title=Dashamakan+Title+Promo+Tamil-320kbps&path=downloads%2Fhigh%2FAh4aQiRkcF0%2FAh4aQiRkcF0.mp3',
    'Download Dashamakan Title Promo Tamil By Britto Michael From Dashamakan Title Promo Tamil Released By T-Series In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 44: Vetri Veerane From Mask (Album: Vetri Veerane From Mask)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Vetri Veerane From Mask' LIMIT 1), 1),
    'Vetri Veerane From Mask',
    'G.V. Prakash Kumar',
    'https://pagalworldmusic.com/downloads/cover/4578228/4578228.jpg',
    'https://pagalworldmusic.com/download.php?title=Vetri+Veerane+From+Mask-320kbps&path=downloads%2Fhigh%2FRy8MAjhhaHI%2FRy8MAjhhaHI.mp3',
    'Download Vetri Veerane From Mask By G.V. Prakash Kumar From Vetri Veerane From Mask Released By T-Series In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 45: Kandara Kolli From Retta Thala (Album: Kandara Kolli From Retta Thala)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Kandara Kolli From Retta Thala' LIMIT 1), 1),
    'Kandara Kolli From Retta Thala',
    'Sam C.S.',
    'https://pagalworldmusic.com/downloads/cover/4578227/4578227.jpg',
    'https://pagalworldmusic.com/download.php?title=Kandara+Kolli+From+Retta+Thala-320kbps&path=downloads%2Fhigh%2FMyEaXj1Wbl4%2FMyEaXj1Wbl4.mp3',
    'Download Kandara Kolli From Retta Thala By Sam C.S. From Kandara Kolli From Retta Thala Released By T-Series In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 46: Pretty Baby From BIKERTamil (Album: Pretty Baby From BIKERTamil)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Pretty Baby From BIKERTamil' LIMIT 1), 1),
    'Pretty Baby From BIKERTamil',
    'Ghibran',
    'https://pagalworldmusic.com/downloads/cover/4578226/4578226.jpg',
    'https://pagalworldmusic.com/download.php?title=Pretty+Baby+From+BIKERTamil-320kbps&path=downloads%2Fhigh%2FMlwTSwVBT2M%2FMlwTSwVBT2M.mp3',
    'Download Pretty Baby From BIKERTamil By Ghibran From Pretty Baby From BIKERTamil Released By Aditya Music (India) Pvt Ltd In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 47: Rebel Saab From The Rajasaab Tamil (Album: Rebel Saab From The Rajasaab Tamil)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Rebel Saab From The Rajasaab Tamil' LIMIT 1), 1),
    'Rebel Saab From The Rajasaab Tamil',
    'Thaman S',
    'https://pagalworldmusic.com/downloads/cover/4578225/4578225.jpg',
    'https://pagalworldmusic.com/download.php?title=Rebel+Saab+From+The+Rajasaab+Tamil-320kbps&path=downloads%2Fhigh%2FAFksCT5XeWk%2FAFksCT5XeWk.mp3',
    'Download Rebel Saab From The Rajasaab Tamil By Thaman S From Rebel Saab From The Rajasaab Tamil Released By T-Series In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 48: Storm The Moonwalk Theme From Moon Walk (Album: Storm The Moonwalk Theme From Moon Walk)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Storm The Moonwalk Theme From Moon Walk' LIMIT 1), 1),
    'Storm The Moonwalk Theme From Moon Walk',
    'Arivu',
    'https://pagalworldmusic.com/downloads/cover/4578111/4578111.jpg',
    'https://pagalworldmusic.com/download.php?title=Storm+The+Moonwalk+Theme+From+Moon+Walk-320kbps&path=downloads%2Fhigh%2FHTstYiMFfFw%2FHTstYiMFfFw.mp3',
    'Download Storm The Moonwalk Theme From Moon Walk By Arivu From Storm The Moonwalk Theme From Moon Walk Released By Lahari Music In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 49: Esa Kaaththa From My Lord (Album: Esa Kaaththa From My Lord)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Esa Kaaththa From My Lord' LIMIT 1), 1),
    'Esa Kaaththa From My Lord',
    'Yugabharathi',
    'https://pagalworldmusic.com/downloads/cover/4578110/4578110.jpg',
    'https://pagalworldmusic.com/download.php?title=Esa+Kaaththa+From+My+Lord-320kbps&path=downloads%2Fhigh%2FPgIvXAFIUEo%2FPgIvXAFIUEo.mp3',
    'Download Esa Kaaththa From My Lord By Yugabharathi From Esa Kaaththa From My Lord Released By Think Music In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 50: Karmugil Kannazhago From KaanthaTamil (Album: Karmugil Kannazhago From KaanthaTamil)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Karmugil Kannazhago From KaanthaTamil' LIMIT 1), 1),
    'Karmugil Kannazhago From KaanthaTamil',
    'Sivam',
    'https://pagalworldmusic.com/downloads/cover/4578109/4578109.jpg',
    'https://pagalworldmusic.com/download.php?title=Karmugil+Kannazhago+From+KaanthaTamil-320kbps&path=downloads%2Fhigh%2FOzpZfhVCVB4%2FOzpZfhVCVB4.mp3',
    'Download Karmugil Kannazhago From KaanthaTamil By Sivam From Karmugil Kannazhago From KaanthaTamil Released By Aditya Music (India) Pvt Ltd In Tamil Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 51: Bella Bella From Bhartha Mahasayulaku Wignyapthi (Album: Bella Bella From Bhartha Mahasayulaku Wignyapthi)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Bella Bella From Bhartha Mahasayulaku Wignyapthi' LIMIT 1), 1),
    'Bella Bella From Bhartha Mahasayulaku Wignyapthi',
    'Suresh Gangula',
    'https://pagalworldmusic.com/downloads/cover/4578436/4578436.jpg',
    'https://pagalworldmusic.com/download.php?title=Bella+Bella+From+Bhartha+Mahasayulaku+Wignyapthi-320kbps&path=downloads%2Fhigh%2FNiE%2CXC51Q2E%2FNiE%2CXC51Q2E.mp3',
    'Download Bella Bella From Bhartha Mahasayulaku Wignyapthi By Suresh Gangula From Bella Bella From Bhartha Mahasayulaku Wignyapthi Released By SaReGaMA India Ltd In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 52: Bhimavaram Balma From Anaganaga Oka Raju (Album: Bhimavaram Balma From Anaganaga Oka Raju)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Bhimavaram Balma From Anaganaga Oka Raju' LIMIT 1), 1),
    'Bhimavaram Balma From Anaganaga Oka Raju',
    'Naveen Polishetty',
    'https://pagalworldmusic.com/downloads/cover/4578426/4578426.jpg',
    'https://pagalworldmusic.com/download.php?title=Bhimavaram+Balma+From+Anaganaga+Oka+Raju-320kbps&path=downloads%2Fhigh%2FA1xfX0IFemc%2FA1xfX0IFemc.mp3',
    'Download Bhimavaram Balma From Anaganaga Oka Raju By Naveen Polishetty From Bhimavaram Balma From Anaganaga Oka Raju Released By Aditya Music (India) Pvt Ltd In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 53: Ratnamala From Parasakthi Telugu (Album: Ratnamala From Parasakthi Telugu)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Ratnamala From Parasakthi Telugu' LIMIT 1), 1),
    'Ratnamala From Parasakthi Telugu',
    'Ramajogayya Sastry',
    'https://pagalworldmusic.com/downloads/cover/4578425/4578425.jpg',
    NULL,
    'Download Ratnamala From Parasakthi Telugu By Ramajogayya Sastry From Ratnamala From Parasakthi Telugu Released By SaReGaMA India Ltd In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 54: Gira Gira Gingiraagirey From Champion (Album: Gira Gira Gingiraagirey From Chion)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Gira Gira Gingiraagirey From Chion' LIMIT 1), 1),
    'Gira Gira Gingiraagirey From Champion',
    'Mickey J. Meyer',
    'https://pagalworldmusic.com/downloads/cover/4578424/4578424.jpg',
    'https://pagalworldmusic.com/download.php?title=Gira+Gira+Gingiraagirey+From+Champion-320kbps&path=downloads%2Fhigh%2FNgtaBBFVVkI%2FNgtaBBFVVkI.mp3',
    'Download Gira Gira Gingiraagirey From Champion By Mickey J. Meyer From Gira Gira Gingiraagirey From Chion Released By Sony Music Entertainment India Pvt. Ltd. In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 55: Blue Yellow From Psych Siddhartha (Album: Blue Yellow From Psych Siddhartha)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Blue Yellow From Psych Siddhartha' LIMIT 1), 1),
    'Blue Yellow From Psych Siddhartha',
    'Jassie Gift',
    'https://pagalworldmusic.com/downloads/cover/4578423/4578423.jpg',
    'https://pagalworldmusic.com/download.php?title=Blue+Yellow+From+Psych+Siddhartha-320kbps&path=downloads%2Fhigh%2FEQktXE1dW1k%2FEQktXE1dW1k.mp3',
    'Download Blue Yellow From Psych Siddhartha By Jassie Gift From Blue Yellow From Psych Siddhartha Released By T-Series In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 56: Pilla From Dhandoraa (Album: Pilla From Dhandoraa)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Pilla From Dhandoraa' LIMIT 1), 1),
    'Pilla From Dhandoraa',
    'Mark K Robin',
    'https://pagalworldmusic.com/downloads/cover/4578422/4578422.jpg',
    'https://pagalworldmusic.com/download.php?title=Pilla+From+Dhandoraa-320kbps&path=downloads%2Fhigh%2FLzcpWjBgXlE%2FLzcpWjBgXlE.mp3',
    'Download Pilla From Dhandoraa By Mark K Robin From Pilla From Dhandoraa Released By T-Series In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 57: Vanavaasam From Mowgli 2025 (Album: Vanavaasam From Mowgli 2025)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Vanavaasam From Mowgli 2025' LIMIT 1), 1),
    'Vanavaasam From Mowgli 2025',
    'Kaala Bhairava',
    'https://pagalworldmusic.com/downloads/cover/4578421/4578421.jpg',
    'https://pagalworldmusic.com/download.php?title=Vanavaasam+From+Mowgli+2025-320kbps&path=downloads%2Fhigh%2FFSkHBSt3XVY%2FFSkHBSt3XVY.mp3',
    'Download Vanavaasam From Mowgli 2025 By Kaala Bhairava From Vanavaasam From Mowgli 2025 Released By T-Series In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 58: Danger Mama From Revolver Rita Telugu (Album: Danger Mama From Revolver Rita Telugu)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Danger Mama From Revolver Rita Telugu' LIMIT 1), 1),
    'Danger Mama From Revolver Rita Telugu',
    'Geethika Vasanth',
    'https://pagalworldmusic.com/downloads/cover/4578420/4578420.jpg',
    'https://pagalworldmusic.com/download.php?title=Danger+Mama+From+Revolver+Rita+Telugu-320kbps&path=downloads%2Fhigh%2FCFw%2CBBN5eks%2FCFw%2CBBN5eks.mp3',
    'Download Danger Mama From Revolver Rita Telugu By Geethika Vasanth From Danger Mama From Revolver Rita Telugu Released By Think Music In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 59: Emosanal Drama From Patang (Album: Emosanal Drama From Patang)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Emosanal Drama From Patang' LIMIT 1), 1),
    'Emosanal Drama From Patang',
    'Anthony Daasan',
    'https://pagalworldmusic.com/downloads/cover/4578419/4578419.jpg',
    'https://pagalworldmusic.com/download.php?title=Emosanal+Drama+From+Patang-320kbps&path=downloads%2Fhigh%2FRhBZWiJ8TWI%2FRhBZWiJ8TWI.mp3',
    'Download Emosanal Drama From Patang By Anthony Daasan From Emosanal Drama From Patang Released By T-Series In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 60: Chandrullo Kundele From Failure Boys (Album: Chandrullo Kundele From Failure Boys)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Chandrullo Kundele From Failure Boys' LIMIT 1), 1),
    'Chandrullo Kundele From Failure Boys',
    'Karunakar Adigarla',
    'https://pagalworldmusic.com/downloads/cover/4578418/4578418.jpg',
    'https://pagalworldmusic.com/download.php?title=Chandrullo+Kundele+From+Failure+Boys-320kbps&path=downloads%2Fhigh%2FAQsSQQRfA1c%2FAQsSQQRfA1c.mp3',
    'Download Chandrullo Kundele From Failure Boys By Karunakar Adigarla From Chandrullo Kundele From Failure Boys Released By Aditya Music (India) Pvt Ltd In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 61: Rebel Saab From The Rajasaab Telugu (Album: Rebel Saab From The Rajasaab Telugu)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Rebel Saab From The Rajasaab Telugu' LIMIT 1), 1),
    'Rebel Saab From The Rajasaab Telugu',
    'Thaman S',
    'https://pagalworldmusic.com/downloads/cover/4578238/4578238.jpg',
    'https://pagalworldmusic.com/download.php?title=Rebel+Saab+From+The+Rajasaab+Telugu-320kbps&path=downloads%2Fhigh%2FOjkYBxZVU0Q%2FOjkYBxZVU0Q.mp3',
    'Download Rebel Saab From The Rajasaab Telugu By Thaman S From Rebel Saab From The Rajasaab Telugu Released By T-Series In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 62: Choodu Choodu Side A From Godari Gattupaina (Album: Choodu Choodu Side A From Godari Gattupaina)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Choodu Choodu Side A From Godari Gattupaina' LIMIT 1), 1),
    'Choodu Choodu Side A From Godari Gattupaina',
    'Dinesh Kakkerla',
    'https://pagalworldmusic.com/downloads/cover/4578232/4578232.jpg',
    'https://pagalworldmusic.com/download.php?title=Choodu+Choodu+Side+A+From+Godari+Gattupaina-320kbps&path=downloads%2Fhigh%2FORA8VS5UWlA%2FORA8VS5UWlA.mp3',
    'Download Choodu Choodu Side A From Godari Gattupaina By Dinesh Kakkerla From Choodu Choodu Side A From Godari Gattupaina Released By SaReGaMA India Ltd In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 63: Bayilone Ballipalike (Album: Bayilone Ballipalike)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Bayilone Ballipalike' LIMIT 1), 1),
    'Bayilone Ballipalike',
    'Mangli',
    'https://pagalworldmusic.com/downloads/cover/4578231/4578231.jpg',
    'https://pagalworldmusic.com/download.php?title=Bayilone+Ballipalike-320kbps&path=downloads%2Fhigh%2FCFEYAiFWDlY%2FCFEYAiFWDlY.mp3',
    'Download Bayilone Ballipalike By Mangli From Bayilone Ballipalike Released By Mangli In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 64: Jajikaya Jajikaya From Akhanda 2 Thaandavam (Album: Jajikaya Jajikaya From Akhanda 2 Thaandavam)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Jajikaya Jajikaya From Akhanda 2 Thaandavam' LIMIT 1), 1),
    'Jajikaya Jajikaya From Akhanda 2 Thaandavam',
    'Kasarla Shyam',
    'https://pagalworldmusic.com/downloads/cover/4578117/4578117.jpg',
    'https://pagalworldmusic.com/download.php?title=Jajikaya+Jajikaya+From+Akhanda+2+Thaandavam-320kbps&path=downloads%2Fhigh%2FJwBbYRhvWmo%2FJwBbYRhvWmo.mp3',
    'Download Jajikaya Jajikaya From Akhanda 2 Thaandavam By Kasarla Shyam From Jajikaya Jajikaya From Akhanda 2 Thaandavam Released By Aditya Music (India) Pvt Ltd In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 65: Cheliya (Album: Cheliya)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Cheliya' LIMIT 1), 1),
    'Cheliya',
    'Sid Sriram',
    'https://pagalworldmusic.com/downloads/cover/4578116/4578116.jpg',
    'https://pagalworldmusic.com/download.php?title=Cheliya-320kbps&path=downloads%2Fhigh%2FFwIJAxBxeAU%2FFwIJAxBxeAU.mp3',
    'Download Cheliya By Sid Sriram From Cheliya Released By Warner Music India In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Song 66: Rana Kumbha From Varanasi (Album: Rana Kumbha From Varanasi)
INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = 'Rana Kumbha From Varanasi' LIMIT 1), 1),
    'Rana Kumbha From Varanasi',
    'M.M. Keeravaani',
    'https://pagalworldmusic.com/downloads/cover/4578115/4578115.jpg',
    'https://pagalworldmusic.com/download.php?title=Rana+Kumbha+From+Varanasi-320kbps&path=downloads%2Fhigh%2FCSM5ZwVgblg%2FCSM5ZwVgblg.mp3',
    'Download Rana Kumbha From Varanasi By M.M. Keeravaani From Rana Kumbha From Varanasi Released By T-Series In Telugu Mp3 Song Pagalworld Music .com',
    NOW(),
    NOW()
);

-- Total songs: 66

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check albums inserted
SELECT 'Albums Inserted:' as check_label, COUNT(*) as count FROM albums WHERE created_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE);

-- Check songs inserted
SELECT 'Songs Inserted:' as check_label, COUNT(*) as count FROM songs WHERE created_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE);

-- Check song-album relationships
SELECT 
    'Album-Song Mapping:' as check_label,
    a.title,
    COUNT(s.id) as song_count
FROM albums a
LEFT JOIN songs s ON a.id = s.album_id
WHERE a.created_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
GROUP BY a.id, a.title
ORDER BY a.title;

-- Show all audio URLs for verification
SELECT 'Audio URLs Sample:' as check_label, title, SUBSTRING(audio_url, 1, 80) as audio_url
FROM songs
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
LIMIT 5;

COMMIT;
SET FOREIGN_KEY_CHECKS=1;

-- End of script
