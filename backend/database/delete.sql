-- Delete all data from tables except users
SET FOREIGN_KEY_CHECKS=0;

TRUNCATE TABLE user_playlists;
TRUNCATE TABLE singers;
TRUNCATE TABLE music_directors;
TRUNCATE TABLE artists;
TRUNCATE TABLE songs;
TRUNCATE TABLE albums;

SET FOREIGN_KEY_CHECKS=1;