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
  getAllSongsByAlbum,
  getSingleSong,
  addArtistToAlbum,
  addSingerToSong,
  addMusicDirectorToAlbum,
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
router.get("/single/:id", getSingleSong);
router.post("/:id/thumbnail", isAuth, uploadFile, addThumbnail);
router.post("/:id/singer", isAuth, addSingerToSong);
router.delete("/:id", isAuth, deleteSong);

module.exports = router;
