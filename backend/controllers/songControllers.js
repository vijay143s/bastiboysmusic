const TryCatch = require("../utils/TryCatch.js");
const getDataurl = require("../utils/urlGenerator.js");
const cloudinary = require("cloudinary");
const {
  createAlbum: createAlbumRecord,
  getAllAlbums: fetchAlbums,
  findAlbumById,
} = require("../repositories/albumRepository.js");
const {
  createSong,
  deleteSongById,
  findSongById,
  getAllSongs: fetchSongs,
  getSongsByAlbum,
  updateSongThumbnail,
} = require("../repositories/songRepository.js");

const formatAlbum = (album) => ({
  ...album,
  _id: String(album.id),
});

const formatSong = (song) => ({
  ...song,
  _id: String(song.id),
  album: song.albumId ? String(song.albumId) : null,
});

const createAlbum = TryCatch(async (req, res) => {
  if (req.user.role !== "admin")
    return res.status(403).json({
      message: "You are not admin",
    });

  const { title, description } = req.body;

  const file = req.file;

  const fileUrl = getDataurl(file);

  const cloud = await cloudinary.v2.uploader.upload(fileUrl.content);

  await createAlbumRecord({
    title,
    description,
    thumbnail: {
      id: cloud.public_id,
      url: cloud.secure_url,
    },
  });

  res.json({
    message: "Album Added",
  });
});

const getAllAlbums = TryCatch(async (req, res) => {
  const albums = await fetchAlbums();

  res.json(albums.map(formatAlbum));
});

const addSong = TryCatch(async (req, res) => {
  if (req.user.role !== "admin")
    return res.status(403).json({
      message: "You are not admin",
    });

  const { title, description, singer, album } = req.body;
  const albumId = Number(album);

  if (Number.isNaN(albumId))
    return res.status(400).json({
      message: "Invalid album id",
    });

  const albumRecord = await findAlbumById(albumId);

  if (!albumRecord)
    return res.status(404).json({
      message: "Album not found",
    });

  const file = req.file;

  const fileUrl = getDataurl(file);

  const cloud = await cloudinary.v2.uploader.upload(fileUrl.content, {
    resource_type: "video",
  });

  await createSong({
    title,
    description,
    singer,
    audio: {
      id: cloud.public_id,
      url: cloud.secure_url,
    },
    albumId,
  });

  res.json({
    message: "Song Added",
  });
});

const addThumbnail = TryCatch(async (req, res) => {
  if (req.user.role !== "admin")
    return res.status(403).json({
      message: "You are not admin",
    });

  const file = req.file;

  const fileUrl = getDataurl(file);

  const cloud = await cloudinary.v2.uploader.upload(fileUrl.content);

  const songId = Number(req.params.id);

  if (Number.isNaN(songId))
    return res.status(400).json({
      message: "Invalid song id",
    });

  await updateSongThumbnail(songId, {
    id: cloud.public_id,
    url: cloud.secure_url,
  });

  res.json({
    message: "thumbnail Added",
  });
});

const getAllSongs = TryCatch(async (req, res) => {
  const songs = await fetchSongs();

  res.json(songs.map(formatSong));
});

const getAllSongsByAlbum = TryCatch(async (req, res) => {
  const albumId = Number(req.params.id);

  if (Number.isNaN(albumId))
    return res.status(400).json({
      message: "Invalid album id",
    });

  const album = await findAlbumById(albumId);
  if (!album)
    return res.status(404).json({
      message: "Album not found",
    });

  const songs = await getSongsByAlbum(albumId);

  res.json({ album: formatAlbum(album), songs: songs.map(formatSong) });
});

const deleteSong = TryCatch(async (req, res) => {
  const songId = Number(req.params.id);

  if (Number.isNaN(songId))
    return res.status(400).json({
      message: "Invalid song id",
    });

  await deleteSongById(songId);

  res.json({ message: "Song Deleted" });
});

const getSingleSong = TryCatch(async (req, res) => {
  const songId = Number(req.params.id);

  if (Number.isNaN(songId))
    return res.status(400).json({
      message: "Invalid song id",
    });

  const song = await findSongById(songId);

  if (!song)
    return res.status(404).json({
      message: "Song not found",
    });

  res.json(formatSong(song));
});

module.exports = {
  createAlbum,
  getAllAlbums,
  addSong,
  addThumbnail,
  getAllSongs,
  getAllSongsByAlbum,
  deleteSong,
  getSingleSong,
};
