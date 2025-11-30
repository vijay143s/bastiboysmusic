const express = require("express");
const {
  getLatestAlbumsByYear,
  getAllAlbumsPaginated,
  getTopArtistsSection,
  getAllArtistsPaginated,
  getTopSingersSection,
  getAllSingersPaginated,
  getTopMusicDirectorsSection,
  getAllMusicDirectorsPaginated,
  getSongsByAlbumId,
  getSongsBySingerName,
  getAlbumsByArtistId,
  getAlbumsByMusicDirector,
} = require("../controllers/homeControllers.js");

const router = express.Router();

// Latest Albums Routes
router.get("/albums/latest", getLatestAlbumsByYear);
router.get("/albums/:albumId/songs", getSongsByAlbumId);
router.get("/albums", getAllAlbumsPaginated);

// Artists Routes
router.get("/artists/top", getTopArtistsSection);
router.get("/artists/:artistId/albums", getAlbumsByArtistId);
router.get("/artists", getAllArtistsPaginated);

// Singers Routes
router.get("/singers/top", getTopSingersSection);
router.get("/singers/:singerName/songs", getSongsBySingerName);
router.get("/singers", getAllSingersPaginated);

// Music Directors Routes
router.get("/music-directors/top", getTopMusicDirectorsSection);
router.get("/music-directors/:directorName/albums", getAlbumsByMusicDirector);
router.get("/music-directors", getAllMusicDirectorsPaginated);

module.exports = router;
