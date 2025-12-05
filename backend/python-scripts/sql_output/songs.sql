-- Songs INSERT statements
-- Uses COALESCE to link to album_id by title
-- Includes pre-generated stream_url for instant playback

INSERT IGNORE INTO songs (
    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at
) VALUES
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dange' LIMIT 1), 1),
    'Khel',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/4564644/4564644.jpg',
    'https://pagalworldmusic.com/download.php?title=Khel-320kbps&path=downloads%2Fhigh%2FFSk9WzpAb2E%2FFSk9WzpAb2E.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKhel-320kbps%26path%3Ddownloads%252Fhigh%252FFSk9WzpAb2E%252FFSk9WzpAb2E.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dange' LIMIT 1), 1),
    'Dil Ki Mez',
    'Pritam',
    'https://pagalworldmusic.com/downloads/cover/4564653/4564653.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Ki+Mez-320kbps&path=downloads%2Fhigh%2FHCAfZx5jcwE%2FHCAfZx5jcwE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BKi%2BMez-320kbps%26path%3Ddownloads%252Fhigh%252FHCAfZx5jcwE%252FHCAfZx5jcwE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dange' LIMIT 1), 1),
    'Le Le Pangey',
    'Sanjith Hegde, Dhruv Visvanath, Gaurav Godkhindi',
    'https://pagalworldmusic.com/downloads/cover/4564837/4564837.jpg',
    'https://pagalworldmusic.com/download.php?title=Le+Le+Pangey-320kbps&path=downloads%2Fhigh%2FI1slQy1SR3o%2FI1slQy1SR3o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DLe%2BLe%2BPangey-320kbps%26path%3Ddownloads%252Fhigh%252FI1slQy1SR3o%252FI1slQy1SR3o.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dange' LIMIT 1), 1),
    'Jeena Haraam',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/4564641/4564641.jpg',
    'https://pagalworldmusic.com/download.php?title=Jeena+Haraam-320kbps&path=downloads%2Fhigh%2FHQ8JRUB8Alc%2FHQ8JRUB8Alc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DJeena%2BHaraam-320kbps%26path%3Ddownloads%252Fhigh%252FHQ8JRUB8Alc%252FHQ8JRUB8Alc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Merry Christmas' LIMIT 1), 1),
    'Khayal Rakhna',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/4564643/4564643.jpg',
    'https://pagalworldmusic.com/download.php?title=Khayal+Rakhna-320kbps&path=downloads%2Fhigh%2FKFoOUzBCUmY%2FKFoOUzBCUmY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKhayal%2BRakhna-320kbps%26path%3Ddownloads%252Fhigh%252FKFoOUzBCUmY%252FKFoOUzBCUmY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Merry Christmas' LIMIT 1), 1),
    'Crakk Title Track',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/4564642/4564642.jpg',
    'https://pagalworldmusic.com/download.php?title=Crakk+Title+Track-320kbps&path=downloads%2Fhigh%2FQyEBVj9iAlY%2FQyEBVj9iAlY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DCrakk%2BTitle%2BTrack-320kbps%26path%3Ddownloads%252Fhigh%252FQyEBVj9iAlY%252FQyEBVj9iAlY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Merry Christmas' LIMIT 1), 1),
    'Yeh Pal Hain Apne',
    'Sanjith Hegde, Dhruv Visvanath, Gaurav Godkhindi',
    'https://pagalworldmusic.com/downloads/cover/4564838/4564838.jpg',
    'https://pagalworldmusic.com/download.php?title=Yeh+Pal+Hain+Apne-320kbps&path=downloads%2Fhigh%2FPlsdBxldDmw%2FPlsdBxldDmw.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYeh%2BPal%2BHain%2BApne-320kbps%26path%3Ddownloads%252Fhigh%252FPlsdBxldDmw%252FPlsdBxldDmw.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Merry Christmas' LIMIT 1), 1),
    'Dange Theme',
    'Sanjith Hegde, Dhruv Visvanath, Gaurav Godkhindi',
    'https://pagalworldmusic.com/downloads/cover/4564840/4564840.jpg',
    'https://pagalworldmusic.com/download.php?title=Dange+Theme-320kbps&path=downloads%2Fhigh%2FQws-BAJ2AAc%2FQws-BAJ2AAc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDange%2BTheme-320kbps%26path%3Ddownloads%252Fhigh%252FQws-BAJ2AAc%252FQws-BAJ2AAc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crakk Jeetegaa Toh Jiyegaa' LIMIT 1), 1),
    'Nazar Teri Toofan',
    'Pritam',
    'https://pagalworldmusic.com/downloads/cover/4564651/4564651.jpg',
    'https://pagalworldmusic.com/download.php?title=Nazar+Teri+Toofan-320kbps&path=downloads%2Fhigh%2FPDcFWxBSfws%2FPDcFWxBSfws.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNazar%2BTeri%2BToofan-320kbps%26path%3Ddownloads%252Fhigh%252FPDcFWxBSfws%252FPDcFWxBSfws.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crakk Jeetegaa Toh Jiyegaa' LIMIT 1), 1),
    'Dil Jhoom',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/4564639/4564639.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Jhoom-320kbps&path=downloads%2Fhigh%2FGwUmVRoIYFg%2FGwUmVRoIYFg.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BJhoom-320kbps%26path%3Ddownloads%252Fhigh%252FGwUmVRoIYFg%252FGwUmVRoIYFg.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crakk Jeetegaa Toh Jiyegaa' LIMIT 1), 1),
    'Aa Bhid Jaa Re',
    'Sanjith Hegde, Dhruv Visvanath, Gaurav Godkhindi',
    'https://pagalworldmusic.com/downloads/cover/4564839/4564839.jpg',
    'https://pagalworldmusic.com/download.php?title=Aa+Bhid+Jaa+Re-320kbps&path=downloads%2Fhigh%2FORpSYUdVXWc%2FORpSYUdVXWc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DAa%2BBhid%2BJaa%2BRe-320kbps%26path%3Ddownloads%252Fhigh%252FORpSYUdVXWc%252FORpSYUdVXWc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crakk Jeetegaa Toh Jiyegaa' LIMIT 1), 1),
    'Merry Christmas (Title Track)',
    'Pritam',
    'https://pagalworldmusic.com/downloads/cover/4564650/4564650.jpg',
    'https://pagalworldmusic.com/download.php?title=Merry+Christmas+%28Title+Track%29-320kbps&path=downloads%2Fhigh%2FQhssVgcHBB4%2FQhssVgcHBB4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMerry%2BChristmas%2B%2528Title%2BTrack%2529-320kbps%26path%3Ddownloads%252Fhigh%252FQhssVgcHBB4%252FQhssVgcHBB4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crakk Jeetegaa Toh Jiyegaa' LIMIT 1), 1),
    'Rom Rom',
    'Various Artists',
    'https://pagalworldmusic.com/downloads/cover/4564640/4564640.jpg',
    'https://pagalworldmusic.com/download.php?title=Rom+Rom-320kbps&path=downloads%2Fhigh%2FOBlaQgYGT0Y%2FOBlaQgYGT0Y.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRom%2BRom-320kbps%26path%3Ddownloads%252Fhigh%252FOBlaQgYGT0Y%252FOBlaQgYGT0Y.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Crakk Jeetegaa Toh Jiyegaa' LIMIT 1), 1),
    'Raat Akeli Thi',
    'Pritam',
    'https://pagalworldmusic.com/downloads/cover/4564652/4564652.jpg',
    'https://pagalworldmusic.com/download.php?title=Raat+Akeli+Thi-320kbps&path=downloads%2Fhigh%2FNAEfUzMIWlk%2FNAEfUzMIWlk.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaat%2BAkeli%2BThi-320kbps%26path%3Ddownloads%252Fhigh%252FNAEfUzMIWlk%252FNAEfUzMIWlk.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Nakharali Dewasan' LIMIT 1), 1),
    'Nakharali Dewasan',
    'Bablu Ankiya, Sonu Kanwar',
    'https://pagalworldmusic.com/downloads/cover/4564749/4564749.jpg',
    'https://pagalworldmusic.com/download.php?title=Nakharali+Dewasan-320kbps&path=downloads%2Fhigh%2FKCAAfAxRBnE%2FKCAAfAxRBnE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DNakharali%2BDewasan-320kbps%26path%3Ddownloads%252Fhigh%252FKCAAfAxRBnE%252FKCAAfAxRBnE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Bandi Padhyodi' LIMIT 1), 1),
    'Bandi Padhyodi',
    'Shambhu Meena, Vaishali Rajkor',
    'https://pagalworldmusic.com/downloads/cover/4564987/4564987.jpg',
    'https://pagalworldmusic.com/download.php?title=Bandi+Padhyodi-320kbps&path=downloads%2Fhigh%2FHRIsdgZ5Bl8%2FHRIsdgZ5Bl8.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DBandi%2BPadhyodi-320kbps%26path%3Ddownloads%252Fhigh%252FHRIsdgZ5Bl8%252FHRIsdgZ5Bl8.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ghar Gavadi Laje Pivar Sasro' LIMIT 1), 1),
    'Ghar Gavadi Laje Pivar Sasro',
    'Dinesh Dewasi, Isha Bhati',
    'https://pagalworldmusic.com/downloads/cover/4564986/4564986.jpg',
    'https://pagalworldmusic.com/download.php?title=Ghar+Gavadi+Laje+Pivar+Sasro-320kbps&path=downloads%2Fhigh%2FEiATWwIJQnY%2FEiATWwIJQnY.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGhar%2BGavadi%2BLaje%2BPivar%2BSasro-320kbps%26path%3Ddownloads%252Fhigh%252FEiATWwIJQnY%252FEiATWwIJQnY.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Fagan Mein Gori Nache' LIMIT 1), 1),
    'Fagan Mein Gori Nache',
    'Happy Singh, Bablu Ankiya',
    'https://pagalworldmusic.com/downloads/cover/4564926/4564926.jpg',
    'https://pagalworldmusic.com/download.php?title=Fagan+Mein+Gori+Nache-320kbps&path=downloads%2Fhigh%2FLyIBdUFBAwU%2FLyIBdUFBAwU.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DFagan%2BMein%2BGori%2BNache-320kbps%26path%3Ddownloads%252Fhigh%252FLyIBdUFBAwU%252FLyIBdUFBAwU.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Ram Se Mera (feat. Saurabh Gujjar  Nancy Rathore)' LIMIT 1), 1),
    'Ram Se Mera (feat. Saurabh Gujjar  Nancy Rathore)',
    'Mintu Bhardwaj, Harjeet Deewana',
    'https://pagalworldmusic.com/downloads/cover/4564914/4564914.jpg',
    'https://pagalworldmusic.com/download.php?title=Ram+Se+Mera+%28feat.+Saurabh+Gujjar++Nancy+Rathore%29-320kbps&path=downloads%2Fhigh%2FPAJGYw10B0Y%2FPAJGYw10B0Y.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRam%2BSe%2BMera%2B%2528feat.%2BSaurabh%2BGujjar%2B%2BNancy%2BRathore%2529-320kbps%26path%3Ddownloads%252Fhigh%252FPAJGYw10B0Y%252FPAJGYw10B0Y.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Singles' LIMIT 1), 1),
    '',
    '',
    'https://pagalworldmusic.com/default.webp',
    NULL,
    NULL,
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Pivar Java De' LIMIT 1), 1),
    'Pivar Java De',
    'Vaishali Rajkor, Dinesh Lohar',
    'https://pagalworldmusic.com/downloads/cover/4564930/4564930.jpg',
    'https://pagalworldmusic.com/download.php?title=Pivar+Java+De-320kbps&path=downloads%2Fhigh%2FRBsDehZafn0%2FRBsDehZafn0.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPivar%2BJava%2BDe-320kbps%26path%3Ddownloads%252Fhigh%252FRBsDehZafn0%252FRBsDehZafn0.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Raghunandana (From HanuMan) Hindi' LIMIT 1), 1),
    'Raghunandana (From HanuMan) Hindi',
    'GowraHari',
    'https://pagalworldmusic.com/downloads/cover/4564654/4564654.jpg',
    'https://pagalworldmusic.com/download.php?title=Raghunandana+%28From+HanuMan%29+Hindi-320kbps&path=downloads%2Fhigh%2FJgRGVAZvc1o%2FJgRGVAZvc1o.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRaghunandana%2B%2528From%2BHanuMan%2529%2BHindi-320kbps%26path%3Ddownloads%252Fhigh%252FJgRGVAZvc1o%252FJgRGVAZvc1o.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Dil Ki Baat' LIMIT 1), 1),
    'Dil Ki Baat',
    'Rashmi Nishad, Mukesh Choudhary',
    'https://pagalworldmusic.com/downloads/cover/4564750/4564750.jpg',
    'https://pagalworldmusic.com/download.php?title=Dil+Ki+Baat-320kbps&path=downloads%2Fhigh%2FKCI8eRYCaGA%2FKCI8eRYCaGA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DDil%2BKi%2BBaat-320kbps%26path%3Ddownloads%252Fhigh%252FKCI8eRYCaGA%252FKCI8eRYCaGA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Rupyo Automatic' LIMIT 1), 1),
    'Rupyo Automatic',
    'Sharwan Racheti, Rakhi Rangili',
    'https://pagalworldmusic.com/downloads/cover/4564828/4564828.jpg',
    'https://pagalworldmusic.com/download.php?title=Rupyo+Automatic-320kbps&path=downloads%2Fhigh%2FFVklXjlccQE%2FFVklXjlccQE.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DRupyo%2BAutomatic-320kbps%26path%3Ddownloads%252Fhigh%252FFVklXjlccQE%252FFVklXjlccQE.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Yeh Pal Hain Apne (From Dange)' LIMIT 1), 1),
    'Yeh Pal Hain Apne (From Dange)',
    'Dhruv Visvanath, Vishwadeep Zeest',
    'https://pagalworldmusic.com/downloads/cover/4564645/4564645.jpg',
    'https://pagalworldmusic.com/download.php?title=Yeh+Pal+Hain+Apne+%28From+Dange%29-320kbps&path=downloads%2Fhigh%2FEwweWhkGAWI%2FEwweWhkGAWI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DYeh%2BPal%2BHain%2BApne%2B%2528From%2BDange%2529-320kbps%26path%3Ddownloads%252Fhigh%252FEwweWhkGAWI%252FEwweWhkGAWI.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Kako Layo Kakdi Dj Remix' LIMIT 1), 1),
    'Kako Layo Kakdi Dj Remix',
    'Ojasvi Geeta Goswami',
    'https://pagalworldmusic.com/downloads/cover/4564751/4564751.jpg',
    'https://pagalworldmusic.com/download.php?title=Kako+Layo+Kakdi+Dj+Remix-320kbps&path=downloads%2Fhigh%2FIwsFBUBAZX4%2FIwsFBUBAZX4.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DKako%2BLayo%2BKakdi%2BDj%2BRemix-320kbps%26path%3Ddownloads%252Fhigh%252FIwsFBUBAZX4%252FIwsFBUBAZX4.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Mami Aaja Khela Fagan Me' LIMIT 1), 1),
    'Mami Aaja Khela Fagan Me',
    'Shyam Bidiyasar, Rinku Sharma',
    'https://pagalworldmusic.com/downloads/cover/4564826/4564826.jpg',
    'https://pagalworldmusic.com/download.php?title=Mami+Aaja+Khela+Fagan+Me-320kbps&path=downloads%2Fhigh%2FSFsyekRSdFA%2FSFsyekRSdFA.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DMami%2BAaja%2BKhela%2BFagan%2BMe-320kbps%26path%3Ddownloads%252Fhigh%252FSFsyekRSdFA%252FSFsyekRSdFA.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Good Morning DJ Remix' LIMIT 1), 1),
    'Good Morning DJ Remix',
    'Prakash Dewasi, Jyoti Sen',
    'https://pagalworldmusic.com/downloads/cover/4564752/4564752.jpg',
    'https://pagalworldmusic.com/download.php?title=Good+Morning+DJ+Remix-320kbps&path=downloads%2Fhigh%2FFV00RBN3Dwc%2FFV00RBN3Dwc.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DGood%2BMorning%2BDJ%2BRemix-320kbps%26path%3Ddownloads%252Fhigh%252FFV00RBN3Dwc%252FFV00RBN3Dwc.mp3',
    NOW(),
    NOW()
),
(
    COALESCE((SELECT id FROM albums WHERE title = 'Pichkari Ro Pani' LIMIT 1), 1),
    'Pichkari Ro Pani',
    'Jyoti Sen',
    'https://pagalworldmusic.com/downloads/cover/4564754/4564754.jpg',
    'https://pagalworldmusic.com/download.php?title=Pichkari+Ro+Pani-320kbps&path=downloads%2Fhigh%2FGABSUzkIcUI%2FGABSUzkIcUI.mp3',
    '/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DPichkari%2BRo%2BPani-320kbps%26path%3Ddownloads%252Fhigh%252FGABSUzkIcUI%252FGABSUzkIcUI.mp3',
    NOW(),
    NOW()
);

