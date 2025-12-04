-- Songs INSERT statements
-- Uses COALESCE to link to album_id by title
-- Includes pre-generated stream_url for instant playback

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1),
    'Tere Zikr Mein by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577878/4577878.jpg',
    'https://pagalworldmusic.com/download.php?title=Tere+Zikr+Mein-320kbps&path=downloads%2Fhigh%2FBywNYyFRBXo%2FBywNYyFRBXo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTere%2BZikr%2BMein-320kbps%26path%3Ddownloads%252Fhigh%252FBywNYyFRBXo%252FBywNYyFRBXo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1),
    'Usey Kehna by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577878/4577878.jpg',
    'https://pagalworldmusic.com/download.php?title=Usey+Kehna-320kbps&path=downloads%2Fhigh%2FPzJcdBh1VX0%2FPzJcdBh1VX0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DUsey%2BKehna-320kbps%26path%3Ddownloads%252Fhigh%252FPzJcdBh1VX0%252FPzJcdBh1VX0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1),
    'Jigar Thanda Female by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577878/4577878.jpg',
    'https://pagalworldmusic.com/download.php?title=Jigar+Thanda+Female-320kbps&path=downloads%2Fhigh%2FFz05eQZVVHw%2FFz05eQZVVHw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJigar%2BThanda%2BFemale-320kbps%26path%3Ddownloads%252Fhigh%252FFz05eQZVVHw%252FFz05eQZVVHw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1),
    'Tere Ishk Mein by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577878/4577878.jpg',
    'https://pagalworldmusic.com/download.php?title=Tere+Ishk+Mein-320kbps&path=downloads%2Fhigh%2FRxgcdg0dAEQ%2FRxgcdg0dAEQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTere%2BIshk%2BMein-320kbps%26path%3Ddownloads%252Fhigh%252FRxgcdg0dAEQ%252FRxgcdg0dAEQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1),
    'Deewaana Deewaana by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577878/4577878.jpg',
    'https://pagalworldmusic.com/download.php?title=Deewaana+Deewaana-320kbps&path=downloads%2Fhigh%2FCBwzAidfD2Y%2FCBwzAidfD2Y.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDeewaana%2BDeewaana-320kbps%26path%3Ddownloads%252Fhigh%252FCBwzAidfD2Y%252FCBwzAidfD2Y.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1),
    'Aawaara Angaara by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577878/4577878.jpg',
    'https://pagalworldmusic.com/download.php?title=Aawaara+Angaara-320kbps&path=downloads%2Fhigh%2FIl8KZFldYEk%2FIl8KZFldYEk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAawaara%2BAngaara-320kbps%26path%3Ddownloads%252Fhigh%252FIl8KZFldYEk%252FIl8KZFldYEk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1),
    'Aakhri Salaam Sagar Bhatia Version by Sagar Bhatia |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577878/4577878.jpg',
    'https://pagalworldmusic.com/download.php?title=Aakhri+Salaam+Sagar+Bhatia+Version-320kbps&path=downloads%2Fhigh%2FSTEKXkZ0BFU%2FSTEKXkZ0BFU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAakhri%2BSalaam%2BSagar%2BBhatia%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FSTEKXkZ0BFU%252FSTEKXkZ0BFU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1),
    'Chinnaware by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577878/4577878.jpg',
    'https://pagalworldmusic.com/download.php?title=Chinnaware-320kbps&path=downloads%2Fhigh%2FEl0tCUF2QHk%2FEl0tCUF2QHk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChinnaware-320kbps%26path%3Ddownloads%252Fhigh%252FEl0tCUF2QHk%252FEl0tCUF2QHk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1), 1),
    'Jigar Thanda by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577878/4577878.jpg',
    'https://pagalworldmusic.com/download.php?title=Jigar+Thanda-320kbps&path=downloads%2Fhigh%2FMzwyWC1EZ0M%2FMzwyWC1EZ0M.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJigar%2BThanda-320kbps%26path%3Ddownloads%252Fhigh%252FMzwyWC1EZ0M%252FMzwyWC1EZ0M.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'De De Pyaar De 2 Deluxe Album' LIMIT 1), 1),
    'Ladki Jaisi by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4578106/4578106.jpg',
    'https://pagalworldmusic.com/download.php?title=Ladki+Jaisi-320kbps&path=downloads%2Fhigh%2FHhgeRURUU0Q%2FHhgeRURUU0Q.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLadki%2BJaisi-320kbps%26path%3Ddownloads%252Fhigh%252FHhgeRURUU0Q%252FHhgeRURUU0Q.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'De De Pyaar De 2 Deluxe Album' LIMIT 1), 1),
    '3 Shaukk by Avvy Sra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4578106/4578106.jpg',
    'https://pagalworldmusic.com/download.php?title=3+Shaukk-320kbps&path=downloads%2Fhigh%2FHTozBCsAfwY%2FHTozBCsAfwY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3D3%2BShaukk-320kbps%26path%3Ddownloads%252Fhigh%252FHTozBCsAfwY%252FHTozBCsAfwY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'De De Pyaar De 2 Deluxe Album' LIMIT 1), 1),
    'Raat Bhar by Aditya Rikhari |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4578106/4578106.jpg',
    'https://pagalworldmusic.com/download.php?title=Raat+Bhar-320kbps&path=downloads%2Fhigh%2FQzA0UCcHVFY%2FQzA0UCcHVFY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaat%2BBhar-320kbps%26path%3Ddownloads%252Fhigh%252FQzA0UCcHVFY%252FQzA0UCcHVFY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'De De Pyaar De 2 Deluxe Album' LIMIT 1), 1),
    'Aakhri Salaam by Sagar Bhatia |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4578106/4578106.jpg',
    'https://pagalworldmusic.com/download.php?title=Aakhri+Salaam-320kbps&path=downloads%2Fhigh%2FOB09ABUFWQA%2FOB09ABUFWQA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAakhri%2BSalaam-320kbps%26path%3Ddownloads%252Fhigh%252FOB09ABUFWQA%252FOB09ABUFWQA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'De De Pyaar De 2 Deluxe Album' LIMIT 1), 1),
    'Jhoom Sharaabi by Yo Yo Honey Singh |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4578106/4578106.jpg',
    'https://pagalworldmusic.com/download.php?title=Jhoom+Sharaabi-320kbps&path=downloads%2Fhigh%2FRg4fVz9-B2w%2FRg4fVz9-B2w.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJhoom%2BSharaabi-320kbps%26path%3Ddownloads%252Fhigh%252FRg4fVz9-B2w%252FRg4fVz9-B2w.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'De De Pyaar De 2 Deluxe Album' LIMIT 1), 1),
    'Baabul Ve by Payal Dev |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4578106/4578106.jpg',
    'https://pagalworldmusic.com/download.php?title=Baabul+Ve-320kbps&path=downloads%2Fhigh%2FIAU9YxUGcUs%2FIAU9YxUGcUs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBaabul%2BVe-320kbps%26path%3Ddownloads%252Fhigh%252FIAU9YxUGcUs%252FIAU9YxUGcUs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ek Deewane Ki Deewaniyat' LIMIT 1), 1),
    'Baramulla Title Track by Siddhant Kaushal |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577652/4577652.jpg',
    'https://pagalworldmusic.com/download.php?title=Baramulla+Title+Track-320kbps&path=downloads%2Fhigh%2FBAtTWwRFBkA%2FBAtTWwRFBkA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBaramulla%2BTitle%2BTrack-320kbps%26path%3Ddownloads%252Fhigh%252FBAtTWwRFBkA%252FBAtTWwRFBkA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ek Deewane Ki Deewaniyat' LIMIT 1), 1),
    'Ez Ez by Hanumankind |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577652/4577652.jpg',
    'https://pagalworldmusic.com/download.php?title=Ez+Ez-320kbps&path=downloads%2Fhigh%2FHFxcBAIEZ0A%2FHFxcBAIEZ0A.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DEz%2BEz-320kbps%26path%3Ddownloads%252Fhigh%252FHFxcBAIEZ0A%252FHFxcBAIEZ0A.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ek Deewane Ki Deewaniyat' LIMIT 1), 1),
    'Deewaniyat From Ek Deewane Ki Deewaniyat Original Motion Picture Soundtrack by Kunaal Vermaa |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577652/4577652.jpg',
    'https://pagalworldmusic.com/download.php?title=Deewaniyat+From+Ek+Deewane+Ki+Deewaniyat+Original+Motion+Picture+Soundtrack-320kbps&path=downloads%2Fhigh%2FFBseZBZeTlY%2FFBseZBZeTlY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDeewaniyat%2BFrom%2BEk%2BDeewane%2BKi%2BDeewaniyat%2BOriginal%2BMotion%2BPicture%2BSoundtrack-320kbps%26path%3Ddownloads%252Fhigh%252FFBseZBZeTlY%252FFBseZBZeTlY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1), 1),
    'Hum Bas Tere Hain From Ek Deewane Ki Deewaniyat Reprise by Prince Dubey |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4578100/4578100.jpg',
    'https://pagalworldmusic.com/download.php?title=Hum+Bas+Tere+Hain+From+Ek+Deewane+Ki+Deewaniyat+Reprise-320kbps&path=downloads%2Fhigh%2FPTxYZgVYBWs%2FPTxYZgVYBWs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHum%2BBas%2BTere%2BHain%2BFrom%2BEk%2BDeewane%2BKi%2BDeewaniyat%2BReprise-320kbps%26path%3Ddownloads%252Fhigh%252FPTxYZgVYBWs%252FPTxYZgVYBWs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1), 1),
    'Shararat by Jasmine Sandlas |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4578100/4578100.jpg',
    'https://pagalworldmusic.com/download.php?title=Shararat-320kbps&path=downloads%2Fhigh%2FOzg%2CSDFFe2A%2FOzg%2CSDFFe2A.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DShararat-320kbps%26path%3Ddownloads%252Fhigh%252FOzg%252CSDFFe2A%252FOzg%252CSDFFe2A.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = '120 Bahadur Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Run Down The City Monica by Reble |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4578394/4578394.jpg',
    'https://pagalworldmusic.com/download.php?title=Run+Down+The+City+Monica-320kbps&path=downloads%2Fhigh%2FQww5Zi1DWEA%2FQww5Zi1DWEA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRun%2BDown%2BThe%2BCity%2BMonica-320kbps%26path%3Ddownloads%252Fhigh%252FQww5Zi1DWEA%252FQww5Zi1DWEA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = '120 Bahadur Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Gehra Hua by Irshad Kamil |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4578394/4578394.jpg',
    'https://pagalworldmusic.com/download.php?title=Gehra+Hua-320kbps&path=downloads%2Fhigh%2FQQ8jRRlhBEs%2FQQ8jRRlhBEs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGehra%2BHua-320kbps%26path%3Ddownloads%252Fhigh%252FQQ8jRRlhBEs%252FQQ8jRRlhBEs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = '120 Bahadur Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Neend Ke Shikaare by Siddhant Kaushal |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4578394/4578394.jpg',
    'https://pagalworldmusic.com/download.php?title=Neend+Ke+Shikaare-320kbps&path=downloads%2Fhigh%2FOV8tAjlRb1o%2FOV8tAjlRb1o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNeend%2BKe%2BShikaare-320kbps%26path%3Ddownloads%252Fhigh%252FOV8tAjlRb1o%252FOV8tAjlRb1o.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = '120 Bahadur Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Phir Se Dikhe by Siddhant Kaushal |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4578394/4578394.jpg',
    'https://pagalworldmusic.com/download.php?title=Phir+Se+Dikhe-320kbps&path=downloads%2Fhigh%2FOToaWkZkRnU%2FOToaWkZkRnU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPhir%2BSe%2BDikhe-320kbps%26path%3Ddownloads%252Fhigh%252FOToaWkZkRnU%252FOToaWkZkRnU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = '120 Bahadur Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Yaad Aate Hain by Javed Akhtar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4578394/4578394.jpg',
    'https://pagalworldmusic.com/download.php?title=Yaad+Aate+Hain-320kbps&path=downloads%2Fhigh%2FFyI8QjV6Ukc%2FFyI8QjV6Ukc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYaad%2BAate%2BHain-320kbps%26path%3Ddownloads%252Fhigh%252FFyI8QjV6Ukc%252FFyI8QjV6Ukc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = '120 Bahadur Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Main Hoon Woh Dharti Maa by Javed Akhtar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4578394/4578394.jpg',
    'https://pagalworldmusic.com/download.php?title=Main+Hoon+Woh+Dharti+Maa-320kbps&path=downloads%2Fhigh%2FAToMYkQJQlk%2FAToMYkQJQlk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMain%2BHoon%2BWoh%2BDharti%2BMaa-320kbps%26path%3Ddownloads%252Fhigh%252FAToMYkQJQlk%252FAToMYkQJQlk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1), 1),
    'Naine Ra Lobhi by Javed Akhtar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577760/4577760.jpg',
    'https://pagalworldmusic.com/download.php?title=Naine+Ra+Lobhi-320kbps&path=downloads%2Fhigh%2FGAAOWCtJbwI%2FGAAOWCtJbwI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNaine%2BRa%2BLobhi-320kbps%26path%3Ddownloads%252Fhigh%252FGAAOWCtJbwI%252FGAAOWCtJbwI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1), 1),
    'Dada Kishan Ki Jai by Javed Akhtar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577760/4577760.jpg',
    'https://pagalworldmusic.com/download.php?title=Dada+Kishan+Ki+Jai-320kbps&path=downloads%2Fhigh%2FEQUKXgBiVHY%2FEQUKXgBiVHY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDada%2BKishan%2BKi%2BJai-320kbps%26path%3Ddownloads%252Fhigh%252FEQUKXgBiVHY%252FEQUKXgBiVHY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1), 1),
    'Dhurandhar Title Track by Hanumankind |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577760/4577760.jpg',
    'https://pagalworldmusic.com/download.php?title=Dhurandhar+Title+Track-320kbps&path=downloads%2Fhigh%2FH1o-WDt9eEY%2FH1o-WDt9eEY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDhurandhar%2BTitle%2BTrack-320kbps%26path%3Ddownloads%252Fhigh%252FH1o-WDt9eEY%252FH1o-WDt9eEY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1), 1),
    'Ishq Jalakar Karvaan by Irshad Kamil |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577760/4577760.jpg',
    'https://pagalworldmusic.com/download.php?title=Ishq+Jalakar+Karvaan-320kbps&path=downloads%2Fhigh%2FAiYsBg1IeEU%2FAiYsBg1IeEU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIshq%2BJalakar%2BKarvaan-320kbps%26path%3Ddownloads%252Fhigh%252FAiYsBg1IeEU%252FAiYsBg1IeEU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Baramulla Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Dil Tod Gaya Tu Duet Version by Kaushal Kishore |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577487/4577487.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Tod+Gaya+Tu+Duet+Version-320kbps&path=downloads%2Fhigh%2FFSsAAkJ1T1Y%2FFSsAAkJ1T1Y.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BTod%2BGaya%2BTu%2BDuet%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FFSsAAkJ1T1Y%252FFSsAAkJ1T1Y.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Baramulla Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Kya Paaya by Kaushal Kishore |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577487/4577487.jpg',
    'https://pagalworldmusic.com/download.php?title=Kya+Paaya-320kbps&path=downloads%2Fhigh%2FPyM0cDB%2Cdmo%2FPyM0cDB%2Cdmo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKya%2BPaaya-320kbps%26path%3Ddownloads%252Fhigh%252FPyM0cDB%252Cdmo%252FPyM0cDB%252Cdmo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Baramulla Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Haq Hai Mera by Kaushal Kishore |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577487/4577487.jpg',
    'https://pagalworldmusic.com/download.php?title=Haq+Hai+Mera-320kbps&path=downloads%2Fhigh%2FJAk7eCd2YVU%2FJAk7eCd2YVU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHaq%2BHai%2BMera-320kbps%26path%3Ddownloads%252Fhigh%252FJAk7eCd2YVU%252FJAk7eCd2YVU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Baramulla Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Jhoom Banware by Kaushal Kishore |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577487/4577487.jpg',
    'https://pagalworldmusic.com/download.php?title=Jhoom+Banware-320kbps&path=downloads%2Fhigh%2FQAUJYiBjAWI%2FQAUJYiBjAWI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJhoom%2BBanware-320kbps%26path%3Ddownloads%252Fhigh%252FQAUJYiBjAWI%252FQAUJYiBjAWI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Baramulla Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Dil Tod Gaya Tu by Kaushal Kishore |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577487/4577487.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Tod+Gaya+Tu-320kbps&path=downloads%2Fhigh%2FMjsMRzB7fHU%2FMjsMRzB7fHU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BTod%2BGaya%2BTu-320kbps%26path%3Ddownloads%252Fhigh%252FMjsMRzB7fHU%252FMjsMRzB7fHU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Baramulla Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Qubool by Kaushal Kishore |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577487/4577487.jpg',
    'https://pagalworldmusic.com/download.php?title=Qubool-320kbps&path=downloads%2Fhigh%2FPjcGBydjbVY%2FPjcGBydjbVY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DQubool-320kbps%26path%3Ddownloads%252Fhigh%252FPjcGBydjbVY%252FPjcGBydjbVY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jassi Weds Jassi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Chuu Le by Prashanth R Vihari |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577643/4577643.jpg',
    'https://pagalworldmusic.com/download.php?title=Chuu+Le-320kbps&path=downloads%2Fhigh%2FRCIfYRlUAAU%2FRCIfYRlUAAU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChuu%2BLe-320kbps%26path%3Ddownloads%252Fhigh%252FRCIfYRlUAAU%252FRCIfYRlUAAU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jassi Weds Jassi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Gaa De Zara by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577643/4577643.jpg',
    'https://pagalworldmusic.com/download.php?title=Gaa+De+Zara-320kbps&path=downloads%2Fhigh%2FJDwcZhdJeEo%2FJDwcZhdJeEo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGaa%2BDe%2BZara-320kbps%26path%3Ddownloads%252Fhigh%252FJDwcZhdJeEo%252FJDwcZhdJeEo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jassi Weds Jassi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Chaand Baki Hai Zara Sa by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577643/4577643.jpg',
    'https://pagalworldmusic.com/download.php?title=Chaand+Baki+Hai+Zara+Sa-320kbps&path=downloads%2Fhigh%2FBRxeYBVvcWQ%2FBRxeYBVvcWQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChaand%2BBaki%2BHai%2BZara%2BSa-320kbps%26path%3Ddownloads%252Fhigh%252FBRxeYBVvcWQ%252FBRxeYBVvcWQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jassi Weds Jassi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Dariya by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577643/4577643.jpg',
    'https://pagalworldmusic.com/download.php?title=Dariya-320kbps&path=downloads%2Fhigh%2FIzJdSR1UUHo%2FIzJdSR1UUHo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDariya-320kbps%26path%3Ddownloads%252Fhigh%252FIzJdSR1UUHo%252FIzJdSR1UUHo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jassi Weds Jassi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Baabul Ve by Payal Dev |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577643/4577643.jpg',
    'https://pagalworldmusic.com/download.php?title=Baabul+Ve-320kbps&path=downloads%2Fhigh%2FAzAdWj11Rls%2FAzAdWj11Rls.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBaabul%2BVe-320kbps%26path%3Ddownloads%252Fhigh%252FAzAdWj11Rls%252FAzAdWj11Rls.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jassi Weds Jassi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Kya Ho Raha Hai Ye by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577643/4577643.jpg',
    'https://pagalworldmusic.com/download.php?title=Kya+Ho+Raha+Hai+Ye-320kbps&path=downloads%2Fhigh%2FFCcZaR5aaGc%2FFCcZaR5aaGc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKya%2BHo%2BRaha%2BHai%2BYe-320kbps%26path%3Ddownloads%252Fhigh%252FFCcZaR5aaGc%252FFCcZaR5aaGc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jassi Weds Jassi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Hui Re by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577643/4577643.jpg',
    'https://pagalworldmusic.com/download.php?title=Hui+Re-320kbps&path=downloads%2Fhigh%2FMyQKUyNlf0o%2FMyQKUyNlf0o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHui%2BRe-320kbps%26path%3Ddownloads%252Fhigh%252FMyQKUyNlf0o%252FMyQKUyNlf0o.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Girlfriend Hindi' LIMIT 1), 1),
    '3 Shaukk by Avvy Sra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577658/4577658.jpg',
    'https://pagalworldmusic.com/download.php?title=3+Shaukk-320kbps&path=downloads%2Fhigh%2FHgwRdgYCQlg%2FHgwRdgYCQlg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3D3%2BShaukk-320kbps%26path%3Ddownloads%252Fhigh%252FHgwRdgYCQlg%252FHgwRdgYCQlg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Girlfriend Hindi' LIMIT 1), 1),
    'Bheege Mann by Prashanth R Vihari |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577658/4577658.jpg',
    'https://pagalworldmusic.com/download.php?title=Bheege+Mann-320kbps&path=downloads%2Fhigh%2FQjwNWDF0AEc%2FQjwNWDF0AEc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBheege%2BMann-320kbps%26path%3Ddownloads%252Fhigh%252FQjwNWDF0AEc%252FQjwNWDF0AEc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Girlfriend Hindi' LIMIT 1), 1),
    'Raat Bhar by Aditya Rikhari |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577658/4577658.jpg',
    'https://pagalworldmusic.com/download.php?title=Raat+Bhar-320kbps&path=downloads%2Fhigh%2FCQ1SWh1eAEs%2FCQ1SWh1eAEs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaat%2BBhar-320kbps%26path%3Ddownloads%252Fhigh%252FCQ1SWh1eAEs%252FCQ1SWh1eAEs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Girlfriend Hindi' LIMIT 1), 1),
    'Jhoom Sharaabi by Yo Yo Honey Singh |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577658/4577658.jpg',
    'https://pagalworldmusic.com/download.php?title=Jhoom+Sharaabi-320kbps&path=downloads%2Fhigh%2FNTc7ABBnAms%2FNTc7ABBnAms.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJhoom%2BSharaabi-320kbps%26path%3Ddownloads%252Fhigh%252FNTc7ABBnAms%252FNTc7ABBnAms.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Girlfriend Hindi' LIMIT 1), 1),
    'Ishq Manzoor From Sunny Sanskari Ki Tulsi Kumari by Shreya Ghoshal |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577658/4577658.jpg',
    'https://pagalworldmusic.com/download.php?title=Ishq+Manzoor+From+Sunny+Sanskari+Ki+Tulsi+Kumari-320kbps&path=downloads%2Fhigh%2FPg4mABMJZwI%2FPg4mABMJZwI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIshq%2BManzoor%2BFrom%2BSunny%2BSanskari%2BKi%2BTulsi%2BKumari-320kbps%26path%3Ddownloads%252Fhigh%252FPg4mABMJZwI%252FPg4mABMJZwI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tehran Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Sunny Sunny Boy From Sunny Sanskari Ki Tulsi Kumari by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576598/4576598.jpg',
    'https://pagalworldmusic.com/download.php?title=Sunny+Sunny+Boy+From+Sunny+Sanskari+Ki+Tulsi+Kumari-320kbps&path=downloads%2Fhigh%2FQREOCB9Xe1k%2FQREOCB9Xe1k.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSunny%2BSunny%2BBoy%2BFrom%2BSunny%2BSanskari%2BKi%2BTulsi%2BKumari-320kbps%26path%3Ddownloads%252Fhigh%252FQREOCB9Xe1k%252FQREOCB9Xe1k.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tehran Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Tumse Behtar From Sunny Sanskari Ki Tulsi Kumari by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576598/4576598.jpg',
    'https://pagalworldmusic.com/download.php?title=Tumse+Behtar+From+Sunny+Sanskari+Ki+Tulsi+Kumari-320kbps&path=downloads%2Fhigh%2FNR4ychJ2e0E%2FNR4ychJ2e0E.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTumse%2BBehtar%2BFrom%2BSunny%2BSanskari%2BKi%2BTulsi%2BKumari-320kbps%26path%3Ddownloads%252Fhigh%252FNR4ychJ2e0E%252FNR4ychJ2e0E.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tehran Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Tu Hai Meri From Sunny Sanskari Ki Tulsi Kumari by Sachet-Parampara |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576598/4576598.jpg',
    'https://pagalworldmusic.com/download.php?title=Tu+Hai+Meri+From+Sunny+Sanskari+Ki+Tulsi+Kumari-320kbps&path=downloads%2Fhigh%2FXS8ybhN4cFw%2FXS8ybhN4cFw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTu%2BHai%2BMeri%2BFrom%2BSunny%2BSanskari%2BKi%2BTulsi%2BKumari-320kbps%26path%3Ddownloads%252Fhigh%252FXS8ybhN4cFw%252FXS8ybhN4cFw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tehran Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Aakhri Salaam by Sagar Bhatia |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576598/4576598.jpg',
    'https://pagalworldmusic.com/download.php?title=Aakhri+Salaam-320kbps&path=downloads%2Fhigh%2FQToaSBp6fB4%2FQToaSBp6fB4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAakhri%2BSalaam-320kbps%26path%3Ddownloads%252Fhigh%252FQToaSBp6fB4%252FQToaSBp6fB4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tehran Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Panwadi From Sunny Sanskari Ki Tulsi Kumari by Khesari Lal Yadav |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576598/4576598.jpg',
    'https://pagalworldmusic.com/download.php?title=Panwadi+From+Sunny+Sanskari+Ki+Tulsi+Kumari-320kbps&path=downloads%2Fhigh%2FJRwEYw5vQnY%2FJRwEYw5vQnY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPanwadi%2BFrom%2BSunny%2BSanskari%2BKi%2BTulsi%2BKumari-320kbps%26path%3Ddownloads%252Fhigh%252FJRwEYw5vQnY%252FJRwEYw5vQnY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tehran Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Ichakdana by Akhil Tiwari |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576598/4576598.jpg',
    'https://pagalworldmusic.com/download.php?title=Ichakdana-320kbps&path=downloads%2Fhigh%2FHjIoex50dV0%2FHjIoex50dV0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIchakdana-320kbps%26path%3Ddownloads%252Fhigh%252FHjIoex50dV0%252FHjIoex50dV0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tehran Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Bhai Vakeel Hai by Pardhaan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576598/4576598.jpg',
    'https://pagalworldmusic.com/download.php?title=Bhai+Vakeel+Hai-320kbps&path=downloads%2Fhigh%2FLzg8STVeZgc%2FLzg8STVeZgc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBhai%2BVakeel%2BHai-320kbps%26path%3Ddownloads%252Fhigh%252FLzg8STVeZgc%252FLzg8STVeZgc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thamma' LIMIT 1), 1),
    'Varaha Roopam by Shasiraj Kavoor |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576164/4576164.jpg',
    'https://pagalworldmusic.com/download.php?title=Varaha+Roopam-320kbps&path=downloads%2Fhigh%2FOgAjZyNgAgc%2FOgAjZyNgAgc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DVaraha%2BRoopam-320kbps%26path%3Ddownloads%252Fhigh%252FOgAjZyNgAgc%252FOgAjZyNgAgc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thamma' LIMIT 1), 1),
    'Karma Song by Juno |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576164/4576164.jpg',
    'https://pagalworldmusic.com/download.php?title=Karma+Song-320kbps&path=downloads%2Fhigh%2FEQ8YSyIIQx4%2FEQ8YSyIIQx4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKarma%2BSong-320kbps%26path%3Ddownloads%252Fhigh%252FEQ8YSyIIQx4%252FEQ8YSyIIQx4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thamma' LIMIT 1), 1),
    'Agriculture Song by Arafat Mohamood |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576164/4576164.jpg',
    'https://pagalworldmusic.com/download.php?title=Agriculture+Song-320kbps&path=downloads%2Fhigh%2FRR8qYjpRD0A%2FRR8qYjpRD0A.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAgriculture%2BSong-320kbps%26path%3Ddownloads%252Fhigh%252FRR8qYjpRD0A%252FRR8qYjpRD0A.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thamma' LIMIT 1), 1),
    'Rebel Song From Kantara A Legend Chapter 1 Hindi by Juno |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576164/4576164.jpg',
    'https://pagalworldmusic.com/download.php?title=Rebel+Song+From+Kantara+A+Legend+Chapter+1+Hindi-320kbps&path=downloads%2Fhigh%2FNCoDVxp1fGs%2FNCoDVxp1fGs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRebel%2BSong%2BFrom%2BKantara%2BA%2BLegend%2BChapter%2B1%2BHindi-320kbps%26path%3Ddownloads%252Fhigh%252FNCoDVxp1fGs%252FNCoDVxp1fGs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kantara A Legend Chapter 1 Hindi' LIMIT 1), 1),
    'Mann Mohini by Juno |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576988/4576988.jpg',
    'https://pagalworldmusic.com/download.php?title=Mann+Mohini-320kbps&path=downloads%2Fhigh%2FIitbWTZxemw%2FIitbWTZxemw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMann%2BMohini-320kbps%26path%3Ddownloads%252Fhigh%252FIitbWTZxemw%252FIitbWTZxemw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kantara A Legend Chapter 1 Hindi' LIMIT 1), 1),
    'Bijuria From Sunny Sanskari Ki Tulsi Kumari by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576988/4576988.jpg',
    'https://pagalworldmusic.com/download.php?title=Bijuria+From+Sunny+Sanskari+Ki+Tulsi+Kumari-320kbps&path=downloads%2Fhigh%2FHhg0RSdIeEk%2FHhg0RSdIeEk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBijuria%2BFrom%2BSunny%2BSanskari%2BKi%2BTulsi%2BKumari-320kbps%26path%3Ddownloads%252Fhigh%252FHhg0RSdIeEk%252FHhg0RSdIeEk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kantara A Legend Chapter 1 Hindi' LIMIT 1), 1),
    'Hua Na by Puneet Sharma |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576988/4576988.jpg',
    'https://pagalworldmusic.com/download.php?title=Hua+Na-320kbps&path=downloads%2Fhigh%2FFSU7fi5jfmQ%2FFSU7fi5jfmQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHua%2BNa-320kbps%26path%3Ddownloads%252Fhigh%252FFSU7fi5jfmQ%252FFSU7fi5jfmQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kantara A Legend Chapter 1 Hindi' LIMIT 1), 1),
    'Kantara Chapter 1 Trailer Theme From Kantara A Legend Chapter 1 Hindi by B. Ajaneesh Loknath |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576988/4576988.jpg',
    'https://pagalworldmusic.com/download.php?title=Kantara+Chapter+1+Trailer+Theme+From+Kantara+A+Legend+Chapter+1+Hindi-320kbps&path=downloads%2Fhigh%2FPDcCdxlecWU%2FPDcCdxlecWU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKantara%2BChapter%2B1%2BTrailer%2BTheme%2BFrom%2BKantara%2BA%2BLegend%2BChapter%2B1%2BHindi-320kbps%26path%3Ddownloads%252Fhigh%252FPDcCdxlecWU%252FPDcCdxlecWU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kantara A Legend Chapter 1 Hindi' LIMIT 1), 1),
    'Tera Shabab by REV Shergill |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576988/4576988.jpg',
    'https://pagalworldmusic.com/download.php?title=Tera+Shabab-320kbps&path=downloads%2Fhigh%2FCjoOAhcDYGA%2FCjoOAhcDYGA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTera%2BShabab-320kbps%26path%3Ddownloads%252Fhigh%252FCjoOAhcDYGA%252FCjoOAhcDYGA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kantara A Legend Chapter 1 Hindi' LIMIT 1), 1),
    'Bhool Jawanga by Prashant Beybaar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576988/4576988.jpg',
    'https://pagalworldmusic.com/download.php?title=Bhool+Jawanga-320kbps&path=downloads%2Fhigh%2FMSwKRBdKeUU%2FMSwKRBdKeUU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBhool%2BJawanga-320kbps%26path%3Ddownloads%252Fhigh%252FMSwKRBdKeUU%252FMSwKRBdKeUU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kantara A Legend Chapter 1 Hindi' LIMIT 1), 1),
    'Ishq E Desi by IP Singh |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576988/4576988.jpg',
    'https://pagalworldmusic.com/download.php?title=Ishq+E+Desi-320kbps&path=downloads%2Fhigh%2FCQ4OAwxmBXc%2FCQ4OAwxmBXc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIshq%2BE%2BDesi-320kbps%26path%3Ddownloads%252Fhigh%252FCQ4OAwxmBXc%252FCQ4OAwxmBXc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Rahein Na Rahein Hum From ďż˝Thammaďż˝' LIMIT 1), 1),
    'Glass Uchhi Rakhey by Meggha Bali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577648/4577648.jpg',
    'https://pagalworldmusic.com/download.php?title=Glass+Uchhi+Rakhey-320kbps&path=downloads%2Fhigh%2FRRJSBzJxeQU%2FRRJSBzJxeQU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGlass%2BUchhi%2BRakhey-320kbps%26path%3Ddownloads%252Fhigh%252FRRJSBzJxeQU%252FRRJSBzJxeQU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Rahein Na Rahein Hum From ďż˝Thammaďż˝' LIMIT 1), 1),
    'Make Up by REV Shergill |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577648/4577648.jpg',
    'https://pagalworldmusic.com/download.php?title=Make+Up-320kbps&path=downloads%2Fhigh%2FSAAOSzBjUwQ%2FSAAOSzBjUwQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMake%2BUp-320kbps%26path%3Ddownloads%252Fhigh%252FSAAOSzBjUwQ%252FSAAOSzBjUwQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Rahein Na Rahein Hum From ďż˝Thammaďż˝' LIMIT 1), 1),
    'Chamkeela by REV Shergill |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577648/4577648.jpg',
    'https://pagalworldmusic.com/download.php?title=Chamkeela-320kbps&path=downloads%2Fhigh%2FQiYhZxYEYAU%2FQiYhZxYEYAU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChamkeela-320kbps%26path%3Ddownloads%252Fhigh%252FQiYhZxYEYAU%252FQiYhZxYEYAU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Rahein Na Rahein Hum From ďż˝Thammaďż˝' LIMIT 1), 1),
    'Rahein Na Rahein Hum From “Thamma” by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577648/4577648.jpg',
    'https://pagalworldmusic.com/download.php?title=Rahein+Na+Rahein+Hum+From+%E2%80%9CThamma%E2%80%9D-320kbps&path=downloads%2Fhigh%2FMikMeERnGnc%2FMikMeERnGnc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRahein%2BNa%2BRahein%2BHum%2BFrom%2B%25E2%2580%259CThamma%25E2%2580%259D-320kbps%26path%3Ddownloads%252Fhigh%252FMikMeERnGnc%252FMikMeERnGnc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Rahein Na Rahein Hum From ďż˝Thammaďż˝' LIMIT 1), 1),
    'Tum Mere Na Huye From “Thamma” by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4577648/4577648.jpg',
    'https://pagalworldmusic.com/download.php?title=Tum+Mere+Na+Huye+From+%E2%80%9CThamma%E2%80%9D-320kbps&path=downloads%2Fhigh%2FGQ05ejNyYkc%2FGQ05ejNyYkc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTum%2BMere%2BNa%2BHuye%2BFrom%2B%25E2%2580%259CThamma%25E2%2580%259D-320kbps%26path%3Ddownloads%252Fhigh%252FGQ05ejNyYkc%252FGQ05ejNyYkc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sunny Sanskari Ki Tulsi Kumari' LIMIT 1), 1),
    'Sundari Ke Pyar Mein From Param Sundari by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576848/4576848.jpg',
    'https://pagalworldmusic.com/download.php?title=Sundari+Ke+Pyar+Mein+From+Param+Sundari-320kbps&path=downloads%2Fhigh%2FHjpYYAdSeVU%2FHjpYYAdSeVU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSundari%2BKe%2BPyar%2BMein%2BFrom%2BParam%2BSundari-320kbps%26path%3Ddownloads%252Fhigh%252FHjpYYAdSeVU%252FHjpYYAdSeVU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sunny Sanskari Ki Tulsi Kumari' LIMIT 1), 1),
    'Danger From Param Sundari by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576848/4576848.jpg',
    'https://pagalworldmusic.com/download.php?title=Danger+From+Param+Sundari-320kbps&path=downloads%2Fhigh%2FEgkeVkEIDns%2FEgkeVkEIDns.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDanger%2BFrom%2BParam%2BSundari-320kbps%26path%3Ddownloads%252Fhigh%252FEgkeVkEIDns%252FEgkeVkEIDns.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jolly LLB 3 Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Brahmakalasha From Kantara A Legend Chapter 1 Hindi by Juno |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575827/4575827.jpg',
    'https://pagalworldmusic.com/download.php?title=Brahmakalasha+From+Kantara+A+Legend+Chapter+1+Hindi-320kbps&path=downloads%2Fhigh%2FQFoOciFHfl0%2FQFoOciFHfl0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBrahmakalasha%2BFrom%2BKantara%2BA%2BLegend%2BChapter%2B1%2BHindi-320kbps%26path%3Ddownloads%252Fhigh%252FQFoOciFHfl0%252FQFoOciFHfl0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jolly LLB 3 Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Sunn Mere Yaar Ve From Param Sundari by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575827/4575827.jpg',
    'https://pagalworldmusic.com/download.php?title=Sunn+Mere%C2%A0Yaar%C2%A0Ve+From+Param+Sundari-320kbps&path=downloads%2Fhigh%2FES5fWCV2AQE%2FES5fWCV2AQE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSunn%2BMere%25C2%25A0Yaar%25C2%25A0Ve%2BFrom%2BParam%2BSundari-320kbps%26path%3Ddownloads%252Fhigh%252FES5fWCV2AQE%252FES5fWCV2AQE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jolly LLB 3 Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Chand Kagaz Ka From Param Sundari by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575827/4575827.jpg',
    'https://pagalworldmusic.com/download.php?title=Chand+Kagaz+Ka+From+Param+Sundari-320kbps&path=downloads%2Fhigh%2FICE-RwZ4GgY%2FICE-RwZ4GgY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChand%2BKagaz%2BKa%2BFrom%2BParam%2BSundari-320kbps%26path%3Ddownloads%252Fhigh%252FICE-RwZ4GgY%252FICE-RwZ4GgY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jolly LLB 3 Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Bheegi Saree From Param Sundari by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575827/4575827.jpg',
    'https://pagalworldmusic.com/download.php?title=Bheegi+Saree+From+Param+Sundari-320kbps&path=downloads%2Fhigh%2FGhEOAz5hVn8%2FGhEOAz5hVn8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBheegi%2BSaree%2BFrom%2BParam%2BSundari-320kbps%26path%3Ddownloads%252Fhigh%252FGhEOAz5hVn8%252FGhEOAz5hVn8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jolly LLB 3 Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Poison Baby From “Thamma” by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575827/4575827.jpg',
    'https://pagalworldmusic.com/download.php?title=Poison+Baby+From+%E2%80%9CThamma%E2%80%9D-320kbps&path=downloads%2Fhigh%2FIh9ZXRZYTUM%2FIh9ZXRZYTUM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPoison%2BBaby%2BFrom%2B%25E2%2580%259CThamma%25E2%2580%259D-320kbps%26path%3Ddownloads%252Fhigh%252FIh9ZXRZYTUM%252FIh9ZXRZYTUM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jolly LLB 3 Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Rahein Na Rahein Hum From “Thamma” by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575827/4575827.jpg',
    'https://pagalworldmusic.com/download.php?title=Rahein+Na+Rahein+Hum+From+%E2%80%9CThamma%E2%80%9D-320kbps&path=downloads%2Fhigh%2FHAwhXTd5dGE%2FHAwhXTd5dGE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRahein%2BNa%2BRahein%2BHum%2BFrom%2B%25E2%2580%259CThamma%25E2%2580%259D-320kbps%26path%3Ddownloads%252Fhigh%252FHAwhXTd5dGE%252FHAwhXTd5dGE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Param Sundari' LIMIT 1), 1),
    'Tum Mere Na Huye From “Thamma” by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576992/4576992.jpg',
    'https://pagalworldmusic.com/download.php?title=Tum+Mere+Na+Huye+From+%E2%80%9CThamma%E2%80%9D-320kbps&path=downloads%2Fhigh%2FRlsbBSdbDnU%2FRlsbBSdbDnU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTum%2BMere%2BNa%2BHuye%2BFrom%2B%25E2%2580%259CThamma%25E2%2580%259D-320kbps%26path%3Ddownloads%252Fhigh%252FRlsbBSdbDnU%252FRlsbBSdbDnU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Param Sundari' LIMIT 1), 1),
    'Nachdi by Tejwant Kittu |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576992/4576992.jpg',
    'https://pagalworldmusic.com/download.php?title=Nachdi-320kbps&path=downloads%2Fhigh%2FFxIRdBtec0A%2FFxIRdBtec0A.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNachdi-320kbps%26path%3Ddownloads%252Fhigh%252FFxIRdBtec0A%252FFxIRdBtec0A.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Param Sundari' LIMIT 1), 1),
    'Rabba Sanu by Sunny Vik |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4576992/4576992.jpg',
    'https://pagalworldmusic.com/download.php?title=Rabba+Sanu-320kbps&path=downloads%2Fhigh%2FHgkCfEJCWGw%2FHgkCfEJCWGw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRabba%2BSanu-320kbps%26path%3Ddownloads%252Fhigh%252FHgkCfEJCWGw%252FHgkCfEJCWGw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Son Of Sardaar 2' LIMIT 1), 1),
    'Kali Ainak by Lijo George-Dj Chetas |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575819/4575819.jpg',
    'https://pagalworldmusic.com/download.php?title=Kali+Ainak-320kbps&path=downloads%2Fhigh%2FMhwSZytJc3c%2FMhwSZytJc3c.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKali%2BAinak-320kbps%26path%3Ddownloads%252Fhigh%252FMhwSZytJc3c%252FMhwSZytJc3c.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Son Of Sardaar 2' LIMIT 1), 1),
    'PERFECT From Sunny Sanskari Ki Tulsi Kumari by Guru Randhawa |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575819/4575819.jpg',
    'https://pagalworldmusic.com/download.php?title=PERFECT+From+Sunny+Sanskari+Ki+Tulsi+Kumari-320kbps&path=downloads%2Fhigh%2FKj4bAhdDZ3Y%2FKj4bAhdDZ3Y.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPERFECT%2BFrom%2BSunny%2BSanskari%2BKi%2BTulsi%2BKumari-320kbps%26path%3Ddownloads%252Fhigh%252FKj4bAhdDZ3Y%252FKj4bAhdDZ3Y.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Son Of Sardaar 2' LIMIT 1), 1),
    'Pehla Tu Duja Tu by Jaani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575819/4575819.jpg',
    'https://pagalworldmusic.com/download.php?title=Pehla+Tu+Duja+Tu-320kbps&path=downloads%2Fhigh%2FPgA8cEQFf0U%2FPgA8cEQFf0U.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPehla%2BTu%2BDuja%2BTu-320kbps%26path%3Ddownloads%252Fhigh%252FPgA8cEQFf0U%252FPgA8cEQFf0U.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Son Of Sardaar 2' LIMIT 1), 1),
    'Nazar Battu by Harsh Upadhyay |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575819/4575819.jpg',
    'https://pagalworldmusic.com/download.php?title=Nazar+Battu-320kbps&path=downloads%2Fhigh%2FFxk7aCwdc1I%2FFxk7aCwdc1I.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNazar%2BBattu-320kbps%26path%3Ddownloads%252Fhigh%252FFxk7aCwdc1I%252FFxk7aCwdc1I.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Son Of Sardaar 2' LIMIT 1), 1),
    'Son Of Sardaar 2 Title Track by Harsh Upadhyay |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575819/4575819.jpg',
    'https://pagalworldmusic.com/download.php?title=Son+Of+Sardaar+2+Title+Track-320kbps&path=downloads%2Fhigh%2FBwUFCR4dZmI%2FBwUFCR4dZmI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSon%2BOf%2BSardaar%2B2%2BTitle%2BTrack-320kbps%26path%3Ddownloads%252Fhigh%252FBwUFCR4dZmI%252FBwUFCR4dZmI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Son Of Sardaar 2' LIMIT 1), 1),
    'The Po Po Song by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575819/4575819.jpg',
    'https://pagalworldmusic.com/download.php?title=The+Po+Po+Song-320kbps&path=downloads%2Fhigh%2FJQADUhBkAGk%2FJQADUhBkAGk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThe%2BPo%2BPo%2BSong-320kbps%26path%3Ddownloads%252Fhigh%252FJQADUhBkAGk%252FJQADUhBkAGk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Son Of Sardaar 2' LIMIT 1), 1),
    'Yeh Ishq Hai Papon Version by Shweta Bothra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575819/4575819.jpg',
    'https://pagalworldmusic.com/download.php?title=Yeh+Ishq+Hai+Papon+Version-320kbps&path=downloads%2Fhigh%2FKlwge0ZRQWs%2FKlwge0ZRQWs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYeh%2BIshq%2BHai%2BPapon%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FKlwge0ZRQWs%252FKlwge0ZRQWs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ufff Yeh Siyapaa' LIMIT 1), 1),
    'Pardesiya From Param Sundari by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575765/4575765.jpg',
    'https://pagalworldmusic.com/download.php?title=Pardesiya+From+Param+Sundari-320kbps&path=downloads%2Fhigh%2FPzseVwxGAXo%2FPzseVwxGAXo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPardesiya%2BFrom%2BParam%2BSundari-320kbps%26path%3Ddownloads%252Fhigh%252FPzseVwxGAXo%252FPzseVwxGAXo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ufff Yeh Siyapaa' LIMIT 1), 1),
    'Kuch Toh Hai Male Version by Shweta Bothra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575765/4575765.jpg',
    'https://pagalworldmusic.com/download.php?title=Kuch+Toh+Hai+Male+Version-320kbps&path=downloads%2Fhigh%2FCF0NBz9KUH4%2FCF0NBz9KUH4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKuch%2BToh%2BHai%2BMale%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FCF0NBz9KUH4%252FCF0NBz9KUH4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ufff Yeh Siyapaa' LIMIT 1), 1),
    'Kaun Hai Woh Female Version by Shweta Bothra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575765/4575765.jpg',
    'https://pagalworldmusic.com/download.php?title=Kaun+Hai+Woh+Female+Version-320kbps&path=downloads%2Fhigh%2FRCAGeBtXZ0c%2FRCAGeBtXZ0c.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKaun%2BHai%2BWoh%2BFemale%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FRCAGeBtXZ0c%252FRCAGeBtXZ0c.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ufff Yeh Siyapaa' LIMIT 1), 1),
    'Kaun Hai Woh Male Version by Shweta Bothra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575765/4575765.jpg',
    'https://pagalworldmusic.com/download.php?title=Kaun+Hai+Woh+Male+Version-320kbps&path=downloads%2Fhigh%2FFwZSfh91b3k%2FFwZSfh91b3k.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKaun%2BHai%2BWoh%2BMale%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FFwZSfh91b3k%252FFwZSfh91b3k.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ufff Yeh Siyapaa' LIMIT 1), 1),
    'Bhoolane Ki Tumko Female Version by Shweta Bothra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575765/4575765.jpg',
    'https://pagalworldmusic.com/download.php?title=Bhoolane+Ki+Tumko+Female+Version-320kbps&path=downloads%2Fhigh%2FPQoufRFlWFI%2FPQoufRFlWFI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBhoolane%2BKi%2BTumko%2BFemale%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FPQoufRFlWFI%252FPQoufRFlWFI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ufff Yeh Siyapaa' LIMIT 1), 1),
    'Tu Meri Poori Kahani Rock Version by Shweta Bothra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575765/4575765.jpg',
    'https://pagalworldmusic.com/download.php?title=Tu+Meri+Poori+Kahani+Rock+Version-320kbps&path=downloads%2Fhigh%2FIFstZhp5UF0%2FIFstZhp5UF0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTu%2BMeri%2BPoori%2BKahani%2BRock%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FIFstZhp5UF0%252FIFstZhp5UF0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ufff Yeh Siyapaa' LIMIT 1), 1),
    'Ab Jab Ki Tu Nahi Hai Female Version by Shweta Bothra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575765/4575765.jpg',
    'https://pagalworldmusic.com/download.php?title=Ab+Jab+Ki+Tu+Nahi+Hai+Female+Version-320kbps&path=downloads%2Fhigh%2FIAsRWyNhQV8%2FIAsRWyNhQV8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAb%2BJab%2BKi%2BTu%2BNahi%2BHai%2BFemale%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FIAsRWyNhQV8%252FIAsRWyNhQV8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ufff Yeh Siyapaa' LIMIT 1), 1),
    'Ab Jab Ki Tu Nahi Hai Male Version by Shweta Bothra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575765/4575765.jpg',
    'https://pagalworldmusic.com/download.php?title=Ab+Jab+Ki+Tu+Nahi+Hai+Male+Version-320kbps&path=downloads%2Fhigh%2FGVhZR0NGGnA%2FGVhZR0NGGnA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAb%2BJab%2BKi%2BTu%2BNahi%2BHai%2BMale%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FGVhZR0NGGnA%252FGVhZR0NGGnA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ufff Yeh Siyapaa' LIMIT 1), 1),
    'Kuch Toh Hai Female Version by Shweta Bothra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575765/4575765.jpg',
    'https://pagalworldmusic.com/download.php?title=Kuch+Toh+Hai+Female+Version-320kbps&path=downloads%2Fhigh%2FOgQfXTp7X1g%2FOgQfXTp7X1g.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKuch%2BToh%2BHai%2BFemale%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FOgQfXTp7X1g%252FOgQfXTp7X1g.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ufff Yeh Siyapaa' LIMIT 1), 1),
    'Tera Khayal by Siddhaant Miishhraa |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575765/4575765.jpg',
    'https://pagalworldmusic.com/download.php?title=Tera+Khayal-320kbps&path=downloads%2Fhigh%2FRgcScjNkUkE%2FRgcScjNkUkE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTera%2BKhayal-320kbps%26path%3Ddownloads%252Fhigh%252FRgcScjNkUkE%252FRgcScjNkUkE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ufff Yeh Siyapaa' LIMIT 1), 1),
    'Tu Meri Poori Kahani Male Version by Shweta Bothra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575765/4575765.jpg',
    'https://pagalworldmusic.com/download.php?title=Tu+Meri+Poori+Kahani+Male+Version-320kbps&path=downloads%2Fhigh%2FMw8sAh5UQAM%2FMw8sAh5UQAM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTu%2BMeri%2BPoori%2BKahani%2BMale%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FMw8sAh5UQAM%252FMw8sAh5UQAM.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ufff Yeh Siyapaa' LIMIT 1), 1),
    'Yeh Ishq Hai Raghav Chaitanya Version by Shweta Bothra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575765/4575765.jpg',
    'https://pagalworldmusic.com/download.php?title=Yeh+Ishq+Hai+Raghav+Chaitanya+Version-320kbps&path=downloads%2Fhigh%2FEwVZaRZpXwc%2FEwVZaRZpXwc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYeh%2BIshq%2BHai%2BRaghav%2BChaitanya%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FEwVZaRZpXwc%252FEwVZaRZpXwc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ufff Yeh Siyapaa' LIMIT 1), 1),
    'Rona Sikha Diya by Gourov Dasgupta |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575765/4575765.jpg',
    'https://pagalworldmusic.com/download.php?title=Rona+Sikha+Diya-320kbps&path=downloads%2Fhigh%2FMwYMWydTDgQ%2FMwYMWydTDgQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRona%2BSikha%2BDiya-320kbps%26path%3Ddownloads%252Fhigh%252FMwYMWydTDgQ%252FMwYMWydTDgQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nishaanchi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Maar Maar by Suyyash Rai |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575662/4575662.jpg',
    'https://pagalworldmusic.com/download.php?title=Maar+Maar-320kbps&path=downloads%2Fhigh%2FHS0ZW0QGWwI%2FHS0ZW0QGWwI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMaar%2BMaar-320kbps%26path%3Ddownloads%252Fhigh%252FHS0ZW0QGWwI%252FHS0ZW0QGWwI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nishaanchi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Marjaana by Siddhaant Miishhraa |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575662/4575662.jpg',
    'https://pagalworldmusic.com/download.php?title=Marjaana-320kbps&path=downloads%2Fhigh%2FPz4vWCdXbwo%2FPz4vWCdXbwo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMarjaana-320kbps%26path%3Ddownloads%252Fhigh%252FPz4vWCdXbwo%252FPz4vWCdXbwo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nishaanchi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Get Ready To Fight Khauf Hai by Suyyash Rai |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575662/4575662.jpg',
    'https://pagalworldmusic.com/download.php?title=Get+Ready+To+Fight+Khauf+Hai-320kbps&path=downloads%2Fhigh%2FNwIYZDZ3AVE%2FNwIYZDZ3AVE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGet%2BReady%2BTo%2BFight%2BKhauf%2BHai-320kbps%26path%3Ddownloads%252Fhigh%252FNwIYZDZ3AVE%252FNwIYZDZ3AVE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nishaanchi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Bhoolane Ki Tumko Male Version by Shweta Bothra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575662/4575662.jpg',
    'https://pagalworldmusic.com/download.php?title=Bhoolane+Ki+Tumko+Male+Version-320kbps&path=downloads%2Fhigh%2FGl5fZhxcQ1c%2FGl5fZhxcQ1c.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBhoolane%2BKi%2BTumko%2BMale%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FGl5fZhxcQ1c%252FGl5fZhxcQ1c.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nishaanchi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Bahli Sohni by Badshah |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575662/4575662.jpg',
    'https://pagalworldmusic.com/download.php?title=Bahli+Sohni-320kbps&path=downloads%2Fhigh%2FBjIYQRliZEk%2FBjIYQRliZEk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBahli%2BSohni-320kbps%26path%3Ddownloads%252Fhigh%252FBjIYQRliZEk%252FBjIYQRliZEk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nishaanchi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Tu Meri Poori Kahani Female Version by Shweta Bothra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575662/4575662.jpg',
    'https://pagalworldmusic.com/download.php?title=Tu+Meri+Poori+Kahani+Female+Version-320kbps&path=downloads%2Fhigh%2FFyUyUjFAB3E%2FFyUyUjFAB3E.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTu%2BMeri%2BPoori%2BKahani%2BFemale%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FFyUyUjFAB3E%252FFyUyUjFAB3E.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nishaanchi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Darr Ke Aage Dance From Ufff Yeh Siyapaa / Female Version by A. R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575662/4575662.jpg',
    'https://pagalworldmusic.com/download.php?title=Darr+Ke+Aage+Dance+From+Ufff+Yeh+Siyapaa+%2F+Female+Version-320kbps&path=downloads%2Fhigh%2FPRApRgVjcwQ%2FPRApRgVjcwQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDarr%2BKe%2BAage%2BDance%2BFrom%2BUfff%2BYeh%2BSiyapaa%2B%252F%2BFemale%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FPRApRgVjcwQ%252FPRApRgVjcwQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nishaanchi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Tamancha From Ufff Yeh Siyapaa by A. R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575662/4575662.jpg',
    'https://pagalworldmusic.com/download.php?title=Tamancha+From+Ufff+Yeh+Siyapaa-320kbps&path=downloads%2Fhigh%2FEyUqXQJiBVA%2FEyUqXQJiBVA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTamancha%2BFrom%2BUfff%2BYeh%2BSiyapaa-320kbps%26path%3Ddownloads%252Fhigh%252FEyUqXQJiBVA%252FEyUqXQJiBVA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nishaanchi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Naazuka From Ufff Yeh Siyapaa by A. R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575662/4575662.jpg',
    'https://pagalworldmusic.com/download.php?title=Naazuka+From+Ufff+Yeh+Siyapaa-320kbps&path=downloads%2Fhigh%2FRSIPXxsJAwc%2FRSIPXxsJAwc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNaazuka%2BFrom%2BUfff%2BYeh%2BSiyapaa-320kbps%26path%3Ddownloads%252Fhigh%252FRSIPXxsJAwc%252FRSIPXxsJAwc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Baaghi 4' LIMIT 1), 1),
    'Guzaara by Josh Brar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575818/4575818.jpg',
    'https://pagalworldmusic.com/download.php?title=Guzaara-320kbps&path=downloads%2Fhigh%2FRyFGfjZ8YwE%2FRyFGfjZ8YwE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGuzaara-320kbps%26path%3Ddownloads%252Fhigh%252FRyFGfjZ8YwE%252FRyFGfjZ8YwE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Baaghi 4' LIMIT 1), 1),
    'Dil Parinda From Ufff Yeh Siyapaa by A. R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575818/4575818.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Parinda+From+Ufff+Yeh+Siyapaa-320kbps&path=downloads%2Fhigh%2FSQQjegVifUE%2FSQQjegVifUE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BParinda%2BFrom%2BUfff%2BYeh%2BSiyapaa-320kbps%26path%3Ddownloads%252Fhigh%252FSQQjegVifUE%252FSQQjegVifUE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Baaghi 4' LIMIT 1), 1),
    'Trailer Theme by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575818/4575818.jpg',
    'https://pagalworldmusic.com/download.php?title=Trailer+Theme-320kbps&path=downloads%2Fhigh%2FPFgHVRZiQkk%2FPFgHVRZiQkk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTrailer%2BTheme-320kbps%26path%3Ddownloads%252Fhigh%252FPFgHVRZiQkk%252FPFgHVRZiQkk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Baaghi 4' LIMIT 1), 1),
    'Yeh Mera Husn by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575818/4575818.jpg',
    'https://pagalworldmusic.com/download.php?title=Yeh+Mera+Husn-320kbps&path=downloads%2Fhigh%2FAAYffAFEeGw%2FAAYffAFEeGw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYeh%2BMera%2BHusn-320kbps%26path%3Ddownloads%252Fhigh%252FAAYffAFEeGw%252FAAYffAFEeGw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Baaghi 4' LIMIT 1), 1),
    'Teri Judaai by Ritesh G Rao |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575818/4575818.jpg',
    'https://pagalworldmusic.com/download.php?title=Teri+Judaai-320kbps&path=downloads%2Fhigh%2FJDtYeBBUVEY%2FJDtYeBBUVEY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTeri%2BJudaai-320kbps%26path%3Ddownloads%252Fhigh%252FJDtYeBBUVEY%252FJDtYeBBUVEY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dil Madharaasi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Madharaasi Flow by Kwame Fyah |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575473/4575473.jpg',
    'https://pagalworldmusic.com/download.php?title=Madharaasi+Flow-320kbps&path=downloads%2Fhigh%2FPARYSEBVR0I%2FPARYSEBVR0I.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMadharaasi%2BFlow-320kbps%26path%3Ddownloads%252Fhigh%252FPARYSEBVR0I%252FPARYSEBVR0I.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dil Madharaasi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Animal Instinct by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575473/4575473.jpg',
    'https://pagalworldmusic.com/download.php?title=Animal+Instinct-320kbps&path=downloads%2Fhigh%2FHAcNYzZKGno%2FHAcNYzZKGno.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAnimal%2BInstinct-320kbps%26path%3Ddownloads%252Fhigh%252FHAcNYzZKGno%252FHAcNYzZKGno.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dil Madharaasi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Naina Tere by Ritesh G Rao |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575473/4575473.jpg',
    'https://pagalworldmusic.com/download.php?title=Naina+Tere-320kbps&path=downloads%2Fhigh%2FJQY-ST1WXmw%2FJQY-ST1WXmw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNaina%2BTere-320kbps%26path%3Ddownloads%252Fhigh%252FJQY-ST1WXmw%252FJQY-ST1WXmw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dil Madharaasi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Akeli Laila by Payal Dev |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575473/4575473.jpg',
    'https://pagalworldmusic.com/download.php?title=Akeli+Laila-320kbps&path=downloads%2Fhigh%2FQx0bVRdARWo%2FQx0bVRdARWo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAkeli%2BLaila-320kbps%26path%3Ddownloads%252Fhigh%252FQx0bVRdARWo%252FQx0bVRdARWo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dil Madharaasi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Happy Street by Ritesh G Rao |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575473/4575473.jpg',
    'https://pagalworldmusic.com/download.php?title=Happy+Street-320kbps&path=downloads%2Fhigh%2FPThdYAYHW1A%2FPThdYAYHW1A.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHappy%2BStreet-320kbps%26path%3Ddownloads%252Fhigh%252FPThdYAYHW1A%252FPThdYAYHW1A.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dil Madharaasi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Kaise Karu by Ritesh G Rao |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575473/4575473.jpg',
    'https://pagalworldmusic.com/download.php?title=Kaise+Karu-320kbps&path=downloads%2Fhigh%2FNyYgeiF4Unw%2FNyYgeiF4Unw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKaise%2BKaru-320kbps%26path%3Ddownloads%252Fhigh%252FNyYgeiF4Unw%252FNyYgeiF4Unw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dil Madharaasi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Darr Ke Aage Dance From Ufff Yeh Siyapaa by A. R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575473/4575473.jpg',
    'https://pagalworldmusic.com/download.php?title=Darr+Ke+Aage+Dance+From+Ufff+Yeh+Siyapaa-320kbps&path=downloads%2Fhigh%2FOAAEVxNmbns%2FOAAEVxNmbns.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDarr%2BKe%2BAage%2BDance%2BFrom%2BUfff%2BYeh%2BSiyapaa-320kbps%26path%3Ddownloads%252Fhigh%252FOAAEVxNmbns%252FOAAEVxNmbns.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dil Madharaasi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Madharaasi Theme by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575473/4575473.jpg',
    'https://pagalworldmusic.com/download.php?title=Madharaasi+Theme-320kbps&path=downloads%2Fhigh%2FXVojQ0VSe1I%2FXVojQ0VSe1I.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMadharaasi%2BTheme-320kbps%26path%3Ddownloads%252Fhigh%252FXVojQ0VSe1I%252FXVojQ0VSe1I.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dil Madharaasi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Tadapaa by Ritesh G Rao |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575473/4575473.jpg',
    'https://pagalworldmusic.com/download.php?title=Tadapaa-320kbps&path=downloads%2Fhigh%2FJFkOZEVBXFg%2FJFkOZEVBXFg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTadapaa-320kbps%26path%3Ddownloads%252Fhigh%252FJFkOZEVBXFg%252FJFkOZEVBXFg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mannu Kya Karegga Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Chhaya Hai Andhiyara by Alok Ranjan Jha |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575372/4575372.jpg',
    'https://pagalworldmusic.com/download.php?title=Chhaya+Hai+Andhiyara-320kbps&path=downloads%2Fhigh%2FJDshASQBBlU%2FJDshASQBBlU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChhaya%2BHai%2BAndhiyara-320kbps%26path%3Ddownloads%252Fhigh%252FJDshASQBBlU%252FJDshASQBBlU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mannu Kya Karegga Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Na Kar Sasse by Gurmeet Singh |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575372/4575372.jpg',
    'https://pagalworldmusic.com/download.php?title=Na+Kar+Sasse-320kbps&path=downloads%2Fhigh%2FITIjBA5EUHQ%2FITIjBA5EUHQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNa%2BKar%2BSasse-320kbps%26path%3Ddownloads%252Fhigh%252FITIjBA5EUHQ%252FITIjBA5EUHQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mannu Kya Karegga Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Fanaa Hua by Sharad Mehra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575372/4575372.jpg',
    'https://pagalworldmusic.com/download.php?title=Fanaa+Hua-320kbps&path=downloads%2Fhigh%2FKlgxYxAdX0Q%2FKlgxYxAdX0Q.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DFanaa%2BHua-320kbps%26path%3Ddownloads%252Fhigh%252FKlgxYxAdX0Q%252FKlgxYxAdX0Q.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mannu Kya Karegga Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Mannu Tera Kya Hoga by Kumaar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575372/4575372.jpg',
    'https://pagalworldmusic.com/download.php?title=Mannu+Tera+Kya+Hoga-320kbps&path=downloads%2Fhigh%2FEywveDxaYVQ%2FEywveDxaYVQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMannu%2BTera%2BKya%2BHoga-320kbps%26path%3Ddownloads%252Fhigh%252FEywveDxaYVQ%252FEywveDxaYVQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mannu Kya Karegga Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Gulfam by Javed Akhtar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575372/4575372.jpg',
    'https://pagalworldmusic.com/download.php?title=Gulfam-320kbps&path=downloads%2Fhigh%2FCDI6SUZmfmk%2FCDI6SUZmfmk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGulfam-320kbps%26path%3Ddownloads%252Fhigh%252FCDI6SUZmfmk%252FCDI6SUZmfmk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mannu Kya Karegga Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Halki Halki Barish by Javed Akhtar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575372/4575372.jpg',
    'https://pagalworldmusic.com/download.php?title=Halki+Halki+Barish-320kbps&path=downloads%2Fhigh%2FFz0ceUJIcwE%2FFz0ceUJIcwE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHalki%2BHalki%2BBarish-320kbps%26path%3Ddownloads%252Fhigh%252FFz0ceUJIcwE%252FFz0ceUJIcwE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mannu Kya Karegga Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Shubhkamnayein by Sunny Inder |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575372/4575372.jpg',
    'https://pagalworldmusic.com/download.php?title=Shubhkamnayein-320kbps&path=downloads%2Fhigh%2FFTo-XhkBbWY%2FFTo-XhkBbWY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DShubhkamnayein-320kbps%26path%3Ddownloads%252Fhigh%252FFTo-XhkBbWY%252FFTo-XhkBbWY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mannu Kya Karegga Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Humnava by Jatin-Lalit |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575372/4575372.jpg',
    'https://pagalworldmusic.com/download.php?title=Humnava-320kbps&path=downloads%2Fhigh%2FPUUNARMDe2U%2FPUUNARMDe2U.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHumnava-320kbps%26path%3Ddownloads%252Fhigh%252FPUUNARMDe2U%252FPUUNARMDe2U.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mannu Kya Karegga Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Teri Yaadein by Sharad Mehra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575372/4575372.jpg',
    'https://pagalworldmusic.com/download.php?title=Teri+Yaadein-320kbps&path=downloads%2Fhigh%2FNgpTQhhRBWU%2FNgpTQhhRBWU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTeri%2BYaadein-320kbps%26path%3Ddownloads%252Fhigh%252FNgpTQhhRBWU%252FNgpTQhhRBWU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maa' LIMIT 1), 1),
    'Humnava by Shreya Ghoshal |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575276/4575276.jpg',
    'https://pagalworldmusic.com/download.php?title=Humnava-320kbps&path=downloads%2Fhigh%2FJlFfCCRxUWY%2FJlFfCCRxUWY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHumnava-320kbps%26path%3Ddownloads%252Fhigh%252FJlFfCCRxUWY%252FJlFfCCRxUWY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maa' LIMIT 1), 1),
    'Kali Shakti by Usha Uthup |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575276/4575276.jpg',
    'https://pagalworldmusic.com/download.php?title=Kali+Shakti-320kbps&path=downloads%2Fhigh%2FKj1TQBcdaFg%2FKj1TQBcdaFg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKali%2BShakti-320kbps%26path%3Ddownloads%252Fhigh%252FKj1TQBcdaFg%252FKj1TQBcdaFg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maa' LIMIT 1), 1),
    'Tripping High by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575276/4575276.jpg',
    'https://pagalworldmusic.com/download.php?title=Tripping+High-320kbps&path=downloads%2Fhigh%2FHwYsBg0EdXE%2FHwYsBg0EdXE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTripping%2BHigh-320kbps%26path%3Ddownloads%252Fhigh%252FHwYsBg0EdXE%252FHwYsBg0EdXE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Danger From Param Sundari' LIMIT 1), 1),
    'War Theme 2.0 by Sanchit Balhara |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575115/4575115.jpg',
    'https://pagalworldmusic.com/download.php?title=War+Theme+2.0-320kbps&path=downloads%2Fhigh%2FPAEYWEF%2CTgc%2FPAEYWEF%2CTgc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DWar%2BTheme%2B2.0-320kbps%26path%3Ddownloads%252Fhigh%252FPAEYWEF%252CTgc%252FPAEYWEF%252CTgc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Danger From Param Sundari' LIMIT 1), 1),
    'Saiyaan by Lalit Pandit |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575115/4575115.jpg',
    'https://pagalworldmusic.com/download.php?title=Saiyaan-320kbps&path=downloads%2Fhigh%2FQjkkWB1nYUI%2FQjkkWB1nYUI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSaiyaan-320kbps%26path%3Ddownloads%252Fhigh%252FQjkkWB1nYUI%252FQjkkWB1nYUI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Danger From Param Sundari' LIMIT 1), 1),
    'Kabir Theme Reloaded by Sanchit Balhara |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575115/4575115.jpg',
    'https://pagalworldmusic.com/download.php?title=Kabir+Theme+Reloaded-320kbps&path=downloads%2Fhigh%2FJCI9ZBtCWgE%2FJCI9ZBtCWgE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKabir%2BTheme%2BReloaded-320kbps%26path%3Ddownloads%252Fhigh%252FJCI9ZBtCWgE%252FJCI9ZBtCWgE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Danger From Param Sundari' LIMIT 1), 1),
    'Raghu & Kaboo Theme by Sanchit Balhara |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575115/4575115.jpg',
    'https://pagalworldmusic.com/download.php?title=Raghu+%26amp%3B+Kaboo+Theme-320kbps&path=downloads%2Fhigh%2FFVERYQFzVHU%2FFVERYQFzVHU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaghu%2B%2526amp%253B%2BKaboo%2BTheme-320kbps%26path%3Ddownloads%252Fhigh%252FFVERYQFzVHU%252FFVERYQFzVHU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Danger From Param Sundari' LIMIT 1), 1),
    'Shaitan by Sanchit Balhara |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575115/4575115.jpg',
    'https://pagalworldmusic.com/download.php?title=Shaitan-320kbps&path=downloads%2Fhigh%2FOhs8WzZBekY%2FOhs8WzZBekY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DShaitan-320kbps%26path%3Ddownloads%252Fhigh%252FOhs8WzZBekY%252FOhs8WzZBekY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Danger From Param Sundari' LIMIT 1), 1),
    'Janaab e Aali by Sachet Tandon |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575115/4575115.jpg',
    'https://pagalworldmusic.com/download.php?title=Janaab+e+Aali-320kbps&path=downloads%2Fhigh%2FQiYeWT4DVQM%2FQiYeWT4DVQM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJanaab%2Be%2BAali-320kbps%26path%3Ddownloads%252Fhigh%252FQiYeWT4DVQM%252FQiYeWT4DVQM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Danger From Param Sundari' LIMIT 1), 1),
    'Mobsta by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575115/4575115.jpg',
    'https://pagalworldmusic.com/download.php?title=Mobsta-320kbps&path=downloads%2Fhigh%2FXThaYQ5kRF0%2FXThaYQ5kRF0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMobsta-320kbps%26path%3Ddownloads%252Fhigh%252FXThaYQ5kRF0%252FXThaYQ5kRF0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'WAR 2' LIMIT 1), 1),
    'Powerhouse by Arivu |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575258/4575258.jpg',
    'https://pagalworldmusic.com/download.php?title=Powerhouse-320kbps&path=downloads%2Fhigh%2FGypYBQ1zc0Q%2FGypYBQ1zc0Q.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPowerhouse-320kbps%26path%3Ddownloads%252Fhigh%252FGypYBQ1zc0Q%252FGypYBQ1zc0Q.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'WAR 2' LIMIT 1), 1),
    'Danger From Param Sundari by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575258/4575258.jpg',
    'https://pagalworldmusic.com/download.php?title=Danger+From+Param+Sundari-320kbps&path=downloads%2Fhigh%2FBBoJbgQFXl8%2FBBoJbgQFXl8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDanger%2BFrom%2BParam%2BSundari-320kbps%26path%3Ddownloads%252Fhigh%252FBBoJbgQFXl8%252FBBoJbgQFXl8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'WAR 2' LIMIT 1), 1),
    'Pardesiya From Param Sundari by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575258/4575258.jpg',
    'https://pagalworldmusic.com/download.php?title=Pardesiya+From+Param+Sundari-320kbps&path=downloads%2Fhigh%2FHywYdhNqRUA%2FHywYdhNqRUA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPardesiya%2BFrom%2BParam%2BSundari-320kbps%26path%3Ddownloads%252Fhigh%252FHywYdhNqRUA%252FHywYdhNqRUA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'WAR 2' LIMIT 1), 1),
    'Aavan Jaavan by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575258/4575258.jpg',
    'https://pagalworldmusic.com/download.php?title=Aavan+Jaavan-320kbps&path=downloads%2Fhigh%2FHCI9dEd3fF4%2FHCI9dEd3fF4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAavan%2BJaavan-320kbps%26path%3Ddownloads%252Fhigh%252FHCI9dEd3fF4%252FHCI9dEd3fF4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Coolie The Powerhouse Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Kokki by Sooraj Santhosh |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575015/4575015.jpg',
    'https://pagalworldmusic.com/download.php?title=Kokki-320kbps&path=downloads%2Fhigh%2FCiFaYEZCfVY%2FCiFaYEZCfVY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKokki-320kbps%26path%3Ddownloads%252Fhigh%252FCiFaYEZCfVY%252FCiFaYEZCfVY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Coolie The Powerhouse Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Bheegi Saree From Param Sundari by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575015/4575015.jpg',
    'https://pagalworldmusic.com/download.php?title=Bheegi+Saree+From+Param+Sundari-320kbps&path=downloads%2Fhigh%2FGjcqXT5DDlU%2FGjcqXT5DDlU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBheegi%2BSaree%2BFrom%2BParam%2BSundari-320kbps%26path%3Ddownloads%252Fhigh%252FGjcqXT5DDlU%252FGjcqXT5DDlU.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Coolie The Powerhouse Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Milna Ye Aakhri Hai Kya by Sai Smriti |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575015/4575015.jpg',
    'https://pagalworldmusic.com/download.php?title=Milna+Ye+Aakhri+Hai+Kya-320kbps&path=downloads%2Fhigh%2FGDETVyxAXAM%2FGDETVyxAXAM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMilna%2BYe%2BAakhri%2BHai%2BKya-320kbps%26path%3Ddownloads%252Fhigh%252FGDETVyxAXAM%252FGDETVyxAXAM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Coolie The Powerhouse Original Motion Picture Soundtrack' LIMIT 1), 1),
    'I Am The Danger by Siddharth Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575015/4575015.jpg',
    'https://pagalworldmusic.com/download.php?title=I+Am+The+Danger-320kbps&path=downloads%2Fhigh%2FBiwoBitzREM%2FBiwoBitzREM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DI%2BAm%2BThe%2BDanger-320kbps%26path%3Ddownloads%252Fhigh%252FBiwoBitzREM%252FBiwoBitzREM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Coolie The Powerhouse Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Monica by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575015/4575015.jpg',
    'https://pagalworldmusic.com/download.php?title=Monica-320kbps&path=downloads%2Fhigh%2FJjcjfj9hUUI%2FJjcjfj9hUUI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMonica-320kbps%26path%3Ddownloads%252Fhigh%252FJjcjfj9hUUI%252FJjcjfj9hUUI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Coolie The Powerhouse Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Chikitu by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575015/4575015.jpg',
    'https://pagalworldmusic.com/download.php?title=Chikitu-320kbps&path=downloads%2Fhigh%2FCVoOXzFxVXs%2FCVoOXzFxVXs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChikitu-320kbps%26path%3Ddownloads%252Fhigh%252FCVoOXzFxVXs%252FCVoOXzFxVXs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Coolie The Powerhouse Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Coolie Disco by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575015/4575015.jpg',
    'https://pagalworldmusic.com/download.php?title=Coolie+Disco-320kbps&path=downloads%2Fhigh%2FQ1EcSStIflo%2FQ1EcSStIflo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DCoolie%2BDisco-320kbps%26path%3Ddownloads%252Fhigh%252FQ1EcSStIflo%252FQ1EcSStIflo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Coolie The Powerhouse Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Neend by Aman Moroney |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4575015/4575015.jpg',
    'https://pagalworldmusic.com/download.php?title=Neend-320kbps&path=downloads%2Fhigh%2FHQpdRFlIf2U%2FHQpdRFlIf2U.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNeend-320kbps%26path%3Ddownloads%252Fhigh%252FHQpdRFlIf2U%252FHQpdRFlIf2U.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhadak 2 Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Tehtul e Ishq by Subhi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574977/4574977.jpg',
    'https://pagalworldmusic.com/download.php?title=Tehtul+e+Ishq-320kbps&path=downloads%2Fhigh%2FBRAEckEHQ10%2FBRAEckEHQ10.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTehtul%2Be%2BIshq-320kbps%26path%3Ddownloads%252Fhigh%252FBRAEckEHQ10%252FBRAEckEHQ10.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhadak 2 Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Sunn Mere Yaar Ve From Param Sundari by Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574977/4574977.jpg',
    'https://pagalworldmusic.com/download.php?title=Sunn+Mere%C2%A0Yaar%C2%A0Ve+From+Param+Sundari-320kbps&path=downloads%2Fhigh%2FHxs7VysDWX4%2FHxs7VysDWX4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSunn%2BMere%25C2%25A0Yaar%25C2%25A0Ve%2BFrom%2BParam%2BSundari-320kbps%26path%3Ddownloads%252Fhigh%252FHxs7VysDWX4%252FHxs7VysDWX4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhadak 2 Original Motion Picture Soundtrack' LIMIT 1), 1),
    'KI KORI by Mumzy Stranger |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574977/4574977.jpg',
    'https://pagalworldmusic.com/download.php?title=KI+KORI-320kbps&path=downloads%2Fhigh%2FIwNfei1ID1c%2FIwNfei1ID1c.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKI%2BKORI-320kbps%26path%3Ddownloads%252Fhigh%252FIwNfei1ID1c%252FIwNfei1ID1c.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhadak 2 Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Sun Sada by Kaushik Vikas |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574977/4574977.jpg',
    'https://pagalworldmusic.com/download.php?title=Sun+Sada-320kbps&path=downloads%2Fhigh%2FPCkpfC4JfGY%2FPCkpfC4JfGY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSun%2BSada-320kbps%26path%3Ddownloads%252Fhigh%252FPCkpfC4JfGY%252FPCkpfC4JfGY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhadak 2 Original Motion Picture Soundtrack' LIMIT 1), 1),
    'MR. RAMBO by YUNG SAMMY |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574977/4574977.jpg',
    'https://pagalworldmusic.com/download.php?title=MR.+RAMBO-320kbps&path=downloads%2Fhigh%2FMgYtQQdAAmQ%2FMgYtQQdAAmQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMR.%2BRAMBO-320kbps%26path%3Ddownloads%252Fhigh%252FMgYtQQdAAmQ%252FMgYtQQdAAmQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dhadak 2 Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Tauba by DJ LYAN |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574977/4574977.jpg',
    'https://pagalworldmusic.com/download.php?title=Tauba-320kbps&path=downloads%2Fhigh%2FMRwdaDBqVHs%2FMRwdaDBqVHs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTauba-320kbps%26path%3Ddownloads%252Fhigh%252FMRwdaDBqVHs%252FMRwdaDBqVHs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nikita Roy' LIMIT 1), 1),
    'Senti by Natania |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574672/4574672.jpg',
    'https://pagalworldmusic.com/download.php?title=Senti-320kbps&path=downloads%2Fhigh%2FCV8OSTpne2w%2FCV8OSTpne2w.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSenti-320kbps%26path%3Ddownloads%252Fhigh%252FCV8OSTpne2w%252FCV8OSTpne2w.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nikita Roy' LIMIT 1), 1),
    'Satyamev Jayate by Abhinav Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574672/4574672.jpg',
    'https://pagalworldmusic.com/download.php?title=Satyamev+Jayate-320kbps&path=downloads%2Fhigh%2FAAYscxh-cVA%2FAAYscxh-cVA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSatyamev%2BJayate-320kbps%26path%3Ddownloads%252Fhigh%252FAAYscxh-cVA%252FAAYscxh-cVA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nikita Roy' LIMIT 1), 1),
    'Soona Soona by Abhinav Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574672/4574672.jpg',
    'https://pagalworldmusic.com/download.php?title=Soona+Soona-320kbps&path=downloads%2Fhigh%2FGBgheTV3W2I%2FGBgheTV3W2I.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSoona%2BSoona-320kbps%26path%3Ddownloads%252Fhigh%252FGBgheTV3W2I%252FGBgheTV3W2I.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nikita Roy' LIMIT 1), 1),
    'Accomplishments by Addy Nagar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574672/4574672.jpg',
    'https://pagalworldmusic.com/download.php?title=Accomplishments-320kbps&path=downloads%2Fhigh%2FKBAta0ADR3I%2FKBAta0ADR3I.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAccomplishments-320kbps%26path%3Ddownloads%252Fhigh%252FKBAta0ADR3I%252FKBAta0ADR3I.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nikita Roy' LIMIT 1), 1),
    'Soona Soona Unplugged by Abhinav Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574672/4574672.jpg',
    'https://pagalworldmusic.com/download.php?title=Soona+Soona+Unplugged-320kbps&path=downloads%2Fhigh%2FPAc0ZhtAVn8%2FPAc0ZhtAVn8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSoona%2BSoona%2BUnplugged-320kbps%26path%3Ddownloads%252Fhigh%252FPAc0ZhtAVn8%252FPAc0ZhtAVn8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'KING IN THE NORTH' LIMIT 1), 1),
    'Desi''s Anthem by Addy Nagar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574652/4574652.jpg',
    'https://pagalworldmusic.com/download.php?title=Desi%27s+Anthem-320kbps&path=downloads%2Fhigh%2FBgYfYCBlAVE%2FBgYfYCBlAVE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDesi%2527s%2BAnthem-320kbps%26path%3Ddownloads%252Fhigh%252FBgYfYCBlAVE%252FBgYfYCBlAVE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'KING IN THE NORTH' LIMIT 1), 1),
    'King In The North by Addy Nagar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574652/4574652.jpg',
    'https://pagalworldmusic.com/download.php?title=King+In+The+North-320kbps&path=downloads%2Fhigh%2FMgVcAxwATXs%2FMgVcAxwATXs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKing%2BIn%2BThe%2BNorth-320kbps%26path%3Ddownloads%252Fhigh%252FMgVcAxwATXs%252FMgVcAxwATXs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'KING IN THE NORTH' LIMIT 1), 1),
    'Kaali Raatein by Abhinav Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574652/4574652.jpg',
    'https://pagalworldmusic.com/download.php?title=Kaali+Raatein-320kbps&path=downloads%2Fhigh%2FQBoiYwF%2CQ3c%2FQBoiYwF%2CQ3c.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKaali%2BRaatein-320kbps%26path%3Ddownloads%252Fhigh%252FQBoiYwF%252CQ3c%252FQBoiYwF%252CQ3c.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'KING IN THE NORTH' LIMIT 1), 1),
    'College Life by Addy Nagar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574652/4574652.jpg',
    'https://pagalworldmusic.com/download.php?title=College+Life-320kbps&path=downloads%2Fhigh%2FE1oxWzdSGmE%2FE1oxWzdSGmE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DCollege%2BLife-320kbps%26path%3Ddownloads%252Fhigh%252FE1oxWzdSGmE%252FE1oxWzdSGmE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'KING IN THE NORTH' LIMIT 1), 1),
    'Lali Tham Jaa by Addy Nagar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574652/4574652.jpg',
    'https://pagalworldmusic.com/download.php?title=Lali+Tham+Jaa-320kbps&path=downloads%2Fhigh%2FOloabjEJAmw%2FOloabjEJAmw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLali%2BTham%2BJaa-320kbps%26path%3Ddownloads%252Fhigh%252FOloabjEJAmw%252FOloabjEJAmw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'KING IN THE NORTH' LIMIT 1), 1),
    'Everything Is Nice by Addy Nagar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574652/4574652.jpg',
    'https://pagalworldmusic.com/download.php?title=Everything+Is+Nice-320kbps&path=downloads%2Fhigh%2FSSABXjxnB0Q%2FSSABXjxnB0Q.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DEverything%2BIs%2BNice-320kbps%26path%3Ddownloads%252Fhigh%252FSSABXjxnB0Q%252FSSABXjxnB0Q.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'KING IN THE NORTH' LIMIT 1), 1),
    'Last Emotions by Addy Nagar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574652/4574652.jpg',
    'https://pagalworldmusic.com/download.php?title=Last+Emotions-320kbps&path=downloads%2Fhigh%2FJwAtYi5jdlc%2FJwAtYi5jdlc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLast%2BEmotions-320kbps%26path%3Ddownloads%252Fhigh%252FJwAtYi5jdlc%252FJwAtYi5jdlc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'KING IN THE NORTH' LIMIT 1), 1),
    'GOD''s CHILD by Addy Nagar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574652/4574652.jpg',
    'https://pagalworldmusic.com/download.php?title=GOD%27s+CHILD-320kbps&path=downloads%2Fhigh%2FEywxZThXT3g%2FEywxZThXT3g.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGOD%2527s%2BCHILD-320kbps%26path%3Ddownloads%252Fhigh%252FEywxZThXT3g%252FEywxZThXT3g.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'KING IN THE NORTH' LIMIT 1), 1),
    'Namaste Narsimha Aarti Version by Sam C.S. |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574652/4574652.jpg',
    'https://pagalworldmusic.com/download.php?title=Namaste+Narsimha+Aarti+Version-320kbps&path=downloads%2Fhigh%2FKFonVjgGYnw%2FKFonVjgGYnw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNamaste%2BNarsimha%2BAarti%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FKFonVjgGYnw%252FKFonVjgGYnw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'KING IN THE NORTH' LIMIT 1), 1),
    'Tu Badh Badh by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574652/4574652.jpg',
    'https://pagalworldmusic.com/download.php?title=Tu+Badh+Badh-320kbps&path=downloads%2Fhigh%2FCVxaQhNKXWE%2FCVxaQhNKXWE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTu%2BBadh%2BBadh-320kbps%26path%3Ddownloads%252Fhigh%252FCVxaQhNKXWE%252FCVxaQhNKXWE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Saamrajya' LIMIT 1), 1),
    'MY JOURNEY by Addy Nagar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574472/4574472.jpg',
    'https://pagalworldmusic.com/download.php?title=MY+JOURNEY-320kbps&path=downloads%2Fhigh%2FQCkZXxpSXVY%2FQCkZXxpSXVY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMY%2BJOURNEY-320kbps%26path%3Ddownloads%252Fhigh%252FQCkZXxpSXVY%252FQCkZXxpSXVY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Saamrajya' LIMIT 1), 1),
    'Maine Pukaraa by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574472/4574472.jpg',
    'https://pagalworldmusic.com/download.php?title=Maine+Pukaraa-320kbps&path=downloads%2Fhigh%2FQBg6UiwJD2M%2FQBg6UiwJD2M.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMaine%2BPukaraa-320kbps%26path%3Ddownloads%252Fhigh%252FQBg6UiwJD2M%252FQBg6UiwJD2M.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mahavatar Narsimha Hindi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Asura Theme by The Shloka |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574398/4574398.jpg',
    'https://pagalworldmusic.com/download.php?title=Asura+Theme-320kbps&path=downloads%2Fhigh%2FOQ8ACUB2ewM%2FOQ8ACUB2ewM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAsura%2BTheme-320kbps%26path%3Ddownloads%252Fhigh%252FOQ8ACUB2ewM%252FOQ8ACUB2ewM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mahavatar Narsimha Hindi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Jag Mein Tera Naam Ho by The Shloka |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574398/4574398.jpg',
    'https://pagalworldmusic.com/download.php?title=Jag+Mein+Tera+Naam+Ho-320kbps&path=downloads%2Fhigh%2FOF0oAkFiTVA%2FOF0oAkFiTVA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJag%2BMein%2BTera%2BNaam%2BHo-320kbps%26path%3Ddownloads%252Fhigh%252FOF0oAkFiTVA%252FOF0oAkFiTVA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mahavatar Narsimha Hindi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Namaste Narsimha Orchestral Version by Sam C.S. |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574398/4574398.jpg',
    'https://pagalworldmusic.com/download.php?title=Namaste+Narsimha+Orchestral+Version-320kbps&path=downloads%2Fhigh%2FIwEgBEVJeEo%2FIwEgBEVJeEo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNamaste%2BNarsimha%2BOrchestral%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FIwEgBEVJeEo%252FIwEgBEVJeEo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mahavatar Narsimha Hindi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Hari Ki Gatha by The Shloka |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574398/4574398.jpg',
    'https://pagalworldmusic.com/download.php?title=Hari+Ki+Gatha-320kbps&path=downloads%2Fhigh%2FESw8ewB1Rmc%2FESw8ewB1Rmc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHari%2BKi%2BGatha-320kbps%26path%3Ddownloads%252Fhigh%252FESw8ewB1Rmc%252FESw8ewB1Rmc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mahavatar Narsimha Hindi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Roar Of Narsimha by The Shloka |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574398/4574398.jpg',
    'https://pagalworldmusic.com/download.php?title=Roar+Of+Narsimha-320kbps&path=downloads%2Fhigh%2FASUvdi0BAGI%2FASUvdi0BAGI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRoar%2BOf%2BNarsimha-320kbps%26path%3Ddownloads%252Fhigh%252FASUvdi0BAGI%252FASUvdi0BAGI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mahavatar Narsimha Hindi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Kaindiyaan by Asees Kaur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574398/4574398.jpg',
    'https://pagalworldmusic.com/download.php?title=Kaindiyaan-320kbps&path=downloads%2Fhigh%2FBicldStIVmw%2FBicldStIVmw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKaindiyaan-320kbps%26path%3Ddownloads%252Fhigh%252FBicldStIVmw%252FBicldStIVmw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mahavatar Narsimha Hindi Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Phir Na Milenge by Asees Kaur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574398/4574398.jpg',
    'https://pagalworldmusic.com/download.php?title=Phir+Na+Milenge-320kbps&path=downloads%2Fhigh%2FPBEKAgNJVUI%2FPBEKAgNJVUI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPhir%2BNa%2BMilenge-320kbps%26path%3Ddownloads%252Fhigh%252FPBEKAgNJVUI%252FPBEKAgNJVUI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Broken' LIMIT 1), 1),
    'Aa Gale Lag Jaa Duet Version by Kausar Munir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574316/4574316.jpg',
    'https://pagalworldmusic.com/download.php?title=Aa+Gale+Lag+Jaa+Duet+Version-320kbps&path=downloads%2Fhigh%2FJjEgfB1%2CX0o%2FJjEgfB1%2CX0o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAa%2BGale%2BLag%2BJaa%2BDuet%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FJjEgfB1%252CX0o%252FJjEgfB1%252CX0o.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Broken' LIMIT 1), 1),
    'Om Namo Bhagavate Vasudevaya by Saurabh Mittal |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574316/4574316.jpg',
    'https://pagalworldmusic.com/download.php?title=Om+Namo+Bhagavate+Vasudevaya-320kbps&path=downloads%2Fhigh%2FGhBbVC57BFU%2FGhBbVC57BFU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DOm%2BNamo%2BBhagavate%2BVasudevaya-320kbps%26path%3Ddownloads%252Fhigh%252FGhBbVC57BFU%252FGhBbVC57BFU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Broken' LIMIT 1), 1),
    'Toot Gaya by Asees Kaur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574316/4574316.jpg',
    'https://pagalworldmusic.com/download.php?title=Toot+Gaya-320kbps&path=downloads%2Fhigh%2FXT0ZbkUGDkQ%2FXT0ZbkUGDkQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DToot%2BGaya-320kbps%26path%3Ddownloads%252Fhigh%252FXT0ZbkUGDkQ%252FXT0ZbkUGDkQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Broken' LIMIT 1), 1),
    'Bhool Jaungi by Asees Kaur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574316/4574316.jpg',
    'https://pagalworldmusic.com/download.php?title=Bhool+Jaungi-320kbps&path=downloads%2Fhigh%2FQVs0STwFeXA%2FQVs0STwFeXA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBhool%2BJaungi-320kbps%26path%3Ddownloads%252Fhigh%252FQVs0STwFeXA%252FQVs0STwFeXA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarzameen' LIMIT 1), 1),
    'Aa Gale Lag Jaa Female Version by Kausar Munir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574039/4574039.jpg',
    'https://pagalworldmusic.com/download.php?title=Aa+Gale+Lag+Jaa+Female+Version-320kbps&path=downloads%2Fhigh%2FEystazdjZls%2FEystazdjZls.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAa%2BGale%2BLag%2BJaa%2BFemale%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FEystazdjZls%252FEystazdjZls.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarzameen' LIMIT 1), 1),
    'Aa Gale Lag Jaa by Kausar Munir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574039/4574039.jpg',
    'https://pagalworldmusic.com/download.php?title=Aa+Gale+Lag+Jaa-320kbps&path=downloads%2Fhigh%2FFDAlfwd0f0A%2FFDAlfwd0f0A.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAa%2BGale%2BLag%2BJaa-320kbps%26path%3Ddownloads%252Fhigh%252FFDAlfwd0f0A%252FFDAlfwd0f0A.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarzameen' LIMIT 1), 1),
    'Aaj Ruk Jaa Female Version by Kausar Munir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574039/4574039.jpg',
    'https://pagalworldmusic.com/download.php?title=Aaj+Ruk+Jaa+Female+Version-320kbps&path=downloads%2Fhigh%2FNSVbASZqZwU%2FNSVbASZqZwU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAaj%2BRuk%2BJaa%2BFemale%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FNSVbASZqZwU%252FNSVbASZqZwU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarzameen' LIMIT 1), 1),
    'Aaj Ruk Jaa by Kausar Munir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574039/4574039.jpg',
    'https://pagalworldmusic.com/download.php?title=Aaj+Ruk+Jaa-320kbps&path=downloads%2Fhigh%2FHlwnaQVqYmk%2FHlwnaQVqYmk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAaj%2BRuk%2BJaa-320kbps%26path%3Ddownloads%252Fhigh%252FHlwnaQVqYmk%252FHlwnaQVqYmk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarzameen' LIMIT 1), 1),
    'Ve Mahiya by Kausar Munir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574039/4574039.jpg',
    'https://pagalworldmusic.com/download.php?title=Ve+Mahiya-320kbps&path=downloads%2Fhigh%2FPSkPAUdAZwA%2FPSkPAUdAZwA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DVe%2BMahiya-320kbps%26path%3Ddownloads%252Fhigh%252FPSkPAUdAZwA%252FPSkPAUdAZwA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarzameen' LIMIT 1), 1),
    'Mere Murshid Mere Yaara by Jaani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574039/4574039.jpg',
    'https://pagalworldmusic.com/download.php?title=Mere+Murshid+Mere+Yaara-320kbps&path=downloads%2Fhigh%2FJgIvehhobX0%2FJgIvehhobX0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMere%2BMurshid%2BMere%2BYaara-320kbps%26path%3Ddownloads%252Fhigh%252FJgIvehhobX0%252FJgIvehhobX0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarzameen' LIMIT 1), 1),
    'Saiyaara Reprise Female by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574039/4574039.jpg',
    'https://pagalworldmusic.com/download.php?title=Saiyaara+Reprise+Female-320kbps&path=downloads%2Fhigh%2FMlosQDFDBVQ%2FMlosQDFDBVQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSaiyaara%2BReprise%2BFemale-320kbps%26path%3Ddownloads%252Fhigh%252FMlosQDFDBVQ%252FMlosQDFDBVQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarzameen' LIMIT 1), 1),
    'Dhun by Mithoon |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4574039/4574039.jpg',
    'https://pagalworldmusic.com/download.php?title=Dhun-320kbps&path=downloads%2Fhigh%2FO1AsaTx2Alg%2FO1AsaTx2Alg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDhun-320kbps%26path%3Ddownloads%252Fhigh%252FO1AsaTx2Alg%252FO1AsaTx2Alg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Saiyaara' LIMIT 1), 1),
    'Barbaad by The Rish |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573889/4573889.jpg',
    'https://pagalworldmusic.com/download.php?title=Barbaad-320kbps&path=downloads%2Fhigh%2FIV9ZUidnXUI%2FIV9ZUidnXUI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBarbaad-320kbps%26path%3Ddownloads%252Fhigh%252FIV9ZUidnXUI%252FIV9ZUidnXUI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Saiyaara' LIMIT 1), 1),
    'Saiyaara by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573889/4573889.jpg',
    'https://pagalworldmusic.com/download.php?title=Saiyaara-320kbps&path=downloads%2Fhigh%2FO18beQR2eX8%2FO18beQR2eX8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSaiyaara-320kbps%26path%3Ddownloads%252Fhigh%252FO18beQR2eX8%252FO18beQR2eX8.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Saiyaara' LIMIT 1), 1),
    'Humsafar by Sachet-Parampara |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573889/4573889.jpg',
    'https://pagalworldmusic.com/download.php?title=Humsafar-320kbps&path=downloads%2Fhigh%2FAQ9GfhdGegU%2FAQ9GfhdGegU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHumsafar-320kbps%26path%3Ddownloads%252Fhigh%252FAQ9GfhdGegU%252FAQ9GfhdGegU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Saiyaara' LIMIT 1), 1),
    'High On Life by Addy Nagar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573889/4573889.jpg',
    'https://pagalworldmusic.com/download.php?title=High+On+Life-320kbps&path=downloads%2Fhigh%2FSSIiAjB4Bnk%2FSSIiAjB4Bnk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHigh%2BOn%2BLife-320kbps%26path%3Ddownloads%252Fhigh%252FSSIiAjB4Bnk%252FSSIiAjB4Bnk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Saiyaara' LIMIT 1), 1),
    'Jaadu Wali Chimki From Aap Jaisa Koi by Justin Prabhakaran |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573889/4573889.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaadu+Wali+Chimki+From+Aap+Jaisa+Koi-320kbps&path=downloads%2Fhigh%2FCSc9RiZIfF4%2FCSc9RiZIfF4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaadu%2BWali%2BChimki%2BFrom%2BAap%2BJaisa%2BKoi-320kbps%26path%3Ddownloads%252Fhigh%252FCSc9RiZIfF4%252FCSc9RiZIfF4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Saiyaara' LIMIT 1), 1),
    'Watna Ve by Kausar Munir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573889/4573889.jpg',
    'https://pagalworldmusic.com/download.php?title=Watna+Ve-320kbps&path=downloads%2Fhigh%2FLx4iVBlhU3s%2FLx4iVBlhU3s.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DWatna%2BVe-320kbps%26path%3Ddownloads%252Fhigh%252FLx4iVBlhU3s%252FLx4iVBlhU3s.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Saiyaara' LIMIT 1), 1),
    'Saare Jag Mein From Aap Jaisa Koi by Justin Prabhakaran |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573889/4573889.jpg',
    'https://pagalworldmusic.com/download.php?title=Saare+Jag+Mein+From+Aap+Jaisa+Koi-320kbps&path=downloads%2Fhigh%2FOgseWkxzRAc%2FOgseWkxzRAc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSaare%2BJag%2BMein%2BFrom%2BAap%2BJaisa%2BKoi-320kbps%26path%3Ddownloads%252Fhigh%252FOgseWkxzRAc%252FOgseWkxzRAc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Aap Jaisa Koi' LIMIT 1), 1),
    'Tum Ho Toh by Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573444/4573444.jpg',
    'https://pagalworldmusic.com/download.php?title=Tum+Ho+Toh-320kbps&path=downloads%2Fhigh%2FIiUFeQ1ABXA%2FIiUFeQ1ABXA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTum%2BHo%2BToh-320kbps%26path%3Ddownloads%252Fhigh%252FIiUFeQ1ABXA%252FIiUFeQ1ABXA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Aap Jaisa Koi' LIMIT 1), 1),
    'Dhuan Dhuan From Aap Jaisa Koi by Sanjith Hegde |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573444/4573444.jpg',
    'https://pagalworldmusic.com/download.php?title=Dhuan+Dhuan+From+Aap+Jaisa+Koi-320kbps&path=downloads%2Fhigh%2FQAs6BidVUn8%2FQAs6BidVUn8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDhuan%2BDhuan%2BFrom%2BAap%2BJaisa%2BKoi-320kbps%26path%3Ddownloads%252Fhigh%252FQAs6BidVUn8%252FQAs6BidVUn8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Aap Jaisa Koi' LIMIT 1), 1),
    'Raaj Karega Maalik Rap Version Rap Version by Amitabh Bhattacharya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573444/4573444.jpg',
    'https://pagalworldmusic.com/download.php?title=Raaj+Karega+Maalik+Rap+Version+Rap+Version-320kbps&path=downloads%2Fhigh%2FSUUkbgVXXwo%2FSUUkbgVXXwo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaaj%2BKarega%2BMaalik%2BRap%2BVersion%2BRap%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FSUUkbgVXXwo%252FSUUkbgVXXwo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Aap Jaisa Koi' LIMIT 1), 1),
    'Affair by Amitabh Bhattacharya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573444/4573444.jpg',
    'https://pagalworldmusic.com/download.php?title=Affair-320kbps&path=downloads%2Fhigh%2FRxwufydyZnY%2FRxwufydyZnY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAffair-320kbps%26path%3Ddownloads%252Fhigh%252FRxwufydyZnY%252FRxwufydyZnY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Aap Jaisa Koi' LIMIT 1), 1),
    'Raaj Karega Maalik From Maalik by Amitabh Bhattacharya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573444/4573444.jpg',
    'https://pagalworldmusic.com/download.php?title=Raaj+Karega+Maalik+From+Maalik-320kbps&path=downloads%2Fhigh%2FHBIBWScJU3U%2FHBIBWScJU3U.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaaj%2BKarega%2BMaalik%2BFrom%2BMaalik-320kbps%26path%3Ddownloads%252Fhigh%252FHBIBWScJU3U%252FHBIBWScJU3U.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Metro ... In Dino Side A' LIMIT 1), 1),
    'Dil Thaam Ke From Maalik by Amitabh Bhattacharya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573835/4573835.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Thaam+Ke+From+Maalik-320kbps&path=downloads%2Fhigh%2FJCsNZE1DDlo%2FJCsNZE1DDlo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BThaam%2BKe%2BFrom%2BMaalik-320kbps%26path%3Ddownloads%252Fhigh%252FJCsNZE1DDlo%252FJCsNZE1DDlo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Metro ... In Dino Side A' LIMIT 1), 1),
    'Naamumkin From Maalik by Amitabh Bhattacharya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573835/4573835.jpg',
    'https://pagalworldmusic.com/download.php?title=Naamumkin+From+Maalik-320kbps&path=downloads%2Fhigh%2FPF4IcxFxTWo%2FPF4IcxFxTWo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNaamumkin%2BFrom%2BMaalik-320kbps%26path%3Ddownloads%252Fhigh%252FPF4IcxFxTWo%252FPF4IcxFxTWo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Metro ... In Dino Side A' LIMIT 1), 1),
    'Chor Bazari Phir Se From Bhool Chuk Maaf by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573835/4573835.jpg',
    'https://pagalworldmusic.com/download.php?title=Chor+Bazari+Phir+Se+From+Bhool+Chuk+Maaf-320kbps&path=downloads%2Fhigh%2FRTdaQDFkDmQ%2FRTdaQDFkDmQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChor%2BBazari%2BPhir%2BSe%2BFrom%2BBhool%2BChuk%2BMaaf-320kbps%26path%3Ddownloads%252Fhigh%252FRTdaQDFkDmQ%252FRTdaQDFkDmQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Metro ... In Dino Side A' LIMIT 1), 1),
    'Naamumkin Sad Version Sad Version by Amitabh Bhattacharya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573835/4573835.jpg',
    'https://pagalworldmusic.com/download.php?title=Naamumkin+Sad+Version+Sad+Version-320kbps&path=downloads%2Fhigh%2FHQIfVQZlVAM%2FHQIfVQZlVAM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNaamumkin%2BSad%2BVersion%2BSad%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FHQIfVQZlVAM%252FHQIfVQZlVAM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Metro ... In Dino Side A' LIMIT 1), 1),
    'Sawariya Tera From Bhool Chuk Maaf by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573835/4573835.jpg',
    'https://pagalworldmusic.com/download.php?title=Sawariya+Tera+From+Bhool+Chuk+Maaf-320kbps&path=downloads%2Fhigh%2FLycvfjNFUVI%2FLycvfjNFUVI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSawariya%2BTera%2BFrom%2BBhool%2BChuk%2BMaaf-320kbps%26path%3Ddownloads%252Fhigh%252FLycvfjNFUVI%252FLycvfjNFUVI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Metro ... In Dino Side A' LIMIT 1), 1),
    'Koi Naa From Bhool Chuk Maaf by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573835/4573835.jpg',
    'https://pagalworldmusic.com/download.php?title=Koi+Naa+From+Bhool+Chuk+Maaf-320kbps&path=downloads%2Fhigh%2FHwQFfDlgeUA%2FHwQFfDlgeUA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKoi%2BNaa%2BFrom%2BBhool%2BChuk%2BMaaf-320kbps%26path%3Ddownloads%252Fhigh%252FHwQFfDlgeUA%252FHwQFfDlgeUA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thug Life Hindi' LIMIT 1), 1),
    'Maahi Mera From Bhool Chuk Maaf by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572672/4572672.jpg',
    'https://pagalworldmusic.com/download.php?title=Maahi+Mera+From+Bhool+Chuk+Maaf-320kbps&path=downloads%2Fhigh%2FRTlaXyN8BQQ%2FRTlaXyN8BQQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMaahi%2BMera%2BFrom%2BBhool%2BChuk%2BMaaf-320kbps%26path%3Ddownloads%252Fhigh%252FRTlaXyN8BQQ%252FRTlaXyN8BQQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thug Life Hindi' LIMIT 1), 1),
    'Jab Tu Sajan From Aap Jaisa Koi by Rochak Kohli |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572672/4572672.jpg',
    'https://pagalworldmusic.com/download.php?title=Jab+Tu+Sajan+From+Aap+Jaisa+Koi-320kbps&path=downloads%2Fhigh%2FJB0fWBhHZX8%2FJB0fWBhHZX8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJab%2BTu%2BSajan%2BFrom%2BAap%2BJaisa%2BKoi-320kbps%26path%3Ddownloads%252Fhigh%252FJB0fWBhHZX8%252FJB0fWBhHZX8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thug Life Hindi' LIMIT 1), 1),
    'Dhaagena Tinak Dhin by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572672/4572672.jpg',
    'https://pagalworldmusic.com/download.php?title=Dhaagena+Tinak+Dhin-320kbps&path=downloads%2Fhigh%2FBQo9YC1nXUc%2FBQo9YC1nXUc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDhaagena%2BTinak%2BDhin-320kbps%26path%3Ddownloads%252Fhigh%252FBQo9YC1nXUc%252FBQo9YC1nXUc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thug Life Hindi' LIMIT 1), 1),
    'Dil Ka Kya Encore by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572672/4572672.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Ka+Kya+Encore-320kbps&path=downloads%2Fhigh%2FRxEjSFlHBHc%2FRxEjSFlHBHc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BKa%2BKya%2BEncore-320kbps%26path%3Ddownloads%252Fhigh%252FRxEjSFlHBHc%252FRxEjSFlHBHc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chidiya Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Mann Ye Mera Rewind by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573334/4573334.jpg',
    'https://pagalworldmusic.com/download.php?title=Mann+Ye+Mera+Rewind-320kbps&path=downloads%2Fhigh%2FNRgtXzNCZ0M%2FNRgtXzNCZ0M.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMann%2BYe%2BMera%2BRewind-320kbps%26path%3Ddownloads%252Fhigh%252FNRgtXzNCZ0M%252FNRgtXzNCZ0M.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chidiya Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Barbaad Reprise Female by The Rish |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573334/4573334.jpg',
    'https://pagalworldmusic.com/download.php?title=Barbaad+Reprise+Female-320kbps&path=downloads%2Fhigh%2FRUUvekUEaGU%2FRUUvekUEaGU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBarbaad%2BReprise%2BFemale-320kbps%26path%3Ddownloads%252Fhigh%252FRUUvekUEaGU%252FRUUvekUEaGU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chidiya Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Aur Mohabbat Kitni Karoon by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573334/4573334.jpg',
    'https://pagalworldmusic.com/download.php?title=Aur+Mohabbat+Kitni+Karoon-320kbps&path=downloads%2Fhigh%2FGyRdeh5RZEU%2FGyRdeh5RZEU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAur%2BMohabbat%2BKitni%2BKaroon-320kbps%26path%3Ddownloads%252Fhigh%252FGyRdeh5RZEU%252FGyRdeh5RZEU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chidiya Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Mann Ye Mera by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573334/4573334.jpg',
    'https://pagalworldmusic.com/download.php?title=Mann+Ye+Mera-320kbps&path=downloads%2Fhigh%2FJTo9UBB3A3E%2FJTo9UBB3A3E.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMann%2BYe%2BMera-320kbps%26path%3Ddownloads%252Fhigh%252FJTo9UBB3A3E%252FJTo9UBB3A3E.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chidiya Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Mausam by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573334/4573334.jpg',
    'https://pagalworldmusic.com/download.php?title=Mausam-320kbps&path=downloads%2Fhigh%2FQQQCQDFCQFY%2FQQQCQDFCQFY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMausam-320kbps%26path%3Ddownloads%252Fhigh%252FQQQCQDFCQFY%252FQQQCQDFCQFY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chidiya Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Yaad by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573334/4573334.jpg',
    'https://pagalworldmusic.com/download.php?title=Yaad-320kbps&path=downloads%2Fhigh%2FBQohXyFXZF4%2FBQohXyFXZF4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYaad-320kbps%26path%3Ddownloads%252Fhigh%252FBQohXyFXZF4%252FBQohXyFXZF4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chidiya Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Jewel Thief Title Track by Shilpa Rao |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573334/4573334.jpg',
    'https://pagalworldmusic.com/download.php?title=Jewel+Thief+Title+Track-320kbps&path=downloads%2Fhigh%2FPlwaZEdCXX0%2FPlwaZEdCXX0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJewel%2BThief%2BTitle%2BTrack-320kbps%26path%3Ddownloads%252Fhigh%252FPlwaZEdCXX0%252FPlwaZEdCXX0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chidiya Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Ecstasy by RUUH |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573334/4573334.jpg',
    'https://pagalworldmusic.com/download.php?title=Ecstasy-320kbps&path=downloads%2Fhigh%2FRD8yW0YBD3k%2FRD8yW0YBD3k.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DEcstasy-320kbps%26path%3Ddownloads%252Fhigh%252FRD8yW0YBD3k%252FRD8yW0YBD3k.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chidiya Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Ilzaam by Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4573334/4573334.jpg',
    'https://pagalworldmusic.com/download.php?title=Ilzaam-320kbps&path=downloads%2Fhigh%2FFTlcCBd9YWY%2FFTlcCBd9YWY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIlzaam-320kbps%26path%3Ddownloads%252Fhigh%252FFTlcCBd9YWY%252FFTlcCBd9YWY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jewel Thief: The Heist Begins' LIMIT 1), 1),
    'Lootera by Neuman Pinto |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572574/4572574.jpg',
    'https://pagalworldmusic.com/download.php?title=Lootera-320kbps&path=downloads%2Fhigh%2FMlgPYid2BGw%2FMlgPYid2BGw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLootera-320kbps%26path%3Ddownloads%252Fhigh%252FMlgPYid2BGw%252FMlgPYid2BGw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jewel Thief: The Heist Begins' LIMIT 1), 1),
    'Dhun by Aditya N. |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572574/4572574.jpg',
    'https://pagalworldmusic.com/download.php?title=Dhun-320kbps&path=downloads%2Fhigh%2FBCEMXQ1WRh4%2FBCEMXQ1WRh4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDhun-320kbps%26path%3Ddownloads%252Fhigh%252FBCEMXQ1WRh4%252FBCEMXQ1WRh4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jewel Thief: The Heist Begins' LIMIT 1), 1),
    'Dil Deewana by RUUH |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572574/4572574.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Deewana-320kbps&path=downloads%2Fhigh%2FCj8tUER9TWA%2FCj8tUER9TWA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BDeewana-320kbps%26path%3Ddownloads%252Fhigh%252FCj8tUER9TWA%252FCj8tUER9TWA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jewel Thief: The Heist Begins' LIMIT 1), 1),
    'Jaadu by OAFF |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572574/4572574.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaadu-320kbps&path=downloads%2Fhigh%2FJScDfgdUdWQ%2FJScDfgdUdWQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaadu-320kbps%26path%3Ddownloads%252Fhigh%252FJScDfgdUdWQ%252FJScDfgdUdWQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Royals Original Soundtrack' LIMIT 1), 1),
    'Adayein Teri by RUUH |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572448/4572448.jpg',
    'https://pagalworldmusic.com/download.php?title=Adayein+Teri-320kbps&path=downloads%2Fhigh%2FKh8aWRZxRmE%2FKh8aWRZxRmE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAdayein%2BTeri-320kbps%26path%3Ddownloads%252Fhigh%252FKh8aWRZxRmE%252FKh8aWRZxRmE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Royals Original Soundtrack' LIMIT 1), 1),
    'Dil Ka Kya by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572448/4572448.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Ka+Kya-320kbps&path=downloads%2Fhigh%2FKCUjdzMBD0A%2FKCUjdzMBD0A.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BKa%2BKya-320kbps%26path%3Ddownloads%252Fhigh%252FKCUjdzMBD0A%252FKCUjdzMBD0A.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Royals Original Soundtrack' LIMIT 1), 1),
    'Jeena by Yashwardhan Goswami |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572448/4572448.jpg',
    'https://pagalworldmusic.com/download.php?title=Jeena-320kbps&path=downloads%2Fhigh%2FIC4CfhNgRHI%2FIC4CfhNgRHI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJeena-320kbps%26path%3Ddownloads%252Fhigh%252FIC4CfhNgRHI%252FIC4CfhNgRHI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Royals Original Soundtrack' LIMIT 1), 1),
    'Who Rules The World by Harsh Upadhyay |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572448/4572448.jpg',
    'https://pagalworldmusic.com/download.php?title=Who+Rules+The+World-320kbps&path=downloads%2Fhigh%2FRxkuR0N6YWE%2FRxkuR0N6YWE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DWho%2BRules%2BThe%2BWorld-320kbps%26path%3Ddownloads%252Fhigh%252FRxkuR0N6YWE%252FRxkuR0N6YWE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Royals Original Soundtrack' LIMIT 1), 1),
    'Money Money by Yo Yo Honey Singh |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572448/4572448.jpg',
    'https://pagalworldmusic.com/download.php?title=Money+Money-320kbps&path=downloads%2Fhigh%2FIkUuQRZDA0k%2FIkUuQRZDA0k.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMoney%2BMoney-320kbps%26path%3Ddownloads%252Fhigh%252FIkUuQRZDA0k%252FIkUuQRZDA0k.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Royals Original Soundtrack' LIMIT 1), 1),
    'Mila Tujhe From Aap Jaisa Koi by Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572448/4572448.jpg',
    'https://pagalworldmusic.com/download.php?title=Mila+Tujhe+From+Aap+Jaisa+Koi-320kbps&path=downloads%2Fhigh%2FRzkjejsBBEo%2FRzkjejsBBEo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMila%2BTujhe%2BFrom%2BAap%2BJaisa%2BKoi-320kbps%26path%3Ddownloads%252Fhigh%252FRzkjejsBBEo%252FRzkjejsBBEo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raid 2' LIMIT 1), 1),
    'Nasha by Jasmine Sandlas |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572039/4572039.jpg',
    'https://pagalworldmusic.com/download.php?title=Nasha-320kbps&path=downloads%2Fhigh%2FQV4meAJyZVU%2FQV4meAJyZVU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNasha-320kbps%26path%3Ddownloads%252Fhigh%252FQV4meAJyZVU%252FQV4meAJyZVU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raid 2' LIMIT 1), 1),
    'Anarkali by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572039/4572039.jpg',
    'https://pagalworldmusic.com/download.php?title=Anarkali-320kbps&path=downloads%2Fhigh%2FLwM%2CAyJZclk%2FLwM%2CAyJZclk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAnarkali-320kbps%26path%3Ddownloads%252Fhigh%252FLwM%252CAyJZclk%252FLwM%252CAyJZclk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raid 2' LIMIT 1), 1),
    'Zamaana Lage by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572039/4572039.jpg',
    'https://pagalworldmusic.com/download.php?title=Zamaana+Lage-320kbps&path=downloads%2Fhigh%2FJB06eFl6RAE%2FJB06eFl6RAE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DZamaana%2BLage-320kbps%26path%3Ddownloads%252Fhigh%252FJB06eFl6RAE%252FJB06eFl6RAE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Bhootnii Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Kamle by Parampara Tandon |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572036/4572036.jpg',
    'https://pagalworldmusic.com/download.php?title=Kamle-320kbps&path=downloads%2Fhigh%2FPj46RQEGdWs%2FPj46RQEGdWs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKamle-320kbps%26path%3Ddownloads%252Fhigh%252FPj46RQEGdWs%252FPj46RQEGdWs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Bhootnii Original Motion Picture Soundtrack' LIMIT 1), 1),
    'The One by Sarthak Kalyani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572036/4572036.jpg',
    'https://pagalworldmusic.com/download.php?title=The+One-320kbps&path=downloads%2Fhigh%2FRQ0PHEVHfHU%2FRQ0PHEVHfHU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThe%2BOne-320kbps%26path%3Ddownloads%252Fhigh%252FRQ0PHEVHfHU%252FRQ0PHEVHfHU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Bhootnii Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Lose Your Fkin Mind by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572036/4572036.jpg',
    'https://pagalworldmusic.com/download.php?title=Lose+Your+Fkin+Mind-320kbps&path=downloads%2Fhigh%2FAyA8ZCFUZwY%2FAyA8ZCFUZwY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLose%2BYour%2BFkin%2BMind-320kbps%26path%3Ddownloads%252Fhigh%252FAyA8ZCFUZwY%252FAyA8ZCFUZwY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Bhootnii Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Love Detox by Punya Selva |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572036/4572036.jpg',
    'https://pagalworldmusic.com/download.php?title=Love+Detox-320kbps&path=downloads%2Fhigh%2FKgkjaxFDeFk%2FKgkjaxFDeFk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLove%2BDetox-320kbps%26path%3Ddownloads%252Fhigh%252FKgkjaxFDeFk%252FKgkjaxFDeFk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Bhootnii Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Shri Rama Rama by Neha Bhalerao |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572036/4572036.jpg',
    'https://pagalworldmusic.com/download.php?title=Shri+Rama+Rama-320kbps&path=downloads%2Fhigh%2FAC0ZSQ1EQUU%2FAC0ZSQ1EQUU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DShri%2BRama%2BRama-320kbps%26path%3Ddownloads%252Fhigh%252FAC0ZSQ1EQUU%252FAC0ZSQ1EQUU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Bhootnii Original Motion Picture Soundtrack' LIMIT 1), 1),
    'Jashn Jashn Manao by Pankaj Saini |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4572036/4572036.jpg',
    'https://pagalworldmusic.com/download.php?title=Jashn+Jashn+Manao-320kbps&path=downloads%2Fhigh%2FQC8lVB5jdVY%2FQC8lVB5jdVY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJashn%2BJashn%2BManao-320kbps%26path%3Ddownloads%252Fhigh%252FQC8lVB5jdVY%252FQC8lVB5jdVY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sankranthiki Vasthunam Hindi' LIMIT 1), 1),
    'Gull Ainaa by Hriday Gattani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571314/4571314.jpg',
    'https://pagalworldmusic.com/download.php?title=Gull+Ainaa-320kbps&path=downloads%2Fhigh%2FRDklRgNnWmE%2FRDklRgNnWmE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGull%2BAinaa-320kbps%26path%3Ddownloads%252Fhigh%252FRDklRgNnWmE%252FRDklRgNnWmE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sankranthiki Vasthunam Hindi' LIMIT 1), 1),
    'Meenu by Pankaj Saini |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571314/4571314.jpg',
    'https://pagalworldmusic.com/download.php?title=Meenu-320kbps&path=downloads%2Fhigh%2FFT4MWUZBf30%2FFT4MWUZBf30.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMeenu-320kbps%26path%3Ddownloads%252Fhigh%252FFT4MWUZBf30%252FFT4MWUZBf30.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sankranthiki Vasthunam Hindi' LIMIT 1), 1),
    'Lallayi Lallayi by Pankaj Saini |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571314/4571314.jpg',
    'https://pagalworldmusic.com/download.php?title=Lallayi+Lallayi-320kbps&path=downloads%2Fhigh%2FFQ5aYxxvVAQ%2FFQ5aYxxvVAQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLallayi%2BLallayi-320kbps%26path%3Ddownloads%252Fhigh%252FFQ5aYxxvVAQ%252FFQ5aYxxvVAQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sankranthiki Vasthunam Hindi' LIMIT 1), 1),
    'The Conflict by Thaman S |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571314/4571314.jpg',
    'https://pagalworldmusic.com/download.php?title=The+Conflict-320kbps&path=downloads%2Fhigh%2FHg86QDh7Rh4%2FHg86QDh7Rh4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThe%2BConflict-320kbps%26path%3Ddownloads%252Fhigh%252FHg86QDh7Rh4%252FHg86QDh7Rh4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sankranthiki Vasthunam Hindi' LIMIT 1), 1),
    'Dhop by Raqueeb Alam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571314/4571314.jpg',
    'https://pagalworldmusic.com/download.php?title=Dhop-320kbps&path=downloads%2Fhigh%2FMTgtfhIEQ1c%2FMTgtfhIEQ1c.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDhop-320kbps%26path%3Ddownloads%252Fhigh%252FMTgtfhIEQ1c%252FMTgtfhIEQ1c.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sankranthiki Vasthunam Hindi' LIMIT 1), 1),
    'Jaana Hairaan Sa by Kausar Munir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571314/4571314.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaana+Hairaan+Sa-320kbps&path=downloads%2Fhigh%2FJy4eBg10XQY%2FJy4eBg10XQY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaana%2BHairaan%2BSa-320kbps%26path%3Ddownloads%252Fhigh%252FJy4eBg10XQY%252FJy4eBg10XQY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Game Changer Hindi' LIMIT 1), 1),
    'Dam Tu Dikhaja by Kumaar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571270/4571270.jpg',
    'https://pagalworldmusic.com/download.php?title=Dam+Tu+Dikhaja-320kbps&path=downloads%2Fhigh%2FMgkaQy4dZlY%2FMgkaQy4dZlY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDam%2BTu%2BDikhaja-320kbps%26path%3Ddownloads%252Fhigh%252FMgkaQy4dZlY%252FMgkaQy4dZlY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Game Changer Hindi' LIMIT 1), 1),
    'Jaragandi by Thaman S |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571270/4571270.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaragandi-320kbps&path=downloads%2Fhigh%2FPy4xeDNVRGA%2FPy4xeDNVRGA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaragandi-320kbps%26path%3Ddownloads%252Fhigh%252FPy4xeDNVRGA%252FPy4xeDNVRGA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Game Changer Hindi' LIMIT 1), 1),
    'Boli Si Surat by Pankaj Saini |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571270/4571270.jpg',
    'https://pagalworldmusic.com/download.php?title=Boli+Si+Surat-320kbps&path=downloads%2Fhigh%2FFzpGZhBlZ1o%2FFzpGZhBlZ1o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBoli%2BSi%2BSurat-320kbps%26path%3Ddownloads%252Fhigh%252FFzpGZhBlZ1o%252FFzpGZhBlZ1o.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Game Changer Hindi' LIMIT 1), 1),
    'Hailessa Hindi by Devi Sri Prasad |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571270/4571270.jpg',
    'https://pagalworldmusic.com/download.php?title=Hailessa+Hindi-320kbps&path=downloads%2Fhigh%2FBgU7dzFVQ3k%2FBgU7dzFVQ3k.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHailessa%2BHindi-320kbps%26path%3Ddownloads%252Fhigh%252FBgU7dzFVQ3k%252FBgU7dzFVQ3k.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Game Changer Hindi' LIMIT 1), 1),
    'Champa Kali by Devi Sri Prasad |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571270/4571270.jpg',
    'https://pagalworldmusic.com/download.php?title=Champa+Kali-320kbps&path=downloads%2Fhigh%2FMRlSeQBRc3k%2FMRlSeQBRc3k.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChampa%2BKali-320kbps%26path%3Ddownloads%252Fhigh%252FMRlSeQBRc3k%252FMRlSeQBRc3k.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Game Changer Hindi' LIMIT 1), 1),
    'Kyun Phir Se by Punya Selva |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571270/4571270.jpg',
    'https://pagalworldmusic.com/download.php?title=Kyun+Phir+Se-320kbps&path=downloads%2Fhigh%2FRiQxQDN8b1k%2FRiQxQDN8b1k.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKyun%2BPhir%2BSe-320kbps%26path%3Ddownloads%252Fhigh%252FRiQxQDN8b1k%252FRiQxQDN8b1k.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thandel Hindi' LIMIT 1), 1),
    'Namo Namah Shivaya Hindi by Devi Sri Prasad |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571025/4571025.jpg',
    'https://pagalworldmusic.com/download.php?title=Namo+Namah+Shivaya+Hindi-320kbps&path=downloads%2Fhigh%2FH1g6XRVdQXg%2FH1g6XRVdQXg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNamo%2BNamah%2BShivaya%2BHindi-320kbps%26path%3Ddownloads%252Fhigh%252FH1g6XRVdQXg%252FH1g6XRVdQXg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thandel Hindi' LIMIT 1), 1),
    'Pink Blue Remix by Tsumyoki |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571025/4571025.jpg',
    'https://pagalworldmusic.com/download.php?title=Pink+Blue+Remix-320kbps&path=downloads%2Fhigh%2FPAMdeB9kVH4%2FPAMdeB9kVH4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPink%2BBlue%2BRemix-320kbps%26path%3Ddownloads%252Fhigh%252FPAMdeB9kVH4%252FPAMdeB9kVH4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thandel Hindi' LIMIT 1), 1),
    'The Attack by Thaman S |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571025/4571025.jpg',
    'https://pagalworldmusic.com/download.php?title=The+Attack-320kbps&path=downloads%2Fhigh%2FEQlfZgUEB2w%2FEQlfZgUEB2w.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThe%2BAttack-320kbps%26path%3Ddownloads%252Fhigh%252FEQlfZgUEB2w%252FEQlfZgUEB2w.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thandel Hindi' LIMIT 1), 1),
    'Iraade by KALAM INK |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571025/4571025.jpg',
    'https://pagalworldmusic.com/download.php?title=Iraade-320kbps&path=downloads%2Fhigh%2FKDoHCBcJc2A%2FKDoHCBcJc2A.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIraade-320kbps%26path%3Ddownloads%252Fhigh%252FKDoHCBcJc2A%252FKDoHCBcJc2A.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Haqeekat by Nazz |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Haqeekat-320kbps&path=downloads%2Fhigh%2FFSENX0VnWUI%2FFSENX0VnWUI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHaqeekat-320kbps%26path%3Ddownloads%252Fhigh%252FFSENX0VnWUI%252FFSENX0VnWUI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'RANJHA by Jaskaran |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=RANJHA-320kbps&path=downloads%2Fhigh%2FAC4tdTNUZAU%2FAC4tdTNUZAU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRANJHA-320kbps%26path%3Ddownloads%252Fhigh%252FAC4tdTNUZAU%252FAC4tdTNUZAU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Yaar by The PropheC |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Yaar-320kbps&path=downloads%2Fhigh%2FIBwRbkNDBlY%2FIBwRbkNDBlY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYaar-320kbps%26path%3Ddownloads%252Fhigh%252FIBwRbkNDBlY%252FIBwRbkNDBlY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Aazaadi Hindi by Devi Sri Prasad |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Aazaadi+Hindi-320kbps&path=downloads%2Fhigh%2FQz8KczB3BlQ%2FQz8KczB3BlQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAazaadi%2BHindi-320kbps%26path%3Ddownloads%252Fhigh%252FQz8KczB3BlQ%252FQz8KczB3BlQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Guruhibhyah by Pankaj Saini |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Guruhibhyah-320kbps&path=downloads%2Fhigh%2FNVAKZyAFDwQ%2FNVAKZyAFDwQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGuruhibhyah-320kbps%26path%3Ddownloads%252Fhigh%252FNVAKZyAFDwQ%252FNVAKZyAFDwQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Yaad by Karan Aujla |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Yaad-320kbps&path=downloads%2Fhigh%2FPF4%2CBzleDno%2FPF4%2CBzleDno.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYaad-320kbps%26path%3Ddownloads%252Fhigh%252FPF4%252CBzleDno%252FPF4%252CBzleDno.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Mere Bina by The PropheC |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Mere+Bina-320kbps&path=downloads%2Fhigh%2FKg9YRBFJdgI%2FKg9YRBFJdgI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMere%2BBina-320kbps%26path%3Ddownloads%252Fhigh%252FKg9YRBFJdgI%252FKg9YRBFJdgI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Dreams by Riar Saab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Dreams-320kbps&path=downloads%2Fhigh%2FJhA9Qx9lfgA%2FJhA9Qx9lfgA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDreams-320kbps%26path%3Ddownloads%252Fhigh%252FJhA9Qx9lfgA%252FJhA9Qx9lfgA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Khalbum Katti by Dabzee |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Khalbum+Katti-320kbps&path=downloads%2Fhigh%2FAiwFfRJ-bmM%2FAiwFfRJ-bmM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKhalbum%2BKatti-320kbps%26path%3Ddownloads%252Fhigh%252FAiwFfRJ-bmM%252FAiwFfRJ-bmM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Olam Up by Dabzee |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Olam+Up-320kbps&path=downloads%2Fhigh%2FPS0iCUd%2CaH8%2FPS0iCUd%2CaH8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DOlam%2BUp-320kbps%26path%3Ddownloads%252Fhigh%252FPS0iCUd%252CaH8%252FPS0iCUd%252CaH8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Sitara by Jonita Gandhi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Sitara-320kbps&path=downloads%2Fhigh%2FF10-ZkACdXc%2FF10-ZkACdXc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSitara-320kbps%26path%3Ddownloads%252Fhigh%252FF10-ZkACdXc%252FF10-ZkACdXc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'KURTA by Jaskaran |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=KURTA-320kbps&path=downloads%2Fhigh%2FNBsuAh4AU3s%2FNBsuAh4AU3s.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKURTA-320kbps%26path%3Ddownloads%252Fhigh%252FNBsuAh4AU3s%252FNBsuAh4AU3s.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Aawara by Zaeden |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Aawara-320kbps&path=downloads%2Fhigh%2FHxE0bixWdGo%2FHxE0bixWdGo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAawara-320kbps%26path%3Ddownloads%252Fhigh%252FHxE0bixWdGo%252FHxE0bixWdGo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'NISHANI by Rishi Roy |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=NISHANI-320kbps&path=downloads%2Fhigh%2FPzs9Bgd5fF0%2FPzs9Bgd5fF0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNISHANI-320kbps%26path%3Ddownloads%252Fhigh%252FPzs9Bgd5fF0%252FPzs9Bgd5fF0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Tareefan by Karan Aujla |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Tareefan-320kbps&path=downloads%2Fhigh%2FAF8HAhxRc0Q%2FAF8HAhxRc0Q.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTareefan-320kbps%26path%3Ddownloads%252Fhigh%252FAF8HAhxRc0Q%252FAF8HAhxRc0Q.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Jaane Na by The PropheC |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaane+Na-320kbps&path=downloads%2Fhigh%2FKl8nfTJdZEA%2FKl8nfTJdZEA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaane%2BNa-320kbps%26path%3Ddownloads%252Fhigh%252FKl8nfTJdZEA%252FKl8nfTJdZEA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Adtaan by Jass Manak |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Adtaan-320kbps&path=downloads%2Fhigh%2FOi0sZRkDflE%2FOi0sZRkDflE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAdtaan-320kbps%26path%3Ddownloads%252Fhigh%252FOi0sZRkDflE%252FOi0sZRkDflE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Naina by Manan Bhardwaj, Anurag Saikia, A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Naina-320kbps&path=downloads%2Fhigh%2FOl9dSxBzTws%2FOl9dSxBzTws.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNaina-320kbps%26path%3Ddownloads%252Fhigh%252FOl9dSxBzTws%252FOl9dSxBzTws.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Bharat by Manan Bhardwaj, Anurag Saikia, A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Bharat-320kbps&path=downloads%2Fhigh%2FHisdXyJTXnk%2FHisdXyJTXnk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBharat-320kbps%26path%3Ddownloads%252Fhigh%252FHisdXyJTXnk%252FHisdXyJTXnk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'LOVE TAPES' LIMIT 1), 1),
    'Ranjha by Raf-Saperra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4571129/4571129.jpg',
    'https://pagalworldmusic.com/download.php?title=Ranjha-320kbps&path=downloads%2Fhigh%2FAl8ZBxFcWlQ%2FAl8ZBxFcWlQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRanjha-320kbps%26path%3Ddownloads%252Fhigh%252FAl8ZBxFcWlQ%252FAl8ZBxFcWlQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Inn Galiyon Mein' LIMIT 1), 1),
    'Mushy Girl by Dr. NITZ, Raman Raghuvanshi, Shafaat Ali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570701/4570701.jpg',
    'https://pagalworldmusic.com/download.php?title=Mushy+Girl-320kbps&path=downloads%2Fhigh%2FQVtSZyxoZ0U%2FQVtSZyxoZ0U.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMushy%2BGirl-320kbps%26path%3Ddownloads%252Fhigh%252FQVtSZyxoZ0U%252FQVtSZyxoZ0U.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Inn Galiyon Mein' LIMIT 1), 1),
    'Ghar by Manan Bhardwaj, Anurag Saikia, A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570701/4570701.jpg',
    'https://pagalworldmusic.com/download.php?title=Ghar-320kbps&path=downloads%2Fhigh%2FRAcBcgxaREA%2FRAcBcgxaREA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGhar-320kbps%26path%3Ddownloads%252Fhigh%252FRAcBcgxaREA%252FRAcBcgxaREA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Inn Galiyon Mein' LIMIT 1), 1),
    'With You by AP Dhillon |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570701/4570701.jpg',
    'https://pagalworldmusic.com/download.php?title=With+You-320kbps&path=downloads%2Fhigh%2FGi0vAjp8eVI%2FGi0vAjp8eVI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DWith%2BYou-320kbps%26path%3Ddownloads%252Fhigh%252FGi0vAjp8eVI%252FGi0vAjp8eVI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Loveyapa' LIMIT 1), 1),
    'Ishq Karo by Dr. NITZ, Raman Raghuvanshi, Shafaat Ali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570667/4570667.jpg',
    'https://pagalworldmusic.com/download.php?title=Ishq+Karo-320kbps&path=downloads%2Fhigh%2FXRocAVlIVX0%2FXRocAVlIVX0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIshq%2BKaro-320kbps%26path%3Ddownloads%252Fhigh%252FXRocAVlIVX0%252FXRocAVlIVX0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Loveyapa' LIMIT 1), 1),
    'Maaf Kar by Dr. NITZ, Raman Raghuvanshi, Shafaat Ali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570667/4570667.jpg',
    'https://pagalworldmusic.com/download.php?title=Maaf+Kar-320kbps&path=downloads%2Fhigh%2FOCsxezp1Dh4%2FOCsxezp1Dh4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMaaf%2BKar-320kbps%26path%3Ddownloads%252Fhigh%252FOCsxezp1Dh4%252FOCsxezp1Dh4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Loveyapa' LIMIT 1), 1),
    'Bela Kali by Dr. NITZ, Raman Raghuvanshi, Shafaat Ali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570667/4570667.jpg',
    'https://pagalworldmusic.com/download.php?title=Bela+Kali-320kbps&path=downloads%2Fhigh%2FLy8FWixnYWE%2FLy8FWixnYWE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBela%2BKali-320kbps%26path%3Ddownloads%252Fhigh%252FLy8FWixnYWE%252FLy8FWixnYWE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Loveyapa' LIMIT 1), 1),
    'Nafarmaniyan by Dr. NITZ, Raman Raghuvanshi, Shafaat Ali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570667/4570667.jpg',
    'https://pagalworldmusic.com/download.php?title=Nafarmaniyan-320kbps&path=downloads%2Fhigh%2FEScKAxxzA2M%2FEScKAxxzA2M.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNafarmaniyan-320kbps%26path%3Ddownloads%252Fhigh%252FEScKAxxzA2M%252FEScKAxxzA2M.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Loveyapa' LIMIT 1), 1),
    'Taaka Taaki by Dr. NITZ, Raman Raghuvanshi, Shafaat Ali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570667/4570667.jpg',
    'https://pagalworldmusic.com/download.php?title=Taaka+Taaki-320kbps&path=downloads%2Fhigh%2FEwpcREVHdX0%2FEwpcREVHdX0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTaaka%2BTaaki-320kbps%26path%3Ddownloads%252Fhigh%252FEwpcREVHdX0%252FEwpcREVHdX0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Loveyapa' LIMIT 1), 1),
    'Shivoham by Dr. NITZ, Raman Raghuvanshi, Shafaat Ali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570667/4570667.jpg',
    'https://pagalworldmusic.com/download.php?title=Shivoham-320kbps&path=downloads%2Fhigh%2FQFEYCA5aZXo%2FQFEYCA5aZXo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DShivoham-320kbps%26path%3Ddownloads%252Fhigh%252FQFEYCA5aZXo%252FQFEYCA5aZXo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Loveyapa' LIMIT 1), 1),
    'Mohobbat Love by Steel Banglez |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570667/4570667.jpg',
    'https://pagalworldmusic.com/download.php?title=Mohobbat+Love-320kbps&path=downloads%2Fhigh%2FAzooZCYBQHw%2FAzooZCYBQHw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMohobbat%2BLove-320kbps%26path%3Ddownloads%252Fhigh%252FAzooZCYBQHw%252FAzooZCYBQHw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Loveyapa' LIMIT 1), 1),
    'Beautiful Sajna by Dr. NITZ, Raman Raghuvanshi, Shafaat Ali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570667/4570667.jpg',
    'https://pagalworldmusic.com/download.php?title=Beautiful+Sajna-320kbps&path=downloads%2Fhigh%2FPQIoUhhncF8%2FPQIoUhhncF8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBeautiful%2BSajna-320kbps%26path%3Ddownloads%252Fhigh%252FPQIoUhhncF8%252FPQIoUhhncF8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Loveyapa' LIMIT 1), 1),
    'Sawariya Ji by Tanishk Bagchi, Vishal Mishra, Sohail Sen |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570667/4570667.jpg',
    'https://pagalworldmusic.com/download.php?title=Sawariya+Ji-320kbps&path=downloads%2Fhigh%2FBwo%2CcCNhDgc%2FBwo%2CcCNhDgc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSawariya%2BJi-320kbps%26path%3Ddownloads%252Fhigh%252FBwo%252CcCNhDgc%252FBwo%252CcCNhDgc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Loveyapa' LIMIT 1), 1),
    'Ikk Vaari by Tanishk Bagchi, Vishal Mishra, Sohail Sen |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570667/4570667.jpg',
    'https://pagalworldmusic.com/download.php?title=Ikk+Vaari-320kbps&path=downloads%2Fhigh%2FFVgZCTd4eWI%2FFVgZCTd4eWI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIkk%2BVaari-320kbps%26path%3Ddownloads%252Fhigh%252FFVgZCTd4eWI%252FFVgZCTd4eWI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crazxy' LIMIT 1), 1),
    'Desi Banda by Dr. NITZ, Raman Raghuvanshi, Shafaat Ali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570454/4570454.jpg',
    'https://pagalworldmusic.com/download.php?title=Desi+Banda-320kbps&path=downloads%2Fhigh%2FAQsNbhNnfwY%2FAQsNbhNnfwY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDesi%2BBanda-320kbps%26path%3Ddownloads%252Fhigh%252FAQsNbhNnfwY%252FAQsNbhNnfwY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crazxy' LIMIT 1), 1),
    'Chann Ve by Vishal Bhardwaj, Manan Bhardwaj, Harshvardhan Rameshwar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570454/4570454.jpg',
    'https://pagalworldmusic.com/download.php?title=Chann+Ve-320kbps&path=downloads%2Fhigh%2FKC4ySEJRVkk%2FKC4ySEJRVkk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChann%2BVe-320kbps%26path%3Ddownloads%252Fhigh%252FKC4ySEJRVkk%252FKC4ySEJRVkk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crazxy' LIMIT 1), 1),
    'Channa Tu Bemisal by Tanishk Bagchi, Vishal Mishra, Sohail Sen |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570454/4570454.jpg',
    'https://pagalworldmusic.com/download.php?title=Channa+Tu+Bemisal-320kbps&path=downloads%2Fhigh%2FCQwgegwHAmw%2FCQwgegwHAmw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChanna%2BTu%2BBemisal-320kbps%26path%3Ddownloads%252Fhigh%252FCQwgegwHAmw%252FCQwgegwHAmw.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crazxy' LIMIT 1), 1),
    'Rabba Mereya by Tanishk Bagchi, Vishal Mishra, Sohail Sen |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570454/4570454.jpg',
    'https://pagalworldmusic.com/download.php?title=Rabba+Mereya-320kbps&path=downloads%2Fhigh%2FJloYWB8EAVU%2FJloYWB8EAVU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRabba%2BMereya-320kbps%26path%3Ddownloads%252Fhigh%252FJloYWB8EAVU%252FJloYWB8EAVU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mere Husband Ki Biwi' LIMIT 1), 1),
    'Paapi 2.0 by Vishal Bhardwaj, Manan Bhardwaj, Harshvardhan Rameshwar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570511/4570511.jpg',
    'https://pagalworldmusic.com/download.php?title=Paapi+2.0-320kbps&path=downloads%2Fhigh%2FSQw6RCB9XFw%2FSQw6RCB9XFw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPaapi%2B2.0-320kbps%26path%3Ddownloads%252Fhigh%252FSQw6RCB9XFw%252FSQw6RCB9XFw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mere Husband Ki Biwi' LIMIT 1), 1),
    'Paapi by Vishal Bhardwaj, Manan Bhardwaj, Harshvardhan Rameshwar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570511/4570511.jpg',
    'https://pagalworldmusic.com/download.php?title=Paapi-320kbps&path=downloads%2Fhigh%2FGCAmexB-TVs%2FGCAmexB-TVs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPaapi-320kbps%26path%3Ddownloads%252Fhigh%252FGCAmexB-TVs%252FGCAmexB-TVs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mere Husband Ki Biwi' LIMIT 1), 1),
    'O Papa by Vishal Bhardwaj, Manan Bhardwaj, Harshvardhan Rameshwar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570511/4570511.jpg',
    'https://pagalworldmusic.com/download.php?title=O+Papa-320kbps&path=downloads%2Fhigh%2FAz0scjoGYkY%2FAz0scjoGYkY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DO%2BPapa-320kbps%26path%3Ddownloads%252Fhigh%252FAz0scjoGYkY%252FAz0scjoGYkY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mere Husband Ki Biwi' LIMIT 1), 1),
    'Yun Hi Chale Gaye by Vishal Bhardwaj, Manan Bhardwaj, Harshvardhan Rameshwar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570511/4570511.jpg',
    'https://pagalworldmusic.com/download.php?title=Yun+Hi+Chale+Gaye-320kbps&path=downloads%2Fhigh%2FHyY5ZSBHDgc%2FHyY5ZSBHDgc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYun%2BHi%2BChale%2BGaye-320kbps%26path%3Ddownloads%252Fhigh%252FHyY5ZSBHDgc%252FHyY5ZSBHDgc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mere Husband Ki Biwi' LIMIT 1), 1),
    'Mitron Maidaan by Vishal Bhardwaj, Manan Bhardwaj, Harshvardhan Rameshwar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570511/4570511.jpg',
    'https://pagalworldmusic.com/download.php?title=Mitron+Maidaan-320kbps&path=downloads%2Fhigh%2FRh4oWwR6flY%2FRh4oWwR6flY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMitron%2BMaidaan-320kbps%26path%3Ddownloads%252Fhigh%252FRh4oWwR6flY%252FRh4oWwR6flY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mere Husband Ki Biwi' LIMIT 1), 1),
    'O Papa (Orchestral) by Vishal Bhardwaj, Manan Bhardwaj, Harshvardhan Rameshwar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570511/4570511.jpg',
    'https://pagalworldmusic.com/download.php?title=O+Papa+%28Orchestral%29-320kbps&path=downloads%2Fhigh%2FGAcPeRNyAF4%2FGAcPeRNyAF4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DO%2BPapa%2B%2528Orchestral%2529-320kbps%26path%3Ddownloads%252Fhigh%252FGAcPeRNyAF4%252FGAcPeRNyAF4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mere Husband Ki Biwi' LIMIT 1), 1),
    'The Crown (From Chhaava) by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570511/4570511.jpg',
    'https://pagalworldmusic.com/download.php?title=The+Crown+%28From+Chhaava%29-320kbps&path=downloads%2Fhigh%2FER0Bd0FoYFo%2FER0Bd0FoYFo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThe%2BCrown%2B%2528From%2BChhaava%2529-320kbps%26path%3Ddownloads%252Fhigh%252FER0Bd0FoYFo%252FER0Bd0FoYFo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mere Husband Ki Biwi' LIMIT 1), 1),
    'Rudra (From Chhaava) by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570511/4570511.jpg',
    'https://pagalworldmusic.com/download.php?title=Rudra+%28From+Chhaava%29-320kbps&path=downloads%2Fhigh%2FPQwmRSJfUVg%2FPQwmRSJfUVg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRudra%2B%2528From%2BChhaava%2529-320kbps%26path%3Ddownloads%252Fhigh%252FPQwmRSJfUVg%252FPQwmRSJfUVg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chhaava' LIMIT 1), 1),
    'The Roar (From Chhaava) by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570389/4570389.jpg',
    'https://pagalworldmusic.com/download.php?title=The+Roar+%28From+Chhaava%29-320kbps&path=downloads%2Fhigh%2FSSAIYRV-VF8%2FSSAIYRV-VF8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThe%2BRoar%2B%2528From%2BChhaava%2529-320kbps%26path%3Ddownloads%252Fhigh%252FSSAIYRV-VF8%252FSSAIYRV-VF8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chhaava' LIMIT 1), 1),
    'Teri Chaahat (From Chhaava) by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570389/4570389.jpg',
    'https://pagalworldmusic.com/download.php?title=Teri+Chaahat+%28From+Chhaava%29-320kbps&path=downloads%2Fhigh%2FQTtSY0ZEZAo%2FQTtSY0ZEZAo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTeri%2BChaahat%2B%2528From%2BChhaava%2529-320kbps%26path%3Ddownloads%252Fhigh%252FQTtSY0ZEZAo%252FQTtSY0ZEZAo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chhaava' LIMIT 1), 1),
    'Aaya Re Toofan (From Chhaava) by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570389/4570389.jpg',
    'https://pagalworldmusic.com/download.php?title=Aaya+Re+Toofan+%28From+Chhaava%29-320kbps&path=downloads%2Fhigh%2FPwVeSANoYGA%2FPwVeSANoYGA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAaya%2BRe%2BToofan%2B%2528From%2BChhaava%2529-320kbps%26path%3Ddownloads%252Fhigh%252FPwVeSANoYGA%252FPwVeSANoYGA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chhaava' LIMIT 1), 1),
    'Jaane Tu (From Chhaava) by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570389/4570389.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaane+Tu+%28From+Chhaava%29-320kbps&path=downloads%2Fhigh%2FRAwAeiFVeQU%2FRAwAeiFVeQU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaane%2BTu%2B%2528From%2BChhaava%2529-320kbps%26path%3Ddownloads%252Fhigh%252FRAwAeiFVeQU%252FRAwAeiFVeQU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chhaava' LIMIT 1), 1),
    'Pul by Vishal Bhardwaj, Manan Bhardwaj, Harshvardhan Rameshwar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570389/4570389.jpg',
    'https://pagalworldmusic.com/download.php?title=Pul-320kbps&path=downloads%2Fhigh%2FGydadSB6Q0c%2FGydadSB6Q0c.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPul-320kbps%26path%3Ddownloads%252Fhigh%252FGydadSB6Q0c%252FGydadSB6Q0c.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chhaava' LIMIT 1), 1),
    'Rang by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570389/4570389.jpg',
    'https://pagalworldmusic.com/download.php?title=Rang-320kbps&path=downloads%2Fhigh%2FQgAFYjFaenw%2FQgAFYjFaenw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRang-320kbps%26path%3Ddownloads%252Fhigh%252FQgAFYjFaenw%252FQgAFYjFaenw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chhaava' LIMIT 1), 1),
    'Mehsoos by Dr. NITZ, Raman Raghuvanshi, Shafaat Ali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570389/4570389.jpg',
    'https://pagalworldmusic.com/download.php?title=Mehsoos-320kbps&path=downloads%2Fhigh%2FKjcRSDVbXWY%2FKjcRSDVbXWY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMehsoos-320kbps%26path%3Ddownloads%252Fhigh%252FKjcRSDVbXWY%252FKjcRSDVbXWY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sky Force' LIMIT 1), 1),
    'Zinda Rahey (From Chhaava) by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570295/4570295.jpg',
    'https://pagalworldmusic.com/download.php?title=Zinda+Rahey+%28From+Chhaava%29-320kbps&path=downloads%2Fhigh%2FJ1w9RCxZbQo%2FJ1w9RCxZbQo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DZinda%2BRahey%2B%2528From%2BChhaava%2529-320kbps%26path%3Ddownloads%252Fhigh%252FJ1w9RCxZbQo%252FJ1w9RCxZbQo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sky Force' LIMIT 1), 1),
    'Maaye by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570295/4570295.jpg',
    'https://pagalworldmusic.com/download.php?title=Maaye-320kbps&path=downloads%2Fhigh%2FI1kAYxwHcQs%2FI1kAYxwHcQs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMaaye-320kbps%26path%3Ddownloads%252Fhigh%252FI1kAYxwHcQs%252FI1kAYxwHcQs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sky Force' LIMIT 1), 1),
    'Kya Meri Yaad Aati Hai by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570295/4570295.jpg',
    'https://pagalworldmusic.com/download.php?title=Kya+Meri+Yaad+Aati+Hai-320kbps&path=downloads%2Fhigh%2FGB0FWENxXWs%2FGB0FWENxXWs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKya%2BMeri%2BYaad%2BAati%2BHai-320kbps%26path%3Ddownloads%252Fhigh%252FGB0FWENxXWs%252FGB0FWENxXWs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sky Force' LIMIT 1), 1),
    'Marco Theme 1 by Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570295/4570295.jpg',
    'https://pagalworldmusic.com/download.php?title=Marco+Theme+1-320kbps&path=downloads%2Fhigh%2FN1oYfCtScX8%2FN1oYfCtScX8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMarco%2BTheme%2B1-320kbps%26path%3Ddownloads%252Fhigh%252FN1oYfCtScX8%252FN1oYfCtScX8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sky Force' LIMIT 1), 1),
    'Marco Teaser Theme by Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4570295/4570295.jpg',
    'https://pagalworldmusic.com/download.php?title=Marco+Teaser+Theme-320kbps&path=downloads%2Fhigh%2FHTkACRdeTUM%2FHTkACRdeTUM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMarco%2BTeaser%2BTheme-320kbps%26path%3Ddownloads%252Fhigh%252FHTkACRdeTUM%252FHTkACRdeTUM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Fateh' LIMIT 1), 1),
    'Teri Banga Ri Full Version by Padmanabh Gaikwad, Mukul Sharma |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569862/4569862.jpg',
    'https://pagalworldmusic.com/download.php?title=Teri+Banga+Ri+Full+Version-320kbps&path=downloads%2Fhigh%2FPScOAiN9WwY%2FPScOAiN9WwY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTeri%2BBanga%2BRi%2BFull%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FPScOAiN9WwY%252FPScOAiN9WwY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Fateh' LIMIT 1), 1),
    'Tu Hain Toh Main Hoon by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569862/4569862.jpg',
    'https://pagalworldmusic.com/download.php?title=Tu+Hain+Toh+Main+Hoon-320kbps&path=downloads%2Fhigh%2FIi0oXzEBWVo%2FIi0oXzEBWVo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTu%2BHain%2BToh%2BMain%2BHoon-320kbps%26path%3Ddownloads%252Fhigh%252FIi0oXzEBWVo%252FIi0oXzEBWVo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Fateh' LIMIT 1), 1),
    'Rab Ne Kiya Faisala by Padmanabh Gaikwad, Mukul Sharma |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569862/4569862.jpg',
    'https://pagalworldmusic.com/download.php?title=Rab+Ne+Kiya+Faisala-320kbps&path=downloads%2Fhigh%2FGidcaS1jUFY%2FGidcaS1jUFY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRab%2BNe%2BKiya%2BFaisala-320kbps%26path%3Ddownloads%252Fhigh%252FGidcaS1jUFY%252FGidcaS1jUFY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Marco (Hindi) (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Teri Banga Ri Film Version by Padmanabh Gaikwad, Mukul Sharma |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569676/4569676.jpg',
    'https://pagalworldmusic.com/download.php?title=Teri+Banga+Ri+Film+Version-320kbps&path=downloads%2Fhigh%2FEiktZxMJQXE%2FEiktZxMJQXE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTeri%2BBanga%2BRi%2BFilm%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FEiktZxMJQXE%252FEiktZxMJQXE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Marco (Hindi) (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Kaali Mahaa Kaali by Devi Sri Prasad |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569676/4569676.jpg',
    'https://pagalworldmusic.com/download.php?title=Kaali+Mahaa+Kaali-320kbps&path=downloads%2Fhigh%2FNS4vfwNUbnI%2FNS4vfwNUbnI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKaali%2BMahaa%2BKaali-320kbps%26path%3Ddownloads%252Fhigh%252FNS4vfwNUbnI%252FNS4vfwNUbnI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Marco (Hindi) (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Ae Mere Watan Ke Logon by Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569676/4569676.jpg',
    'https://pagalworldmusic.com/download.php?title=Ae+Mere+Watan+Ke+Logon-320kbps&path=downloads%2Fhigh%2FJz8FRkBxWn0%2FJz8FRkBxWn0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAe%2BMere%2BWatan%2BKe%2BLogon-320kbps%26path%3Ddownloads%252Fhigh%252FJz8FRkBxWn0%252FJz8FRkBxWn0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Marco (Hindi) (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Mhara Pranam by Padmanabh Gaikwad, Mukul Sharma |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569676/4569676.jpg',
    'https://pagalworldmusic.com/download.php?title=Mhara+Pranam-320kbps&path=downloads%2Fhigh%2FJxElfUNTdEk%2FJxElfUNTdEk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMhara%2BPranam-320kbps%26path%3Ddownloads%252Fhigh%252FJxElfUNTdEk%252FJxElfUNTdEk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Marco (Hindi) (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Peelings by Devi Sri Prasad |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569676/4569676.jpg',
    'https://pagalworldmusic.com/download.php?title=Peelings-320kbps&path=downloads%2Fhigh%2FCQlbATJqT3s%2FCQlbATJqT3s.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPeelings-320kbps%26path%3Ddownloads%252Fhigh%252FCQlbATJqT3s%252FCQlbATJqT3s.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Marco (Hindi) (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Blood (Hindi) by Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569676/4569676.jpg',
    'https://pagalworldmusic.com/download.php?title=Blood+%28Hindi%29-320kbps&path=downloads%2Fhigh%2FCV1TYyAdcX0%2FCV1TYyAdcX0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBlood%2B%2528Hindi%2529-320kbps%26path%3Ddownloads%252Fhigh%252FCV1TYyAdcX0%252FCV1TYyAdcX0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vanvaas' LIMIT 1), 1),
    'Hardam Hardam by G.V. Prakash Kumar, Sajeev Sarathie |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569670/4569670.jpg',
    'https://pagalworldmusic.com/download.php?title=Hardam+Hardam-320kbps&path=downloads%2Fhigh%2FOSQpUxJgU0Y%2FOSQpUxJgU0Y.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHardam%2BHardam-320kbps%26path%3Ddownloads%252Fhigh%252FOSQpUxJgU0Y%252FOSQpUxJgU0Y.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vanvaas' LIMIT 1), 1),
    'Jaage Jaage by G.V. Prakash Kumar, Sajeev Sarathie |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569670/4569670.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaage+Jaage-320kbps&path=downloads%2Fhigh%2FGFkDc0BpfQc%2FGFkDc0BpfQc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaage%2BJaage-320kbps%26path%3Ddownloads%252Fhigh%252FGFkDc0BpfQc%252FGFkDc0BpfQc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vanvaas' LIMIT 1), 1),
    'Angaaron by Devi Sri Prasad |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569670/4569670.jpg',
    'https://pagalworldmusic.com/download.php?title=Angaaron-320kbps&path=downloads%2Fhigh%2FBxwdYT59cwc%2FBxwdYT59cwc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAngaaron-320kbps%26path%3Ddownloads%252Fhigh%252FBxwdYT59cwc%252FBxwdYT59cwc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vanvaas' LIMIT 1), 1),
    'Amara Samara by G.V. Prakash Kumar, Sajeev Sarathie |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569670/4569670.jpg',
    'https://pagalworldmusic.com/download.php?title=Amara+Samara-320kbps&path=downloads%2Fhigh%2FMQYOZyFFVms%2FMQYOZyFFVms.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAmara%2BSamara-320kbps%26path%3Ddownloads%252Fhigh%252FMQYOZyFFVms%252FMQYOZyFFVms.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vanvaas' LIMIT 1), 1),
    'Kissik by Devi Sri Prasad |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569670/4569670.jpg',
    'https://pagalworldmusic.com/download.php?title=Kissik-320kbps&path=downloads%2Fhigh%2FHFASWgByY0M%2FHFASWgByY0M.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKissik-320kbps%26path%3Ddownloads%252Fhigh%252FHFASWgByY0M%252FHFASWgByY0M.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Rabbit House' LIMIT 1), 1),
    'Pushpa Pushpa by Devi Sri Prasad |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569950/4569950.jpg',
    'https://pagalworldmusic.com/download.php?title=Pushpa+Pushpa-320kbps&path=downloads%2Fhigh%2FPBklXSRzYwE%2FPBklXSRzYwE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPushpa%2BPushpa-320kbps%26path%3Ddownloads%252Fhigh%252FPBklXSRzYwE%252FPBklXSRzYwE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Rabbit House' LIMIT 1), 1),
    'Chand Mera Dil by G.V. Prakash Kumar, Sajeev Sarathie |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569950/4569950.jpg',
    'https://pagalworldmusic.com/download.php?title=Chand+Mera+Dil-320kbps&path=downloads%2Fhigh%2FEhpfQR1dTVo%2FEhpfQR1dTVo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChand%2BMera%2BDil-320kbps%26path%3Ddownloads%252Fhigh%252FEhpfQR1dTVo%252FEhpfQR1dTVo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Rabbit House' LIMIT 1), 1),
    'Hey Soniye by G.V. Prakash Kumar, Sajeev Sarathie |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569950/4569950.jpg',
    'https://pagalworldmusic.com/download.php?title=Hey+Soniye-320kbps&path=downloads%2Fhigh%2FIiEcdyJFTnE%2FIiEcdyJFTnE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHey%2BSoniye-320kbps%26path%3Ddownloads%252Fhigh%252FIiEcdyJFTnE%252FIiEcdyJFTnE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Rabbit House' LIMIT 1), 1),
    'Azadi by G.V. Prakash Kumar, Sajeev Sarathie |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569950/4569950.jpg',
    'https://pagalworldmusic.com/download.php?title=Azadi-320kbps&path=downloads%2Fhigh%2FFg4JAyBhXGQ%2FFg4JAyBhXGQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAzadi-320kbps%26path%3Ddownloads%252Fhigh%252FFg4JAyBhXGQ%252FFg4JAyBhXGQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Rabbit House' LIMIT 1), 1),
    'Sai Pallavis Intro by G.V. Prakash Kumar, Sajeev Sarathie |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569950/4569950.jpg',
    'https://pagalworldmusic.com/download.php?title=Sai+Pallavis+Intro-320kbps&path=downloads%2Fhigh%2FJR4tWyQJQlg%2FJR4tWyQJQlg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSai%2BPallavis%2BIntro-320kbps%26path%3Ddownloads%252Fhigh%252FJR4tWyQJQlg%252FJR4tWyQJQlg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Rabbit House' LIMIT 1), 1),
    'Zindagi Tujhse by Arafat Mehmood |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569950/4569950.jpg',
    'https://pagalworldmusic.com/download.php?title=Zindagi+Tujhse-320kbps&path=downloads%2Fhigh%2FHA8HUht4ZgI%2FHA8HUht4ZgI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DZindagi%2BTujhse-320kbps%26path%3Ddownloads%252Fhigh%252FHA8HUht4ZgI%252FHA8HUht4ZgI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Rabbit House' LIMIT 1), 1),
    'Ye Bikhra Hai Saaman by Padmanabh Gaikwad, Mukul Sharma |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569950/4569950.jpg',
    'https://pagalworldmusic.com/download.php?title=Ye+Bikhra+Hai+Saaman-320kbps&path=downloads%2Fhigh%2FOikZeRZ4cVA%2FOikZeRZ4cVA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYe%2BBikhra%2BHai%2BSaaman-320kbps%26path%3Ddownloads%252Fhigh%252FOikZeRZ4cVA%252FOikZeRZ4cVA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Rabbit House' LIMIT 1), 1),
    'Loot Le Tu by Arafat Mehmood |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569950/4569950.jpg',
    'https://pagalworldmusic.com/download.php?title=Loot+Le+Tu-320kbps&path=downloads%2Fhigh%2FGyYSXCtdcwU%2FGyYSXCtdcwU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLoot%2BLe%2BTu-320kbps%26path%3Ddownloads%252Fhigh%252FGyYSXCtdcwU%252FGyYSXCtdcwU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Pushpa 2 The Rule' LIMIT 1), 1),
    'Teri Banga Ri Climax Version by Padmanabh Gaikwad, Mukul Sharma |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569338/4569338.jpg',
    'https://pagalworldmusic.com/download.php?title=Teri+Banga+Ri+Climax+Version-320kbps&path=downloads%2Fhigh%2FHC4iYj5AcGc%2FHC4iYj5AcGc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTeri%2BBanga%2BRi%2BClimax%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FHC4iYj5AcGc%252FHC4iYj5AcGc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Pushpa 2 The Rule' LIMIT 1), 1),
    'Jism Mein Tere by Arafat Mehmood |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569338/4569338.jpg',
    'https://pagalworldmusic.com/download.php?title=Jism+Mein+Tere-320kbps&path=downloads%2Fhigh%2FOF8EU0RbaAQ%2FOF8EU0RbaAQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJism%2BMein%2BTere-320kbps%26path%3Ddownloads%252Fhigh%252FOF8EU0RbaAQ%252FOF8EU0RbaAQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Pushpa 2 The Rule' LIMIT 1), 1),
    'Musafir by Taba Chake |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569338/4569338.jpg',
    'https://pagalworldmusic.com/download.php?title=Musafir-320kbps&path=downloads%2Fhigh%2FPzkBaRMHYlY%2FPzkBaRMHYlY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMusafir-320kbps%26path%3Ddownloads%252Fhigh%252FPzkBaRMHYlY%252FPzkBaRMHYlY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Sabarmati Report' LIMIT 1), 1),
    'Gum Ho Kahan by Taba Chake |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569277/4569277.jpg',
    'https://pagalworldmusic.com/download.php?title=Gum+Ho+Kahan-320kbps&path=downloads%2Fhigh%2FFllGd0AHQXc%2FFllGd0AHQXc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGum%2BHo%2BKahan-320kbps%26path%3Ddownloads%252Fhigh%252FFllGd0AHQXc%252FFllGd0AHQXc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Sabarmati Report' LIMIT 1), 1),
    'Dil Ghabraye by Taba Chake |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569277/4569277.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Ghabraye-320kbps&path=downloads%2Fhigh%2FHA0mADJ6cmc%2FHA0mADJ6cmc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BGhabraye-320kbps%26path%3Ddownloads%252Fhigh%252FHA0mADJ6cmc%252FHA0mADJ6cmc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Sabarmati Report' LIMIT 1), 1),
    'Nazrein Samundar by Mohit Chauhan, Ayush Anand, Sara Khan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569277/4569277.jpg',
    'https://pagalworldmusic.com/download.php?title=Nazrein+Samundar-320kbps&path=downloads%2Fhigh%2FAh8aXjhTT3k%2FAh8aXjhTT3k.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNazrein%2BSamundar-320kbps%26path%3Ddownloads%252Fhigh%252FAh8aXjhTT3k%252FAh8aXjhTT3k.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Sabarmati Report' LIMIT 1), 1),
    'Manzil Ki Ore by Taba Chake |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569277/4569277.jpg',
    'https://pagalworldmusic.com/download.php?title=Manzil+Ki+Ore-320kbps&path=downloads%2Fhigh%2FJjoNRBt1QwM%2FJjoNRBt1QwM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DManzil%2BKi%2BOre-320kbps%26path%3Ddownloads%252Fhigh%252FJjoNRBt1QwM%252FJjoNRBt1QwM.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Sabarmati Report' LIMIT 1), 1),
    'Mann Re Mann Re by G.V. Prakash Kumar, Sajeev Sarathie |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569277/4569277.jpg',
    'https://pagalworldmusic.com/download.php?title=Mann+Re+Mann+Re-320kbps&path=downloads%2Fhigh%2FNlodeTdmRwQ%2FNlodeTdmRwQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMann%2BRe%2BMann%2BRe-320kbps%26path%3Ddownloads%252Fhigh%252FNlodeTdmRwQ%252FNlodeTdmRwQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Choices' LIMIT 1), 1),
    'Pal Yeh Mere by Taba Chake |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569281/4569281.jpg',
    'https://pagalworldmusic.com/download.php?title=Pal+Yeh+Mere-320kbps&path=downloads%2Fhigh%2FSCAcVkdAbVQ%2FSCAcVkdAbVQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPal%2BYeh%2BMere-320kbps%26path%3Ddownloads%252Fhigh%252FSCAcVkdAbVQ%252FSCAcVkdAbVQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Choices' LIMIT 1), 1),
    'Choices Title Track by Mohit Chauhan, Ayush Anand, Sara Khan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569281/4569281.jpg',
    'https://pagalworldmusic.com/download.php?title=Choices+Title+Track-320kbps&path=downloads%2Fhigh%2FMT1YdCZ9R1s%2FMT1YdCZ9R1s.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChoices%2BTitle%2BTrack-320kbps%26path%3Ddownloads%252Fhigh%252FMT1YdCZ9R1s%252FMT1YdCZ9R1s.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Choices' LIMIT 1), 1),
    'Choices Title Track Reprise by Mohit Chauhan, Ayush Anand, Sara Khan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569281/4569281.jpg',
    'https://pagalworldmusic.com/download.php?title=Choices+Title+Track+Reprise-320kbps&path=downloads%2Fhigh%2FGR4%2CQjlofFw%2FGR4%2CQjlofFw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChoices%2BTitle%2BTrack%2BReprise-320kbps%26path%3Ddownloads%252Fhigh%252FGR4%252CQjlofFw%252FGR4%252CQjlofFw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Choices' LIMIT 1), 1),
    'Lady Singham by Ravi Basrur, Thaman S, Swanand Kirkire |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569281/4569281.jpg',
    'https://pagalworldmusic.com/download.php?title=Lady+Singham-320kbps&path=downloads%2Fhigh%2FQwsyVEVIYWs%2FQwsyVEVIYWs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLady%2BSingham-320kbps%26path%3Ddownloads%252Fhigh%252FQwsyVEVIYWs%252FQwsyVEVIYWs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'I Want To Talk (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Yeh Choice Hai Meri by Mohit Chauhan, Ayush Anand, Sara Khan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569156/4569156.jpg',
    'https://pagalworldmusic.com/download.php?title=Yeh+Choice+Hai+Meri-320kbps&path=downloads%2Fhigh%2FRwpTWz0Gc10%2FRwpTWz0Gc10.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYeh%2BChoice%2BHai%2BMeri-320kbps%26path%3Ddownloads%252Fhigh%252FRwpTWz0Gc10%252FRwpTWz0Gc10.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'I Want To Talk (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Sun Mere Bhai by Amaal Mallik, Tanishk Bagchi, R.D. Burman, Zain Desai |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569156/4569156.jpg',
    'https://pagalworldmusic.com/download.php?title=Sun+Mere+Bhai-320kbps&path=downloads%2Fhigh%2FOxw0fSRGT1g%2FOxw0fSRGT1g.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSun%2BMere%2BBhai-320kbps%26path%3Ddownloads%252Fhigh%252FOxw0fSRGT1g%252FOxw0fSRGT1g.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'I Want To Talk (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Maiyya by Sachet-Parampara, Tanishk Bagchi, Khan Muhammad |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569156/4569156.jpg',
    'https://pagalworldmusic.com/download.php?title=Maiyya-320kbps&path=downloads%2Fhigh%2FNAdaYE1DY1o%2FNAdaYE1DY1o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMaiyya-320kbps%26path%3Ddownloads%252Fhigh%252FNAdaYE1DY1o%252FNAdaYE1DY1o.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Singham Again' LIMIT 1), 1),
    'Jai Bajrangbali by Ravi Basrur, Thaman S, Swanand Kirkire |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569126/4569126.jpg',
    'https://pagalworldmusic.com/download.php?title=Jai+Bajrangbali-320kbps&path=downloads%2Fhigh%2FHloGYSF5VFA%2FHloGYSF5VFA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJai%2BBajrangbali-320kbps%26path%3Ddownloads%252Fhigh%252FHloGYSF5VFA%252FHloGYSF5VFA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Singham Again' LIMIT 1), 1),
    'Pyaar Bhi Jhootha by Amaal Mallik, Tanishk Bagchi, R.D. Burman, Zain Desai |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569126/4569126.jpg',
    'https://pagalworldmusic.com/download.php?title=Pyaar+Bhi+Jhootha-320kbps&path=downloads%2Fhigh%2FFRgbASsHDks%2FFRgbASsHDks.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPyaar%2BBhi%2BJhootha-320kbps%26path%3Ddownloads%252Fhigh%252FFRgbASsHDks%252FFRgbASsHDks.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Singham Again' LIMIT 1), 1),
    'Raanjhan by Sachet-Parampara, Tanishk Bagchi, Khan Muhammad |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569126/4569126.jpg',
    'https://pagalworldmusic.com/download.php?title=Raanjhan-320kbps&path=downloads%2Fhigh%2FFz8qYCBZDh4%2FFz8qYCBZDh4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaanjhan-320kbps%26path%3Ddownloads%252Fhigh%252FFz8qYCBZDh4%252FFz8qYCBZDh4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Miranda Brothers' LIMIT 1), 1),
    'Akhiyaan De Kol by Sachet-Parampara, Tanishk Bagchi, Khan Muhammad |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569081/4569081.jpg',
    'https://pagalworldmusic.com/download.php?title=Akhiyaan+De+Kol-320kbps&path=downloads%2Fhigh%2FOQcYVytTeUE%2FOQcYVytTeUE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAkhiyaan%2BDe%2BKol-320kbps%26path%3Ddownloads%252Fhigh%252FOQcYVytTeUE%252FOQcYVytTeUE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Miranda Brothers' LIMIT 1), 1),
    'Hukkush Phukkush by Tanishk Bagchi, Sachet-Parampara, Amaal Mallik |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569081/4569081.jpg',
    'https://pagalworldmusic.com/download.php?title=Hukkush+Phukkush-320kbps&path=downloads%2Fhigh%2FXVwJUBYAAn0%2FXVwJUBYAAn0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHukkush%2BPhukkush-320kbps%26path%3Ddownloads%252Fhigh%252FXVwJUBYAAn0%252FXVwJUBYAAn0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Miranda Brothers' LIMIT 1), 1),
    'Be My Mehbooba by Amaal Mallik, Tanishk Bagchi, R.D. Burman, Zain Desai |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569081/4569081.jpg',
    'https://pagalworldmusic.com/download.php?title=Be+My+Mehbooba-320kbps&path=downloads%2Fhigh%2FCDcRRRFjZwM%2FCDcRRRFjZwM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBe%2BMy%2BMehbooba-320kbps%26path%3Ddownloads%252Fhigh%252FCDcRRRFjZwM%252FCDcRRRFjZwM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Miranda Brothers' LIMIT 1), 1),
    'Beiraada by Tanishk Bagchi, Sachet-Parampara, Amaal Mallik |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569081/4569081.jpg',
    'https://pagalworldmusic.com/download.php?title=Beiraada-320kbps&path=downloads%2Fhigh%2FEwEZdhlddWU%2FEwEZdhlddWU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBeiraada-320kbps%26path%3Ddownloads%252Fhigh%252FEwEZdhlddWU%252FEwEZdhlddWU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Miranda Brothers' LIMIT 1), 1),
    'Jaana Samjho Na by Tanishk Bagchi, Sachet-Parampara, Amaal Mallik |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569081/4569081.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaana+Samjho+Na-320kbps&path=downloads%2Fhigh%2FBVk6VBVcVko%2FBVk6VBVcVko.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaana%2BSamjho%2BNa-320kbps%26path%3Ddownloads%252Fhigh%252FBVk6VBVcVko%252FBVk6VBVcVko.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Do Patti' LIMIT 1), 1),
    'Bhool Bhulaiyaa 3 - Title Track by Tanishk Bagchi, Sachet-Parampara, Amaal Mallik |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569076/4569076.jpg',
    'https://pagalworldmusic.com/download.php?title=Bhool+Bhulaiyaa+3+-+Title+Track-320kbps&path=downloads%2Fhigh%2FNCcyVThTTVA%2FNCcyVThTTVA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBhool%2BBhulaiyaa%2B3%2B-%2BTitle%2BTrack-320kbps%26path%3Ddownloads%252Fhigh%252FNCcyVThTTVA%252FNCcyVThTTVA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Do Patti' LIMIT 1), 1),
    'Jaadu by Sachet-Parampara, Tanishk Bagchi, Khan Muhammad |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569076/4569076.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaadu-320kbps&path=downloads%2Fhigh%2FPFEoZ0NZf3o%2FPFEoZ0NZf3o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaadu-320kbps%26path%3Ddownloads%252Fhigh%252FPFEoZ0NZf3o%252FPFEoZ0NZf3o.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Do Patti' LIMIT 1), 1),
    'Ami Je Tomar 3.0 by Tanishk Bagchi, Sachet-Parampara, Amaal Mallik |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569076/4569076.jpg',
    'https://pagalworldmusic.com/download.php?title=Ami+Je+Tomar+3.0-320kbps&path=downloads%2Fhigh%2FASw8Akd-BEo%2FASw8Akd-BEo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAmi%2BJe%2BTomar%2B3.0-320kbps%26path%3Ddownloads%252Fhigh%252FASw8Akd-BEo%252FASw8Akd-BEo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Do Patti' LIMIT 1), 1),
    'Thaaein Thaaein by Sachet-Parampara, Tanishk Bagchi, Khan Muhammad |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569076/4569076.jpg',
    'https://pagalworldmusic.com/download.php?title=Thaaein+Thaaein-320kbps&path=downloads%2Fhigh%2FHi0KdBNUf2I%2FHi0KdBNUf2I.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThaaein%2BThaaein-320kbps%26path%3Ddownloads%252Fhigh%252FHi0KdBNUf2I%252FHi0KdBNUf2I.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Do Patti' LIMIT 1), 1),
    'Singham Again Title Track by Ravi Basrur, Thaman S, Swanand Kirkire |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569076/4569076.jpg',
    'https://pagalworldmusic.com/download.php?title=Singham+Again+Title+Track-320kbps&path=downloads%2Fhigh%2FOgIZfBlYX3Y%2FOgIZfBlYX3Y.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSingham%2BAgain%2BTitle%2BTrack-320kbps%26path%3Ddownloads%252Fhigh%252FOgIZfBlYX3Y%252FOgIZfBlYX3Y.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bhool Bhulaiyaa 3' LIMIT 1), 1),
    'Kuch Tumhare (Male Version) by Vishal Mishra, Lalit Pandit |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569041/4569041.jpg',
    'https://pagalworldmusic.com/download.php?title=Kuch+Tumhare+%28Male+Version%29-320kbps&path=downloads%2Fhigh%2FRBkRAzBVA0s%2FRBkRAzBVA0s.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKuch%2BTumhare%2B%2528Male%2BVersion%2529-320kbps%26path%3Ddownloads%252Fhigh%252FRBkRAzBVA0s%252FRBkRAzBVA0s.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bhool Bhulaiyaa 3' LIMIT 1), 1),
    'Ye Kya Alag Sa Lagta Hai by Vishal Mishra, Lalit Pandit |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569041/4569041.jpg',
    'https://pagalworldmusic.com/download.php?title=Ye+Kya+Alag+Sa+Lagta+Hai-320kbps&path=downloads%2Fhigh%2FJSQhfRVRegY%2FJSQhfRVRegY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYe%2BKya%2BAlag%2BSa%2BLagta%2BHai-320kbps%26path%3Ddownloads%252Fhigh%252FJSQhfRVRegY%252FJSQhfRVRegY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bhool Bhulaiyaa 3' LIMIT 1), 1),
    'Zindagi by Vishal Mishra, Lalit Pandit |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569041/4569041.jpg',
    'https://pagalworldmusic.com/download.php?title=Zindagi-320kbps&path=downloads%2Fhigh%2FQyEhcCFYdHE%2FQyEhcCFYdHE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DZindagi-320kbps%26path%3Ddownloads%252Fhigh%252FQyEhcCFYdHE%252FQyEhcCFYdHE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bhool Bhulaiyaa 3' LIMIT 1), 1),
    'Main To Adhura by Prasad S |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569041/4569041.jpg',
    'https://pagalworldmusic.com/download.php?title=Main+To+Adhura-320kbps&path=downloads%2Fhigh%2FNRoyCSdFAX4%2FNRoyCSdFAX4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMain%2BTo%2BAdhura-320kbps%26path%3Ddownloads%252Fhigh%252FNRoyCSdFAX4%252FNRoyCSdFAX4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bhool Bhulaiyaa 3' LIMIT 1), 1),
    'Gabru by Prasad S |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4569041/4569041.jpg',
    'https://pagalworldmusic.com/download.php?title=Gabru-320kbps&path=downloads%2Fhigh%2FSC85WzpAfkQ%2FSC85WzpAfkQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGabru-320kbps%26path%3Ddownloads%252Fhigh%252FSC85WzpAfkQ%252FSC85WzpAfkQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'CTRL' LIMIT 1), 1),
    'Kuch Humare (Female Version) by Vishal Mishra, Lalit Pandit |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568889/4568889.jpg',
    'https://pagalworldmusic.com/download.php?title=Kuch+Humare+%28Female+Version%29-320kbps&path=downloads%2Fhigh%2FHCwjZxtiBFQ%2FHCwjZxtiBFQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKuch%2BHumare%2B%2528Female%2BVersion%2529-320kbps%26path%3Ddownloads%252Fhigh%252FHCwjZxtiBFQ%252FHCwjZxtiBFQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'CTRL' LIMIT 1), 1),
    'Kasturi by Prasad S |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568889/4568889.jpg',
    'https://pagalworldmusic.com/download.php?title=Kasturi-320kbps&path=downloads%2Fhigh%2FCjgkXzhadVE%2FCjgkXzhadVE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKasturi-320kbps%26path%3Ddownloads%252Fhigh%252FCjgkXzhadVE%252FCjgkXzhadVE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'CTRL' LIMIT 1), 1),
    'Cha Chadheya by Prasad S |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568889/4568889.jpg',
    'https://pagalworldmusic.com/download.php?title=Cha+Chadheya-320kbps&path=downloads%2Fhigh%2FNDlZByFqRn4%2FNDlZByFqRn4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DCha%2BChadheya-320kbps%26path%3Ddownloads%252Fhigh%252FNDlZByFqRn4%252FNDlZByFqRn4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'CTRL' LIMIT 1), 1),
    'Jigra Title Track by Achint, Varun Grover |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568889/4568889.jpg',
    'https://pagalworldmusic.com/download.php?title=Jigra+Title+Track-320kbps&path=downloads%2Fhigh%2FMwcadEdaQlU%2FMwcadEdaQlU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJigra%2BTitle%2BTrack-320kbps%26path%3Ddownloads%252Fhigh%252FMwcadEdaQlU%252FMwcadEdaQlU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'CTRL' LIMIT 1), 1),
    'Shake The Body by Vishal Mishra, Lalit Pandit |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568889/4568889.jpg',
    'https://pagalworldmusic.com/download.php?title=Shake+The+Body-320kbps&path=downloads%2Fhigh%2FLwsGWBxfclg%2FLwsGWBxfclg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DShake%2BThe%2BBody-320kbps%26path%3Ddownloads%252Fhigh%252FLwsGWBxfclg%252FLwsGWBxfclg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'CTRL' LIMIT 1), 1),
    'Pan India Area King by Achint, Varun Grover |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568889/4568889.jpg',
    'https://pagalworldmusic.com/download.php?title=Pan+India+Area+King-320kbps&path=downloads%2Fhigh%2FMRIEVkxvYV0%2FMRIEVkxvYV0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPan%2BIndia%2BArea%2BKing-320kbps%26path%3Ddownloads%252Fhigh%252FMRIEVkxvYV0%252FMRIEVkxvYV0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Amar Prem Ki Prem Kahani (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Jigra Acoustic Version by Achint, Varun Grover |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568873/4568873.jpg',
    'https://pagalworldmusic.com/download.php?title=Jigra+Acoustic+Version-320kbps&path=downloads%2Fhigh%2FNh8AWThCVFE%2FNh8AWThCVFE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJigra%2BAcoustic%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FNh8AWThCVFE%252FNh8AWThCVFE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Amar Prem Ki Prem Kahani (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Chaap Tilak by Prasad S |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568873/4568873.jpg',
    'https://pagalworldmusic.com/download.php?title=Chaap+Tilak-320kbps&path=downloads%2Fhigh%2FSVgSWzFpXEs%2FSVgSWzFpXEs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChaap%2BTilak-320kbps%26path%3Ddownloads%252Fhigh%252FSVgSWzFpXEs%252FSVgSWzFpXEs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Amar Prem Ki Prem Kahani (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Phoolon Ka Taaro Ka by Achint, Varun Grover |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568873/4568873.jpg',
    'https://pagalworldmusic.com/download.php?title=Phoolon+Ka+Taaro+Ka-320kbps&path=downloads%2Fhigh%2FAxEDaThJewY%2FAxEDaThJewY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPhoolon%2BKa%2BTaaro%2BKa-320kbps%26path%3Ddownloads%252Fhigh%252FAxEDaThJewY%252FAxEDaThJewY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Amar Prem Ki Prem Kahani (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Chal Kudiye by Achint, Varun Grover |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568873/4568873.jpg',
    'https://pagalworldmusic.com/download.php?title=Chal+Kudiye-320kbps&path=downloads%2Fhigh%2FKQlbSw1vfgQ%2FKQlbSw1vfgQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChal%2BKudiye-320kbps%26path%3Ddownloads%252Fhigh%252FKQlbSw1vfgQ%252FKQlbSw1vfgQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Amar Prem Ki Prem Kahani (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Marjaaneya III by Various Artists, Sachin-Jigar, Priya Saraiya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568873/4568873.jpg',
    'https://pagalworldmusic.com/download.php?title=Marjaaneya+III-320kbps&path=downloads%2Fhigh%2FPwEGaUNcblw%2FPwEGaUNcblw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMarjaaneya%2BIII-320kbps%26path%3Ddownloads%252Fhigh%252FPwEGaUNcblw%252FPwEGaUNcblw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Amar Prem Ki Prem Kahani (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Jiya by Achint, Varun Grover |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568873/4568873.jpg',
    'https://pagalworldmusic.com/download.php?title=Jiya-320kbps&path=downloads%2Fhigh%2FIF4gbjMCBgs%2FIF4gbjMCBgs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJiya-320kbps%26path%3Ddownloads%252Fhigh%252FIF4gbjMCBgs%252FIF4gbjMCBgs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Amar Prem Ki Prem Kahani (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Tenu Sang Rakhna by Achint, Varun Grover |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568873/4568873.jpg',
    'https://pagalworldmusic.com/download.php?title=Tenu+Sang+Rakhna-320kbps&path=downloads%2Fhigh%2FI10qVBhIY0E%2FI10qVBhIY0E.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTenu%2BSang%2BRakhna-320kbps%26path%3Ddownloads%252Fhigh%252FI10qVBhIY0E%252FI10qVBhIY0E.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jigra' LIMIT 1), 1),
    'Marjaaneya II by Various Artists, Sachin-Jigar, Priya Saraiya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568866/4568866.jpg',
    'https://pagalworldmusic.com/download.php?title=Marjaaneya+II-320kbps&path=downloads%2Fhigh%2FNjhSXQUJdFU%2FNjhSXQUJdFU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMarjaaneya%2BII-320kbps%26path%3Ddownloads%252Fhigh%252FNjhSXQUJdFU%252FNjhSXQUJdFU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jigra' LIMIT 1), 1),
    'Tumhe Apna Banane Ki (90S Revisited) by Various Artists, Sachin-Jigar, Priya Saraiya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568866/4568866.jpg',
    'https://pagalworldmusic.com/download.php?title=Tumhe+Apna+Banane+Ki+%2890S+Revisited%29-320kbps&path=downloads%2Fhigh%2FGCocZSFjUFA%2FGCocZSFjUFA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTumhe%2BApna%2BBanane%2BKi%2B%252890S%2BRevisited%2529-320kbps%26path%3Ddownloads%252Fhigh%252FGCocZSFjUFA%252FGCocZSFjUFA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jigra' LIMIT 1), 1),
    'CHUMMA by Various Artists, Sachin-Jigar, Priya Saraiya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568866/4568866.jpg',
    'https://pagalworldmusic.com/download.php?title=CHUMMA-320kbps&path=downloads%2Fhigh%2FQzcZfAB5Dlg%2FQzcZfAB5Dlg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DCHUMMA-320kbps%26path%3Ddownloads%252Fhigh%252FQzcZfAB5Dlg%252FQzcZfAB5Dlg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jigra' LIMIT 1), 1),
    'Na Na Na Na Na Re by Various Artists, Sachin-Jigar, Priya Saraiya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568866/4568866.jpg',
    'https://pagalworldmusic.com/download.php?title=Na+Na+Na+Na+Na+Re-320kbps&path=downloads%2Fhigh%2FGBsZHCRiQUY%2FGBsZHCRiQUY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNa%2BNa%2BNa%2BNa%2BNa%2BRe-320kbps%26path%3Ddownloads%252Fhigh%252FGBsZHCRiQUY%252FGBsZHCRiQUY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jigra' LIMIT 1), 1),
    'Marjaaneya by Various Artists, Sachin-Jigar, Priya Saraiya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568866/4568866.jpg',
    'https://pagalworldmusic.com/download.php?title=Marjaaneya-320kbps&path=downloads%2Fhigh%2FKgsmAD5iBWc%2FKgsmAD5iBWc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMarjaaneya-320kbps%26path%3Ddownloads%252Fhigh%252FKgsmAD5iBWc%252FKgsmAD5iBWc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jigra' LIMIT 1), 1),
    'Mere Mehboob by Various Artists, Sachin-Jigar, Priya Saraiya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568866/4568866.jpg',
    'https://pagalworldmusic.com/download.php?title=Mere+Mehboob-320kbps&path=downloads%2Fhigh%2FOgkqHDN4cFU%2FOgkqHDN4cFU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMere%2BMehboob-320kbps%26path%3Ddownloads%252Fhigh%252FOgkqHDN4cFU%252FOgkqHDN4cFU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jigra' LIMIT 1), 1),
    'Dandaka by Arko, Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568866/4568866.jpg',
    'https://pagalworldmusic.com/download.php?title=Dandaka-320kbps&path=downloads%2Fhigh%2FBgYpZUxnGgc%2FBgYpZUxnGgc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDandaka-320kbps%26path%3Ddownloads%252Fhigh%252FBgYpZUxnGgc%252FBgYpZUxnGgc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jigra' LIMIT 1), 1),
    'Maa by Arko, Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568866/4568866.jpg',
    'https://pagalworldmusic.com/download.php?title=Maa-320kbps&path=downloads%2Fhigh%2FISZZehVWfks%2FISZZehVWfks.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMaa-320kbps%26path%3Ddownloads%252Fhigh%252FISZZehVWfks%252FISZZehVWfks.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jigra' LIMIT 1), 1),
    'Sajna Ve Sajna by Various Artists, Sachin-Jigar, Priya Saraiya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568866/4568866.jpg',
    'https://pagalworldmusic.com/download.php?title=Sajna+Ve+Sajna-320kbps&path=downloads%2Fhigh%2FCgMnCBVCBHU%2FCgMnCBVCBHU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSajna%2BVe%2BSajna-320kbps%26path%3Ddownloads%252Fhigh%252FCgMnCBVCBHU%252FCgMnCBVCBHU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Jigra' LIMIT 1), 1),
    'Dheemi Dheemi by Prasad S |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568866/4568866.jpg',
    'https://pagalworldmusic.com/download.php?title=Dheemi+Dheemi-320kbps&path=downloads%2Fhigh%2FIyQyVBFVaEE%2FIyQyVBFVaEE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDheemi%2BDheemi-320kbps%26path%3Ddownloads%252Fhigh%252FIyQyVBFVaEE%252FIyQyVBFVaEE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vicky Vidya Ka Woh Wala Video' LIMIT 1), 1),
    'Mushkil Hai by Various Artists, Sachin-Jigar, Priya Saraiya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568480/4568480.jpg',
    'https://pagalworldmusic.com/download.php?title=Mushkil+Hai-320kbps&path=downloads%2Fhigh%2FJFtZAjEIXl0%2FJFtZAjEIXl0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMushkil%2BHai-320kbps%26path%3Ddownloads%252Fhigh%252FJFtZAjEIXl0%252FJFtZAjEIXl0.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vicky Vidya Ka Woh Wala Video' LIMIT 1), 1),
    'Salma by Arko, Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568480/4568480.jpg',
    'https://pagalworldmusic.com/download.php?title=Salma-320kbps&path=downloads%2Fhigh%2FOhsqeBsERVg%2FOhsqeBsERVg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSalma-320kbps%26path%3Ddownloads%252Fhigh%252FOhsqeBsERVg%252FOhsqeBsERVg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vicky Vidya Ka Woh Wala Video' LIMIT 1), 1),
    'Archana by Arko, Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568480/4568480.jpg',
    'https://pagalworldmusic.com/download.php?title=Archana-320kbps&path=downloads%2Fhigh%2FCVkzch5Iens%2FCVkzch5Iens.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DArchana-320kbps%26path%3Ddownloads%252Fhigh%252FCVkzch5Iens%252FCVkzch5Iens.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vicky Vidya Ka Woh Wala Video' LIMIT 1), 1),
    'Aawargi by Shor |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568480/4568480.jpg',
    'https://pagalworldmusic.com/download.php?title=Aawargi-320kbps&path=downloads%2Fhigh%2FBwoBckNEYUo%2FBwoBckNEYUo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAawargi-320kbps%26path%3Ddownloads%252Fhigh%252FBwoBckNEYUo%252FBwoBckNEYUo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vicky Vidya Ka Woh Wala Video' LIMIT 1), 1),
    'Aho Vikramaarka by Arko, Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568480/4568480.jpg',
    'https://pagalworldmusic.com/download.php?title=Aho+Vikramaarka-320kbps&path=downloads%2Fhigh%2FG14pRUFDVno%2FG14pRUFDVno.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAho%2BVikramaarka-320kbps%26path%3Ddownloads%252Fhigh%252FG14pRUFDVno%252FG14pRUFDVno.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Aho Vikramaarka (Hindi)' LIMIT 1), 1),
    'Teri Oor by Shor |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568475/4568475.jpg',
    'https://pagalworldmusic.com/download.php?title=Teri+Oor-320kbps&path=downloads%2Fhigh%2FIiEzQzp4UWA%2FIiEzQzp4UWA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTeri%2BOor-320kbps%26path%3Ddownloads%252Fhigh%252FIiEzQzp4UWA%252FIiEzQzp4UWA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Aho Vikramaarka (Hindi)' LIMIT 1), 1),
    'Ki Karaan by Shor |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568475/4568475.jpg',
    'https://pagalworldmusic.com/download.php?title=Ki+Karaan-320kbps&path=downloads%2Fhigh%2FBzwsWTpHZGE%2FBzwsWTpHZGE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKi%2BKaraan-320kbps%26path%3Ddownloads%252Fhigh%252FBzwsWTpHZGE%252FBzwsWTpHZGE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Aho Vikramaarka (Hindi)' LIMIT 1), 1),
    'Tum Jo Mile Ho by Various Artists, Sachin-Jigar, Priya Saraiya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568475/4568475.jpg',
    'https://pagalworldmusic.com/download.php?title=Tum+Jo+Mile+Ho-320kbps&path=downloads%2Fhigh%2FIiA7ejtDRXg%2FIiA7ejtDRXg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTum%2BJo%2BMile%2BHo-320kbps%26path%3Ddownloads%252Fhigh%252FIiA7ejtDRXg%252FIiA7ejtDRXg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Aho Vikramaarka (Hindi)' LIMIT 1), 1),
    'Saaya (From Sector 36) by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568475/4568475.jpg',
    'https://pagalworldmusic.com/download.php?title=Saaya+%28From+Sector+36%29-320kbps&path=downloads%2Fhigh%2FCgsvdB9VYgE%2FCgsvdB9VYgE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSaaya%2B%2528From%2BSector%2B36%2529-320kbps%26path%3Ddownloads%252Fhigh%252FCgsvdB9VYgE%252FCgsvdB9VYgE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maaya Ka Moh' LIMIT 1), 1),
    'Mann Kaafira (From Sector 36) by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568471/4568471.jpg',
    'https://pagalworldmusic.com/download.php?title=Mann+Kaafira+%28From+Sector+36%29-320kbps&path=downloads%2Fhigh%2FIAleSD9iTlA%2FIAleSD9iTlA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMann%2BKaafira%2B%2528From%2BSector%2B36%2529-320kbps%26path%3Ddownloads%252Fhigh%252FIAleSD9iTlA%252FIAleSD9iTlA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maaya Ka Moh' LIMIT 1), 1),
    'Ruan (From Sector 36) by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568471/4568471.jpg',
    'https://pagalworldmusic.com/download.php?title=Ruan+%28From+Sector+36%29-320kbps&path=downloads%2Fhigh%2FNAZGVxhaR2k%2FNAZGVxhaR2k.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRuan%2B%2528From%2BSector%2B36%2529-320kbps%26path%3Ddownloads%252Fhigh%252FNAZGVxhaR2k%252FNAZGVxhaR2k.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maaya Ka Moh' LIMIT 1), 1),
    'Ayudha Pooja - Hindi by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568471/4568471.jpg',
    'https://pagalworldmusic.com/download.php?title=Ayudha+Pooja+-+Hindi-320kbps&path=downloads%2Fhigh%2FJSEkVz5dAlc%2FJSEkVz5dAlc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAyudha%2BPooja%2B-%2BHindi-320kbps%26path%3Ddownloads%252Fhigh%252FJSEkVz5dAlc%252FJSEkVz5dAlc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maaya Ka Moh' LIMIT 1), 1),
    'Dumroo (From Sector 36) by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568471/4568471.jpg',
    'https://pagalworldmusic.com/download.php?title=Dumroo+%28From+Sector+36%29-320kbps&path=downloads%2Fhigh%2FSDAeYjpFZFA%2FSDAeYjpFZFA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDumroo%2B%2528From%2BSector%2B36%2529-320kbps%26path%3Ddownloads%252Fhigh%252FSDAeYjpFZFA%252FSDAeYjpFZFA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Devara Part 1 - Hindi' LIMIT 1), 1),
    'Daavudi - Hindi by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568464/4568464.jpg',
    'https://pagalworldmusic.com/download.php?title=Daavudi+-+Hindi-320kbps&path=downloads%2Fhigh%2FIDcKBjhpZH8%2FIDcKBjhpZH8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDaavudi%2B-%2BHindi-320kbps%26path%3Ddownloads%252Fhigh%252FIDcKBjhpZH8%252FIDcKBjhpZH8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Devara Part 1 - Hindi' LIMIT 1), 1),
    'Rang Udaye by Dhvani Bhanushali, Sunidhi Chauhan, Varun Jain |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568464/4568464.jpg',
    'https://pagalworldmusic.com/download.php?title=Rang+Udaye-320kbps&path=downloads%2Fhigh%2FHAMSXRhAfUk%2FHAMSXRhAfUk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRang%2BUdaye-320kbps%26path%3Ddownloads%252Fhigh%252FHAMSXRhAfUk%252FHAMSXRhAfUk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Devara Part 1 - Hindi' LIMIT 1), 1),
    'Fear Song - Hindi by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568464/4568464.jpg',
    'https://pagalworldmusic.com/download.php?title=Fear+Song+-+Hindi-320kbps&path=downloads%2Fhigh%2FJzIMaTNnXkk%2FJzIMaTNnXkk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DFear%2BSong%2B-%2BHindi-320kbps%26path%3Ddownloads%252Fhigh%252FJzIMaTNnXkk%252FJzIMaTNnXkk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Devara Part 1 - Hindi' LIMIT 1), 1),
    'Laapata by Shor |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568464/4568464.jpg',
    'https://pagalworldmusic.com/download.php?title=Laapata-320kbps&path=downloads%2Fhigh%2FIS8cfEFKUkY%2FIS8cfEFKUkY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLaapata-320kbps%26path%3Ddownloads%252Fhigh%252FIS8cfEFKUkY%252FIS8cfEFKUkY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kahan Shuru Kahan Khatam' LIMIT 1), 1),
    'Dheere Dheere by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568460/4568460.jpg',
    'https://pagalworldmusic.com/download.php?title=Dheere+Dheere-320kbps&path=downloads%2Fhigh%2FQFkqZkNoB0M%2FQFkqZkNoB0M.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDheere%2BDheere-320kbps%26path%3Ddownloads%252Fhigh%252FQFkqZkNoB0M%252FQFkqZkNoB0M.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kahan Shuru Kahan Khatam' LIMIT 1), 1),
    'Ishq De Shot by Dhvani Bhanushali, Sunidhi Chauhan, Varun Jain |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568460/4568460.jpg',
    'https://pagalworldmusic.com/download.php?title=Ishq+De+Shot-320kbps&path=downloads%2Fhigh%2FIjkiYDhDUls%2FIjkiYDhDUls.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIshq%2BDe%2BShot-320kbps%26path%3Ddownloads%252Fhigh%252FIjkiYDhDUls%252FIjkiYDhDUls.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kahan Shuru Kahan Khatam' LIMIT 1), 1),
    'Ek Ladki Bheegi Bhagi Si by Dhvani Bhanushali, Sunidhi Chauhan, Varun Jain |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568460/4568460.jpg',
    'https://pagalworldmusic.com/download.php?title=Ek+Ladki+Bheegi+Bhagi+Si-320kbps&path=downloads%2Fhigh%2FHy44c0NVeWQ%2FHy44c0NVeWQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DEk%2BLadki%2BBheegi%2BBhagi%2BSi-320kbps%26path%3Ddownloads%252Fhigh%252FHy44c0NVeWQ%252FHy44c0NVeWQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kahan Shuru Kahan Khatam' LIMIT 1), 1),
    'Kahan Shuru Kahan Khatam Title Track by Dhvani Bhanushali, Sunidhi Chauhan, Varun Jain |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568460/4568460.jpg',
    'https://pagalworldmusic.com/download.php?title=Kahan+Shuru+Kahan+Khatam+Title+Track-320kbps&path=downloads%2Fhigh%2FCAo-BSVCXFQ%2FCAo-BSVCXFQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKahan%2BShuru%2BKahan%2BKhatam%2BTitle%2BTrack-320kbps%26path%3Ddownloads%252Fhigh%252FCAo-BSVCXFQ%252FCAo-BSVCXFQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kahan Shuru Kahan Khatam' LIMIT 1), 1),
    'Spark by Yuvan Shankar Raja |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568460/4568460.jpg',
    'https://pagalworldmusic.com/download.php?title=Spark-320kbps&path=downloads%2Fhigh%2FNRlSQ0RBVmE%2FNRlSQ0RBVmE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSpark-320kbps%26path%3Ddownloads%252Fhigh%252FNRlSQ0RBVmE%252FNRlSQ0RBVmE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kahan Shuru Kahan Khatam' LIMIT 1), 1),
    'Koi To Aae Raah Dikhae by G.V. Prakash Kumar, Raqueeb Alam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568460/4568460.jpg',
    'https://pagalworldmusic.com/download.php?title=Koi+To+Aae+Raah+Dikhae-320kbps&path=downloads%2Fhigh%2FNSUNRDFvWVk%2FNSUNRDFvWVk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKoi%2BTo%2BAae%2BRaah%2BDikhae-320kbps%26path%3Ddownloads%252Fhigh%252FNSUNRDFvWVk%252FNSUNRDFvWVk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thalapathy Is The G.O.A.T.' LIMIT 1), 1),
    'Aaya by Yuvan Shankar Raja |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568396/4568396.jpg',
    'https://pagalworldmusic.com/download.php?title=Aaya-320kbps&path=downloads%2Fhigh%2FHx9aXkdFQlU%2FHx9aXkdFQlU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAaya-320kbps%26path%3Ddownloads%252Fhigh%252FHx9aXkdFQlU%252FHx9aXkdFQlU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thalapathy Is The G.O.A.T.' LIMIT 1), 1),
    'Goron Ne Ki Hai Badi by G.V. Prakash Kumar, Raqueeb Alam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568396/4568396.jpg',
    'https://pagalworldmusic.com/download.php?title=Goron+Ne+Ki+Hai+Badi-128kbps&path=downloads%2Fmedium%2FBDFdXBNDVGw%2FBDFdXBNDVGw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGoron%2BNe%2BKi%2BHai%2BBadi-128kbps%26path%3Ddownloads%252Fmedium%252FBDFdXBNDVGw%252FBDFdXBNDVGw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thalapathy Is The G.O.A.T.' LIMIT 1), 1),
    'Chhoti Chhoti Aankhen by Yuvan Shankar Raja |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568396/4568396.jpg',
    'https://pagalworldmusic.com/download.php?title=Chhoti+Chhoti+Aankhen-320kbps&path=downloads%2Fhigh%2FQyU4UA1vZFc%2FQyU4UA1vZFc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChhoti%2BChhoti%2BAankhen-320kbps%26path%3Ddownloads%252Fhigh%252FQyU4UA1vZFc%252FQyU4UA1vZFc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Thalapathy Is The G.O.A.T.' LIMIT 1), 1),
    'Babu Ki Baby by Dhvani Bhanushali, Sunidhi Chauhan, Varun Jain |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4568396/4568396.jpg',
    'https://pagalworldmusic.com/download.php?title=Babu+Ki+Baby-320kbps&path=downloads%2Fhigh%2FBhxaCExIQVE%2FBhxaCExIQVE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBabu%2BKi%2BBaby-320kbps%26path%3Ddownloads%252Fhigh%252FBhxaCExIQVE%252FBhxaCExIQVE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vedaa' LIMIT 1), 1),
    'Whistle Podu by Yuvan Shankar Raja |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567930/4567930.jpg',
    'https://pagalworldmusic.com/download.php?title=Whistle+Podu-320kbps&path=downloads%2Fhigh%2FMxkgZg5qdgU%2FMxkgZg5qdgU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DWhistle%2BPodu-320kbps%26path%3Ddownloads%252Fhigh%252FMxkgZg5qdgU%252FMxkgZg5qdgU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vedaa' LIMIT 1), 1),
    'Katai Gaana by G.V. Prakash Kumar, Raqueeb Alam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567930/4567930.jpg',
    'https://pagalworldmusic.com/download.php?title=Katai+Gaana-320kbps&path=downloads%2Fhigh%2FHzI5RjlhZmw%2FHzI5RjlhZmw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKatai%2BGaana-320kbps%26path%3Ddownloads%252Fhigh%252FHzI5RjlhZmw%252FHzI5RjlhZmw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vedaa' LIMIT 1), 1),
    'Aayi Nai by Sachin-Jigar, Amitabh Bhattacharya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567930/4567930.jpg',
    'https://pagalworldmusic.com/download.php?title=Aayi+Nai-320kbps&path=downloads%2Fhigh%2FKhssdhViRVw%2FKhssdhViRVw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAayi%2BNai-320kbps%26path%3Ddownloads%252Fhigh%252FKhssdhViRVw%252FKhssdhViRVw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vedaa' LIMIT 1), 1),
    'Khoobsurat by Sachin-Jigar, Amitabh Bhattacharya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567930/4567930.jpg',
    'https://pagalworldmusic.com/download.php?title=Khoobsurat-320kbps&path=downloads%2Fhigh%2FPyQ5BAJRZmM%2FPyQ5BAJRZmM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKhoobsurat-320kbps%26path%3Ddownloads%252Fhigh%252FPyQ5BAJRZmM%252FPyQ5BAJRZmM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Vedaa' LIMIT 1), 1),
    'Thangalaan (War Song) by G.V. Prakash Kumar, Raqueeb Alam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567930/4567930.jpg',
    'https://pagalworldmusic.com/download.php?title=Thangalaan+%28War+Song%29-320kbps&path=downloads%2Fhigh%2FSCJZBR5xWwc%2FSCJZBR5xWwc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThangalaan%2B%2528War%2BSong%2529-320kbps%26path%3Ddownloads%252Fhigh%252FSCJZBR5xWwc%252FSCJZBR5xWwc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Stree 2' LIMIT 1), 1),
    'Tumhare Hi Rahenge Hum by Sachin-Jigar, Amitabh Bhattacharya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567869/4567869.jpg',
    'https://pagalworldmusic.com/download.php?title=Tumhare+Hi+Rahenge+Hum-320kbps&path=downloads%2Fhigh%2FQxpfYytJUn8%2FQxpfYytJUn8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTumhare%2BHi%2BRahenge%2BHum-320kbps%26path%3Ddownloads%252Fhigh%252FQxpfYytJUn8%252FQxpfYytJUn8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Stree 2' LIMIT 1), 1),
    'Baari Barsi by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567869/4567869.jpg',
    'https://pagalworldmusic.com/download.php?title=Baari+Barsi-320kbps&path=downloads%2Fhigh%2FICw%2CdAxccWY%2FICw%2CdAxccWY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBaari%2BBarsi-320kbps%26path%3Ddownloads%252Fhigh%252FICw%252CdAxccWY%252FICw%252CdAxccWY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Stree 2' LIMIT 1), 1),
    'Sehra by Dhvani Bhanushali, Sunidhi Chauhan, Varun Jain |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567869/4567869.jpg',
    'https://pagalworldmusic.com/download.php?title=Sehra-320kbps&path=downloads%2Fhigh%2FAgoYfDh5VWE%2FAgoYfDh5VWE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSehra-320kbps%26path%3Ddownloads%252Fhigh%252FAgoYfDh5VWE%252FAgoYfDh5VWE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Stree 2' LIMIT 1), 1),
    'Aaj Ki Raat by Sachin-Jigar, Amitabh Bhattacharya |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567869/4567869.jpg',
    'https://pagalworldmusic.com/download.php?title=Aaj+Ki+Raat-320kbps&path=downloads%2Fhigh%2FIV4HARUADko%2FIV4HARUADko.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAaj%2BKi%2BRaat-320kbps%26path%3Ddownloads%252Fhigh%252FIV4HARUADko%252FIV4HARUADko.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Khel Khel Mein' LIMIT 1), 1),
    'Do U Know by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567865/4567865.jpg',
    'https://pagalworldmusic.com/download.php?title=Do+U+Know-320kbps&path=downloads%2Fhigh%2FARo%2CaA5Uegs%2FARo%2CaA5Uegs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDo%2BU%2BKnow-320kbps%26path%3Ddownloads%252Fhigh%252FARo%252CaA5Uegs%252FARo%252CaA5Uegs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Khel Khel Mein' LIMIT 1), 1),
    'Chal Ve Dilaa by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567865/4567865.jpg',
    'https://pagalworldmusic.com/download.php?title=Chal+Ve+Dilaa-320kbps&path=downloads%2Fhigh%2FEiYHezNkBVE%2FEiYHezNkBVE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChal%2BVe%2BDilaa-320kbps%26path%3Ddownloads%252Fhigh%252FEiYHezNkBVE%252FEiYHezNkBVE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Khel Khel Mein' LIMIT 1), 1),
    'Hauli Hauli by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567865/4567865.jpg',
    'https://pagalworldmusic.com/download.php?title=Hauli+Hauli-320kbps&path=downloads%2Fhigh%2FPCYeYQxXcHs%2FPCYeYQxXcHs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHauli%2BHauli-320kbps%26path%3Ddownloads%252Fhigh%252FPCYeYQxXcHs%252FPCYeYQxXcHs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Khel Khel Mein' LIMIT 1), 1),
    'Duur Na Karin by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567865/4567865.jpg',
    'https://pagalworldmusic.com/download.php?title=Duur+Na+Karin-320kbps&path=downloads%2Fhigh%2FRV9eBFljRgE%2FRV9eBFljRgE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDuur%2BNa%2BKarin-320kbps%26path%3Ddownloads%252Fhigh%252FRV9eBFljRgE%252FRV9eBFljRgE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Khel Khel Mein' LIMIT 1), 1),
    'Oh Raaya by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567865/4567865.jpg',
    'https://pagalworldmusic.com/download.php?title=Oh+Raaya-320kbps&path=downloads%2Fhigh%2FPjszWBEFBlw%2FPjszWBEFBlw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DOh%2BRaaya-320kbps%26path%3Ddownloads%252Fhigh%252FPjszWBEFBlw%252FPjszWBEFBlw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ghudchadi' LIMIT 1), 1),
    'Raayan Rumble by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567804/4567804.jpg',
    'https://pagalworldmusic.com/download.php?title=Raayan+Rumble-320kbps&path=downloads%2Fhigh%2FRiFYCUJiZnc%2FRiFYCUJiZnc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaayan%2BRumble-320kbps%26path%3Ddownloads%252Fhigh%252FRiFYCUJiZnc%252FRiFYCUJiZnc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ghudchadi' LIMIT 1), 1),
    'MurgaMurgi by G.V. Prakash Kumar, Raqueeb Alam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567804/4567804.jpg',
    'https://pagalworldmusic.com/download.php?title=MurgaMurgi-128kbps&path=downloads%2Fmedium%2FGSYZQwFHYgA%2FGSYZQwFHYgA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMurgaMurgi-128kbps%26path%3Ddownloads%252Fmedium%252FGSYZQwFHYgA%252FGSYZQwFHYgA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ghudchadi' LIMIT 1), 1),
    'Mood Kirkira by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567804/4567804.jpg',
    'https://pagalworldmusic.com/download.php?title=Mood+Kirkira-320kbps&path=downloads%2Fhigh%2FJx8RQQ4FWEY%2FJx8RQQ4FWEY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMood%2BKirkira-320kbps%26path%3Ddownloads%252Fhigh%252FJx8RQQ4FWEY%252FJx8RQQ4FWEY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Phir Aayi Hasseen Dillruba' LIMIT 1), 1),
    'Dil Vasda by Sukhbir, Lijo George-Dj Chetas, Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567493/4567493.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Vasda-320kbps&path=downloads%2Fhigh%2FPyUDAyEFU0I%2FPyUDAyEFU0I.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BVasda-320kbps%26path%3Ddownloads%252Fhigh%252FPyUDAyEFU0I%252FPyUDAyEFU0I.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Phir Aayi Hasseen Dillruba' LIMIT 1), 1),
    'Punjabi Munde by Sukhbir, Lijo George-Dj Chetas, Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567493/4567493.jpg',
    'https://pagalworldmusic.com/download.php?title=Punjabi+Munde-320kbps&path=downloads%2Fhigh%2FBgQ%2CSSFkaFk%2FBgQ%2CSSFkaFk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPunjabi%2BMunde-320kbps%26path%3Ddownloads%252Fhigh%252FBgQ%252CSSFkaFk%252FBgQ%252CSSFkaFk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Phir Aayi Hasseen Dillruba' LIMIT 1), 1),
    'Azaad by Sachet-Parampara, Anurag Saikia |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567493/4567493.jpg',
    'https://pagalworldmusic.com/download.php?title=Azaad-320kbps&path=downloads%2Fhigh%2FFxwyVjx6BHE%2FFxwyVjx6BHE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAzaad-320kbps%26path%3Ddownloads%252Fhigh%252FFxwyVjx6BHE%252FFxwyVjx6BHE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Phir Aayi Hasseen Dillruba' LIMIT 1), 1),
    'Koi Tod Na Iska by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567493/4567493.jpg',
    'https://pagalworldmusic.com/download.php?title=Koi+Tod+Na+Iska-320kbps&path=downloads%2Fhigh%2FHSYnBBtqTn0%2FHSYnBBtqTn0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKoi%2BTod%2BNa%2BIska-320kbps%26path%3Ddownloads%252Fhigh%252FHSYnBBtqTn0%252FHSYnBBtqTn0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Phir Aayi Hasseen Dillruba' LIMIT 1), 1),
    'Kya Haal Hai by Sachet-Parampara, Anurag Saikia |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567493/4567493.jpg',
    'https://pagalworldmusic.com/download.php?title=Kya+Haal+Hai-320kbps&path=downloads%2Fhigh%2FFR4ABkVeQno%2FFR4ABkVeQno.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKya%2BHaal%2BHai-320kbps%26path%3Ddownloads%252Fhigh%252FFR4ABkVeQno%252FFR4ABkVeQno.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ulajh (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Sarvsresth by A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567801/4567801.jpg',
    'https://pagalworldmusic.com/download.php?title=Sarvsresth-320kbps&path=downloads%2Fhigh%2FKTIPWg1ETls%2FKTIPWg1ETls.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSarvsresth-320kbps%26path%3Ddownloads%252Fhigh%252FKTIPWg1ETls%252FKTIPWg1ETls.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ulajh (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Haste Haste by Sachet-Parampara, Anurag Saikia |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567801/4567801.jpg',
    'https://pagalworldmusic.com/download.php?title=Haste+Haste-320kbps&path=downloads%2Fhigh%2FRB06SyV-WAI%2FRB06SyV-WAI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHaste%2BHaste-320kbps%26path%3Ddownloads%252Fhigh%252FRB06SyV-WAI%252FRB06SyV-WAI.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ulajh (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Rote Rote by Sukhbir, Lijo George-Dj Chetas, Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567801/4567801.jpg',
    'https://pagalworldmusic.com/download.php?title=Rote+Rote-320kbps&path=downloads%2Fhigh%2FHSRcSUVCVGY%2FHSRcSUVCVGY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRote%2BRote-320kbps%26path%3Ddownloads%252Fhigh%252FHSRcSUVCVGY%252FHSRcSUVCVGY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tyohaar' LIMIT 1), 1),
    'Raula Raula by Karan Aujla, Vishal Mishra, Abhijeet Srivastava |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567432/4567432.jpg',
    'https://pagalworldmusic.com/download.php?title=Raula+Raula-320kbps&path=downloads%2Fhigh%2FIyASVzUHbgo%2FIyASVzUHbgo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaula%2BRaula-320kbps%26path%3Ddownloads%252Fhigh%252FIyASVzUHbgo%252FIyASVzUHbgo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tyohaar' LIMIT 1), 1),
    'Haule Sajna by Karan Aujla, Vishal Mishra, Abhijeet Srivastava |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567432/4567432.jpg',
    'https://pagalworldmusic.com/download.php?title=Haule+Sajna-320kbps&path=downloads%2Fhigh%2FGwkIAzJeVEk%2FGwkIAzJeVEk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHaule%2BSajna-320kbps%26path%3Ddownloads%252Fhigh%252FGwkIAzJeVEk%252FGwkIAzJeVEk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tyohaar' LIMIT 1), 1),
    'Haule Haule by Karan Aujla, Vishal Mishra, Abhijeet Srivastava |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567432/4567432.jpg',
    'https://pagalworldmusic.com/download.php?title=Haule+Haule-320kbps&path=downloads%2Fhigh%2FO10uBCddDwo%2FO10uBCddDwo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHaule%2BHaule-320kbps%26path%3Ddownloads%252Fhigh%252FO10uBCddDwo%252FO10uBCddDwo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tyohaar' LIMIT 1), 1),
    'Rabb Warga - Neeti Mohan Version by Karan Aujla, Vishal Mishra, Abhijeet Srivastava |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567432/4567432.jpg',
    'https://pagalworldmusic.com/download.php?title=Rabb+Warga+-+Neeti+Mohan+Version-320kbps&path=downloads%2Fhigh%2FQjACQi4EUmU%2FQjACQi4EUmU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRabb%2BWarga%2B-%2BNeeti%2BMohan%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FQjACQi4EUmU%252FQjACQi4EUmU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tyohaar' LIMIT 1), 1),
    'Tauba Tauba by Karan Aujla, Vishal Mishra, Abhijeet Srivastava |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567432/4567432.jpg',
    'https://pagalworldmusic.com/download.php?title=Tauba+Tauba-320kbps&path=downloads%2Fhigh%2FMz4OQDdzblA%2FMz4OQDdzblA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTauba%2BTauba-320kbps%26path%3Ddownloads%252Fhigh%252FMz4OQDdzblA%252FMz4OQDdzblA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tyohaar' LIMIT 1), 1),
    'Hero by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567432/4567432.jpg',
    'https://pagalworldmusic.com/download.php?title=Hero-320kbps&path=downloads%2Fhigh%2FMjdadQQER1Y%2FMjdadQQER1Y.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHero-320kbps%26path%3Ddownloads%252Fhigh%252FMjdadQQER1Y%252FMjdadQQER1Y.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tyohaar' LIMIT 1), 1),
    'Mere Mehboob Mere Sanam by Karan Aujla, Vishal Mishra, Abhijeet Srivastava |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567432/4567432.jpg',
    'https://pagalworldmusic.com/download.php?title=Mere+Mehboob+Mere+Sanam-320kbps&path=downloads%2Fhigh%2FATpcUydbRAo%2FATpcUydbRAo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMere%2BMehboob%2BMere%2BSanam-320kbps%26path%3Ddownloads%252Fhigh%252FATpcUydbRAo%252FATpcUydbRAo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tyohaar' LIMIT 1), 1),
    'Ashwa Vs Ashwa by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567432/4567432.jpg',
    'https://pagalworldmusic.com/download.php?title=Ashwa+Vs+Ashwa-320kbps&path=downloads%2Fhigh%2FHzEHcythR0I%2FHzEHcythR0I.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAshwa%2BVs%2BAshwa-320kbps%26path%3Ddownloads%252Fhigh%252FHzEHcythR0I%252FHzEHcythR0I.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Jaanam by Karan Aujla, Vishal Mishra, Abhijeet Srivastava |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaanam-320kbps&path=downloads%2Fhigh%2FXTslYxV9RWM%2FXTslYxV9RWM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaanam-320kbps%26path%3Ddownloads%252Fhigh%252FXTslYxV9RWM%252FXTslYxV9RWM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Rabb Warga by Karan Aujla, Vishal Mishra, Abhijeet Srivastava |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Rabb+Warga-320kbps&path=downloads%2Fhigh%2FH1EDQh8FBVo%2FH1EDQh8FBVo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRabb%2BWarga-320kbps%26path%3Ddownloads%252Fhigh%252FH1EDQh8FBVo%252FH1EDQh8FBVo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Final Flight by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Final+Flight-320kbps&path=downloads%2Fhigh%2FODlTYi1hZX0%2FODlTYi1hZX0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DFinal%2BFlight-320kbps%26path%3Ddownloads%252Fhigh%252FODlTYi1hZX0%252FODlTYi1hZX0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Shambala by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Shambala-320kbps&path=downloads%2Fhigh%2FESA%2CZUdyemA%2FESA%2CZUdyemA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DShambala-320kbps%26path%3Ddownloads%252Fhigh%252FESA%252CZUdyemA%252FESA%252CZUdyemA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Shambala Rain by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Shambala+Rain-320kbps&path=downloads%2Fhigh%2FCgoSVjpEdFA%2FCgoSVjpEdFA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DShambala%2BRain-320kbps%26path%3Ddownloads%252Fhigh%252FCgoSVjpEdFA%252FCgoSVjpEdFA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Veera Dheera by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Veera+Dheera-320kbps&path=downloads%2Fhigh%2FByIPfRd%2CYGI%2FByIPfRd%2CYGI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DVeera%2BDheera-320kbps%26path%3Ddownloads%252Fhigh%252FByIPfRd%252CYGI%252FByIPfRd%252CYGI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Never Lost a Fight by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Never+Lost+a+Fight-320kbps&path=downloads%2Fhigh%2FJBwCZSxBWkY%2FJBwCZSxBWkY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNever%2BLost%2Ba%2BFight-320kbps%26path%3Ddownloads%252Fhigh%252FJBwCZSxBWkY%252FJBwCZSxBWkY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Lullaby by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Lullaby-320kbps&path=downloads%2Fhigh%2FKV0BVkxiTlY%2FKV0BVkxiTlY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLullaby-320kbps%26path%3Ddownloads%252Fhigh%252FKV0BVkxiTlY%252FKV0BVkxiTlY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Bujji Theme by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Bujji+Theme-320kbps&path=downloads%2Fhigh%2FAC8hBx5%2CGlg%2FAC8hBx5%2CGlg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBujji%2BTheme-320kbps%26path%3Ddownloads%252Fhigh%252FAC8hBx5%252CGlg%252FAC8hBx5%252CGlg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Fist Fight by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Fist+Fight-320kbps&path=downloads%2Fhigh%2FKTgbSRNeAQU%2FKTgbSRNeAQU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DFist%2BFight-320kbps%26path%3Ddownloads%252Fhigh%252FKTgbSRNeAQU%252FKTgbSRNeAQU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Meeting Mother by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Meeting+Mother-320kbps&path=downloads%2Fhigh%2FMlgZA0J-Z1U%2FMlgZA0J-Z1U.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMeeting%2BMother-320kbps%26path%3Ddownloads%252Fhigh%252FMlgZA0J-Z1U%252FMlgZA0J-Z1U.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Where Is My Rent  by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Where+Is+My+Rent+-320kbps&path=downloads%2Fhigh%2FERkFCEBSRX4%2FERkFCEBSRX4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DWhere%2BIs%2BMy%2BRent%2B-320kbps%26path%3Ddownloads%252Fhigh%252FERkFCEBSRX4%252FERkFCEBSRX4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Only Death Wins in War by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Only+Death+Wins+in+War-320kbps&path=downloads%2Fhigh%2FOB4DADgHZn4%2FOB4DADgHZn4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DOnly%2BDeath%2BWins%2Bin%2BWar-320kbps%26path%3Ddownloads%252Fhigh%252FOB4DADgHZn4%252FOB4DADgHZn4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Yashkin by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Yashkin-320kbps&path=downloads%2Fhigh%2FFCozdiF6QWw%2FFCozdiF6QWw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYashkin-320kbps%26path%3Ddownloads%252Fhigh%252FFCozdiF6QWw%252FFCozdiF6QWw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'The Child Within by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=The+Child+Within-320kbps&path=downloads%2Fhigh%2FCAEAAxtlTlU%2FCAEAAxtlTlU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThe%2BChild%2BWithin-320kbps%26path%3Ddownloads%252Fhigh%252FCAEAAxtlTlU%252FCAEAAxtlTlU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Boy From Kasi by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Boy+From+Kasi-320kbps&path=downloads%2Fhigh%2FGgwnUDNxRAM%2FGgwnUDNxRAM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBoy%2BFrom%2BKasi-320kbps%26path%3Ddownloads%252Fhigh%252FGgwnUDNxRAM%252FGgwnUDNxRAM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Jaako Raakhe Saaiyan by Shashwat Sachdev, Vikram Montrose, Haroon-Gavin |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaako+Raakhe+Saaiyan-320kbps&path=downloads%2Fhigh%2FPFoybgJbTWk%2FPFoybgJbTWk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaako%2BRaakhe%2BSaaiyan-320kbps%26path%3Ddownloads%252Fhigh%252FPFoybgJbTWk%252FPFoybgJbTWk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Ashwathama by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Ashwathama-320kbps&path=downloads%2Fhigh%2FJwYoYiBDRXA%2FJwYoYiBDRXA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAshwathama-320kbps%26path%3Ddownloads%252Fhigh%252FJwYoYiBDRXA%252FJwYoYiBDRXA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'The Escape by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=The+Escape-320kbps&path=downloads%2Fhigh%2FHV09QB1HaH4%2FHV09QB1HaH4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThe%2BEscape-320kbps%26path%3Ddownloads%252Fhigh%252FHV09QB1HaH4%252FHV09QB1HaH4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raayan' LIMIT 1), 1),
    'Kyra by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567357/4567357.jpg',
    'https://pagalworldmusic.com/download.php?title=Kyra-320kbps&path=downloads%2Fhigh%2FHVFabk1BYgM%2FHVFabk1BYgM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKyra-320kbps%26path%3Ddownloads%252Fhigh%252FHVFabk1BYgM%252FHVFabk1BYgM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bad Newz' LIMIT 1), 1),
    'Nikat by Shashwat Sachdev, Vikram Montrose, Haroon-Gavin |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567105/4567105.jpg',
    'https://pagalworldmusic.com/download.php?title=Nikat-320kbps&path=downloads%2Fhigh%2FJSoPcyQFZQE%2FJSoPcyQFZQE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNikat-320kbps%26path%3Ddownloads%252Fhigh%252FJSoPcyQFZQE%252FJSoPcyQFZQE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bad Newz' LIMIT 1), 1),
    'Kill (Kaawaa Kaawaa) by Shashwat Sachdev, Vikram Montrose, Haroon-Gavin |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567105/4567105.jpg',
    'https://pagalworldmusic.com/download.php?title=Kill+%28Kaawaa+Kaawaa%29-320kbps&path=downloads%2Fhigh%2FIi4yZERqc3E%2FIi4yZERqc3E.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKill%2B%2528Kaawaa%2BKaawaa%2529-320kbps%26path%3Ddownloads%252Fhigh%252FIi4yZERqc3E%252FIi4yZERqc3E.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bad Newz' LIMIT 1), 1),
    'Thoda Galat by Shashwat Sachdev |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567105/4567105.jpg',
    'https://pagalworldmusic.com/download.php?title=Thoda+Galat-320kbps&path=downloads%2Fhigh%2FHxkDRiUDBnA%2FHxkDRiUDBnA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThoda%2BGalat-320kbps%26path%3Ddownloads%252Fhigh%252FHxkDRiUDBnA%252FHxkDRiUDBnA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kalki 2898 Ad (Hindi)' LIMIT 1), 1),
    'Hey Chintoo by Santhosh Narayanan |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567626/4567626.jpg',
    'https://pagalworldmusic.com/download.php?title=Hey+Chintoo-320kbps&path=downloads%2Fhigh%2FRScHaERDUms%2FRScHaERDUms.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHey%2BChintoo-320kbps%26path%3Ddownloads%252Fhigh%252FRScHaERDUms%252FRScHaERDUms.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kalki 2898 Ad (Hindi)' LIMIT 1), 1),
    'Main Hoon Tera Ae Watan by Shashwat Sachdev |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567626/4567626.jpg',
    'https://pagalworldmusic.com/download.php?title=Main+Hoon+Tera+Ae+Watan-320kbps&path=downloads%2Fhigh%2FOiABRTB%2CUVw%2FOiABRTB%2CUVw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMain%2BHoon%2BTera%2BAe%2BWatan-320kbps%26path%3Ddownloads%252Fhigh%252FOiABRTB%252CUVw%252FOiABRTB%252CUVw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kalki 2898 Ad (Hindi)' LIMIT 1), 1),
    'Jao Ji Jao by Shashwat Sachdev |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567626/4567626.jpg',
    'https://pagalworldmusic.com/download.php?title=Jao+Ji+Jao-320kbps&path=downloads%2Fhigh%2FP1AYQAUBXQI%2FP1AYQAUBXQI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJao%2BJi%2BJao-320kbps%26path%3Ddownloads%252Fhigh%252FP1AYQAUBXQI%252FP1AYQAUBXQI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kalki 2898 Ad (Hindi)' LIMIT 1), 1),
    'Suttebaaz Haseena by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567626/4567626.jpg',
    'https://pagalworldmusic.com/download.php?title=Suttebaaz+Haseena-320kbps&path=downloads%2Fhigh%2FQzIcfUJKAWQ%2FQzIcfUJKAWQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSuttebaaz%2BHaseena-320kbps%26path%3Ddownloads%252Fhigh%252FQzIcfUJKAWQ%252FQzIcfUJKAWQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kalki 2898 Ad (Hindi)' LIMIT 1), 1),
    'Ye Kahani by G.V. Prakash Kumar, Suhit Abhyankar, Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567626/4567626.jpg',
    'https://pagalworldmusic.com/download.php?title=Ye+Kahani-320kbps&path=downloads%2Fhigh%2FQjlScxFDAUU%2FQjlScxFDAUU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYe%2BKahani-320kbps%26path%3Ddownloads%252Fhigh%252FQjlScxFDAUU%252FQjlScxFDAUU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kalki 2898 Ad (Hindi)' LIMIT 1), 1),
    'Husn Irani by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567626/4567626.jpg',
    'https://pagalworldmusic.com/download.php?title=Husn+Irani-320kbps&path=downloads%2Fhigh%2FFT0aVUZfQWU%2FFT0aVUZfQWU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHusn%2BIrani-320kbps%26path%3Ddownloads%252Fhigh%252FFT0aVUZfQWU%252FFT0aVUZfQWU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kill' LIMIT 1), 1),
    'Shaukan by Shashwat Sachdev |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567102/4567102.jpg',
    'https://pagalworldmusic.com/download.php?title=Shaukan-320kbps&path=downloads%2Fhigh%2FP14JXjUGTgU%2FP14JXjUGTgU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DShaukan-320kbps%26path%3Ddownloads%252Fhigh%252FP14JXjUGTgU%252FP14JXjUGTgU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kill' LIMIT 1), 1),
    'Ilahi Mere Rubaroo by Shashwat Sachdev |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567102/4567102.jpg',
    'https://pagalworldmusic.com/download.php?title=Ilahi+Mere+Rubaroo-320kbps&path=downloads%2Fhigh%2FRkUvXgBjVEo%2FRkUvXgBjVEo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIlahi%2BMere%2BRubaroo-320kbps%26path%3Ddownloads%252Fhigh%252FRkUvXgBjVEo%252FRkUvXgBjVEo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kill' LIMIT 1), 1),
    'De Taali by G.V. Prakash Kumar, Suhit Abhyankar, Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567102/4567102.jpg',
    'https://pagalworldmusic.com/download.php?title=De+Taali-320kbps&path=downloads%2Fhigh%2FHgopYhsEcmI%2FHgopYhsEcmI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDe%2BTaali-320kbps%26path%3Ddownloads%252Fhigh%252FHgopYhsEcmI%252FHgopYhsEcmI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kill' LIMIT 1), 1),
    'Aaja Oye by Shashwat Sachdev |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567102/4567102.jpg',
    'https://pagalworldmusic.com/download.php?title=Aaja+Oye-320kbps&path=downloads%2Fhigh%2FRhIAZSNVYmE%2FRhIAZSNVYmE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAaja%2BOye-320kbps%26path%3Ddownloads%252Fhigh%252FRhIAZSNVYmE%252FRhIAZSNVYmE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Wild Wild Punjab' LIMIT 1), 1),
    'I Am Over You by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567098/4567098.jpg',
    'https://pagalworldmusic.com/download.php?title=I+Am+Over+You-320kbps&path=downloads%2Fhigh%2FOSo6BRd9clQ%2FOSo6BRd9clQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DI%2BAm%2BOver%2BYou-320kbps%26path%3Ddownloads%252Fhigh%252FOSo6BRd9clQ%252FOSo6BRd9clQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Wild Wild Punjab' LIMIT 1), 1),
    'Saare Ki by G.V. Prakash Kumar, Suhit Abhyankar, Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567098/4567098.jpg',
    'https://pagalworldmusic.com/download.php?title=Saare+Ki-320kbps&path=downloads%2Fhigh%2FPjA7fyFlDnk%2FPjA7fyFlDnk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSaare%2BKi-320kbps%26path%3Ddownloads%252Fhigh%252FPjA7fyFlDnk%252FPjA7fyFlDnk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Wild Wild Punjab' LIMIT 1), 1),
    'Khudaya by G.V. Prakash Kumar, Suhit Abhyankar, Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567098/4567098.jpg',
    'https://pagalworldmusic.com/download.php?title=Khudaya-320kbps&path=downloads%2Fhigh%2FORIKRRppRmo%2FORIKRRppRmo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKhudaya-320kbps%26path%3Ddownloads%252Fhigh%252FORIKRRppRmo%252FORIKRRppRmo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Wild Wild Punjab' LIMIT 1), 1),
    'Meri Baggi Mera Ghoda by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567098/4567098.jpg',
    'https://pagalworldmusic.com/download.php?title=Meri+Baggi+Mera+Ghoda-320kbps&path=downloads%2Fhigh%2FFlg6aStJZAU%2FFlg6aStJZAU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMeri%2BBaggi%2BMera%2BGhoda-320kbps%26path%3Ddownloads%252Fhigh%252FFlg6aStJZAU%252FFlg6aStJZAU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Wild Wild Punjab' LIMIT 1), 1),
    'Chaawat by G.V. Prakash Kumar, Suhit Abhyankar, Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567098/4567098.jpg',
    'https://pagalworldmusic.com/download.php?title=Chaawat-320kbps&path=downloads%2Fhigh%2FRQIjQyV-UnE%2FRQIjQyV-UnE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChaawat-320kbps%26path%3Ddownloads%252Fhigh%252FRQIjQyV-UnE%252FRQIjQyV-UnE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Wild Wild Punjab' LIMIT 1), 1),
    'The Face-off Theme - Karsan vs Maharaj by Sohail Sen, Sanchit Balhara, Ankit Balhara |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567098/4567098.jpg',
    'https://pagalworldmusic.com/download.php?title=The+Face-off+Theme+-+Karsan+vs+Maharaj-320kbps&path=downloads%2Fhigh%2FKjARfwRFX0Q%2FKjARfwRFX0Q.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThe%2BFace-off%2BTheme%2B-%2BKarsan%2Bvs%2BMaharaj-320kbps%26path%3Ddownloads%252Fhigh%252FKjARfwRFX0Q%252FKjARfwRFX0Q.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Wild Wild Punjab' LIMIT 1), 1),
    'Dewdrops - Virajs Theme by Sohail Sen, Sanchit Balhara, Ankit Balhara |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567098/4567098.jpg',
    'https://pagalworldmusic.com/download.php?title=Dewdrops+-+Virajs+Theme-320kbps&path=downloads%2Fhigh%2FSQVZAx1UVXY%2FSQVZAx1UVXY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDewdrops%2B-%2BVirajs%2BTheme-320kbps%26path%3Ddownloads%252Fhigh%252FSQVZAx1UVXY%252FSQVZAx1UVXY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarfira (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'The Love Ballad Theme by Sohail Sen, Sanchit Balhara, Ankit Balhara |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566965/4566965.jpg',
    'https://pagalworldmusic.com/download.php?title=The+Love+Ballad+Theme-320kbps&path=downloads%2Fhigh%2FQCosZi1hc3A%2FQCosZi1hc3A.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThe%2BLove%2BBallad%2BTheme-320kbps%26path%3Ddownloads%252Fhigh%252FQCosZi1hc3A%252FQCosZi1hc3A.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarfira (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Hiwade Ri Raani by Kapil Jangir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566965/4566965.jpg',
    'https://pagalworldmusic.com/download.php?title=Hiwade+Ri+Raani-320kbps&path=downloads%2Fhigh%2FNgQgWzgHDmU%2FNgQgWzgHDmU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHiwade%2BRi%2BRaani-320kbps%26path%3Ddownloads%252Fhigh%252FNgQgWzgHDmU%252FNgQgWzgHDmU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarfira (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Holi Ke Rang Ma by Sohail Sen, Sanchit Balhara, Ankit Balhara |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566965/4566965.jpg',
    'https://pagalworldmusic.com/download.php?title=Holi+Ke+Rang+Ma-320kbps&path=downloads%2Fhigh%2FKV8xUxsCWwA%2FKV8xUxsCWwA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHoli%2BKe%2BRang%2BMa-320kbps%26path%3Ddownloads%252Fhigh%252FKV8xUxsCWwA%252FKV8xUxsCWwA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarfira (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Achutam Keshavam by Sohail Sen, Sanchit Balhara, Ankit Balhara |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566965/4566965.jpg',
    'https://pagalworldmusic.com/download.php?title=Achutam+Keshavam-320kbps&path=downloads%2Fhigh%2FGC1SWCZ6DkI%2FGC1SWCZ6DkI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAchutam%2BKeshavam-320kbps%26path%3Ddownloads%252Fhigh%252FGC1SWCZ6DkI%252FGC1SWCZ6DkI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarfira (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Haan Ke Haan by Sohail Sen, Sanchit Balhara, Ankit Balhara |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566965/4566965.jpg',
    'https://pagalworldmusic.com/download.php?title=Haan+Ke+Haan-320kbps&path=downloads%2Fhigh%2FQF0eZRFfdlI%2FQF0eZRFfdlI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHaan%2BKe%2BHaan-320kbps%26path%3Ddownloads%252Fhigh%252FQF0eZRFfdlI%252FQF0eZRFfdlI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarfira (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Gurujan by Sohail Sen, Sanchit Balhara, Ankit Balhara |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566965/4566965.jpg',
    'https://pagalworldmusic.com/download.php?title=Gurujan-320kbps&path=downloads%2Fhigh%2FNF4BWz9IZWQ%2FNF4BWz9IZWQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGurujan-320kbps%26path%3Ddownloads%252Fhigh%252FNF4BWz9IZWQ%252FNF4BWz9IZWQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Sarfira (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Dhokha by G.V. Prakash Kumar, Suhit Abhyankar, Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566965/4566965.jpg',
    'https://pagalworldmusic.com/download.php?title=Dhokha-320kbps&path=downloads%2Fhigh%2FEw5dSC1BGkA%2FEw5dSC1BGkA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDhokha-320kbps%26path%3Ddownloads%252Fhigh%252FEw5dSC1BGkA%252FEw5dSC1BGkA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maharaj' LIMIT 1), 1),
    'Rail by Kapil Jangir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567616/4567616.jpg',
    'https://pagalworldmusic.com/download.php?title=Rail-320kbps&path=downloads%2Fhigh%2FRjsgBCEJQmE%2FRjsgBCEJQmE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRail-320kbps%26path%3Ddownloads%252Fhigh%252FRjsgBCEJQmE%252FRjsgBCEJQmE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maharaj' LIMIT 1), 1),
    'Baawari by Kapil Jangir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567616/4567616.jpg',
    'https://pagalworldmusic.com/download.php?title=Baawari-320kbps&path=downloads%2Fhigh%2FQDEGVh8JVFw%2FQDEGVh8JVFw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBaawari-320kbps%26path%3Ddownloads%252Fhigh%252FQDEGVh8JVFw%252FQDEGVh8JVFw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maharaj' LIMIT 1), 1),
    'Maar Udi by G.V. Prakash Kumar, Suhit Abhyankar, Tanishk Bagchi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567616/4567616.jpg',
    'https://pagalworldmusic.com/download.php?title=Maar+Udi-320kbps&path=downloads%2Fhigh%2FKj4MQgRjWGQ%2FKj4MQgRjWGQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMaar%2BUdi-320kbps%26path%3Ddownloads%252Fhigh%252FKj4MQgRjWGQ%252FKj4MQgRjWGQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maharaj' LIMIT 1), 1),
    'Tyohaar by Kapil Jangir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567616/4567616.jpg',
    'https://pagalworldmusic.com/download.php?title=Tyohaar-320kbps&path=downloads%2Fhigh%2FEwMpViFldFU%2FEwMpViFldFU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTyohaar-320kbps%26path%3Ddownloads%252Fhigh%252FEwMpViFldFU%252FEwMpViFldFU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maharaj' LIMIT 1), 1),
    'Kurjal by Kapil Jangir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567616/4567616.jpg',
    'https://pagalworldmusic.com/download.php?title=Kurjal-320kbps&path=downloads%2Fhigh%2FQFE7RxFIdQA%2FQFE7RxFIdQA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKurjal-320kbps%26path%3Ddownloads%252Fhigh%252FQFE7RxFIdQA%252FQFE7RxFIdQA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maharaj' LIMIT 1), 1),
    'Chot Dil Pe Lagi (From Ishq Vishk Rebound) by Rochak Kohli, Badshah, Hiten |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567616/4567616.jpg',
    'https://pagalworldmusic.com/download.php?title=Chot+Dil+Pe+Lagi+%28From+Ishq+Vishk+Rebound%29-320kbps&path=downloads%2Fhigh%2FPwI-SBZhUWE%2FPwI-SBZhUWE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChot%2BDil%2BPe%2BLagi%2B%2528From%2BIshq%2BVishk%2BRebound%2529-320kbps%26path%3Ddownloads%252Fhigh%252FPwI-SBZhUWE%252FPwI-SBZhUWE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maharaj' LIMIT 1), 1),
    'Soni Soni (From Ishq Vishk Rebound) by Rochak Kohli, Badshah, Hiten |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4567616/4567616.jpg',
    'https://pagalworldmusic.com/download.php?title=Soni+Soni+%28From+Ishq+Vishk+Rebound%29-320kbps&path=downloads%2Fhigh%2FGwkqejVdex4%2FGwkqejVdex4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSoni%2BSoni%2B%2528From%2BIshq%2BVishk%2BRebound%2529-320kbps%26path%3Ddownloads%252Fhigh%252FGwkqejVdex4%252FGwkqejVdex4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bhediya' LIMIT 1), 1),
    'Nazar by Kapil Jangir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566872/4566872.jpg',
    'https://pagalworldmusic.com/download.php?title=Nazar-320kbps&path=downloads%2Fhigh%2FAyITCEBiWx4%2FAyITCEBiWx4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNazar-320kbps%26path%3Ddownloads%252Fhigh%252FAyITCEBiWx4%252FAyITCEBiWx4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bhediya' LIMIT 1), 1),
    'Rehmat (Rebound) (Rebound) by Rochak Kohli, Badshah, Hiten |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566872/4566872.jpg',
    'https://pagalworldmusic.com/download.php?title=Rehmat+%28Rebound%29+%28Rebound%29-320kbps&path=downloads%2Fhigh%2FJ0VZazoEZR4%2FJ0VZazoEZR4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRehmat%2B%2528Rebound%2529%2B%2528Rebound%2529-320kbps%26path%3Ddownloads%252Fhigh%252FJ0VZazoEZR4%252FJ0VZazoEZR4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bhediya' LIMIT 1), 1),
    'Jaavi Na by Rochak Kohli, Badshah, Hiten |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566872/4566872.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaavi+Na-320kbps&path=downloads%2Fhigh%2FQyogYDtXfAc%2FQyogYDtXfAc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaavi%2BNa-320kbps%26path%3Ddownloads%252Fhigh%252FQyogYDtXfAc%252FQyogYDtXfAc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bhediya' LIMIT 1), 1),
    'Ishq Vishk Pyaar Vyaar (From Ishq Vishk Rebound) by Rochak Kohli, Badshah, Hiten |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566872/4566872.jpg',
    'https://pagalworldmusic.com/download.php?title=Ishq+Vishk+Pyaar+Vyaar+%28From+Ishq+Vishk+Rebound%29-320kbps&path=downloads%2Fhigh%2FSRpedyJiB2w%2FSRpedyJiB2w.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIshq%2BVishk%2BPyaar%2BVyaar%2B%2528From%2BIshq%2BVishk%2BRebound%2529-320kbps%26path%3Ddownloads%252Fhigh%252FSRpedyJiB2w%252FSRpedyJiB2w.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bhediya' LIMIT 1), 1),
    'Gore Gore Mukhde Pe (From Ishq Vishk Rebound) by Rochak Kohli, Badshah, Hiten |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566872/4566872.jpg',
    'https://pagalworldmusic.com/download.php?title=Gore+Gore+Mukhde+Pe+%28From+Ishq+Vishk+Rebound%29-320kbps&path=downloads%2Fhigh%2FNj9eBENlaB4%2FNj9eBENlaB4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGore%2BGore%2BMukhde%2BPe%2B%2528From%2BIshq%2BVishk%2BRebound%2529-320kbps%26path%3Ddownloads%252Fhigh%252FNj9eBENlaB4%252FNj9eBENlaB4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bhediya' LIMIT 1), 1),
    'Zidd Na Karo by Rochak Kohli, Sohail Rana, Arko, Anurag Saikia |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566872/4566872.jpg',
    'https://pagalworldmusic.com/download.php?title=Zidd+Na+Karo-320kbps&path=downloads%2Fhigh%2FSBFZBzNaW2A%2FSBFZBzNaW2A.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DZidd%2BNa%2BKaro-320kbps%26path%3Ddownloads%252Fhigh%252FSBFZBzNaW2A%252FSBFZBzNaW2A.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bhediya' LIMIT 1), 1),
    'Jogiya by Kapil Jangir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566872/4566872.jpg',
    'https://pagalworldmusic.com/download.php?title=Jogiya-320kbps&path=downloads%2Fhigh%2FOAooXARqAnw%2FOAooXARqAnw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJogiya-320kbps%26path%3Ddownloads%252Fhigh%252FOAooXARqAnw%252FOAooXARqAnw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Munjya' LIMIT 1), 1),
    'Rehmat (From Ishq Vishk Rebound) by Rochak Kohli, Badshah, Hiten |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566550/4566550.jpg',
    'https://pagalworldmusic.com/download.php?title=Rehmat+%28From+Ishq+Vishk+Rebound%29-320kbps&path=downloads%2Fhigh%2FBSw5WRp3fwI%2FBSw5WRp3fwI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRehmat%2B%2528From%2BIshq%2BVishk%2BRebound%2529-320kbps%26path%3Ddownloads%252Fhigh%252FBSw5WRp3fwI%252FBSw5WRp3fwI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Munjya' LIMIT 1), 1),
    'Chota Sa Mann by Rochak Kohli, Sohail Rana, Arko, Anurag Saikia |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566550/4566550.jpg',
    'https://pagalworldmusic.com/download.php?title=Chota+Sa+Mann-320kbps&path=downloads%2Fhigh%2FL1gNXD51YQc%2FL1gNXD51YQc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChota%2BSa%2BMann-320kbps%26path%3Ddownloads%252Fhigh%252FL1gNXD51YQc%252FL1gNXD51YQc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Munjya' LIMIT 1), 1),
    'Dhaage by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566550/4566550.jpg',
    'https://pagalworldmusic.com/download.php?title=Dhaage-320kbps&path=downloads%2Fhigh%2FBzEgfx5RfR4%2FBzEgfx5RfR4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDhaage-320kbps%26path%3Ddownloads%252Fhigh%252FBzEgfx5RfR4%252FBzEgfx5RfR4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Munjya' LIMIT 1), 1),
    'ZagaZaga by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566550/4566550.jpg',
    'https://pagalworldmusic.com/download.php?title=ZagaZaga-320kbps&path=downloads%2Fhigh%2FKiIiAjNxZWM%2FKiIiAjNxZWM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DZagaZaga-320kbps%26path%3Ddownloads%252Fhigh%252FKiIiAjNxZWM%252FKiIiAjNxZWM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chandu Champion' LIMIT 1), 1),
    'Musafir by Rochak Kohli, Sohail Rana, Arko, Anurag Saikia |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566546/4566546.jpg',
    'https://pagalworldmusic.com/download.php?title=Musafir-320kbps&path=downloads%2Fhigh%2FAR0dQRdXTVQ%2FAR0dQRdXTVQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMusafir-320kbps%26path%3Ddownloads%252Fhigh%252FAR0dQRdXTVQ%252FAR0dQRdXTVQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chandu Champion' LIMIT 1), 1),
    'Come Back Indian by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566546/4566546.jpg',
    'https://pagalworldmusic.com/download.php?title=Come+Back+Indian-320kbps&path=downloads%2Fhigh%2FKDoNcB11Xks%2FKDoNcB11Xks.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DCome%2BBack%2BIndian-320kbps%26path%3Ddownloads%252Fhigh%252FKDoNcB11Xks%252FKDoNcB11Xks.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chandu Champion' LIMIT 1), 1),
    'Dada Aara Re by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566546/4566546.jpg',
    'https://pagalworldmusic.com/download.php?title=Dada+Aara+Re-320kbps&path=downloads%2Fhigh%2FGA0uRDFZWmQ%2FGA0uRDFZWmQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDada%2BAara%2BRe-320kbps%26path%3Ddownloads%252Fhigh%252FGA0uRDFZWmQ%252FGA0uRDFZWmQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chandu Champion' LIMIT 1), 1),
    'Dahiya by Prini Siddhant Madhav, Amol-Abhishek, Jaidev Kumar, Sadhu S. Tiwari, Meet Bros, Sandesh Shandilya, A |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566546/4566546.jpg',
    'https://pagalworldmusic.com/download.php?title=Dahiya-320kbps&path=downloads%2Fhigh%2FQFgJWhl5eF4%2FQFgJWhl5eF4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDahiya-320kbps%26path%3Ddownloads%252Fhigh%252FQFgJWhl5eF4%252FQFgJWhl5eF4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chandu Champion' LIMIT 1), 1),
    'Jab Bhi Naachey by Prini Siddhant Madhav, Amol-Abhishek, Jaidev Kumar, Sadhu S. Tiwari, Meet Bros, Sandesh Shandilya, A |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566546/4566546.jpg',
    'https://pagalworldmusic.com/download.php?title=Jab+Bhi+Naachey-320kbps&path=downloads%2Fhigh%2FIzwvWBt%2CWUk%2FIzwvWBt%2CWUk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJab%2BBhi%2BNaachey-320kbps%26path%3Ddownloads%252Fhigh%252FIzwvWBt%252CWUk%252FIzwvWBt%252CWUk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Chandu Champion' LIMIT 1), 1),
    'Dil Samjhdaar by Prini Siddhant Madhav, Amol-Abhishek, Jaidev Kumar, Sadhu S. Tiwari, Meet Bros, Sandesh Shandilya, A |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566546/4566546.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Samjhdaar-320kbps&path=downloads%2Fhigh%2FPi0tARd0ZXY%2FPi0tARd0ZXY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BSamjhdaar-320kbps%26path%3Ddownloads%252Fhigh%252FPi0tARd0ZXY%252FPi0tARd0ZXY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dedh Bigha Zameen' LIMIT 1), 1),
    'Ishq Ki Chhav Tale by Prini Siddhant Madhav, Amol-Abhishek, Jaidev Kumar, Sadhu S. Tiwari, Meet Bros, Sandesh Shandilya, A |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566781/4566781.jpg',
    'https://pagalworldmusic.com/download.php?title=Ishq+Ki+Chhav+Tale-320kbps&path=downloads%2Fhigh%2FQ10dY0EHUWo%2FQ10dY0EHUWo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIshq%2BKi%2BChhav%2BTale-320kbps%26path%3Ddownloads%252Fhigh%252FQ10dY0EHUWo%252FQ10dY0EHUWo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dedh Bigha Zameen' LIMIT 1), 1),
    'Calendar Song by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566781/4566781.jpg',
    'https://pagalworldmusic.com/download.php?title=Calendar+Song-320kbps&path=downloads%2Fhigh%2FQSs%2CXzh9XmY%2FQSs%2CXzh9XmY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DCalendar%2BSong-320kbps%26path%3Ddownloads%252Fhigh%252FQSs%252CXzh9XmY%252FQSs%252CXzh9XmY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dedh Bigha Zameen' LIMIT 1), 1),
    'Bairagi by Prini Siddhant Madhav, Amol-Abhishek, Jaidev Kumar, Sadhu S. Tiwari, Meet Bros, Sandesh Shandilya, A |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566781/4566781.jpg',
    'https://pagalworldmusic.com/download.php?title=Bairagi-320kbps&path=downloads%2Fhigh%2FMxsaBR59cXo%2FMxsaBR59cXo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBairagi-320kbps%26path%3Ddownloads%252Fhigh%252FMxsaBR59cXo%252FMxsaBR59cXo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dedh Bigha Zameen' LIMIT 1), 1),
    'Jaago by Anirudh Ravichander |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566781/4566781.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaago-320kbps&path=downloads%2Fhigh%2FKQYHch9iZAU%2FKQYHch9iZAU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaago-320kbps%26path%3Ddownloads%252Fhigh%252FKQYHch9iZAU%252FKQYHch9iZAU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dedh Bigha Zameen' LIMIT 1), 1),
    'Sarphira Climax Version by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566781/4566781.jpg',
    'https://pagalworldmusic.com/download.php?title=Sarphira+Climax+Version-320kbps&path=downloads%2Fhigh%2FSCxTAB9aQgE%2FSCxTAB9aQgE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSarphira%2BClimax%2BVersion-320kbps%26path%3Ddownloads%252Fhigh%252FSCxTAB9aQgE%252FSCxTAB9aQgE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dedh Bigha Zameen' LIMIT 1), 1),
    'Ghodi by Prini Siddhant Madhav, Amol-Abhishek, Jaidev Kumar, Sadhu S. Tiwari, Meet Bros, Sandesh Shandilya, A |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566781/4566781.jpg',
    'https://pagalworldmusic.com/download.php?title=Ghodi-320kbps&path=downloads%2Fhigh%2FIgwZcxVbZAo%2FIgwZcxVbZAo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGhodi-320kbps%26path%3Ddownloads%252Fhigh%252FIgwZcxVbZAo%252FIgwZcxVbZAo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Hindustani 2 (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Jamoore by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566771/4566771.jpg',
    'https://pagalworldmusic.com/download.php?title=Jamoore-320kbps&path=downloads%2Fhigh%2FNSdSQjxXAEU%2FNSdSQjxXAEU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJamoore-320kbps%26path%3Ddownloads%252Fhigh%252FNSdSQjxXAEU%252FNSdSQjxXAEU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Hindustani 2 (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Jeet Ka Geet by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566771/4566771.jpg',
    'https://pagalworldmusic.com/download.php?title=Jeet+Ka+Geet-320kbps&path=downloads%2Fhigh%2FMwwkQDxfWXo%2FMwwkQDxfWXo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJeet%2BKa%2BGeet-320kbps%26path%3Ddownloads%252Fhigh%252FMwwkQDxfWXo%252FMwwkQDxfWXo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Hindustani 2 (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Sarphira by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566771/4566771.jpg',
    'https://pagalworldmusic.com/download.php?title=Sarphira-320kbps&path=downloads%2Fhigh%2FQDAlRD9SWXE%2FQDAlRD9SWXE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSarphira-320kbps%26path%3Ddownloads%252Fhigh%252FQDAlRD9SWXE%252FQDAlRD9SWXE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Hindustani 2 (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Tu Hai Champion by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566771/4566771.jpg',
    'https://pagalworldmusic.com/download.php?title=Tu+Hai+Champion-320kbps&path=downloads%2Fhigh%2FIkUcVwRKZ0Q%2FIkUcVwRKZ0Q.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTu%2BHai%2BChampion-320kbps%26path%3Ddownloads%252Fhigh%252FIkUcVwRKZ0Q%252FIkUcVwRKZ0Q.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Hindustani 2 (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Musafir (Film Version) by Rochak Kohli, Sohail Rana, Arko, Anurag Saikia |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566771/4566771.jpg',
    'https://pagalworldmusic.com/download.php?title=Musafir+%28Film+Version%29-320kbps&path=downloads%2Fhigh%2FNSwJCS1XTkk%2FNSwJCS1XTkk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMusafir%2B%2528Film%2BVersion%2529-320kbps%26path%3Ddownloads%252Fhigh%252FNSwJCS1XTkk%252FNSwJCS1XTkk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Hindustani 2 (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Satyanaas by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566771/4566771.jpg',
    'https://pagalworldmusic.com/download.php?title=Satyanaas-320kbps&path=downloads%2Fhigh%2FEz1fQAZhWns%2FEz1fQAZhWns.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSatyanaas-320kbps%26path%3Ddownloads%252Fhigh%252FEz1fQAZhWns%252FEz1fQAZhWns.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Hindustani 2 (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Na Door Hai Na Paas Hai by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566771/4566771.jpg',
    'https://pagalworldmusic.com/download.php?title=Na+Door+Hai+Na+Paas+Hai-320kbps&path=downloads%2Fhigh%2FFTdTWUZqXWs%2FFTdTWUZqXWs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNa%2BDoor%2BHai%2BNa%2BPaas%2BHai-320kbps%26path%3Ddownloads%252Fhigh%252FFTdTWUZqXWs%252FFTdTWUZqXWs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Aranmanai 4' LIMIT 1), 1),
    'Maa Durga Maa Kaali by Harmaan Nazim, Tanu Srivasatava, Kushboo Jain, Debanjali B Joshi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566306/4566306.jpg',
    'https://pagalworldmusic.com/download.php?title=Maa+Durga+Maa+Kaali-320kbps&path=downloads%2Fhigh%2FKhEZXRsAGlQ%2FKhEZXRsAGlQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMaa%2BDurga%2BMaa%2BKaali-320kbps%26path%3Ddownloads%252Fhigh%252FKhEZXRsAGlQ%252FKhEZXRsAGlQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Aranmanai 4' LIMIT 1), 1),
    'Jo Jo Jo by Harmaan Nazim, Tanu Srivasatava, Kushboo Jain, Debanjali B Joshi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566306/4566306.jpg',
    'https://pagalworldmusic.com/download.php?title=Jo+Jo+Jo-320kbps&path=downloads%2Fhigh%2FKClTXUFHVno%2FKClTXUFHVno.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJo%2BJo%2BJo-320kbps%26path%3Ddownloads%252Fhigh%252FKClTXUFHVno%252FKClTXUFHVno.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Aranmanai 4' LIMIT 1), 1),
    'Chitralekha by Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566306/4566306.jpg',
    'https://pagalworldmusic.com/download.php?title=Chitralekha-320kbps&path=downloads%2Fhigh%2FJRsxBQx8fGQ%2FJRsxBQx8fGQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChitralekha-320kbps%26path%3Ddownloads%252Fhigh%252FJRsxBQx8fGQ%252FJRsxBQx8fGQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Blackout' LIMIT 1), 1),
    'Paas Tere Main by Vishal Mishra, Piyush Shankar, Arkadeep Karmakar, Javed-Mohsin |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566303/4566303.jpg',
    'https://pagalworldmusic.com/download.php?title=Paas+Tere+Main-320kbps&path=downloads%2Fhigh%2FAiM5dxtmR1U%2FAiM5dxtmR1U.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPaas%2BTere%2BMain-320kbps%26path%3Ddownloads%252Fhigh%252FAiM5dxtmR1U%252FAiM5dxtmR1U.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Blackout' LIMIT 1), 1),
    'Vada Humse Karo (Sad Version) by Vishal Mishra, Piyush Shankar, Arkadeep Karmakar, Javed-Mohsin |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566303/4566303.jpg',
    'https://pagalworldmusic.com/download.php?title=Vada+Humse+Karo+%28Sad+Version%29-320kbps&path=downloads%2Fhigh%2FGD0vZhVBDl4%2FGD0vZhVBDl4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DVada%2BHumse%2BKaro%2B%2528Sad%2BVersion%2529-320kbps%26path%3Ddownloads%252Fhigh%252FGD0vZhVBDl4%252FGD0vZhVBDl4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Blackout' LIMIT 1), 1),
    'Khol Pinjra by Vishal Mishra, Piyush Shankar, Arkadeep Karmakar, Javed-Mohsin |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566303/4566303.jpg',
    'https://pagalworldmusic.com/download.php?title=Khol+Pinjra-320kbps&path=downloads%2Fhigh%2FXQoyARhcXmU%2FXQoyARhcXmU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKhol%2BPinjra-320kbps%26path%3Ddownloads%252Fhigh%252FXQoyARhcXmU%252FXQoyARhcXmU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Savi' LIMIT 1), 1),
    'Vada Humse Karo (Version 2) by Vishal Mishra, Piyush Shankar, Arkadeep Karmakar, Javed-Mohsin |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566300/4566300.jpg',
    'https://pagalworldmusic.com/download.php?title=Vada+Humse+Karo+%28Version+2%29-320kbps&path=downloads%2Fhigh%2FEl4tUyR5X1o%2FEl4tUyR5X1o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DVada%2BHumse%2BKaro%2B%2528Version%2B2%2529-320kbps%26path%3Ddownloads%252Fhigh%252FEl4tUyR5X1o%252FEl4tUyR5X1o.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Savi' LIMIT 1), 1),
    'Vada Humse Karo by Vishal Mishra, Piyush Shankar, Arkadeep Karmakar, Javed-Mohsin |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566300/4566300.jpg',
    'https://pagalworldmusic.com/download.php?title=Vada+Humse+Karo-320kbps&path=downloads%2Fhigh%2FBh4uBjMCQ18%2FBh4uBjMCQ18.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DVada%2BHumse%2BKaro-320kbps%26path%3Ddownloads%252Fhigh%252FBh4uBjMCQ18%252FBh4uBjMCQ18.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Savi' LIMIT 1), 1),
    'Humdum by Vishal Mishra, Piyush Shankar, Arkadeep Karmakar, Javed-Mohsin |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566300/4566300.jpg',
    'https://pagalworldmusic.com/download.php?title=Humdum-320kbps&path=downloads%2Fhigh%2FHl8GXRdvTUE%2FHl8GXRdvTUE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHumdum-320kbps%26path%3Ddownloads%252Fhigh%252FHl8GXRdvTUE%252FHl8GXRdvTUE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Savi' LIMIT 1), 1),
    'Vada Humse Karo (Reprise) by Vishal Mishra, Piyush Shankar, Arkadeep Karmakar, Javed-Mohsin |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566300/4566300.jpg',
    'https://pagalworldmusic.com/download.php?title=Vada+Humse+Karo+%28Reprise%29-320kbps&path=downloads%2Fhigh%2FEV1eSwRHR0I%2FEV1eSwRHR0I.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DVada%2BHumse%2BKaro%2B%2528Reprise%2529-320kbps%26path%3Ddownloads%252Fhigh%252FEV1eSwRHR0I%252FEV1eSwRHR0I.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Savi' LIMIT 1), 1),
    'Vida Karo by A.R. Rahman, Irshad Kamil |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566300/4566300.jpg',
    'https://pagalworldmusic.com/download.php?title=Vida+Karo-320kbps&path=downloads%2Fhigh%2FIxooSBJHZHo%2FIxooSBJHZHo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DVida%2BKaro-320kbps%26path%3Ddownloads%252Fhigh%252FIxooSBJHZHo%252FIxooSBJHZHo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Savi' LIMIT 1), 1),
    'O Yaarum by Vishal Mishra, Piyush Shankar, Arkadeep Karmakar, Javed-Mohsin |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566300/4566300.jpg',
    'https://pagalworldmusic.com/download.php?title=O+Yaarum-320kbps&path=downloads%2Fhigh%2FJj4ZcxJDWUc%2FJj4ZcxJDWUc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DO%2BYaarum-320kbps%26path%3Ddownloads%252Fhigh%252FJj4ZcxJDWUc%252FJj4ZcxJDWUc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Savi' LIMIT 1), 1),
    'Kya Hua by Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566300/4566300.jpg',
    'https://pagalworldmusic.com/download.php?title=Kya+Hua-320kbps&path=downloads%2Fhigh%2FQy4YAj19VmI%2FQy4YAj19VmI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKya%2BHua-320kbps%26path%3Ddownloads%252Fhigh%252FQy4YAj19VmI%252FQy4YAj19VmI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Savi' LIMIT 1), 1),
    'Bol Mohabbat by A.R. Rahman, Irshad Kamil |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566300/4566300.jpg',
    'https://pagalworldmusic.com/download.php?title=Bol+Mohabbat-320kbps&path=downloads%2Fhigh%2FRFwZayVBVGw%2FRFwZayVBVGw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBol%2BMohabbat-320kbps%26path%3Ddownloads%252Fhigh%252FRFwZayVBVGw%252FRFwZayVBVGw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Amar Singh Chamkila' LIMIT 1), 1),
    'Baaja by A.R. Rahman, Irshad Kamil |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566145/4566145.jpg',
    'https://pagalworldmusic.com/download.php?title=Baaja-320kbps&path=downloads%2Fhigh%2FACc4aw1CRnU%2FACc4aw1CRnU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBaaja-320kbps%26path%3Ddownloads%252Fhigh%252FACc4aw1CRnU%252FACc4aw1CRnU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Amar Singh Chamkila' LIMIT 1), 1),
    'Chor by Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566145/4566145.jpg',
    'https://pagalworldmusic.com/download.php?title=Chor-320kbps&path=downloads%2Fhigh%2FQFxTcEQGQXo%2FQFxTcEQGQXo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChor-320kbps%26path%3Ddownloads%252Fhigh%252FQFxTcEQGQXo%252FQFxTcEQGQXo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Amar Singh Chamkila' LIMIT 1), 1),
    'Acho Acho by Harmaan Nazim, Tanu Srivasatava, Kushboo Jain, Debanjali B Joshi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566145/4566145.jpg',
    'https://pagalworldmusic.com/download.php?title=Acho+Acho-320kbps&path=downloads%2Fhigh%2FJgwcWQ5DWAs%2FJgwcWQ5DWAs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAcho%2BAcho-320kbps%26path%3Ddownloads%252Fhigh%252FJgwcWQ5DWAs%252FJgwcWQ5DWAs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Amar Singh Chamkila' LIMIT 1), 1),
    'Tu Kya Jaane by A.R. Rahman, Irshad Kamil |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566145/4566145.jpg',
    'https://pagalworldmusic.com/download.php?title=Tu+Kya+Jaane-320kbps&path=downloads%2Fhigh%2FOw5TBEwdRwM%2FOw5TBEwdRwM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTu%2BKya%2BJaane-320kbps%26path%3Ddownloads%252Fhigh%252FOw5TBEwdRwM%252FOw5TBEwdRwM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Amar Singh Chamkila' LIMIT 1), 1),
    'Ranjhana (From Mr. And Mrs. Mahi) by Tanishk Bagchi, Vishal Mishra, Jaani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566145/4566145.jpg',
    'https://pagalworldmusic.com/download.php?title=Ranjhana+%28From+Mr.+And+Mrs.+Mahi%29-320kbps&path=downloads%2Fhigh%2FJCUFdVlEex4%2FJCUFdVlEex4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRanjhana%2B%2528From%2BMr.%2BAnd%2BMrs.%2BMahi%2529-320kbps%26path%3Ddownloads%252Fhigh%252FJCUFdVlEex4%252FJCUFdVlEex4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Amar Singh Chamkila' LIMIT 1), 1),
    'Junoon Hain (From Mr. And Mrs. Mahi) by Tanishk Bagchi, Vishal Mishra, Jaani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566145/4566145.jpg',
    'https://pagalworldmusic.com/download.php?title=Junoon+Hain+%28From+Mr.+And+Mrs.+Mahi%29-320kbps&path=downloads%2Fhigh%2FGA89QQxZRwE%2FGA89QQxZRwE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJunoon%2BHain%2B%2528From%2BMr.%2BAnd%2BMrs.%2BMahi%2529-320kbps%26path%3Ddownloads%252Fhigh%252FGA89QQxZRwE%252FGA89QQxZRwE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kartam Bhugtam' LIMIT 1), 1),
    'Tu Hain Toh (From Mr. And Mrs. Mahi) by Tanishk Bagchi, Vishal Mishra, Jaani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566292/4566292.jpg',
    'https://pagalworldmusic.com/download.php?title=Tu+Hain+Toh+%28From+Mr.+And+Mrs.+Mahi%29-320kbps&path=downloads%2Fhigh%2FOTkHSQB7f1w%2FOTkHSQB7f1w.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTu%2BHain%2BToh%2B%2528From%2BMr.%2BAnd%2BMrs.%2BMahi%2529-320kbps%26path%3Ddownloads%252Fhigh%252FOTkHSQB7f1w%252FOTkHSQB7f1w.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kartam Bhugtam' LIMIT 1), 1),
    'Dekhha Tenu (From Mr. And Mrs. Mahi) by Tanishk Bagchi, Vishal Mishra, Jaani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566292/4566292.jpg',
    'https://pagalworldmusic.com/download.php?title=Dekhha+Tenu+%28From+Mr.+And+Mrs.+Mahi%29-320kbps&path=downloads%2Fhigh%2FFD0kBzIGW30%2FFD0kBzIGW30.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDekhha%2BTenu%2B%2528From%2BMr.%2BAnd%2BMrs.%2BMahi%2529-320kbps%26path%3Ddownloads%252Fhigh%252FFD0kBzIGW30%252FFD0kBzIGW30.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kartam Bhugtam' LIMIT 1), 1),
    'Tumhe Hi Apna Maana Hai by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566292/4566292.jpg',
    'https://pagalworldmusic.com/download.php?title=Tumhe+Hi+Apna+Maana+Hai-320kbps&path=downloads%2Fhigh%2FISU9WTp9dH4%2FISU9WTp9dH4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTumhe%2BHi%2BApna%2BMaana%2BHai-320kbps%26path%3Ddownloads%252Fhigh%252FISU9WTp9dH4%252FISU9WTp9dH4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kartam Bhugtam' LIMIT 1), 1),
    'Papa Kehte Hain by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566292/4566292.jpg',
    'https://pagalworldmusic.com/download.php?title=Papa+Kehte+Hain-320kbps&path=downloads%2Fhigh%2FGTkSCS5HZ3A%2FGTkSCS5HZ3A.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPapa%2BKehte%2BHain-320kbps%26path%3Ddownloads%252Fhigh%252FGTkSCS5HZ3A%252FGTkSCS5HZ3A.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kartam Bhugtam' LIMIT 1), 1),
    'Tu Mil Gaya by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566292/4566292.jpg',
    'https://pagalworldmusic.com/download.php?title=Tu+Mil+Gaya-320kbps&path=downloads%2Fhigh%2FMiA0SUEJYWk%2FMiA0SUEJYWk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTu%2BMil%2BGaya-320kbps%26path%3Ddownloads%252Fhigh%252FMiA0SUEJYWk%252FMiA0SUEJYWk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kartam Bhugtam' LIMIT 1), 1),
    'Naram Kaalja by A.R. Rahman, Irshad Kamil |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566292/4566292.jpg',
    'https://pagalworldmusic.com/download.php?title=Naram+Kaalja-320kbps&path=downloads%2Fhigh%2FBhAPfQQGeHk%2FBhAPfQQGeHk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNaram%2BKaalja-320kbps%26path%3Ddownloads%252Fhigh%252FBhAPfQQGeHk%252FBhAPfQQGeHk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kartam Bhugtam' LIMIT 1), 1),
    'Jeena Sikha De by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566292/4566292.jpg',
    'https://pagalworldmusic.com/download.php?title=Jeena+Sikha+De-320kbps&path=downloads%2Fhigh%2FAiAfZwdJeng%2FAiAfZwdJeng.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJeena%2BSikha%2BDe-320kbps%26path%3Ddownloads%252Fhigh%252FAiAfZwdJeng%252FAiAfZwdJeng.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Srikanth' LIMIT 1), 1),
    'Ishq Mitaye by A.R. Rahman, Irshad Kamil |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566056/4566056.jpg',
    'https://pagalworldmusic.com/download.php?title=Ishq+Mitaye-320kbps&path=downloads%2Fhigh%2FG1oTfxkBc3s%2FG1oTfxkBc3s.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIshq%2BMitaye-320kbps%26path%3Ddownloads%252Fhigh%252FG1oTfxkBc3s%252FG1oTfxkBc3s.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Srikanth' LIMIT 1), 1),
    'Sona Kitna Sona Hai (Reprise) (Reprise) by Raj Ranjodh, Akshay & IP, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566056/4566056.jpg',
    'https://pagalworldmusic.com/download.php?title=Sona+Kitna+Sona+Hai+%28Reprise%29+%28Reprise%29-320kbps&path=downloads%2Fhigh%2FNgkieiRgYwY%2FNgkieiRgYwY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSona%2BKitna%2BSona%2BHai%2B%2528Reprise%2529%2B%2528Reprise%2529-320kbps%26path%3Ddownloads%252Fhigh%252FNgkieiRgYwY%252FNgkieiRgYwY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Srikanth' LIMIT 1), 1),
    'Sona Kitna Sona Hai by Raj Ranjodh, Akshay & IP, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566056/4566056.jpg',
    'https://pagalworldmusic.com/download.php?title=Sona+Kitna+Sona+Hai-320kbps&path=downloads%2Fhigh%2FBltGaToJfEo%2FBltGaToJfEo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSona%2BKitna%2BSona%2BHai-320kbps%26path%3Ddownloads%252Fhigh%252FBltGaToJfEo%252FBltGaToJfEo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Srikanth' LIMIT 1), 1),
    'Agar Ho Tum (From Mr. And Mrs. Mahi) by Tanishk Bagchi, Vishal Mishra, Jaani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4566056/4566056.jpg',
    'https://pagalworldmusic.com/download.php?title=Agar+Ho+Tum+%28From+Mr.+And+Mrs.+Mahi%29-320kbps&path=downloads%2Fhigh%2FRkUIBTVSVH8%2FRkUIBTVSVH8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAgar%2BHo%2BTum%2B%2528From%2BMr.%2BAnd%2BMrs.%2BMahi%2529-320kbps%26path%3Ddownloads%252Fhigh%252FRkUIBTVSVH8%252FRkUIBTVSVH8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crew' LIMIT 1), 1),
    'Tu Hain Toh - Neeti Mohan Version (From Mr. And Mrs. Mahi) by Tanishk Bagchi, Vishal Mishra, Jaani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565996/4565996.jpg',
    'https://pagalworldmusic.com/download.php?title=Tu+Hain+Toh+-+Neeti+Mohan+Version+%28From+Mr.+And+Mrs.+Mahi%29-320kbps&path=downloads%2Fhigh%2FRCceZzpZWFk%2FRCceZzpZWFk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTu%2BHain%2BToh%2B-%2BNeeti%2BMohan%2BVersion%2B%2528From%2BMr.%2BAnd%2BMrs.%2BMahi%2529-320kbps%26path%3Ddownloads%252Fhigh%252FRCceZzpZWFk%252FRCceZzpZWFk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crew' LIMIT 1), 1),
    'Roya Jab Tu (From Mr. And Mrs. Mahi) by Tanishk Bagchi, Vishal Mishra, Jaani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565996/4565996.jpg',
    'https://pagalworldmusic.com/download.php?title=Roya+Jab+Tu+%28From+Mr.+And+Mrs.+Mahi%29-320kbps&path=downloads%2Fhigh%2FKFolcgVlAwA%2FKFolcgVlAwA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRoya%2BJab%2BTu%2B%2528From%2BMr.%2BAnd%2BMrs.%2BMahi%2529-320kbps%26path%3Ddownloads%252Fhigh%252FKFolcgVlAwA%252FKFolcgVlAwA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crew' LIMIT 1), 1),
    'Choli Ke Peeche (From Crew) by Raj Ranjodh, Akshay & IP, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565996/4565996.jpg',
    'https://pagalworldmusic.com/download.php?title=Choli+Ke+Peeche+%28From+Crew%29-320kbps&path=downloads%2Fhigh%2FCCYNZjNSeF4%2FCCYNZjNSeF4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DCholi%2BKe%2BPeeche%2B%2528From%2BCrew%2529-320kbps%26path%3Ddownloads%252Fhigh%252FCCYNZjNSeF4%252FCCYNZjNSeF4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crew' LIMIT 1), 1),
    'Madabhara Mizhiyoram by Prashant Pillai, P.S Rafeeque |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565996/4565996.jpg',
    'https://pagalworldmusic.com/download.php?title=Madabhara+Mizhiyoram-320kbps&path=downloads%2Fhigh%2FMVxdZUNcbkc%2FMVxdZUNcbkc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMadabhara%2BMizhiyoram-320kbps%26path%3Ddownloads%252Fhigh%252FMVxdZUNcbkc%252FMVxdZUNcbkc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crew' LIMIT 1), 1),
    'Ghagra (From Crew) by Raj Ranjodh, Akshay & IP, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565996/4565996.jpg',
    'https://pagalworldmusic.com/download.php?title=Ghagra+%28From+Crew%29-320kbps&path=downloads%2Fhigh%2FMloMB0MHBEk%2FMloMB0MHBEk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGhagra%2B%2528From%2BCrew%2529-320kbps%26path%3Ddownloads%252Fhigh%252FMloMB0MHBEk%252FMloMB0MHBEk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crew' LIMIT 1), 1),
    'Khwabida by Raj Ranjodh, Akshay & IP, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565996/4565996.jpg',
    'https://pagalworldmusic.com/download.php?title=Khwabida-320kbps&path=downloads%2Fhigh%2FEzEmWgwdBHA%2FEzEmWgwdBHA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKhwabida-320kbps%26path%3Ddownloads%252Fhigh%252FEzEmWgwdBHA%252FEzEmWgwdBHA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crew' LIMIT 1), 1),
    'Shabnami by Prashant Pillai, P.S Rafeeque |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565996/4565996.jpg',
    'https://pagalworldmusic.com/download.php?title=Shabnami-320kbps&path=downloads%2Fhigh%2FMgtGeD96RH8%2FMgtGeD96RH8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DShabnami-320kbps%26path%3Ddownloads%252Fhigh%252FMgtGeD96RH8%252FMgtGeD96RH8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crew' LIMIT 1), 1),
    'Roar Of Ruslaan by Rajat Nagpal, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565996/4565996.jpg',
    'https://pagalworldmusic.com/download.php?title=Roar+Of+Ruslaan-320kbps&path=downloads%2Fhigh%2FQApGfURoU3Y%2FQApGfURoU3Y.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRoar%2BOf%2BRuslaan-320kbps%26path%3Ddownloads%252Fhigh%252FQApGfURoU3Y%252FQApGfURoU3Y.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Malaikottai Vaaliban (Malayalam)' LIMIT 1), 1),
    'Dua-e-Khair by Rajat Nagpal, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565974/4565974.jpg',
    'https://pagalworldmusic.com/download.php?title=Dua-e-Khair-320kbps&path=downloads%2Fhigh%2FJjEFejBnR1U%2FJjEFejBnR1U.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDua-e-Khair-320kbps%26path%3Ddownloads%252Fhigh%252FJjEFejBnR1U%252FJjEFejBnR1U.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Malaikottai Vaaliban (Malayalam)' LIMIT 1), 1),
    'Raakk by Prashant Pillai, P.S Rafeeque |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565974/4565974.jpg',
    'https://pagalworldmusic.com/download.php?title=Raakk-320kbps&path=downloads%2Fhigh%2FAB4eViJbBgA%2FAB4eViJbBgA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaakk-320kbps%26path%3Ddownloads%252Fhigh%252FAB4eViJbBgA%252FAB4eViJbBgA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Malaikottai Vaaliban (Malayalam)' LIMIT 1), 1),
    'Darbadar by Raj Ranjodh, Akshay & IP, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565974/4565974.jpg',
    'https://pagalworldmusic.com/download.php?title=Darbadar-320kbps&path=downloads%2Fhigh%2FQiRZVzwEflA%2FQiRZVzwEflA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDarbadar-320kbps%26path%3Ddownloads%252Fhigh%252FQiRZVzwEflA%252FQiRZVzwEflA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Malaikottai Vaaliban (Malayalam)' LIMIT 1), 1),
    'Dil Phisal Gaya by Rajat Nagpal, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565974/4565974.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Phisal+Gaya-320kbps&path=downloads%2Fhigh%2FGlAjeBhndFE%2FGlAjeBhndFE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BPhisal%2BGaya-320kbps%26path%3Ddownloads%252Fhigh%252FGlAjeBhndFE%252FGlAjeBhndFE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Pyar Ke Do Naam' LIMIT 1), 1),
    'Kann Kandath Nijam by Prashant Pillai, P.S Rafeeque |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565909/4565909.jpg',
    'https://pagalworldmusic.com/download.php?title=Kann+Kandath+Nijam-320kbps&path=downloads%2Fhigh%2FJgEvQjdSBkU%2FJgEvQjdSBkU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKann%2BKandath%2BNijam-320kbps%26path%3Ddownloads%252Fhigh%252FJgEvQjdSBkU%252FJgEvQjdSBkU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Pyar Ke Do Naam' LIMIT 1), 1),
    'Taade by Rajat Nagpal, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565909/4565909.jpg',
    'https://pagalworldmusic.com/download.php?title=Taade-320kbps&path=downloads%2Fhigh%2FB0U4VBl8XFE%2FB0U4VBl8XFE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTaade-320kbps%26path%3Ddownloads%252Fhigh%252FB0U4VBl8XFE%252FB0U4VBl8XFE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Pyar Ke Do Naam' LIMIT 1), 1),
    'Kiddan Zaalima by Raj Ranjodh, Akshay & IP, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565909/4565909.jpg',
    'https://pagalworldmusic.com/download.php?title=Kiddan+Zaalima-320kbps&path=downloads%2Fhigh%2FCFwMAAYCckI%2FCFwMAAYCckI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKiddan%2BZaalima-320kbps%26path%3Ddownloads%252Fhigh%252FCFwMAAYCckI%252FCFwMAAYCckI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Pyar Ke Do Naam' LIMIT 1), 1),
    'Naina (From Crew) by Raj Ranjodh, Akshay & IP, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565909/4565909.jpg',
    'https://pagalworldmusic.com/download.php?title=Naina+%28From+Crew%29-320kbps&path=downloads%2Fhigh%2FAD0JeEVHU1o%2FAD0JeEVHU1o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNaina%2B%2528From%2BCrew%2529-320kbps%26path%3Ddownloads%252Fhigh%252FAD0JeEVHU1o%252FAD0JeEVHU1o.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Pyar Ke Do Naam' LIMIT 1), 1),
    'Kal Ki Baat by Lakhwinder Wadali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565909/4565909.jpg',
    'https://pagalworldmusic.com/download.php?title=Kal+Ki+Baat-320kbps&path=downloads%2Fhigh%2FJiUDCEN-e0E%2FJiUDCEN-e0E.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKal%2BKi%2BBaat-320kbps%26path%3Ddownloads%252Fhigh%252FJiUDCEN-e0E%252FJiUDCEN-e0E.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maidaan' LIMIT 1), 1),
    'Pehla Ishq by Rajat Nagpal, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565738/4565738.jpg',
    'https://pagalworldmusic.com/download.php?title=Pehla+Ishq-320kbps&path=downloads%2Fhigh%2FHzgYWRlkD2Q%2FHzgYWRlkD2Q.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPehla%2BIshq-320kbps%26path%3Ddownloads%252Fhigh%252FHzgYWRlkD2Q%252FHzgYWRlkD2Q.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maidaan' LIMIT 1), 1),
    'Rangrez by Lakhwinder Wadali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565738/4565738.jpg',
    'https://pagalworldmusic.com/download.php?title=Rangrez-320kbps&path=downloads%2Fhigh%2FPx09QTZFaHs%2FPx09QTZFaHs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRangrez-320kbps%26path%3Ddownloads%252Fhigh%252FPx09QTZFaHs%252FPx09QTZFaHs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maidaan' LIMIT 1), 1),
    'Channa by Lakhwinder Wadali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565738/4565738.jpg',
    'https://pagalworldmusic.com/download.php?title=Channa-320kbps&path=downloads%2Fhigh%2FOF0PcAxFVVQ%2FOF0PcAxFVVQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChanna-320kbps%26path%3Ddownloads%252Fhigh%252FOF0PcAxFVVQ%252FOF0PcAxFVVQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maidaan' LIMIT 1), 1),
    'Behki Behki by Lakhwinder Wadali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565738/4565738.jpg',
    'https://pagalworldmusic.com/download.php?title=Behki+Behki-320kbps&path=downloads%2Fhigh%2FCQlYdxNqWGc%2FCQlYdxNqWGc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBehki%2BBehki-320kbps%26path%3Ddownloads%252Fhigh%252FCQlYdxNqWGc%252FCQlYdxNqWGc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maidaan' LIMIT 1), 1),
    'Heer by Lakhwinder Wadali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565738/4565738.jpg',
    'https://pagalworldmusic.com/download.php?title=Heer-320kbps&path=downloads%2Fhigh%2FEwMRYDNTYHY%2FEwMRYDNTYHY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHeer-320kbps%26path%3Ddownloads%252Fhigh%252FEwMRYDNTYHY%252FEwMRYDNTYHY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maidaan' LIMIT 1), 1),
    'Maye Ni by Lakhwinder Wadali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565738/4565738.jpg',
    'https://pagalworldmusic.com/download.php?title=Maye+Ni-320kbps&path=downloads%2Fhigh%2FEgAJZhdvAFY%2FEgAJZhdvAFY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMaye%2BNi-320kbps%26path%3Ddownloads%252Fhigh%252FEgAJZhdvAFY%252FEgAJZhdvAFY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Maidaan' LIMIT 1), 1),
    'Jaaney Do by The Local Train, Kunaal Vermaa, Trina Mukherjee, Abhiruchi Chand, Ankur Tewari, Manoj Yadav, Lost St |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565738/4565738.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaaney+Do-320kbps&path=downloads%2Fhigh%2FCjAaHD8JWQc%2FCjAaHD8JWQc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaaney%2BDo-320kbps%26path%3Ddownloads%252Fhigh%252FCjAaHD8JWQc%252FCjAaHD8JWQc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Rangrez' LIMIT 1), 1),
    'Jazbaati Hai Dil by The Local Train, Kunaal Vermaa, Trina Mukherjee, Abhiruchi Chand, Ankur Tewari, Manoj Yadav, Lost St |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565664/4565664.jpg',
    'https://pagalworldmusic.com/download.php?title=Jazbaati+Hai+Dil-320kbps&path=downloads%2Fhigh%2FRA4fX0xbA0E%2FRA4fX0xbA0E.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJazbaati%2BHai%2BDil-320kbps%26path%3Ddownloads%252Fhigh%252FRA4fX0xbA0E%252FRA4fX0xbA0E.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Rangrez' LIMIT 1), 1),
    'Papa Tu Hai Na by Kumaar, Amit Trivedi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565664/4565664.jpg',
    'https://pagalworldmusic.com/download.php?title=Papa+Tu+Hai+Na-320kbps&path=downloads%2Fhigh%2FNRgCYid1XQc%2FNRgCYid1XQc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPapa%2BTu%2BHai%2BNa-320kbps%26path%3Ddownloads%252Fhigh%252FNRgCYid1XQc%252FNRgCYid1XQc.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Rangrez' LIMIT 1), 1),
    'Tu Hai Kahaan by The Local Train, Kunaal Vermaa, Trina Mukherjee, Abhiruchi Chand, Ankur Tewari, Manoj Yadav, Lost St |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565664/4565664.jpg',
    'https://pagalworldmusic.com/download.php?title=Tu+Hai+Kahaan-320kbps&path=downloads%2Fhigh%2FCS0uaztgVkI%2FCS0uaztgVkI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTu%2BHai%2BKahaan-320kbps%26path%3Ddownloads%252Fhigh%252FCS0uaztgVkI%252FCS0uaztgVkI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Rangrez' LIMIT 1), 1),
    'Khushiyaan Bator Lo by Kumaar, Amit Trivedi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565664/4565664.jpg',
    'https://pagalworldmusic.com/download.php?title=Khushiyaan+Bator+Lo-320kbps&path=downloads%2Fhigh%2FPl0kaBBiQEo%2FPl0kaBBiQEo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKhushiyaan%2BBator%2BLo-320kbps%26path%3Ddownloads%252Fhigh%252FPl0kaBBiQEo%252FPl0kaBBiQEo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Rangrez' LIMIT 1), 1),
    'Aa Bhi Jaa by The Local Train, Kunaal Vermaa, Trina Mukherjee, Abhiruchi Chand, Ankur Tewari, Manoj Yadav, Lost St |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565664/4565664.jpg',
    'https://pagalworldmusic.com/download.php?title=Aa+Bhi+Jaa-320kbps&path=downloads%2Fhigh%2FNT0-f1kDdAI%2FNT0-f1kDdAI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAa%2BBhi%2BJaa-320kbps%26path%3Ddownloads%252Fhigh%252FNT0-f1kDdAI%252FNT0-f1kDdAI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Rangrez' LIMIT 1), 1),
    'Teri Meri Ye Kahaani by The Local Train, Kunaal Vermaa, Trina Mukherjee, Abhiruchi Chand, Ankur Tewari, Manoj Yadav, Lost St |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565664/4565664.jpg',
    'https://pagalworldmusic.com/download.php?title=Teri+Meri+Ye+Kahaani-320kbps&path=downloads%2Fhigh%2FIQIEWwJUQV4%2FIQIEWwJUQV4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTeri%2BMeri%2BYe%2BKahaani-320kbps%26path%3Ddownloads%252Fhigh%252FIQIEWwJUQV4%252FIQIEWwJUQV4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Rangrez' LIMIT 1), 1),
    'Shaitaan Theme by Kumaar, Amit Trivedi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565664/4565664.jpg',
    'https://pagalworldmusic.com/download.php?title=Shaitaan+Theme-320kbps&path=downloads%2Fhigh%2FQyY8Z0BvTXw%2FQyY8Z0BvTXw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DShaitaan%2BTheme-320kbps%26path%3Ddownloads%252Fhigh%252FQyY8Z0BvTXw%252FQyY8Z0BvTXw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Do Aur Do Pyaar' LIMIT 1), 1),
    'Aisa Main Shaitaan by Kumaar, Amit Trivedi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565395/4565395.jpg',
    'https://pagalworldmusic.com/download.php?title=Aisa+Main+Shaitaan-320kbps&path=downloads%2Fhigh%2FFjsAYz52BGM%2FFjsAYz52BGM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAisa%2BMain%2BShaitaan-320kbps%26path%3Ddownloads%252Fhigh%252FFjsAYz52BGM%252FFjsAYz52BGM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Do Aur Do Pyaar' LIMIT 1), 1),
    'Dil Nahi Todenge by A.R. Rahman, Manoj Muntashir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565395/4565395.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Nahi+Todenge-320kbps&path=downloads%2Fhigh%2FHlskVTd1cnw%2FHlskVTd1cnw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BNahi%2BTodenge-320kbps%26path%3Ddownloads%252Fhigh%252FHlskVTd1cnw%252FHlskVTd1cnw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Do Aur Do Pyaar' LIMIT 1), 1),
    'Ta Ra Ta Ra Ta by The Local Train, Kunaal Vermaa, Trina Mukherjee, Abhiruchi Chand, Ankur Tewari, Manoj Yadav, Lost St |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565395/4565395.jpg',
    'https://pagalworldmusic.com/download.php?title=Ta+Ra+Ta+Ra+Ta-320kbps&path=downloads%2Fhigh%2FNQkgdwR9Q3c%2FNQkgdwR9Q3c.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTa%2BRa%2BTa%2BRa%2BTa-320kbps%26path%3Ddownloads%252Fhigh%252FNQkgdwR9Q3c%252FNQkgdwR9Q3c.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Do Aur Do Pyaar' LIMIT 1), 1),
    'Team India Hain Hum by A.R. Rahman, Manoj Muntashir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565395/4565395.jpg',
    'https://pagalworldmusic.com/download.php?title=Team+India+Hain+Hum-320kbps&path=downloads%2Fhigh%2FOy0xCBJ8fWQ%2FOy0xCBJ8fWQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTeam%2BIndia%2BHain%2BHum-320kbps%26path%3Ddownloads%252Fhigh%252FOy0xCBJ8fWQ%252FOy0xCBJ8fWQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Fighter' LIMIT 1), 1),
    'Jaane Do by A.R. Rahman, Manoj Muntashir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565914/4565914.jpg',
    'https://pagalworldmusic.com/download.php?title=Jaane+Do-320kbps&path=downloads%2Fhigh%2FJjo6VUxmegU%2FJjo6VUxmegU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJaane%2BDo-320kbps%26path%3Ddownloads%252Fhigh%252FJjo6VUxmegU%252FJjo6VUxmegU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Fighter' LIMIT 1), 1),
    'Do Kinaare by The Local Train, Kunaal Vermaa, Trina Mukherjee, Abhiruchi Chand, Ankur Tewari, Manoj Yadav, Lost St |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565914/4565914.jpg',
    'https://pagalworldmusic.com/download.php?title=Do+Kinaare-320kbps&path=downloads%2Fhigh%2FGD0cWhEJUn0%2FGD0cWhEJUn0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDo%2BKinaare-320kbps%26path%3Ddownloads%252Fhigh%252FGD0cWhEJUn0%252FGD0cWhEJUn0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Fighter' LIMIT 1), 1),
    'Mitti (Suresh Wadkar Version) by Vishal & Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565914/4565914.jpg',
    'https://pagalworldmusic.com/download.php?title=Mitti+%28Suresh+Wadkar+Version%29-320kbps&path=downloads%2Fhigh%2FOB4FARVgX0M%2FOB4FARVgX0M.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMitti%2B%2528Suresh%2BWadkar%2BVersion%2529-320kbps%26path%3Ddownloads%252Fhigh%252FOB4FARVgX0M%252FOB4FARVgX0M.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Fighter' LIMIT 1), 1),
    'Ishq Jaisa Kuch by Vishal & Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565914/4565914.jpg',
    'https://pagalworldmusic.com/download.php?title=Ishq+Jaisa+Kuch-320kbps&path=downloads%2Fhigh%2FAA8oRix-c1Q%2FAA8oRix-c1Q.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIshq%2BJaisa%2BKuch-320kbps%26path%3Ddownloads%252Fhigh%252FAA8oRix-c1Q%252FAA8oRix-c1Q.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Fighter' LIMIT 1), 1),
    'Nasha by Lakhwinder Wadali |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565914/4565914.jpg',
    'https://pagalworldmusic.com/download.php?title=Nasha-320kbps&path=downloads%2Fhigh%2FPzhdVD5TX1g%2FPzhdVD5TX1g.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNasha-320kbps%26path%3Ddownloads%252Fhigh%252FPzhdVD5TX1g%252FPzhdVD5TX1g.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Shaitaan' LIMIT 1), 1),
    'Ranga Ranga by A.R. Rahman, Manoj Muntashir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565402/4565402.jpg',
    'https://pagalworldmusic.com/download.php?title=Ranga+Ranga-320kbps&path=downloads%2Fhigh%2FRTsPHBhvXWs%2FRTsPHBhvXWs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRanga%2BRanga-320kbps%26path%3Ddownloads%252Fhigh%252FRTsPHBhvXWs%252FRTsPHBhvXWs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Shaitaan' LIMIT 1), 1),
    'Sher Khul Gaye by Vishal & Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565402/4565402.jpg',
    'https://pagalworldmusic.com/download.php?title=Sher+Khul+Gaye-320kbps&path=downloads%2Fhigh%2FQww-YRxkDlY%2FQww-YRxkDlY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSher%2BKhul%2BGaye-320kbps%26path%3Ddownloads%252Fhigh%252FQww-YRxkDlY%252FQww-YRxkDlY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Shaitaan' LIMIT 1), 1),
    'Raat Akeli Thi (Version 2) by Pritam, Varun Grover |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565402/4565402.jpg',
    'https://pagalworldmusic.com/download.php?title=Raat+Akeli+Thi+%28Version+2%29-320kbps&path=downloads%2Fhigh%2FRykkUzwJVVw%2FRykkUzwJVVw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaat%2BAkeli%2BThi%2B%2528Version%2B2%2529-320kbps%26path%3Ddownloads%252Fhigh%252FRykkUzwJVVw%252FRykkUzwJVVw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Shaitaan' LIMIT 1), 1),
    'Dil Banaane Waaleya by Vishal & Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565402/4565402.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Banaane+Waaleya-320kbps&path=downloads%2Fhigh%2FHCYaXAd2T1o%2FHCYaXAd2T1o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BBanaane%2BWaaleya-320kbps%26path%3Ddownloads%252Fhigh%252FHCYaXAd2T1o%252FHCYaXAd2T1o.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Shaitaan' LIMIT 1), 1),
    'Mitti by Vishal & Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565402/4565402.jpg',
    'https://pagalworldmusic.com/download.php?title=Mitti-320kbps&path=downloads%2Fhigh%2FQBsPBwVnQVc%2FQBsPBwVnQVc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMitti-320kbps%26path%3Ddownloads%252Fhigh%252FQBsPBwVnQVc%252FQBsPBwVnQVc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Shaitaan' LIMIT 1), 1),
    'Dil Ki Mez by Pritam, Varun Grover |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565402/4565402.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Ki+Mez-320kbps&path=downloads%2Fhigh%2FEls4VixdAGU%2FEls4VixdAGU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BKi%2BMez-320kbps%26path%3Ddownloads%252Fhigh%252FEls4VixdAGU%252FEls4VixdAGU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Shaitaan' LIMIT 1), 1),
    'Heer Aasmani by Vishal & Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565402/4565402.jpg',
    'https://pagalworldmusic.com/download.php?title=Heer+Aasmani-320kbps&path=downloads%2Fhigh%2FEx8cXAwDD0A%2FEx8cXAwDD0A.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHeer%2BAasmani-320kbps%26path%3Ddownloads%252Fhigh%252FEx8cXAwDD0A%252FEx8cXAwDD0A.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Woh Bhi Din The' LIMIT 1), 1),
    'Bekaar Dil by Vishal & Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565331/4565331.jpg',
    'https://pagalworldmusic.com/download.php?title=Bekaar+Dil-320kbps&path=downloads%2Fhigh%2FQ1kmRExKcGE%2FQ1kmRExKcGE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBekaar%2BDil-320kbps%26path%3Ddownloads%252Fhigh%252FQ1kmRExKcGE%252FQ1kmRExKcGE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Woh Bhi Din The' LIMIT 1), 1),
    'Raat Akeli Thi by Pritam, Varun Grover |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565331/4565331.jpg',
    'https://pagalworldmusic.com/download.php?title=Raat+Akeli+Thi-320kbps&path=downloads%2Fhigh%2FLyQBRDhBeUA%2FLyQBRDhBeUA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaat%2BAkeli%2BThi-320kbps%26path%3Ddownloads%252Fhigh%252FLyQBRDhBeUA%252FLyQBRDhBeUA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Woh Bhi Din The' LIMIT 1), 1),
    'Mirza by A.R. Rahman, Manoj Muntashir |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565331/4565331.jpg',
    'https://pagalworldmusic.com/download.php?title=Mirza-320kbps&path=downloads%2Fhigh%2FBjETCSRvc3I%2FBjETCSRvc3I.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMirza-320kbps%26path%3Ddownloads%252Fhigh%252FBjETCSRvc3I%252FBjETCSRvc3I.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Woh Bhi Din The' LIMIT 1), 1),
    'Nazar Teri Toofan by Pritam, Varun Grover |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565331/4565331.jpg',
    'https://pagalworldmusic.com/download.php?title=Nazar+Teri+Toofan-320kbps&path=downloads%2Fhigh%2FKQwMZxxnaGI%2FKQwMZxxnaGI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNazar%2BTeri%2BToofan-320kbps%26path%3Ddownloads%252Fhigh%252FKQwMZxxnaGI%252FKQwMZxxnaGI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Woh Bhi Din The' LIMIT 1), 1),
    'Benevolent Breeze by Prasoon Joshi, A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565331/4565331.jpg',
    'https://pagalworldmusic.com/download.php?title=Benevolent+Breeze-320kbps&path=downloads%2Fhigh%2FQFEKdC56YgM%2FQFEKdC56YgM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBenevolent%2BBreeze-320kbps%26path%3Ddownloads%252Fhigh%252FQFEKdC56YgM%252FQFEKdC56YgM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Murder Mubarak' LIMIT 1), 1),
    'Badaweih (Palestinian Folk Song) by Prasoon Joshi, A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565134/4565134.jpg',
    'https://pagalworldmusic.com/download.php?title=Badaweih+%28Palestinian+Folk+Song%29-320kbps&path=downloads%2Fhigh%2FOSkIYyd6aAA%2FOSkIYyd6aAA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBadaweih%2B%2528Palestinian%2BFolk%2BSong%2529-320kbps%26path%3Ddownloads%252Fhigh%252FOSkIYyd6aAA%252FOSkIYyd6aAA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Murder Mubarak' LIMIT 1), 1),
    'KHATTI SI WOH IMLI by Prasoon Joshi, A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565134/4565134.jpg',
    'https://pagalworldmusic.com/download.php?title=KHATTI+SI+WOH+IMLI-320kbps&path=downloads%2Fhigh%2FQCw0VUJgAno%2FQCw0VUJgAno.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKHATTI%2BSI%2BWOH%2BIMLI-320kbps%26path%3Ddownloads%252Fhigh%252FQCw0VUJgAno%252FQCw0VUJgAno.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Murder Mubarak' LIMIT 1), 1),
    'Istigfar by Prasoon Joshi, A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565134/4565134.jpg',
    'https://pagalworldmusic.com/download.php?title=Istigfar-320kbps&path=downloads%2Fhigh%2FOy8MUhhgAkM%2FOy8MUhhgAkM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIstigfar-320kbps%26path%3Ddownloads%252Fhigh%252FOy8MUhhgAkM%252FOy8MUhhgAkM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Murder Mubarak' LIMIT 1), 1),
    'Merry Christmas (Title Track) by Pritam, Varun Grover |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565134/4565134.jpg',
    'https://pagalworldmusic.com/download.php?title=Merry+Christmas+%28Title+Track%29-320kbps&path=downloads%2Fhigh%2FBCwOAxMFex4%2FBCwOAxMFex4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMerry%2BChristmas%2B%2528Title%2BTrack%2529-320kbps%26path%3Ddownloads%252Fhigh%252FBCwOAxMFex4%252FBCwOAxMFex4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Murder Mubarak' LIMIT 1), 1),
    'Ae Watan Mere Watan - Title Track by Mukund Suryawanshi, Akashdeep Sengupta, Shashi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565134/4565134.jpg',
    'https://pagalworldmusic.com/download.php?title=Ae+Watan+Mere+Watan+-+Title+Track-320kbps&path=downloads%2Fhigh%2FQAYIBwVHZms%2FQAYIBwVHZms.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAe%2BWatan%2BMere%2BWatan%2B-%2BTitle%2BTrack-320kbps%26path%3Ddownloads%252Fhigh%252FQAYIBwVHZms%252FQAYIBwVHZms.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Goat Life - Aadujeevitham' LIMIT 1), 1),
    'Dua E Azaadi by Mukund Suryawanshi, Akashdeep Sengupta, Shashi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565012/4565012.jpg',
    'https://pagalworldmusic.com/download.php?title=Dua+E+Azaadi-320kbps&path=downloads%2Fhigh%2FJlwJaANfAAc%2FJlwJaANfAAc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDua%2BE%2BAzaadi-320kbps%26path%3Ddownloads%252Fhigh%252FJlwJaANfAAc%252FJlwJaANfAAc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Goat Life - Aadujeevitham' LIMIT 1), 1),
    'Qatra Qatra by Mukund Suryawanshi, Akashdeep Sengupta, Shashi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565012/4565012.jpg',
    'https://pagalworldmusic.com/download.php?title=Qatra+Qatra-320kbps&path=downloads%2Fhigh%2FPD8FWR4AeAI%2FPD8FWR4AeAI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DQatra%2BQatra-320kbps%26path%3Ddownloads%252Fhigh%252FPD8FWR4AeAI%252FPD8FWR4AeAI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Goat Life - Aadujeevitham' LIMIT 1), 1),
    'MEHARBAAN O RAHMAAN by Prasoon Joshi, A.R. Rahman |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565012/4565012.jpg',
    'https://pagalworldmusic.com/download.php?title=MEHARBAAN+O+RAHMAAN-320kbps&path=downloads%2Fhigh%2FGBEJfTwHcAE%2FGBEJfTwHcAE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMEHARBAAN%2BO%2BRAHMAAN-320kbps%26path%3Ddownloads%252Fhigh%252FGBEJfTwHcAE%252FGBEJfTwHcAE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Goat Life - Aadujeevitham' LIMIT 1), 1),
    'Tiranga by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565012/4565012.jpg',
    'https://pagalworldmusic.com/download.php?title=Tiranga-320kbps&path=downloads%2Fhigh%2FBTobdBp4fUk%2FBTobdBp4fUk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTiranga-320kbps%26path%3Ddownloads%252Fhigh%252FBTobdBp4fUk%252FBTobdBp4fUk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'The Goat Life - Aadujeevitham' LIMIT 1), 1),
    'Tere Sang Ishq Hua by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565012/4565012.jpg',
    'https://pagalworldmusic.com/download.php?title=Tere+Sang+Ishq+Hua-320kbps&path=downloads%2Fhigh%2FFCY5UEV8XGM%2FFCY5UEV8XGM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTere%2BSang%2BIshq%2BHua-320kbps%26path%3Ddownloads%252Fhigh%252FFCY5UEV8XGM%252FFCY5UEV8XGM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Swatantrya Veer Savarkar' LIMIT 1), 1),
    'Ae Watan Mere Watan - Title Track (Female Version) by Mukund Suryawanshi, Akashdeep Sengupta, Shashi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564995/4564995.jpg',
    'https://pagalworldmusic.com/download.php?title=Ae+Watan+Mere+Watan+-+Title+Track+%28Female+Version%29-320kbps&path=downloads%2Fhigh%2FNh9ecjVVY3E%2FNh9ecjVVY3E.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAe%2BWatan%2BMere%2BWatan%2B-%2BTitle%2BTrack%2B%2528Female%2BVersion%2529-320kbps%26path%3Ddownloads%252Fhigh%252FNh9ecjVVY3E%252FNh9ecjVVY3E.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Swatantrya Veer Savarkar' LIMIT 1), 1),
    'Qismat Badal Di by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564995/4564995.jpg',
    'https://pagalworldmusic.com/download.php?title=Qismat+Badal+Di-320kbps&path=downloads%2Fhigh%2FEgxaXAECAFU%2FEgxaXAECAFU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DQismat%2BBadal%2BDi-320kbps%26path%3Ddownloads%252Fhigh%252FEgxaXAECAFU%252FEgxaXAECAFU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Swatantrya Veer Savarkar' LIMIT 1), 1),
    'Dange Theme by Sanjith Hegde, Dhruv Visvanath, Gaurav Godkhindi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564995/4564995.jpg',
    'https://pagalworldmusic.com/download.php?title=Dange+Theme-320kbps&path=downloads%2Fhigh%2FQws-BAJ2AAc%2FQws-BAJ2AAc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDange%2BTheme-320kbps%26path%3Ddownloads%252Fhigh%252FQws-BAJ2AAc%252FQws-BAJ2AAc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Swatantrya Veer Savarkar' LIMIT 1), 1),
    'Zindagi Tere Naam by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564995/4564995.jpg',
    'https://pagalworldmusic.com/download.php?title=Zindagi+Tere+Naam-320kbps&path=downloads%2Fhigh%2FHV0PcyRpXQY%2FHV0PcyRpXQY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DZindagi%2BTere%2BNaam-320kbps%26path%3Ddownloads%252Fhigh%252FHV0PcyRpXQY%252FHV0PcyRpXQY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Swatantrya Veer Savarkar' LIMIT 1), 1),
    'Yeh Pal Hain Apne by Sanjith Hegde, Dhruv Visvanath, Gaurav Godkhindi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564995/4564995.jpg',
    'https://pagalworldmusic.com/download.php?title=Yeh+Pal+Hain+Apne-320kbps&path=downloads%2Fhigh%2FPlsdBxldDmw%2FPlsdBxldDmw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYeh%2BPal%2BHain%2BApne-320kbps%26path%3Ddownloads%252Fhigh%252FPlsdBxldDmw%252FPlsdBxldDmw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Swatantrya Veer Savarkar' LIMIT 1), 1),
    'Raat Akeli Thi by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564995/4564995.jpg',
    'https://pagalworldmusic.com/download.php?title=Raat+Akeli+Thi-320kbps&path=downloads%2Fhigh%2FNAEfUzMIWlk%2FNAEfUzMIWlk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaat%2BAkeli%2BThi-320kbps%26path%3Ddownloads%252Fhigh%252FNAEfUzMIWlk%252FNAEfUzMIWlk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tera Kya Hoga Lovely' LIMIT 1), 1),
    'Zindagi Tere Naam (Soul Version) by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564840/4564840.jpg',
    'https://pagalworldmusic.com/download.php?title=Zindagi+Tere+Naam+%28Soul+Version%29-320kbps&path=downloads%2Fhigh%2FJl8lRABpc0Y%2FJl8lRABpc0Y.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DZindagi%2BTere%2BNaam%2B%2528Soul%2BVersion%2529-320kbps%26path%3Ddownloads%252Fhigh%252FJl8lRABpc0Y%252FJl8lRABpc0Y.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tera Kya Hoga Lovely' LIMIT 1), 1),
    'Dil Ki Mez by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564840/4564840.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Ki+Mez-320kbps&path=downloads%2Fhigh%2FHCAfZx5jcwE%2FHCAfZx5jcwE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BKi%2BMez-320kbps%26path%3Ddownloads%252Fhigh%252FHCAfZx5jcwE%252FHCAfZx5jcwE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tera Kya Hoga Lovely' LIMIT 1), 1),
    'Yodha Theme by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564840/4564840.jpg',
    'https://pagalworldmusic.com/download.php?title=Yodha+Theme-320kbps&path=downloads%2Fhigh%2FAFEiSBZUDh4%2FAFEiSBZUDh4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYodha%2BTheme-320kbps%26path%3Ddownloads%252Fhigh%252FAFEiSBZUDh4%252FAFEiSBZUDh4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Tera Kya Hoga Lovely' LIMIT 1), 1),
    'Nazar Teri Toofan by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564840/4564840.jpg',
    'https://pagalworldmusic.com/download.php?title=Nazar+Teri+Toofan-320kbps&path=downloads%2Fhigh%2FPDcFWxBSfws%2FPDcFWxBSfws.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNazar%2BTeri%2BToofan-320kbps%26path%3Ddownloads%252Fhigh%252FPDcFWxBSfws%252FPDcFWxBSfws.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dange' LIMIT 1), 1),
    'Khel by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564653/4564653.jpg',
    'https://pagalworldmusic.com/download.php?title=Khel-320kbps&path=downloads%2Fhigh%2FFSk9WzpAb2E%2FFSk9WzpAb2E.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKhel-320kbps%26path%3Ddownloads%252Fhigh%252FFSk9WzpAb2E%252FFSk9WzpAb2E.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dange' LIMIT 1), 1),
    'Julia by Mukund Suryawanshi, Akashdeep Sengupta, Shashi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564653/4564653.jpg',
    'https://pagalworldmusic.com/download.php?title=Julia-320kbps&path=downloads%2Fhigh%2FL1tYXDF-X2A%2FL1tYXDF-X2A.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJulia-320kbps%26path%3Ddownloads%252Fhigh%252FL1tYXDF-X2A%252FL1tYXDF-X2A.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dange' LIMIT 1), 1),
    'Khayal Rakhna by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564653/4564653.jpg',
    'https://pagalworldmusic.com/download.php?title=Khayal+Rakhna-320kbps&path=downloads%2Fhigh%2FKFoOUzBCUmY%2FKFoOUzBCUmY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKhayal%2BRakhna-320kbps%26path%3Ddownloads%252Fhigh%252FKFoOUzBCUmY%252FKFoOUzBCUmY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dange' LIMIT 1), 1),
    'Aa Bhid Jaa Re by Sanjith Hegde, Dhruv Visvanath, Gaurav Godkhindi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564653/4564653.jpg',
    'https://pagalworldmusic.com/download.php?title=Aa+Bhid+Jaa+Re-320kbps&path=downloads%2Fhigh%2FORpSYUdVXWc%2FORpSYUdVXWc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAa%2BBhid%2BJaa%2BRe-320kbps%26path%3Ddownloads%252Fhigh%252FORpSYUdVXWc%252FORpSYUdVXWc.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crakk - Jeetegaa Toh Jiyegaa' LIMIT 1), 1),
    'Le Le Pangey by Sanjith Hegde, Dhruv Visvanath, Gaurav Godkhindi |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564644/4564644.jpg',
    'https://pagalworldmusic.com/download.php?title=Le+Le+Pangey-320kbps&path=downloads%2Fhigh%2FI1slQy1SR3o%2FI1slQy1SR3o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLe%2BLe%2BPangey-320kbps%26path%3Ddownloads%252Fhigh%252FI1slQy1SR3o%252FI1slQy1SR3o.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crakk - Jeetegaa Toh Jiyegaa' LIMIT 1), 1),
    'Jeena Haraam by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564644/4564644.jpg',
    'https://pagalworldmusic.com/download.php?title=Jeena+Haraam-320kbps&path=downloads%2Fhigh%2FHQ8JRUB8Alc%2FHQ8JRUB8Alc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJeena%2BHaraam-320kbps%26path%3Ddownloads%252Fhigh%252FHQ8JRUB8Alc%252FHQ8JRUB8Alc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crakk - Jeetegaa Toh Jiyegaa' LIMIT 1), 1),
    'Crakk Title Track by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564644/4564644.jpg',
    'https://pagalworldmusic.com/download.php?title=Crakk+Title+Track-320kbps&path=downloads%2Fhigh%2FQyEBVj9iAlY%2FQyEBVj9iAlY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DCrakk%2BTitle%2BTrack-320kbps%26path%3Ddownloads%252Fhigh%252FQyEBVj9iAlY%252FQyEBVj9iAlY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crakk - Jeetegaa Toh Jiyegaa' LIMIT 1), 1),
    'Dil Jhoom by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564644/4564644.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Jhoom-320kbps&path=downloads%2Fhigh%2FGwUmVRoIYFg%2FGwUmVRoIYFg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BJhoom-320kbps%26path%3Ddownloads%252Fhigh%252FGwUmVRoIYFg%252FGwUmVRoIYFg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crakk - Jeetegaa Toh Jiyegaa' LIMIT 1), 1),
    'Merry Christmas (Title Track) by Pritam |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564644/4564644.jpg',
    'https://pagalworldmusic.com/download.php?title=Merry+Christmas+%28Title+Track%29-320kbps&path=downloads%2Fhigh%2FQhssVgcHBB4%2FQhssVgcHBB4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMerry%2BChristmas%2B%2528Title%2BTrack%2529-320kbps%26path%3Ddownloads%252Fhigh%252FQhssVgcHBB4%252FQhssVgcHBB4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crakk - Jeetegaa Toh Jiyegaa' LIMIT 1), 1),
    'Rom Rom by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564644/4564644.jpg',
    'https://pagalworldmusic.com/download.php?title=Rom+Rom-320kbps&path=downloads%2Fhigh%2FOBlaQgYGT0Y%2FOBlaQgYGT0Y.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRom%2BRom-320kbps%26path%3Ddownloads%252Fhigh%252FOBlaQgYGT0Y%252FOBlaQgYGT0Y.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Heading To Scotland by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Heading+To+Scotland-320kbps&path=downloads%2Fhigh%2FPxoRZAZ3bXE%2FPxoRZAZ3bXE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHeading%2BTo%2BScotland-320kbps%26path%3Ddownloads%252Fhigh%252FPxoRZAZ3bXE%252FPxoRZAZ3bXE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Zoyas Confession by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Zoyas+Confession-320kbps&path=downloads%2Fhigh%2FER8%2CZ01dB34%2FER8%2CZ01dB34.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DZoyas%2BConfession-320kbps%26path%3Ddownloads%252Fhigh%252FER8%252CZ01dB34%252FER8%252CZ01dB34.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Irritated Abrar by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Irritated+Abrar-320kbps&path=downloads%2Fhigh%2FBT4PAxtleH0%2FBT4PAxtleH0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIrritated%2BAbrar-320kbps%26path%3Ddownloads%252Fhigh%252FBT4PAxtleH0%252FBT4PAxtleH0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Angry Abrar by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Angry+Abrar-320kbps&path=downloads%2Fhigh%2FND4eRx5YfWc%2FND4eRx5YfWc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAngry%2BAbrar-320kbps%26path%3Ddownloads%252Fhigh%252FND4eRx5YfWc%252FND4eRx5YfWc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Roaring War Machine by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Roaring+War+Machine-320kbps&path=downloads%2Fhigh%2FST4aSx5yQkk%2FST4aSx5yQkk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRoaring%2BWar%2BMachine-320kbps%26path%3Ddownloads%252Fhigh%252FST4aSx5yQkk%252FST4aSx5yQkk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'ANIMAL Meeting ANIMAL by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=ANIMAL+Meeting+ANIMAL-320kbps&path=downloads%2Fhigh%2FNjo8cDheRH8%2FNjo8cDheRH8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DANIMAL%2BMeeting%2BANIMAL-320kbps%26path%3Ddownloads%252Fhigh%252FNjo8cDheRH8%252FNjo8cDheRH8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Nude Walk by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Nude+Walk-320kbps&path=downloads%2Fhigh%2FHD89RgRYQHA%2FHD89RgRYQHA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNude%2BWalk-320kbps%26path%3Ddownloads%252Fhigh%252FHD89RgRYQHA%252FHD89RgRYQHA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Freddys Introduction by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Freddys+Introduction-320kbps&path=downloads%2Fhigh%2FIyxTZwJXBl4%2FIyxTZwJXBl4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DFreddys%2BIntroduction-320kbps%26path%3Ddownloads%252Fhigh%252FIyxTZwJXBl4%252FIyxTZwJXBl4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Aatmanirbhar Bharat by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Aatmanirbhar+Bharat-320kbps&path=downloads%2Fhigh%2FByEJf1l0ZlQ%2FByEJf1l0ZlQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAatmanirbhar%2BBharat-320kbps%26path%3Ddownloads%252Fhigh%252FByEJf1l0ZlQ%252FByEJf1l0ZlQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'ANIMAL Title Music by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=ANIMAL+Title+Music-320kbps&path=downloads%2Fhigh%2FAwEjXSteb2E%2FAwEjXSteb2E.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DANIMAL%2BTitle%2BMusic-320kbps%26path%3Ddownloads%252Fhigh%252FAwEjXSteb2E%252FAwEjXSteb2E.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Killing Jeeja by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Killing+Jeeja-320kbps&path=downloads%2Fhigh%2FF1pcXCRCXGY%2FF1pcXCRCXGY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKilling%2BJeeja-320kbps%26path%3Ddownloads%252Fhigh%252FF1pcXCRCXGY%252FF1pcXCRCXGY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Salute The Champion by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Salute+The+Champion-320kbps&path=downloads%2Fhigh%2FCC0Oe0Fgf10%2FCC0Oe0Fgf10.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSalute%2BThe%2BChampion-320kbps%26path%3Ddownloads%252Fhigh%252FCC0Oe0Fgf10%252FCC0Oe0Fgf10.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Azizs Introduction by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Azizs+Introduction-320kbps&path=downloads%2Fhigh%2FPx1GQjF1fGU%2FPx1GQjF1fGU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAzizs%2BIntroduction-320kbps%26path%3Ddownloads%252Fhigh%252FPx1GQjF1fGU%252FPx1GQjF1fGU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Heading To Kill Jeeja by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Heading+To+Kill+Jeeja-320kbps&path=downloads%2Fhigh%2FHxpdchFkQ1o%2FHxpdchFkQ1o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHeading%2BTo%2BKill%2BJeeja-320kbps%26path%3Ddownloads%252Fhigh%252FHxpdchFkQ1o%252FHxpdchFkQ1o.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Body Doubles Deception by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Body+Doubles+Deception-320kbps&path=downloads%2Fhigh%2FQwU6QgJ%2CDnA%2FQwU6QgJ%2CDnA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBody%2BDoubles%2BDeception-320kbps%26path%3Ddownloads%252Fhigh%252FQwU6QgJ%252CDnA%252FQwU6QgJ%252CDnA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Range Rover Entry by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Range+Rover+Entry-320kbps&path=downloads%2Fhigh%2FXSEpXiMHY2s%2FXSEpXiMHY2s.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRange%2BRover%2BEntry-320kbps%26path%3Ddownloads%252Fhigh%252FXSEpXiMHY2s%252FXSEpXiMHY2s.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'ANIMAL Theme by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=ANIMAL+Theme-320kbps&path=downloads%2Fhigh%2FPjE-YQFzRQI%2FPjE-YQFzRQI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DANIMAL%2BTheme-320kbps%26path%3Ddownloads%252Fhigh%252FPjE-YQFzRQI%252FPjE-YQFzRQI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Tum Se by Tanishk Bagchi, Mitraz, Raghav, Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Tum+Se-320kbps&path=downloads%2Fhigh%2FHRwsfTF3bko%2FHRwsfTF3bko.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTum%2BSe-320kbps%26path%3Ddownloads%252Fhigh%252FHRwsfTF3bko%252FHRwsfTF3bko.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Hospital Entry by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Hospital+Entry-320kbps&path=downloads%2Fhigh%2FRSIaVz0IaGA%2FRSIaVz0IaGA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHospital%2BEntry-320kbps%26path%3Ddownloads%252Fhigh%252FRSIaVz0IaGA%252FRSIaVz0IaGA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kuch Khattaa Ho Jaay' LIMIT 1), 1),
    'Akhiyaan Gulaab by Tanishk Bagchi, Mitraz, Raghav, Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564115/4564115.jpg',
    'https://pagalworldmusic.com/download.php?title=Akhiyaan+Gulaab-320kbps&path=downloads%2Fhigh%2FCiwRZiVmXFE%2FCiwRZiVmXFE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAkhiyaan%2BGulaab-320kbps%26path%3Ddownloads%252Fhigh%252FCiwRZiVmXFE%252FCiwRZiVmXFE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Laapataa Ladies' LIMIT 1), 1),
    'Tabbar Brothers Unite by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564374/4564374.jpg',
    'https://pagalworldmusic.com/download.php?title=Tabbar+Brothers+Unite-320kbps&path=downloads%2Fhigh%2FFjJdXzBWdl8%2FFjJdXzBWdl8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTabbar%2BBrothers%2BUnite-320kbps%26path%3Ddownloads%252Fhigh%252FFjJdXzBWdl8%252FFjJdXzBWdl8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Laapataa Ladies' LIMIT 1), 1),
    'Papa Meri Jaan (Whistle) by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564374/4564374.jpg',
    'https://pagalworldmusic.com/download.php?title=Papa+Meri+Jaan+%28Whistle%29-320kbps&path=downloads%2Fhigh%2FRg0TeSB2GmA%2FRg0TeSB2GmA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPapa%2BMeri%2BJaan%2B%2528Whistle%2529-320kbps%26path%3Ddownloads%252Fhigh%252FRg0TeSB2GmA%252FRg0TeSB2GmA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Laapataa Ladies' LIMIT 1), 1),
    'Skull Fight Entry by Harshavardhan Rameshwar, Vishal Mishra |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564374/4564374.jpg',
    'https://pagalworldmusic.com/download.php?title=Skull+Fight+Entry-320kbps&path=downloads%2Fhigh%2FQT0seitXZ1w%2FQT0seitXZ1w.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSkull%2BFight%2BEntry-320kbps%26path%3Ddownloads%252Fhigh%252FQT0seitXZ1w%252FQT0seitXZ1w.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Laapataa Ladies' LIMIT 1), 1),
    'Laal Peeli Akhiyaan by Tanishk Bagchi, Mitraz, Raghav, Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564374/4564374.jpg',
    'https://pagalworldmusic.com/download.php?title=Laal+Peeli+Akhiyaan-320kbps&path=downloads%2Fhigh%2FHSxbVhJWUUE%2FHSxbVhJWUUE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLaal%2BPeeli%2BAkhiyaan-320kbps%26path%3Ddownloads%252Fhigh%252FHSxbVhJWUUE%252FHSxbVhJWUUE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Satranga (Stripped) by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Satranga+%28Stripped%29-320kbps&path=downloads%2Fhigh%2FCiBfBwxGXHI%2FCiBfBwxGXHI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSatranga%2B%2528Stripped%2529-320kbps%26path%3Ddownloads%252Fhigh%252FCiBfBwxGXHI%252FCiBfBwxGXHI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Saari Duniya Jalaa Denge (Extended Film Version) by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Saari+Duniya+Jalaa+Denge+%28Extended+Film+Version%29-320kbps&path=downloads%2Fhigh%2FNQkPezBRT2U%2FNQkPezBRT2U.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSaari%2BDuniya%2BJalaa%2BDenge%2B%2528Extended%2BFilm%2BVersion%2529-320kbps%26path%3Ddownloads%252Fhigh%252FNQkPezBRT2U%252FNQkPezBRT2U.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Marham (Pehle Bhi Main) by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Marham+%28Pehle+Bhi+Main%29-320kbps&path=downloads%2Fhigh%2FKAooUxVUUUk%2FKAooUxVUUUk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMarham%2B%2528Pehle%2BBhi%2BMain%2529-320kbps%26path%3Ddownloads%252Fhigh%252FKAooUxVUUUk%252FKAooUxVUUUk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Urdu Ke Jaisa Ishq (Kashmir) by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Urdu+Ke+Jaisa+Ishq+%28Kashmir%29-320kbps&path=downloads%2Fhigh%2FQhoFSB5%2Ce3o%2FQhoFSB5%2Ce3o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DUrdu%2BKe%2BJaisa%2BIshq%2B%2528Kashmir%2529-320kbps%26path%3Ddownloads%252Fhigh%252FQhoFSB5%252Ce3o%252FQhoFSB5%252Ce3o.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'AbrarS Entry Jamal Kudu by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=AbrarS+Entry+Jamal+Kudu-320kbps&path=downloads%2Fhigh%2FOFEvSyRDYUU%2FOFEvSyRDYUU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAbrarS%2BEntry%2BJamal%2BKudu-320kbps%26path%3Ddownloads%252Fhigh%252FOFEvSyRDYUU%252FOFEvSyRDYUU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Papa Meri Jaan (Childs Version) by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Papa+Meri+Jaan+%28Childs+Version%29-320kbps&path=downloads%2Fhigh%2FQ1gJaBtIb1U%2FQ1gJaBtIb1U.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPapa%2BMeri%2BJaan%2B%2528Childs%2BVersion%2529-320kbps%26path%3Ddownloads%252Fhigh%252FQ1gJaBtIb1U%252FQ1gJaBtIb1U.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Saari Duniya Jalaa Denge by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Saari+Duniya+Jalaa+Denge-320kbps&path=downloads%2Fhigh%2FJ1sncjxIY0I%2FJ1sncjxIY0I.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSaari%2BDuniya%2BJalaa%2BDenge-320kbps%26path%3Ddownloads%252Fhigh%252FJ1sncjxIY0I%252FJ1sncjxIY0I.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Teri Baaton Mein Aisa Uljha Jiya Title Song by Tanishk Bagchi, Mitraz, Raghav, Sachin-Jigar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Teri+Baaton+Mein+Aisa+Uljha+Jiya+Title+Song-320kbps&path=downloads%2Fhigh%2FMSUYVQdHfFw%2FMSUYVQdHfFw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DTeri%2BBaaton%2BMein%2BAisa%2BUljha%2BJiya%2BTitle%2BSong-320kbps%26path%3Ddownloads%252Fhigh%252FMSUYVQdHfFw%252FMSUYVQdHfFw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Haiwaan by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Haiwaan-320kbps&path=downloads%2Fhigh%2FXSotfBtZY34%2FXSotfBtZY34.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHaiwaan-320kbps%26path%3Ddownloads%252Fhigh%252FXSotfBtZY34%252FXSotfBtZY34.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Pehle Bhi Main by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Pehle+Bhi+Main-320kbps&path=downloads%2Fhigh%2FBV0SVSEIWn8%2FBV0SVSEIWn8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPehle%2BBhi%2BMain-320kbps%26path%3Ddownloads%252Fhigh%252FBV0SVSEIWn8%252FBV0SVSEIWn8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Kashmir by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Kashmir-320kbps&path=downloads%2Fhigh%2FNTEgcB0Hc0U%2FNTEgcB0Hc0U.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKashmir-320kbps%26path%3Ddownloads%252Fhigh%252FNTEgcB0Hc0U%252FNTEgcB0Hc0U.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Satranga by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Satranga-320kbps&path=downloads%2Fhigh%2FJiAdBxNEeQo%2FJiAdBxNEeQo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSatranga-320kbps%26path%3Ddownloads%252Fhigh%252FJiAdBxNEeQo%252FJiAdBxNEeQo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Ranvijays Entry Medley by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Ranvijays+Entry+Medley-320kbps&path=downloads%2Fhigh%2FIQYKazNkAEM%2FIQYKazNkAEM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRanvijays%2BEntry%2BMedley-320kbps%26path%3Ddownloads%252Fhigh%252FIQYKazNkAEM%252FIQYKazNkAEM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Hua Main by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Hua+Main-320kbps&path=downloads%2Fhigh%2FNDkHUDp-WQY%2FNDkHUDp-WQY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHua%2BMain-320kbps%26path%3Ddownloads%252Fhigh%252FNDkHUDp-WQY%252FNDkHUDp-WQY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Papa Meri Jaan by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Papa+Meri+Jaan-320kbps&path=downloads%2Fhigh%2FPi4EdjVoAkE%2FPi4EdjVoAkE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPapa%2BMeri%2BJaan-320kbps%26path%3Ddownloads%252Fhigh%252FPi4EdjVoAkE%252FPi4EdjVoAkE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Arjan Vailly by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Arjan+Vailly-320kbps&path=downloads%2Fhigh%2FNgI5QidoDkY%2FNgI5QidoDkY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DArjan%2BVailly-320kbps%26path%3Ddownloads%252Fhigh%252FNgI5QidoDkY%252FNgI5QidoDkY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Teri Baaton Mein Aisa Uljha Jiya' LIMIT 1), 1),
    'Yaraa (From Salaar Cease Fire - Hindi) by Riya Mukherjee, Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564087/4564087.jpg',
    'https://pagalworldmusic.com/download.php?title=Yaraa+%28From+Salaar+Cease+Fire+-+Hindi%29-320kbps&path=downloads%2Fhigh%2FKQ4lcg1HVVo%2FKQ4lcg1HVVo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYaraa%2B%2528From%2BSalaar%2BCease%2BFire%2B-%2BHindi%2529-320kbps%26path%3Ddownloads%252Fhigh%252FKQ4lcg1HVVo%252FKQ4lcg1HVVo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'ANIMAL (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Sooraj Hi Chhaon Banke (From Salaar Cease Fire - Hindi) by Riya Mukherjee, Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563808/4563808.jpg',
    'https://pagalworldmusic.com/download.php?title=Sooraj+Hi+Chhaon+Banke+%28From+Salaar+Cease+Fire+-+Hindi%29-320kbps&path=downloads%2Fhigh%2FOjksYyEDBEI%2FOjksYyEDBEI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSooraj%2BHi%2BChhaon%2BBanke%2B%2528From%2BSalaar%2BCease%2BFire%2B-%2BHindi%2529-320kbps%26path%3Ddownloads%252Fhigh%252FOjksYyEDBEI%252FOjksYyEDBEI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'ANIMAL (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Bhaavein Jaane Ya Na Jaane by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563808/4563808.jpg',
    'https://pagalworldmusic.com/download.php?title=Bhaavein+Jaane+Ya+Na+Jaane-320kbps&path=downloads%2Fhigh%2FAgsfaENeD1s%2FAgsfaENeD1s.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBhaavein%2BJaane%2BYa%2BNa%2BJaane-320kbps%26path%3Ddownloads%252Fhigh%252FAgsfaENeD1s%252FAgsfaENeD1s.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'ANIMAL (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Sound of Salaar (From Salaar Cease Fire) by Riya Mukherjee, Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563808/4563808.jpg',
    'https://pagalworldmusic.com/download.php?title=Sound+of+Salaar+%28From+Salaar+Cease+Fire%29-320kbps&path=downloads%2Fhigh%2FGyMtfENxBGM%2FGyMtfENxBGM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSound%2Bof%2BSalaar%2B%2528From%2BSalaar%2BCease%2BFire%2529-320kbps%26path%3Ddownloads%252Fhigh%252FGyMtfENxBGM%252FGyMtfENxBGM.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'ANIMAL (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Iss Baar Jo Chale Gaye by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563808/4563808.jpg',
    'https://pagalworldmusic.com/download.php?title=Iss+Baar+Jo+Chale+Gaye-320kbps&path=downloads%2Fhigh%2FIQ4ERyZqBwA%2FIQ4ERyZqBwA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIss%2BBaar%2BJo%2BChale%2BGaye-320kbps%26path%3Ddownloads%252Fhigh%252FIQ4ERyZqBwA%252FIQ4ERyZqBwA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'ANIMAL (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Salaar Cease Fire Hindi Trailer Theme (From Salaar Cease Fire Hindi Trailer) by Riya Mukherjee, Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563808/4563808.jpg',
    'https://pagalworldmusic.com/download.php?title=Salaar+Cease+Fire+Hindi+Trailer+Theme+%28From+Salaar+Cease+Fire+Hindi+Trailer%29-320kbps&path=downloads%2Fhigh%2FPl0iBA55e3I%2FPl0iBA55e3I.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSalaar%2BCease%2BFire%2BHindi%2BTrailer%2BTheme%2B%2528From%2BSalaar%2BCease%2BFire%2BHindi%2BTrailer%2529-320kbps%26path%3Ddownloads%252Fhigh%252FPl0iBA55e3I%252FPl0iBA55e3I.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'ANIMAL (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Salaar - Final Punch (From Salaar Cease Fire - Hindi Trailer) by Riya Mukherjee, Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563808/4563808.jpg',
    'https://pagalworldmusic.com/download.php?title=Salaar+-+Final+Punch+%28From+Salaar+Cease+Fire+-+Hindi+Trailer%29-320kbps&path=downloads%2Fhigh%2FJSIjZxt1fAI%2FJSIjZxt1fAI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSalaar%2B-%2BFinal%2BPunch%2B%2528From%2BSalaar%2BCease%2BFire%2B-%2BHindi%2BTrailer%2529-320kbps%26path%3Ddownloads%252Fhigh%252FJSIjZxt1fAI%252FJSIjZxt1fAI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'ANIMAL (Original Motion Picture Soundtrack)' LIMIT 1), 1),
    'Jhol Jhal by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563808/4563808.jpg',
    'https://pagalworldmusic.com/download.php?title=Jhol+Jhal-320kbps&path=downloads%2Fhigh%2FIB8xABVTVF0%2FIB8xABVTVF0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJhol%2BJhal-320kbps%26path%3Ddownloads%252Fhigh%252FIB8xABVTVF0%252FIB8xABVTVF0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'ANIMAL (Deluxe Edition Album)' LIMIT 1), 1),
    'Happy Birthday by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564568/4564568.jpg',
    'https://pagalworldmusic.com/download.php?title=Happy+Birthday-320kbps&path=downloads%2Fhigh%2FMjkKQxZgGmQ%2FMjkKQxZgGmQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHappy%2BBirthday-320kbps%26path%3Ddownloads%252Fhigh%252FMjkKQxZgGmQ%252FMjkKQxZgGmQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'ANIMAL (Deluxe Edition Album)' LIMIT 1), 1),
    'Qissonmein (From Salaar Cease Fire - Hindi) by Riya Mukherjee, Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564568/4564568.jpg',
    'https://pagalworldmusic.com/download.php?title=Qissonmein+%28From+Salaar+Cease+Fire+-+Hindi%29-320kbps&path=downloads%2Fhigh%2FPwshQyteUgA%2FPwshQyteUgA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DQissonmein%2B%2528From%2BSalaar%2BCease%2BFire%2B-%2BHindi%2529-320kbps%26path%3Ddownloads%252Fhigh%252FPwshQyteUgA%252FPwshQyteUgA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'ANIMAL (Deluxe Edition Album)' LIMIT 1), 1),
    'Ishare Tere by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564568/4564568.jpg',
    'https://pagalworldmusic.com/download.php?title=Ishare+Tere-320kbps&path=downloads%2Fhigh%2FMz4GdTxncVw%2FMz4GdTxncVw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIshare%2BTere-320kbps%26path%3Ddownloads%252Fhigh%252FMz4GdTxncVw%252FMz4GdTxncVw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'ANIMAL (Deluxe Edition Album)' LIMIT 1), 1),
    'Kaali Maa (From Salaar Cease Fire - Hindi) by Riya Mukherjee, Ravi Basrur |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564568/4564568.jpg',
    'https://pagalworldmusic.com/download.php?title=Kaali+Maa+%28From+Salaar+Cease+Fire+-+Hindi%29-320kbps&path=downloads%2Fhigh%2FID0MaTpeUwM%2FID0MaTpeUwM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKaali%2BMaa%2B%2528From%2BSalaar%2BCease%2BFire%2B-%2BHindi%2529-320kbps%26path%3Ddownloads%252Fhigh%252FID0MaTpeUwM%252FID0MaTpeUwM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'ANIMAL (Deluxe Edition Album)' LIMIT 1), 1),
    'Jeena Sikhaya by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564568/4564568.jpg',
    'https://pagalworldmusic.com/download.php?title=Jeena+Sikhaya-320kbps&path=downloads%2Fhigh%2FCTw-CTFfYV0%2FCTw-CTFfYV0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJeena%2BSikhaya-320kbps%26path%3Ddownloads%252Fhigh%252FCTw-CTFfYV0%252FCTw-CTFfYV0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'ANIMAL (Deluxe Edition Album)' LIMIT 1), 1),
    'Mitti by Vishal & Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564568/4564568.jpg',
    'https://pagalworldmusic.com/download.php?title=Mitti-320kbps&path=downloads%2Fhigh%2FPCEbbi1ITmo%2FPCEbbi1ITmo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMitti-320kbps%26path%3Ddownloads%252Fhigh%252FPCEbbi1ITmo%252FPCEbbi1ITmo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'ANIMAL (Deluxe Edition Album)' LIMIT 1), 1),
    'Ishq Jaisa Kuch by Vishal & Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564568/4564568.jpg',
    'https://pagalworldmusic.com/download.php?title=Ishq+Jaisa+Kuch-320kbps&path=downloads%2Fhigh%2FHA85ejdme1Y%2FHA85ejdme1Y.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIshq%2BJaisa%2BKuch-320kbps%26path%3Ddownloads%252Fhigh%252FHA85ejdme1Y%252FHA85ejdme1Y.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Main Atal Hoon' LIMIT 1), 1),
    'Sher Khul Gaye by Vishal & Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564063/4564063.jpg',
    'https://pagalworldmusic.com/download.php?title=Sher+Khul+Gaye-320kbps&path=downloads%2Fhigh%2FEhwOdQd%2CUQQ%2FEhwOdQd%2CUQQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSher%2BKhul%2BGaye-320kbps%26path%3Ddownloads%252Fhigh%252FEhwOdQd%252CUQQ%252FEhwOdQd%252CUQQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Main Atal Hoon' LIMIT 1), 1),
    'Main Atal Hoon Theme by Payal Dev, Salim-Sulaiman, Kailash Kher, Manoj Muntashir, Shri Atal Bihari Vajpayee |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564063/4564063.jpg',
    'https://pagalworldmusic.com/download.php?title=Main+Atal+Hoon+Theme-320kbps&path=downloads%2Fhigh%2FKQ4kUAVncEo%2FKQ4kUAVncEo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMain%2BAtal%2BHoon%2BTheme-320kbps%26path%3Ddownloads%252Fhigh%252FKQ4kUAVncEo%252FKQ4kUAVncEo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Main Atal Hoon' LIMIT 1), 1),
    'Bottley Kholo by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564063/4564063.jpg',
    'https://pagalworldmusic.com/download.php?title=Bottley+Kholo-320kbps&path=downloads%2Fhigh%2FGwYBBhZURgU%2FGwYBBhZURgU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBottley%2BKholo-320kbps%26path%3Ddownloads%252Fhigh%252FGwYBBhZURgU%252FGwYBBhZURgU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Main Atal Hoon' LIMIT 1), 1),
    'Hindu Tan-Man by Payal Dev, Salim-Sulaiman, Kailash Kher, Manoj Muntashir, Shri Atal Bihari Vajpayee |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564063/4564063.jpg',
    'https://pagalworldmusic.com/download.php?title=Hindu+Tan-Man-320kbps&path=downloads%2Fhigh%2FMlwYZixoZEk%2FMlwYZixoZEk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHindu%2BTan-Man-320kbps%26path%3Ddownloads%252Fhigh%252FMlwYZixoZEk%252FMlwYZixoZEk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Main Atal Hoon' LIMIT 1), 1),
    'Ram Dhun by Payal Dev, Salim-Sulaiman, Kailash Kher, Manoj Muntashir, Shri Atal Bihari Vajpayee |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564063/4564063.jpg',
    'https://pagalworldmusic.com/download.php?title=Ram+Dhun-320kbps&path=downloads%2Fhigh%2FHQYdchV9AXk%2FHQYdchV9AXk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRam%2BDhun-320kbps%26path%3Ddownloads%252Fhigh%252FHQYdchV9AXk%252FHQYdchV9AXk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Main Atal Hoon' LIMIT 1), 1),
    'Ankaha by Payal Dev, Salim-Sulaiman, Kailash Kher, Manoj Muntashir, Shri Atal Bihari Vajpayee |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564063/4564063.jpg',
    'https://pagalworldmusic.com/download.php?title=Ankaha-320kbps&path=downloads%2Fhigh%2FHlwbeA5xdAE%2FHlwbeA5xdAE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAnkaha-320kbps%26path%3Ddownloads%252Fhigh%252FHlwbeA5xdAE%252FHlwbeA5xdAE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Fighter' LIMIT 1), 1),
    'Heer Aasmani by Vishal & Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565914/4565914.jpg',
    'https://pagalworldmusic.com/download.php?title=Heer+Aasmani-320kbps&path=downloads%2Fhigh%2FCBAyfSxWb0I%2FCBAyfSxWb0I.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHeer%2BAasmani-320kbps%26path%3Ddownloads%252Fhigh%252FCBAyfSxWb0I%252FCBAyfSxWb0I.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Fighter' LIMIT 1), 1),
    'Desh Pehle by Payal Dev, Salim-Sulaiman, Kailash Kher, Manoj Muntashir, Shri Atal Bihari Vajpayee |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565914/4565914.jpg',
    'https://pagalworldmusic.com/download.php?title=Desh+Pehle-320kbps&path=downloads%2Fhigh%2FCgMeVTwHA1k%2FCgMeVTwHA1k.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDesh%2BPehle-320kbps%26path%3Ddownloads%252Fhigh%252FCgMeVTwHA1k%252FCgMeVTwHA1k.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Fighter' LIMIT 1), 1),
    'Waheguru by Pritam, Shekhar Ravjiani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565914/4565914.jpg',
    'https://pagalworldmusic.com/download.php?title=Waheguru-320kbps&path=downloads%2Fhigh%2FPVgJV0EGRgM%2FPVgJV0EGRgM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DWaheguru-320kbps%26path%3Ddownloads%252Fhigh%252FPVgJV0EGRgM%252FPVgJV0EGRgM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Fighter' LIMIT 1), 1),
    'Main Tera Rasta Dekhunga (Film Version) by Pritam, Shekhar Ravjiani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565914/4565914.jpg',
    'https://pagalworldmusic.com/download.php?title=Main+Tera+Rasta+Dekhunga+%28Film+Version%29-320kbps&path=downloads%2Fhigh%2FHAwKewNxcH8%2FHAwKewNxcH8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMain%2BTera%2BRasta%2BDekhunga%2B%2528Film%2BVersion%2529-320kbps%26path%3Ddownloads%252Fhigh%252FHAwKewNxcH8%252FHAwKewNxcH8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Fighter' LIMIT 1), 1),
    'Raja Rani by Various Artists |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4565914/4565914.jpg',
    'https://pagalworldmusic.com/download.php?title=Raja+Rani-320kbps&path=downloads%2Fhigh%2FFAVGXCZHBx4%2FFAVGXCZHBx4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaja%2BRani-320kbps%26path%3Ddownloads%252Fhigh%252FFAVGXCZHBx4%252FFAVGXCZHBx4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Salaar Cease Fire - Hindi' LIMIT 1), 1),
    'Dil Banaane Waaleya by Vishal & Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563570/4563570.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Banaane+Waaleya-320kbps&path=downloads%2Fhigh%2FMTcPUDp%2CA1g%2FMTcPUDp%2CA1g.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BBanaane%2BWaaleya-320kbps%26path%3Ddownloads%252Fhigh%252FMTcPUDp%252CA1g%252FMTcPUDp%252CA1g.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Salaar Cease Fire - Hindi' LIMIT 1), 1),
    'Main Tera Rasta Dekhunga by Pritam, Shekhar Ravjiani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563570/4563570.jpg',
    'https://pagalworldmusic.com/download.php?title=Main+Tera+Rasta+Dekhunga-320kbps&path=downloads%2Fhigh%2FAhIJBwVjDmE%2FAhIJBwVjDmE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMain%2BTera%2BRasta%2BDekhunga-320kbps%26path%3Ddownloads%252Fhigh%252FAhIJBwVjDmE%252FAhIJBwVjDmE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Salaar Cease Fire - Hindi' LIMIT 1), 1),
    'Banda by Pritam, Shekhar Ravjiani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563570/4563570.jpg',
    'https://pagalworldmusic.com/download.php?title=Banda-320kbps&path=downloads%2Fhigh%2FXQoSciNvcVU%2FXQoSciNvcVU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBanda-320kbps%26path%3Ddownloads%252Fhigh%252FXQoSciNvcVU%252FXQoSciNvcVU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Salaar Cease Fire - Hindi' LIMIT 1), 1),
    'Chal Ve Watna by Pritam, Shekhar Ravjiani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563570/4563570.jpg',
    'https://pagalworldmusic.com/download.php?title=Chal+Ve+Watna-320kbps&path=downloads%2Fhigh%2FARxddgBmaFw%2FARxddgBmaFw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DChal%2BVe%2BWatna-320kbps%26path%3Ddownloads%252Fhigh%252FARxddgBmaFw%252FARxddgBmaFw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Salaar Cease Fire - Hindi' LIMIT 1), 1),
    'Bekaar Dil by Vishal & Shekhar |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563570/4563570.jpg',
    'https://pagalworldmusic.com/download.php?title=Bekaar+Dil-320kbps&path=downloads%2Fhigh%2FRlEBQRdyZwM%2FRlEBQRdyZwM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBekaar%2BDil-320kbps%26path%3Ddownloads%252Fhigh%252FRlEBQRdyZwM%252FRlEBQRdyZwM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Salaar Cease Fire - Hindi' LIMIT 1), 1),
    'Aune Paune Tattu by Anurag Saikia, Kaam Bhaari, Shailendra Barve |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563570/4563570.jpg',
    'https://pagalworldmusic.com/download.php?title=Aune+Paune+Tattu-320kbps&path=downloads%2Fhigh%2FEysmZRMIQHc%2FEysmZRMIQHc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAune%2BPaune%2BTattu-320kbps%26path%3Ddownloads%252Fhigh%252FEysmZRMIQHc%252FEysmZRMIQHc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Salaar Cease Fire - Hindi' LIMIT 1), 1),
    'Sundara by Anurag Saikia, Kaam Bhaari, Shailendra Barve |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563570/4563570.jpg',
    'https://pagalworldmusic.com/download.php?title=Sundara-320kbps&path=downloads%2Fhigh%2FHSEBYARVWAM%2FHSEBYARVWAM.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSundara-320kbps%26path%3Ddownloads%252Fhigh%252FHSEBYARVWAM%252FHSEBYARVWAM.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Salaar Cease Fire - Hindi' LIMIT 1), 1),
    'Ek Taara Reprise by Anurag Saikia, Kaam Bhaari, Shailendra Barve |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563570/4563570.jpg',
    'https://pagalworldmusic.com/download.php?title=Ek+Taara+Reprise-320kbps&path=downloads%2Fhigh%2FPToFfSJ3X0A%2FPToFfSJ3X0A.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DEk%2BTaara%2BReprise-320kbps%26path%3Ddownloads%252Fhigh%252FPToFfSJ3X0A%252FPToFfSJ3X0A.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dry Day' LIMIT 1), 1),
    'Kabhi Kabhi Zindagi by Anurag Saikia, Kaam Bhaari, Shailendra Barve |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563281/4563281.jpg',
    'https://pagalworldmusic.com/download.php?title=Kabhi+Kabhi+Zindagi-320kbps&path=downloads%2Fhigh%2FGiYqYiFIVUc%2FGiYqYiFIVUc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKabhi%2BKabhi%2BZindagi-320kbps%26path%3Ddownloads%252Fhigh%252FGiYqYiFIVUc%252FGiYqYiFIVUc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dry Day' LIMIT 1), 1),
    'Mast Mein Rehne Ka Title Track by Anurag Saikia, Kaam Bhaari, Shailendra Barve |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563281/4563281.jpg',
    'https://pagalworldmusic.com/download.php?title=Mast+Mein+Rehne+Ka+Title+Track-320kbps&path=downloads%2Fhigh%2FEQEjQCx9Rgs%2FEQEjQCx9Rgs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMast%2BMein%2BRehne%2BKa%2BTitle%2BTrack-320kbps%26path%3Ddownloads%252Fhigh%252FEQEjQCx9Rgs%252FEQEjQCx9Rgs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dry Day' LIMIT 1), 1),
    'Phir Se Aaj by Anurag Saikia, Kaam Bhaari, Shailendra Barve |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563281/4563281.jpg',
    'https://pagalworldmusic.com/download.php?title=Phir+Se+Aaj-320kbps&path=downloads%2Fhigh%2FKCUSeQxST3U%2FKCUSeQxST3U.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPhir%2BSe%2BAaj-320kbps%26path%3Ddownloads%252Fhigh%252FKCUSeQxST3U%252FKCUSeQxST3U.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dry Day' LIMIT 1), 1),
    'Nikle The Kabhi Hum Ghar Se by Pritam, Shekhar Ravjiani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563281/4563281.jpg',
    'https://pagalworldmusic.com/download.php?title=Nikle+The+Kabhi+Hum+Ghar+Se-320kbps&path=downloads%2Fhigh%2FPzk%2CU0FhUnc%2FPzk%2CU0FhUnc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNikle%2BThe%2BKabhi%2BHum%2BGhar%2BSe-320kbps%26path%3Ddownloads%252Fhigh%252FPzk%252CU0FhUnc%252FPzk%252CU0FhUnc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dry Day' LIMIT 1), 1),
    'Mast Mein Rehne Ka Title Track (Feat. Jackie Shroff) by Anurag Saikia, Kaam Bhaari, Shailendra Barve |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563281/4563281.jpg',
    'https://pagalworldmusic.com/download.php?title=Mast+Mein+Rehne+Ka+Title+Track+%28Feat.+Jackie+Shroff%29-320kbps&path=downloads%2Fhigh%2FHDwFcAJUYX8%2FHDwFcAJUYX8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMast%2BMein%2BRehne%2BKa%2BTitle%2BTrack%2B%2528Feat.%2BJackie%2BShroff%2529-320kbps%26path%3Ddownloads%252Fhigh%252FHDwFcAJUYX8%252FHDwFcAJUYX8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dry Day' LIMIT 1), 1),
    'Ek Taara by Anurag Saikia, Kaam Bhaari, Shailendra Barve |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563281/4563281.jpg',
    'https://pagalworldmusic.com/download.php?title=Ek+Taara-320kbps&path=downloads%2Fhigh%2FKQAkejBKaF8%2FKQAkejBKaF8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DEk%2BTaara-320kbps%26path%3Ddownloads%252Fhigh%252FKQAkejBKaF8%252FKQAkejBKaF8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dry Day' LIMIT 1), 1),
    'Gannu Mahaan by Javed-Mohsin, Protijyoti Ghosh |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563281/4563281.jpg',
    'https://pagalworldmusic.com/download.php?title=Gannu+Mahaan-320kbps&path=downloads%2Fhigh%2FKVAbegV5YXo%2FKVAbegV5YXo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGannu%2BMahaan-320kbps%26path%3Ddownloads%252Fhigh%252FKVAbegV5YXo%252FKVAbegV5YXo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dry Day' LIMIT 1), 1),
    'Lutt Putt Gaya by Pritam, Shekhar Ravjiani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563281/4563281.jpg',
    'https://pagalworldmusic.com/download.php?title=Lutt+Putt+Gaya-320kbps&path=downloads%2Fhigh%2FSRgDaxUGelA%2FSRgDaxUGelA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLutt%2BPutt%2BGaya-320kbps%26path%3Ddownloads%252Fhigh%252FSRgDaxUGelA%252FSRgDaxUGelA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Hi Papa - Hindi' LIMIT 1), 1),
    'Dur Se Darshan by Javed-Mohsin, Protijyoti Ghosh |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563525/4563525.jpg',
    'https://pagalworldmusic.com/download.php?title=Dur+Se+Darshan-320kbps&path=downloads%2Fhigh%2FN1BSBSN%2CUkU%2FN1BSBSN%2CUkU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDur%2BSe%2BDarshan-320kbps%26path%3Ddownloads%252Fhigh%252FN1BSBSN%252CUkU%252FN1BSBSN%252CUkU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Hi Papa - Hindi' LIMIT 1), 1),
    'Halla Macha by Javed-Mohsin, Protijyoti Ghosh |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563525/4563525.jpg',
    'https://pagalworldmusic.com/download.php?title=Halla+Macha-320kbps&path=downloads%2Fhigh%2FIA0iVyB8c2Q%2FIA0iVyB8c2Q.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DHalla%2BMacha-320kbps%26path%3Ddownloads%252Fhigh%252FIA0iVyB8c2Q%252FIA0iVyB8c2Q.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Hi Papa - Hindi' LIMIT 1), 1),
    'Image Banayenge by Javed-Mohsin, Protijyoti Ghosh |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563525/4563525.jpg',
    'https://pagalworldmusic.com/download.php?title=Image+Banayenge-320kbps&path=downloads%2Fhigh%2FMg4CUgNoRXQ%2FMg4CUgNoRXQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DImage%2BBanayenge-320kbps%26path%3Ddownloads%252Fhigh%252FMg4CUgNoRXQ%252FMg4CUgNoRXQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Hi Papa - Hindi' LIMIT 1), 1),
    'O Maahi by Pritam, Shekhar Ravjiani |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563525/4563525.jpg',
    'https://pagalworldmusic.com/download.php?title=O+Maahi-320kbps&path=downloads%2Fhigh%2FBwsYdR1jRHI%2FBwsYdR1jRHI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DO%2BMaahi-320kbps%26path%3Ddownloads%252Fhigh%252FBwsYdR1jRHI%252FBwsYdR1jRHI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Hi Papa - Hindi' LIMIT 1), 1),
    'Dheeme Dheeme by Ram Sampath |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563525/4563525.jpg',
    'https://pagalworldmusic.com/download.php?title=Dheeme+Dheeme-320kbps&path=downloads%2Fhigh%2FAV4iRixVWGs%2FAV4iRixVWGs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDheeme%2BDheeme-320kbps%26path%3Ddownloads%252Fhigh%252FAV4iRixVWGs%252FAV4iRixVWGs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mast Mein Rehne Ka' LIMIT 1), 1),
    'Doubtwa by Ram Sampath |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564561/4564561.jpg',
    'https://pagalworldmusic.com/download.php?title=Doubtwa-320kbps&path=downloads%2Fhigh%2FAVlbaBAHf2o%2FAVlbaBAHf2o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDoubtwa-320kbps%26path%3Ddownloads%252Fhigh%252FAVlbaBAHf2o%252FAVlbaBAHf2o.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mast Mein Rehne Ka' LIMIT 1), 1),
    'Na Bhoola Tujhe by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564561/4564561.jpg',
    'https://pagalworldmusic.com/download.php?title=Na+Bhoola+Tujhe-320kbps&path=downloads%2Fhigh%2FMxkcVS5KdGE%2FMxkcVS5KdGE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNa%2BBhoola%2BTujhe-320kbps%26path%3Ddownloads%252Fhigh%252FMxkcVS5KdGE%252FMxkcVS5KdGE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mast Mein Rehne Ka' LIMIT 1), 1),
    'Mann Mein Jo by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564561/4564561.jpg',
    'https://pagalworldmusic.com/download.php?title=Mann+Mein+Jo-320kbps&path=downloads%2Fhigh%2FPhkffgVqYWo%2FPhkffgVqYWo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMann%2BMein%2BJo-320kbps%26path%3Ddownloads%252Fhigh%252FPhkffgVqYWo%252FPhkffgVqYWo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mast Mein Rehne Ka' LIMIT 1), 1),
    'Sajni by Ram Sampath |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4564561/4564561.jpg',
    'https://pagalworldmusic.com/download.php?title=Sajni-320kbps&path=downloads%2Fhigh%2FNipTZjZZYEU%2FNipTZjZZYEU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSajni-320kbps%26path%3Ddownloads%252Fhigh%252FNipTZjZZYEU%252FNipTZjZZYEU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kho Gaye Hum Kahan' LIMIT 1), 1),
    'Beda Paar by Ram Sampath |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563291/4563291.jpg',
    'https://pagalworldmusic.com/download.php?title=Beda+Paar-320kbps&path=downloads%2Fhigh%2FQxxdAUNUZVc%2FQxxdAUNUZVc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBeda%2BPaar-320kbps%26path%3Ddownloads%252Fhigh%252FQxxdAUNUZVc%252FQxxdAUNUZVc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kho Gaye Hum Kahan' LIMIT 1), 1),
    'Aye Khuda by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563291/4563291.jpg',
    'https://pagalworldmusic.com/download.php?title=Aye+Khuda-320kbps&path=downloads%2Fhigh%2FCAwPRjhVeh4%2FCAwPRjhVeh4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAye%2BKhuda-320kbps%26path%3Ddownloads%252Fhigh%252FCAwPRjhVeh4%252FCAwPRjhVeh4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kho Gaye Hum Kahan' LIMIT 1), 1),
    'Sun Liya by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563291/4563291.jpg',
    'https://pagalworldmusic.com/download.php?title=Sun+Liya-320kbps&path=downloads%2Fhigh%2FCFAdATpFTws%2FCFAdATpFTws.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSun%2BLiya-320kbps%26path%3Ddownloads%252Fhigh%252FCFAdATpFTws%252FCFAdATpFTws.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kho Gaye Hum Kahan' LIMIT 1), 1),
    'Saaya Tera by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563291/4563291.jpg',
    'https://pagalworldmusic.com/download.php?title=Saaya+Tera-320kbps&path=downloads%2Fhigh%2FKgQSdTkGVQA%2FKgQSdTkGVQA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSaaya%2BTera-320kbps%26path%3Ddownloads%252Fhigh%252FKgQSdTkGVQA%252FKgQSdTkGVQA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kho Gaye Hum Kahan' LIMIT 1), 1),
    'Sheeshe Ki Gudiya by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563291/4563291.jpg',
    'https://pagalworldmusic.com/download.php?title=Sheeshe+Ki+Gudiya-320kbps&path=downloads%2Fhigh%2FAwIAQFkdZkA%2FAwIAQFkdZkA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSheeshe%2BKi%2BGudiya-320kbps%26path%3Ddownloads%252Fhigh%252FAwIAQFkdZkA%252FAwIAQFkdZkA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kho Gaye Hum Kahan' LIMIT 1), 1),
    'Daata by Javed-Mohsin, Protijyoti Ghosh |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563291/4563291.jpg',
    'https://pagalworldmusic.com/download.php?title=Daata-320kbps&path=downloads%2Fhigh%2FBi0Cdg5FWng%2FBi0Cdg5FWng.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDaata-320kbps%26path%3Ddownloads%252Fhigh%252FBi0Cdg5FWng%252FBi0Cdg5FWng.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kho Gaye Hum Kahan' LIMIT 1), 1),
    'Pyara Laage by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563291/4563291.jpg',
    'https://pagalworldmusic.com/download.php?title=Pyara+Laage-320kbps&path=downloads%2Fhigh%2FMS8-ZjsFcAU%2FMS8-ZjsFcAU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPyara%2BLaage-320kbps%26path%3Ddownloads%252Fhigh%252FMS8-ZjsFcAU%252FMS8-ZjsFcAU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kho Gaye Hum Kahan' LIMIT 1), 1),
    'Itni Itni by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563291/4563291.jpg',
    'https://pagalworldmusic.com/download.php?title=Itni+Itni-320kbps&path=downloads%2Fhigh%2FL1okQT0FcR4%2FL1okQT0FcR4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DItni%2BItni-320kbps%26path%3Ddownloads%252Fhigh%252FL1okQT0FcR4%252FL1okQT0FcR4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kho Gaye Hum Kahan' LIMIT 1), 1),
    'Pehla Pehla by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563291/4563291.jpg',
    'https://pagalworldmusic.com/download.php?title=Pehla+Pehla-320kbps&path=downloads%2Fhigh%2FOilYHB0FQVo%2FOilYHB0FQVo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPehla%2BPehla-320kbps%26path%3Ddownloads%252Fhigh%252FOilYHB0FQVo%252FOilYHB0FQVo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kho Gaye Hum Kahan' LIMIT 1), 1),
    'Odiyamma by Hesham Abdul Wahab |MP3 Song Download| Pagalworld Music Com',
    '',
    'https://pagalworldmusic.com/downloads/cover/4563291/4563291.jpg',
    'https://pagalworldmusic.com/download.php?title=Odiyamma-320kbps&path=downloads%2Fhigh%2FBSw%2CADtvU3g%2FBSw%2CADtvU3g.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DOdiyamma-320kbps%26path%3Ddownloads%252Fhigh%252FBSw%252CADtvU3g%252FBSw%252CADtvU3g.mp3',
    NOW(),
    NOW()
);

