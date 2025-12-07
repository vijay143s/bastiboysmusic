-- Songs INSERT statements
-- Uses COALESCE to link to album_id by title
-- Includes pre-generated stream_url for instant playback

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Konchi Pesalama' LIMIT 1), 1),
    'Ezhu Vannam',
    'Ilaiyaraaja',
    'https://pagalworldmusic.com/downloads/cover/3182046/3182046.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Konchi Pesalama' LIMIT 1), 1),
    'Oru Kili Oru Kili',
    'Satish Chakravarthy',
    'https://pagalworldmusic.com/downloads/cover/3182012/3182012.jpg',
    'https://pagalworldmusic.com/download.php?title=Oru+Kili+Oru+Kili-320kbps&path=downloads%2Fhigh%2FPjgzRS59RGo%2FPjgzRS59RGo.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DOru%2BKili%2BOru%2BKili-320kbps%26path%3Ddownloads%252Fhigh%252FPjgzRS59RGo%252FPjgzRS59RGo.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Konchi Pesalama' LIMIT 1), 1),
    'Kaiyile Panam Irundhal',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181989/3181989.jpg',
    'https://pagalworldmusic.com/download.php?title=Kaiyile+Panam+Irundhal-320kbps&path=downloads%2Fhigh%2FAzcoaTxaR14%2FAzcoaTxaR14.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKaiyile%2BPanam%2BIrundhal-320kbps%26path%3Ddownloads%252Fhigh%252FAzcoaTxaR14%252FAzcoaTxaR14.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Konchi Pesalama' LIMIT 1), 1),
    'Jilendru Oru Kalavaram',
    'Satish Chakravarthy',
    'https://pagalworldmusic.com/downloads/cover/3182011/3182011.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Konchi Pesalama' LIMIT 1), 1),
    'Unnai Thedi',
    'Ilaiyaraaja',
    'https://pagalworldmusic.com/downloads/cover/3182043/3182043.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Konchi Pesalama' LIMIT 1), 1),
    'Kasthoori Pottu',
    'Ilaiyaraaja',
    'https://pagalworldmusic.com/downloads/cover/3182045/3182045.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Leelai' LIMIT 1), 1),
    'Aadhara Suruthi',
    'Ilaiyaraaja',
    'https://pagalworldmusic.com/downloads/cover/3182047/3182047.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Leelai' LIMIT 1), 1),
    'Siru Siru Siragugal',
    'Ilaiyaraaja',
    'https://pagalworldmusic.com/downloads/cover/3182044/3182044.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Leelai' LIMIT 1), 1),
    'Aah Aah Ithu Nalliravu',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181990/3181990.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Leelai' LIMIT 1), 1),
    'Bubble Gum',
    'Satish Chakravarthy',
    'https://pagalworldmusic.com/downloads/cover/3182015/3182015.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Leelai' LIMIT 1), 1),
    'Idhu Varai',
    'Ilaiyaraaja',
    'https://pagalworldmusic.com/downloads/cover/3182048/3182048.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Leelai' LIMIT 1), 1),
    'Ponmalai Pozhudu',
    'Satish Chakravarthy',
    'https://pagalworldmusic.com/downloads/cover/3182013/3182013.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L R Eswari Cine Classics Hits' LIMIT 1), 1),
    'Ungu Unnada Sivamae',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181988/3181988.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L R Eswari Cine Classics Hits' LIMIT 1), 1),
    'Oru Kili Oru Kili (Reprise)',
    'Satish Chakravarthy',
    'https://pagalworldmusic.com/downloads/cover/3182016/3182016.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L R Eswari Cine Classics Hits' LIMIT 1), 1),
    'Unnai Partha Pinbhu',
    'Satish Chakravarthy',
    'https://pagalworldmusic.com/downloads/cover/3182014/3182014.jpg',
    'https://pagalworldmusic.com/download.php?title=Unnai+Partha+Pinbhu-320kbps&path=downloads%2Fhigh%2FMl8ffT4AfUk%2FMl8ffT4AfUk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DUnnai%2BPartha%2BPinbhu-320kbps%26path%3Ddownloads%252Fhigh%252FMl8ffT4AfUk%252FMl8ffT4AfUk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L R Eswari Cine Classics Hits' LIMIT 1), 1),
    'Oh Pappa Oh Pappa',
    'Sirpy',
    'https://pagalworldmusic.com/downloads/cover/3182054/3182054.jpg',
    'https://pagalworldmusic.com/download.php?title=Oh+Pappa+Oh+Pappa-320kbps&path=downloads%2Fhigh%2FAQkjSzpcQXw%2FAQkjSzpcQXw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DOh%2BPappa%2BOh%2BPappa-320kbps%26path%3Ddownloads%252Fhigh%252FAQkjSzpcQXw%252FAQkjSzpcQXw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L R Eswari Cine Classics Hits' LIMIT 1), 1),
    'Azhagaana Malayalam',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181987/3181987.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L R Eswari Cine Classics Hits' LIMIT 1), 1),
    'Thaththi Thaththi Nadandhuvarum',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181985/3181985.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kodambakkam' LIMIT 1), 1),
    'Charcha Meri Kahani',
    'Sirpy',
    'https://pagalworldmusic.com/downloads/cover/3182052/3182052.jpg',
    'https://pagalworldmusic.com/download.php?title=Charcha+Meri+Kahani-320kbps&path=downloads%2Fhigh%2FJCZYfhBXAws%2FJCZYfhBXAws.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DCharcha%2BMeri%2BKahani-320kbps%26path%3Ddownloads%252Fhigh%252FJCZYfhBXAws%252FJCZYfhBXAws.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kodambakkam' LIMIT 1), 1),
    'Naam Iruvar',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181972/3181972.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kodambakkam' LIMIT 1), 1),
    'Ragasiyamanadhu Kadhal - Male',
    'Sirpy',
    'https://pagalworldmusic.com/downloads/cover/3182050/3182050.jpg',
    'https://pagalworldmusic.com/download.php?title=Ragasiyamanadhu+Kadhal+-+Male-320kbps&path=downloads%2Fhigh%2FCAcebgF1eVs%2FCAcebgF1eVs.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRagasiyamanadhu%2BKadhal%2B-%2BMale-320kbps%26path%3Ddownloads%252Fhigh%252FCAcebgF1eVs%252FCAcebgF1eVs.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kodambakkam' LIMIT 1), 1),
    'Ragasiyamanadhu Kaadhal - Female',
    'Sirpy',
    'https://pagalworldmusic.com/downloads/cover/3182053/3182053.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kodambakkam' LIMIT 1), 1),
    'Ninaiththapadi Kidaiththadadi',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181970/3181970.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kodambakkam' LIMIT 1), 1),
    'Muththana Oorgolamo',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181969/3181969.jpg',
    'https://pagalworldmusic.com/download.php?title=Muththana+Oorgolamo-320kbps&path=downloads%2Fhigh%2FGhg5aCt4egA%2FGhg5aCt4egA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMuththana%2BOorgolamo-320kbps%26path%3Ddownloads%252Fhigh%252FGhg5aCt4egA%252FGhg5aCt4egA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L.R.Eswari Ivvalavuthan Ulagam Vol 2' LIMIT 1), 1),
    'En Valibam Ennum',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181971/3181971.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L.R.Eswari Ivvalavuthan Ulagam Vol 2' LIMIT 1), 1),
    'Kodambakkam Engal',
    'Sirpy',
    'https://pagalworldmusic.com/downloads/cover/3182049/3182049.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L.R.Eswari Ivvalavuthan Ulagam Vol 2' LIMIT 1), 1),
    'Yaaradi Vanthar',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181967/3181967.jpg',
    'https://pagalworldmusic.com/download.php?title=Yaaradi+Vanthar-320kbps&path=downloads%2Fhigh%2FQBIlXytCVn0%2FQBIlXytCVn0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYaaradi%2BVanthar-320kbps%26path%3Ddownloads%252Fhigh%252FQBIlXytCVn0%252FQBIlXytCVn0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L.R.Eswari Ivvalavuthan Ulagam Vol 2' LIMIT 1), 1),
    'Kaettathu Kidaikkum',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181986/3181986.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L.R.Eswari Ivvalavuthan Ulagam Vol 2' LIMIT 1), 1),
    'Oonjai Katti Aadattuma',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181968/3181968.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L.R.Eswari Ivvalavuthan Ulagam Vol 2' LIMIT 1), 1),
    'Adi Nee Oru Super',
    'Sirpy',
    'https://pagalworldmusic.com/downloads/cover/3182051/3182051.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Iravuppaadagan (From Oorukku Uzhaippavan)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182042/3182042.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Enna Sugam (From Pallaandu Vaazhga)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182040/3182040.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Sorgatthin Thirappuvaizha (From Pallaandu Vaazhga)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182041/3182041.jpg',
    'https://pagalworldmusic.com/download.php?title=Sorgatthin+Thirappuvaizha+%28From+Pallaandu+Vaazhga%29-320kbps&path=downloads%2Fhigh%2FFSknYhpEDlg%2FFSknYhpEDlg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSorgatthin%2BThirappuvaizha%2B%2528From%2BPallaandu%2BVaazhga%2529-320kbps%26path%3Ddownloads%252Fhigh%252FFSknYhpEDlg%252FFSknYhpEDlg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Ithuthaan Muthal Raaththiri (From Oorukku Uzhaippavan)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182039/3182039.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Azhagiya Oviyam (From Oorukku Uzhaippavan)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182038/3182038.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Kaathal Enbathu (From Naalai Namathey)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182037/3182037.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Poi Vaa Nadhiyalaiyae (From Pallaandu Vaazhga)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182034/3182034.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Anbukku Naan Adimai (From Indrupol Endrum Vaazhga)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182032/3182032.jpg',
    'https://pagalworldmusic.com/download.php?title=Anbukku+Naan+Adimai+%28From+Indrupol+Endrum+Vaazhga%29-320kbps&path=downloads%2Fhigh%2FJTIvfEVRGls%2FJTIvfEVRGls.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAnbukku%2BNaan%2BAdimai%2B%2528From%2BIndrupol%2BEndrum%2BVaazhga%2529-320kbps%26path%3Ddownloads%252Fhigh%252FJTIvfEVRGls%252FJTIvfEVRGls.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Thendralil Aadidum (From Maduraiyai Meetta Sundarapandian)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182031/3182031.jpg',
    'https://pagalworldmusic.com/download.php?title=Thendralil+Aadidum+%28From+Maduraiyai+Meetta+Sundarapandian%29-320kbps&path=downloads%2Fhigh%2FACE%2CBxZDQ3Y%2FACE%2CBxZDQ3Y.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThendralil%2BAadidum%2B%2528From%2BMaduraiyai%2BMeetta%2BSundarapandian%2529-320kbps%26path%3Ddownloads%252Fhigh%252FACE%252CBxZDQ3Y%252FACE%252CBxZDQ3Y.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Ennai Vittal (From Naalai Namathey)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182030/3182030.jpg',
    'https://pagalworldmusic.com/download.php?title=Ennai+Vittal+%28From+Naalai+Namathey%29-320kbps&path=downloads%2Fhigh%2FEh0HCRgdD1w%2FEh0HCRgdD1w.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DEnnai%2BVittal%2B%2528From%2BNaalai%2BNamathey%2529-320kbps%26path%3Ddownloads%252Fhigh%252FEh0HCRgdD1w%252FEh0HCRgdD1w.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Naalai Ulagai (From Uzhaikkum Karangal)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182036/3182036.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Neela Nayanangalil (From Naalai Namathey)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182033/3182033.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Ondre Kulamendru (From Pallaandu Vaazhga)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182028/3182028.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Thangathil Mugameduththu (From Meenava Nanban)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182029/3182029.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'K.J. Yesudas Sings For Mgr' LIMIT 1), 1),
    'Thanga Thoniyile (From Ulagam Sutrum Valiban)',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/3182035/3182035.jpg',
    'https://pagalworldmusic.com/download.php?title=Thanga+Thoniyile+%28From+Ulagam+Sutrum+Valiban%29-320kbps&path=downloads%2Fhigh%2FOAcMAEEHBmY%2FOAcMAEEHBmY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DThanga%2BThoniyile%2B%2528From%2BUlagam%2BSutrum%2BValiban%2529-320kbps%26path%3Ddownloads%252Fhigh%252FOAcMAEEHBmY%252FOAcMAEEHBmY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L. Ramesh Cine Jewels On Guitar' LIMIT 1), 1),
    'Sandhana Thendral Guitar (Film  Kandukondain Kandukondian)',
    'L. Ramesh',
    'https://pagalworldmusic.com/downloads/cover/3181982/3181982.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L. Ramesh Cine Jewels On Guitar' LIMIT 1), 1),
    'Nee Katru Naan Maram Guitar (Film  Nilaavae Vaa)',
    'L. Ramesh',
    'https://pagalworldmusic.com/downloads/cover/3181983/3181983.jpg',
    'https://pagalworldmusic.com/download.php?title=Nee+Katru+Naan+Maram+Guitar+%28Film++Nilaavae+Vaa%29-320kbps&path=downloads%2Fhigh%2FFxIiHCdFflU%2FFxIiHCdFflU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNee%2BKatru%2BNaan%2BMaram%2BGuitar%2B%2528Film%2B%2BNilaavae%2BVaa%2529-320kbps%26path%3Ddownloads%252Fhigh%252FFxIiHCdFflU%252FFxIiHCdFflU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L. Ramesh Cine Jewels On Guitar' LIMIT 1), 1),
    'Kick Yearuthae Guitar (Film  Padayappa)',
    'L. Ramesh',
    'https://pagalworldmusic.com/downloads/cover/3181984/3181984.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L. Ramesh Cine Jewels On Guitar' LIMIT 1), 1),
    'Velinaattu Kaattru Guitar (Film  Vaanavil)',
    'L. Ramesh',
    'https://pagalworldmusic.com/downloads/cover/3181981/3181981.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L. Ramesh Cine Jewels On Guitar' LIMIT 1), 1),
    'O Lakshmi',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181977/3181977.jpg',
    'https://pagalworldmusic.com/download.php?title=O+Lakshmi-320kbps&path=downloads%2Fhigh%2FBDxdZFkJdlE%2FBDxdZFkJdlE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DO%2BLakshmi-320kbps%26path%3Ddownloads%252Fhigh%252FBDxdZFkJdlE%252FBDxdZFkJdlE.mp3',
    NOW(),
    NOW()
);

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'L.R.Eswari Paarvai Ondre Pothume Hits' LIMIT 1), 1),
    'Kadalenum Guitar (Film  Kadalar Dhinam)',
    'L. Ramesh',
    'https://pagalworldmusic.com/downloads/cover/3181980/3181980.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L.R.Eswari Paarvai Ondre Pothume Hits' LIMIT 1), 1),
    'Thenatrangkara Iyinile',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181976/3181976.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L.R.Eswari Paarvai Ondre Pothume Hits' LIMIT 1), 1),
    'Vaadai Kaatramma',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181975/3181975.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L.R.Eswari Paarvai Ondre Pothume Hits' LIMIT 1), 1),
    'Ammano Samiyo',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181978/3181978.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L.R.Eswari Paarvai Ondre Pothume Hits' LIMIT 1), 1),
    'Aarambam Indrey Aagattum',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181979/3181979.jpg',
    'https://pagalworldmusic.com/download.php?title=Aarambam+Indrey+Aagattum-320kbps&path=downloads%2Fhigh%2FQQ8FXhdgTwU%2FQQ8FXhdgTwU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAarambam%2BIndrey%2BAagattum-320kbps%26path%3Ddownloads%252Fhigh%252FQQ8FXhdgTwU%252FQQ8FXhdgTwU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L.R.Eswari Paarvai Ondre Pothume Hits' LIMIT 1), 1),
    'Uravinil Fifty Fifty',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181973/3181973.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'L.R.Eswari Paarvai Ondre Pothume Hits' LIMIT 1), 1),
    'Mini Mini Poochigal',
    'L. R. Eswari',
    'https://pagalworldmusic.com/downloads/cover/3181974/3181974.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'We Will',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3182008/3182008.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'In To Your',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3182010/3182010.jpg',
    'https://pagalworldmusic.com/download.php?title=In+To+Your-320kbps&path=downloads%2Fhigh%2FKgUZfTBXDnU%2FKgUZfTBXDnU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DIn%2BTo%2BYour-320kbps%26path%3Ddownloads%252Fhigh%252FKgUZfTBXDnU%252FKgUZfTBXDnU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'We Bring',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3182009/3182009.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'The Name',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3182007/3182007.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'The Lord',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3182006/3182006.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'Iam In',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3182004/3182004.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'Because He',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3182002/3182002.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'Will Bless',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3182000/3182000.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'Celebrate',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3182001/3182001.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'Father You',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3181999/3181999.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'God Has',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3181997/3181997.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'He Is',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3182005/3182005.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'Majesty',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3181996/3181996.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'Prasing The',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3182003/3182003.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'Gods Not',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3181994/3181994.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'Worthy Of',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3181993/3181993.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'Prase The',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3181998/3181998.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'Let The',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3181995/3181995.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Letus Worship' LIMIT 1), 1),
    'Put On The',
    'Angeline Jacob, Jane Jacob, Pastor Jacob, Jason Jacob, Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3181992/3181992.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kandhapuranam Vol   6' LIMIT 1), 1),
    'Devayanai Vall Thirumanam',
    'Thiru Muruga Kirubananda Variyar',
    'https://pagalworldmusic.com/downloads/cover/3182017/3182017.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kandhapuranam Vol   4' LIMIT 1), 1),
    'Veeragu Devar Thoothu',
    'Thiru Muruga Kirubananda Variyar',
    'https://pagalworldmusic.com/downloads/cover/3182019/3182019.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kannum Kannum' LIMIT 1), 1),
    'Kannum Kannum',
    'Urumi Band',
    'https://pagalworldmusic.com/downloads/cover/3182022/3182022.jpg',
    'https://pagalworldmusic.com/download.php?title=Kannum+Kannum-320kbps&path=downloads%2Fhigh%2FRz1YQy1ofEQ%2FRz1YQy1ofEQ.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKannum%2BKannum-320kbps%26path%3Ddownloads%252Fhigh%252FRz1YQy1ofEQ%252FRz1YQy1ofEQ.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kadhalukku' LIMIT 1), 1),
    'Kadhalukku',
    'Sheriff',
    'https://pagalworldmusic.com/downloads/cover/3182025/3182025.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kandhapuranam Vol   3' LIMIT 1), 1),
    'Vel Perttru Vidai Peruthal',
    'Thiru Muruga Kirubananda Variyar',
    'https://pagalworldmusic.com/downloads/cover/3182020/3182020.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kung Superstar (From Kung Kutta 2)' LIMIT 1), 1),
    'Kampung Superstar (From kampung kutta 2)',
    'Ram Nath Rnb, Saint TFC, Nashvin Ash',
    'https://pagalworldmusic.com/downloads/cover/3182024/3182024.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kandhapuranam Vol   2' LIMIT 1), 1),
    'Murugavel Thiru Avadharam',
    'Thiru Muruga Kirubananda Variyar',
    'https://pagalworldmusic.com/downloads/cover/3182021/3182021.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kaadhal Theevey (From Dharala Prabhu)' LIMIT 1), 1),
    'Kaadhal Theevey (From Dharala Prabhu)',
    'Sean Roldan',
    'https://pagalworldmusic.com/downloads/cover/3182023/3182023.jpg',
    'https://pagalworldmusic.com/download.php?title=Kaadhal+Theevey+%28From+Dharala+Prabhu%29-320kbps&path=downloads%2Fhigh%2FNlk9ez9IfGU%2FNlk9ez9IfGU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKaadhal%2BTheevey%2B%2528From%2BDharala%2BPrabhu%2529-320kbps%26path%3Ddownloads%252Fhigh%252FNlk9ez9IfGU%252FNlk9ez9IfGU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Life Of Jesus (Vol. 2)' LIMIT 1), 1),
    'Life Of Jesus - Vol.2',
    'Bhushan Dua',
    'https://pagalworldmusic.com/downloads/cover/3181991/3181991.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kandhapuranam Vol   5' LIMIT 1), 1),
    'Soorapathaman Peruvazhvu',
    'Thiru Muruga Kirubananda Variyar',
    'https://pagalworldmusic.com/downloads/cover/3182018/3182018.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Karuppankaatu Valasu' LIMIT 1), 1),
    'Puyal Kaatha',
    'Adithyha Soorya',
    'https://pagalworldmusic.com/downloads/cover/3182026/3182026.jpg',
    NULL,
    NULL,
    NOW(),
    NOW()
);

