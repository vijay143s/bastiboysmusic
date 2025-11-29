import TryCatch from "../utils/TryCatch.js";
import getDataurl from "../utils/urlGenerator.js";
import cloudinary from "cloudinary";
import {
  createAlbum as createAlbumRecord,
  getAllAlbums as fetchAlbums,
  findAlbumById,
} from "../repositories/albumRepository.js";
import {
  createSong,
  deleteSongById,
  findSongById,
  getAllSongs as fetchSongs,
  getSongsByAlbum,
  updateSongThumbnail,
} from "../repositories/songRepository.js";

const formatAlbum = (album) => ({
  ...album,
  _id: String(album.id),
});

const formatSong = (song) => ({
  ...song,
  _id: String(song.id),
  album: song.albumId ? String(song.albumId) : null,
});

export const createAlbum = TryCatch(async (req, res) => {
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

export const getAllAlbums = TryCatch(async (req, res) => {
  const albums = await fetchAlbums();

  res.json(albums.map(formatAlbum));
});

export const addSong = TryCatch(async (req, res) => {
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

export const addThumbnail = TryCatch(async (req, res) => {
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

export const getAllSongs = TryCatch(async (req, res) => {
  const songs = await fetchSongs();

  res.json(songs.map(formatSong));
});

export const getAllSongsByAlbum = TryCatch(async (req, res) => {
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

export const deleteSong = TryCatch(async (req, res) => {
  const songId = Number(req.params.id);

  if (Number.isNaN(songId))
    return res.status(400).json({
      message: "Invalid song id",
    });

  await deleteSongById(songId);

  res.json({ message: "Song Deleted" });
});

export const getSingleSong = TryCatch(async (req, res) => {
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
