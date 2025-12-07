-- Songs INSERT statements

INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Tu Meri Main Tera Main Tera Tu Meri' LIMIT 1),
    'Title Track',
    'Vishal Dadlani',
    'Anvitaa Dutt',
    'hindi',
    'https://pagalnew.com/coverimages/album/tu-meri-main-tera-main-tera-tu-meri-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52702',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'King' LIMIT 1),
    'They Call Him King Theme',
    'Anirudh Ravichander',
    'Heisenberg',
    'hindi',
    'https://pagalnew.com/coverimages/album/king-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52585',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'The Rajasaab' LIMIT 1),
    'Rebel Saab',
    'Sachet Tandon',
    'Kumaar',
    'hindi',
    'https://pagalnew.com/coverimages/album/the-rajasaab-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52676',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    'Gehra Hua',
    'Arijit Singh',
    'Irshad Kamil',
    'hindi',
    'https://pagalnew.com/coverimages/album/dhurandhar-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52703',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    'Shararat',
    'Jasmine Sandlas',
    'Jasmine Sandlas',
    'hindi',
    'https://pagalnew.com/coverimages/album/dhurandhar-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52706',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    'Title Track',
    'Hanumankind',
    'Hanumankind, Jasmine Sandlas and Babu Singh Maan',
    'hindi',
    'https://pagalnew.com/coverimages/album/dhurandhar-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52483',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    'Run Down The City Monica',
    'Reble',
    'Irshad Kamil',
    'hindi',
    'https://pagalnew.com/coverimages/album/dhurandhar-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52705',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    'Ez Ez',
    'Diljit Dosanjh',
    'Hanumankind and Raj Ranjodh',
    'hindi',
    'https://pagalnew.com/coverimages/album/dhurandhar-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52704',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    'Ishq Jalakar',
    'Shashwat Sachdev',
    'Irshad Kamil and Sahir Ludhianvi',
    'hindi',
    'https://pagalnew.com/coverimages/album/dhurandhar-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52675',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Non Violence' LIMIT 1),
    'Sundara',
    'Tejaswini Nandibhatla',
    'Kartika Nainan Dubey',
    'hindi',
    'https://pagalnew.com/coverimages/album/non-violence-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52707',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Kis Kisko Pyaar Karoon 2' LIMIT 1),
    'Phurr',
    'Yo Yo Honey Singh',
    'Raj Brar',
    'hindi',
    'https://pagalnew.com/coverimages/album/kis-kisko-pyaar-karoon-2-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52611',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    'Jhoom Banware',
    'Kaushal Kishore',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/haq-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52582',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    'Dil Tod Gaya Tu',
    'Kaushal Kishore',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/haq-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52579',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    'Dil Tod Gaya Tu Duet Version',
    'Kaushal Kishore',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/haq-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52580',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    'Haq Hai Mera',
    'Kaushal Kishore',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/haq-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52581',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    'Kya Paaya',
    'Kaushal Kishore',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/haq-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52583',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    'Qubool',
    'Armaan Khan',
    'Kaushal Kishore',
    'hindi',
    'https://pagalnew.com/coverimages/album/haq-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52489',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Peddi' LIMIT 1),
    'Chikiri Chikiri',
    'Mohit Chauhan',
    'Raqueeb Alam',
    'hindi',
    'https://pagalnew.com/coverimages/album/peddi-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52578',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    'Ladki Jaisi',
    'Sukhwinder Singh',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/tere-ishk-mein-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52700',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    'Jigar Thanda',
    'Darshan Raval',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/tere-ishk-mein-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52698',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    'Tere Zikr Mein',
    'Shilpa Rao',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/tere-ishk-mein-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52701',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    'Title Track',
    'Arijit Singh',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/tere-ishk-mein-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52484',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    'Usey Kehna',
    'Nitesh Aher',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/tere-ishk-mein-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52572',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    'Jigar Thanda Female Version',
    'Shilpa Rao',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/tere-ishk-mein-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52699',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    'Aawaara Angaara',
    'Faheem Abdullah',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/tere-ishk-mein-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52695',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    'Chinnaware',
    'Shankar Mahadevan',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/tere-ishk-mein-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52696',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    'Deewaana Deewaana',
    'Irshad Kamil',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/tere-ishk-mein-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52697',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    'Aakhri Salaam',
    'Sagar Bhatia',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/de-de-pyaar-de-2-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52575',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    'Raat Bhar',
    'Aditya Rikhari',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/de-de-pyaar-de-2-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52485',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    '3 Shaukk',
    'Karan Aujla',
    'Jaani',
    'hindi',
    'https://pagalnew.com/coverimages/album/de-de-pyaar-de-2-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52571',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    'Jhoom Sharaabi',
    'Yo Yo Honey Singh',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/de-de-pyaar-de-2-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52566',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    'Baabul Ve',
    'Payal Dev',
    '',
    'hindi',
    'https://pagalnew.com/coverimages/album/de-de-pyaar-de-2-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52576',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Mastiii 4' LIMIT 1),
    'One In Crore',
    'Meet Bros',
    'Meet Bros and Mellow D',
    'hindi',
    'https://pagalnew.com/coverimages/album/mastiii-4-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52612',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Mastiii 4' LIMIT 1),
    'Rasiya Balama',
    'Darshan Rathod',
    'Sanjeev Chaturvedi',
    'hindi',
    'https://pagalnew.com/coverimages/album/mastiii-4-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52586',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Mastiii 4' LIMIT 1),
    'Pakad Pakad',
    'Danish Sabri',
    'Danish Sabri',
    'hindi',
    'https://pagalnew.com/coverimages/album/mastiii-4-2025-500-500.jpg',
    'https://pagalnew.com/320-download/52584',
    NOW(), NOW());
INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (
    (SELECT id FROM albums WHERE title = 'Soulmates' LIMIT 1),
    'Halki Halki Nami',
    'B Praak',
    'Gulzar',
    'hindi',
    'https://pagalnew.com/coverimages/album/soulmates-2025-500-500.jpg',
    'https://320.pagalnew.com/320-downloads/52469',
    NOW(), NOW());
