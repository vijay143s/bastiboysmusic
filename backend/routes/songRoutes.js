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
router.get("/queue", getQueueData); // Optimized endpoint for queue
router.get("/queue/years", getQueueYears); // Get available years
router.get("/queue/year/:year", getQueueByYear); // Get songs by year
router.get("/search", searchSongs); // Search songs
router.get("/single/:id", getSingleSong);
router.post("/:id/thumbnail", isAuth, uploadFile, addThumbnail);
router.post("/:id/singer", isAuth, addSingerToSong);
router.delete("/:id", isAuth, deleteSong);

module.exports = router;
