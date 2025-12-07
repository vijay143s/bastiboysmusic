-- Metadata INSERT statements

INSERT IGNORE INTO singers (singer_name) VALUES ('Anirudh Ravichander');
INSERT IGNORE INTO singers (singer_name) VALUES ('Jasmine Sandlas');
INSERT IGNORE INTO singers (singer_name) VALUES ('Darshan Rathod');
INSERT IGNORE INTO singers (singer_name) VALUES ('Karan Aujla');
INSERT IGNORE INTO singers (singer_name) VALUES ('Sachet Tandon');
INSERT IGNORE INTO singers (singer_name) VALUES ('Irshad Kamil');
INSERT IGNORE INTO singers (singer_name) VALUES ('B Praak');
INSERT IGNORE INTO singers (singer_name) VALUES ('Diljit Dosanjh');
INSERT IGNORE INTO singers (singer_name) VALUES ('Shankar Mahadevan');
INSERT IGNORE INTO singers (singer_name) VALUES ('Faheem Abdullah');
INSERT IGNORE INTO singers (singer_name) VALUES ('Hanumankind');
INSERT IGNORE INTO singers (singer_name) VALUES ('Shilpa Rao');
INSERT IGNORE INTO singers (singer_name) VALUES ('Payal Dev');
INSERT IGNORE INTO singers (singer_name) VALUES ('Yo Yo Honey Singh');
INSERT IGNORE INTO singers (singer_name) VALUES ('Sagar Bhatia');
INSERT IGNORE INTO singers (singer_name) VALUES ('Aditya Rikhari');
INSERT IGNORE INTO singers (singer_name) VALUES ('Mohit Chauhan');
INSERT IGNORE INTO singers (singer_name) VALUES ('Meet Bros');
INSERT IGNORE INTO singers (singer_name) VALUES ('Darshan Raval');
INSERT IGNORE INTO singers (singer_name) VALUES ('Armaan Khan');
INSERT IGNORE INTO singers (singer_name) VALUES ('Kaushal Kishore');
INSERT IGNORE INTO singers (singer_name) VALUES ('Tejaswini Nandibhatla');
INSERT IGNORE INTO singers (singer_name) VALUES ('Danish Sabri');
INSERT IGNORE INTO singers (singer_name) VALUES ('Vishal Dadlani');
INSERT IGNORE INTO singers (singer_name) VALUES ('Shashwat Sachdev');
INSERT IGNORE INTO singers (singer_name) VALUES ('Nitesh Aher');
INSERT IGNORE INTO singers (singer_name) VALUES ('Arijit Singh');
INSERT IGNORE INTO singers (singer_name) VALUES ('Reble');
INSERT IGNORE INTO singers (singer_name) VALUES ('Sukhwinder Singh');
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Vishal Dadlani',
    'Tu Meri Main Tera Main Tera Tu Meri',
    (SELECT id FROM albums WHERE title = 'Tu Meri Main Tera Main Tera Tu Meri' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Shekhar Ravjiani',
    'Tu Meri Main Tera Main Tera Tu Meri',
    (SELECT id FROM albums WHERE title = 'Tu Meri Main Tera Main Tera Tu Meri' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Anirudh Ravichander',
    'King',
    (SELECT id FROM albums WHERE title = 'King' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Sachet Tandon',
    'The Rajasaab',
    (SELECT id FROM albums WHERE title = 'The Rajasaab' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Blaaze',
    'The Rajasaab',
    (SELECT id FROM albums WHERE title = 'The Rajasaab' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Arijit Singh',
    'Dhurandhar',
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Armaan Khan',
    'Dhurandhar',
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Jasmine Sandlas',
    'Dhurandhar',
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Shashwat Sachdev',
    'Dhurandhar',
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Madhubanti Bagchi',
    'Dhurandhar',
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Hanumankind',
    'Dhurandhar',
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Reble',
    'Dhurandhar',
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Diljit Dosanjh',
    'Dhurandhar',
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Shahzad Ali',
    'Dhurandhar',
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Subhadeep Das Chowdhury',
    'Dhurandhar',
    (SELECT id FROM albums WHERE title = 'Dhurandhar' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Tejaswini Nandibhatla',
    'Non Violence',
    (SELECT id FROM albums WHERE title = 'Non Violence' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Vozhi',
    'Non Violence',
    (SELECT id FROM albums WHERE title = 'Non Violence' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Yo Yo Honey Singh',
    'Kis Kisko Pyaar Karoon 2',
    (SELECT id FROM albums WHERE title = 'Kis Kisko Pyaar Karoon 2' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Josh Brar',
    'Kis Kisko Pyaar Karoon 2',
    (SELECT id FROM albums WHERE title = 'Kis Kisko Pyaar Karoon 2' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Leo Grewal',
    'Kis Kisko Pyaar Karoon 2',
    (SELECT id FROM albums WHERE title = 'Kis Kisko Pyaar Karoon 2' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Kaushal Kishore',
    'Haq',
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Vishal Mishra',
    'Haq',
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Malini Awasthi',
    'Haq',
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Jyotica Tangri',
    'Haq',
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Bidyut Jyoti Mohan',
    'Haq',
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Akash Ojha',
    'Haq',
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Sneha Shankar',
    'Haq',
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Ali Brothers',
    'Haq',
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Armaan Khan',
    'Haq',
    (SELECT id FROM albums WHERE title = 'Haq' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Mohit Chauhan',
    'Peddi',
    (SELECT id FROM albums WHERE title = 'Peddi' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Sukhwinder Singh',
    'Tere Ishk Mein',
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Irshad Kamil',
    'Tere Ishk Mein',
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Darshan Raval',
    'Tere Ishk Mein',
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Shilpa Rao',
    'Tere Ishk Mein',
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Arijit Singh',
    'Tere Ishk Mein',
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Nitesh Aher',
    'Tere Ishk Mein',
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Jonita Gandhi',
    'Tere Ishk Mein',
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Faheem Abdullah',
    'Tere Ishk Mein',
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Shankar Mahadevan',
    'Tere Ishk Mein',
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Dhanush',
    'Tere Ishk Mein',
    (SELECT id FROM albums WHERE title = 'Tere Ishk Mein' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Sagar Bhatia',
    'De De Pyaar De 2',
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Aditya Rikhari',
    'De De Pyaar De 2',
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Payal Dev',
    'De De Pyaar De 2',
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Karan Aujla',
    'De De Pyaar De 2',
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Jyotica Tangri',
    'De De Pyaar De 2',
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Yo Yo Honey Singh',
    'De De Pyaar De 2',
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Athar Hayat',
    'De De Pyaar De 2',
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Aditya Dev',
    'De De Pyaar De 2',
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Shreya Ghoshal',
    'De De Pyaar De 2',
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Kumaar',
    'De De Pyaar De 2',
    (SELECT id FROM albums WHERE title = 'De De Pyaar De 2' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Meet Bros',
    'Mastiii 4',
    (SELECT id FROM albums WHERE title = 'Mastiii 4' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Mellow D',
    'Mastiii 4',
    (SELECT id FROM albums WHERE title = 'Mastiii 4' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Darshan Rathod',
    'Mastiii 4',
    (SELECT id FROM albums WHERE title = 'Mastiii 4' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Payal Dev',
    'Mastiii 4',
    (SELECT id FROM albums WHERE title = 'Mastiii 4' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'Danish Sabri',
    'Mastiii 4',
    (SELECT id FROM albums WHERE title = 'Mastiii 4' LIMIT 1),
    NOW(), NOW());
INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (
    'B Praak',
    'Soulmates',
    (SELECT id FROM albums WHERE title = 'Soulmates' LIMIT 1),
    NOW(), NOW());
