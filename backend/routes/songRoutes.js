const express = require("express");
const { isAuth } = require("../middlewares/isAuth.js");
const uploadFile = require("../middlewares/multer.js");
const {
  addSong,
  addThumbnail,
  createAlbum,
  deleteSong,
  getAllAlbums,
  getAllSongs,
  getQueueData,
  getQueueYears,
  getQueueByYear,
  getAllSongsByAlbum,
  getSingleSong,
  addArtistToAlbum,
  addSingerToSong,
  addMusicDirectorToAlbum,
  searchSongs,
  updatePlayCount,
  getTopPlayedSongs,
  getTopYears,
  getAlbumsByYear,
  getQueueByYearBatch,
  getPlaylistSongs,
  getDistinctLanguages,
} = require("../controllers/songControllers.js");

const router = express.Router();

// Album routes
router.post("/album/new", isAuth, uploadFile, createAlbum);
router.get("/album/all", getAllAlbums);
router.get("/album/:id", isAuth, getAllSongsByAlbum);
router.post("/album/:id/artist", isAuth, addArtistToAlbum);
router.post("/album/:id/musicdirector", isAuth, addMusicDirectorToAlbum);

// Song routes
router.post("/new", isAuth, uploadFile, addSong);
router.get("/all", getAllSongs);
router.get("/playlist", isAuth, getPlaylistSongs); // Get user's playlist songs
router.get("/top-played", getTopPlayedSongs); // Top played songs with pagination and shuffle
router.get("/queue", getQueueData); // Optimized endpoint for queue
router.get("/queue/batch", getQueueByYearBatch); // Queue with year ordering and batch loading
router.get("/queue/years", getQueueYears); // Get available years
router.get("/queue/year/:year", getQueueByYear); // Get songs by year
router.get("/search", searchSongs); // Search songs with optional year filter
router.get("/single/:id", getSingleSong);
router.get("/languages", getDistinctLanguages); // Get distinct languages
router.post("/:id/play", updatePlayCount); // Update play count
router.post("/:id/thumbnail", isAuth, uploadFile, addThumbnail);
router.post("/:id/singer", isAuth, addSingerToSong);
router.delete("/:id", isAuth, deleteSong);

// Years routes
router.get("/years/top", getTopYears); // Get top 10 years
router.get("/years/:year/albums", getAlbumsByYear); // Get albums by year with songs

module.exports = router;
