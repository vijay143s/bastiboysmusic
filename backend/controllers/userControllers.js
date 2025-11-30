const TryCatch = require("../utils/TryCatch.js");
const bcrypt = require("bcrypt");
const generateToken = require("../utils/generateToken.js");
const {
  createUser,
  findUserByEmail,
  getUserWithPlaylist,
  getAllUsersWithPlaylistSongs,
} = require("../repositories/userRepository.js");
const {
  addSongToPlaylist,
  isSongInPlaylist,
  removeSongFromPlaylist,
} = require("../repositories/playlistRepository.js");
const { findSongById } = require("../repositories/songRepository.js");

const sanitizeUser = (userDoc) => {
  if (!userDoc) return null;
  return {
    id: userDoc.id,
    _id: String(userDoc.id),
    name: userDoc.name,
    email: userDoc.email,
    role: userDoc.role,
    playlist: userDoc.playlist || [],
    createdAt: userDoc.createdAt,
    updatedAt: userDoc.updatedAt,
  };
};

const sendAuthSuccess = (res, user, message, statusCode = 200) => {
  generateToken(user.id, res);

  return res.status(statusCode).json({
    success: true,
    message,
    user: sanitizeUser(user),
  });
};

const registerUser = TryCatch(async (req, res) => {
  const { name, email, password } = req.body;
  const normalizedEmail = email.trim().toLowerCase();
  const normalizedName = name.trim();

  const existingUser = await findUserByEmail(normalizedEmail);

  if (existingUser)
    return res.status(409).json({
      success: false,
      message: "Email already registered",
    });

  const hashPassword = await bcrypt.hash(password, 10);

  const user = await createUser({
    name: normalizedName,
    email: normalizedEmail,
    passwordHash: hashPassword,
  });

  return sendAuthSuccess(
    res,
    {
      ...user,
      playlist: [],
    },
    "User Registered",
    201
  );
});

const loginUser = TryCatch(async (req, res) => {
  const { email, password } = req.body;
  const normalizedEmail = email.trim().toLowerCase();

  const user = await findUserByEmail(normalizedEmail);

  if (!user)
    return res.status(401).json({
      success: false,
      message: "Invalid credentials",
    });

  const comparePassword = await bcrypt.compare(password, user.passwordHash);

  if (!comparePassword)
    return res.status(401).json({
      success: false,
      message: "Invalid credentials",
    });

  const userWithPlaylist = await getUserWithPlaylist(user.id);

  return sendAuthSuccess(res, userWithPlaylist, "User Logged In");
});

const myProfile = TryCatch(async (req, res) => {
  const user = await getUserWithPlaylist(req.user.id);

  if (!user)
    return res.status(404).json({
      success: false,
      message: "User not found",
    });

  res.json(sanitizeUser(user));
});

const logoutUser = TryCatch(async (req, res) => {
  res.cookie("token", "", {
    maxAge: 0,
    httpOnly: true,
    sameSite: process.env.NODE_ENV === "production" ? "none" : "lax",
    secure: process.env.NODE_ENV === "production",
  });

  res.json({
    success: true,
    message: "Logged Out Successfully",
  });
});

const saveToPlaylist = TryCatch(async (req, res) => {
  const songId = Number(req.params.id);

  if (Number.isNaN(songId))
    return res.status(400).json({
      success: false,
      message: "Invalid song id",
    });

  const song = await findSongById(songId);

  if (!song)
    return res.status(404).json({
      success: false,
      message: "Song not found",
    });

  const alreadySaved = await isSongInPlaylist(req.user.id, songId);

  if (alreadySaved) {
    await removeSongFromPlaylist(req.user.id, songId);

    return res.json({
      success: true,
      message: "Removed from playlist",
    });
  }

  await addSongToPlaylist(req.user.id, songId);

  return res.json({
    success: true,
    message: "Added to playlist",
  });
});

const formatCommunitySong = (song) => ({
  ...song,
  _id: String(song.id),
  album: song.albumId ? String(song.albumId) : null,
});

const getAllCommunityPlaylists = TryCatch(async (req, res) => {
  const rawPlaylists = await getAllUsersWithPlaylistSongs();

  const playlists = rawPlaylists.map((entry) => ({
    user: {
      id: entry.user.id,
      _id: String(entry.user.id),
      name: entry.user.name,
      email: entry.user.email,
    },
    songs: entry.songs.map(formatCommunitySong),
    totalSongs: entry.songs.length,
  }));

  res.json({ success: true, playlists });
});

module.exports = {
  registerUser,
  loginUser,
  myProfile,
  logoutUser,
  saveToPlaylist,
  getAllCommunityPlaylists,
};
