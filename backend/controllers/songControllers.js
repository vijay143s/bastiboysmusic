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
  getQueueSongs,
  getAvailableYears,
  getQueueSongsByYear,
  findSongByIdForPlayer,
  searchSongs: searchSongsRepo,
  incrementPlayCount,
  getTopPlayedSongs: getTopPlayedSongsRepo,
  getTopYears: getTopYearsRepo,
  getAlbumsByYear: getAlbumsByYearRepo,
  getQueueSongsByYearBatch,
} = require("../repositories/songRepository.js");
const {
  createArtist,
  getArtistsByAlbum,
  deleteArtistsByAlbum,
} = require("../repositories/artistRepository.js");
const {
  createSinger,
  getSingersBySong,
  deleteSingersBySong,
} = require("../repositories/singerRepository.js");
const {
  createMusicDirector,
  getMusicDirectorsByAlbum,
  deleteMusicDirectorsByAlbum,
} = require("../repositories/musicDirectorRepository.js");

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

  const { title, description, year, director, musicDirector, starCast, artists } = req.body;

  const file = req.file;

  const fileUrl = getDataurl(file);

  const cloud = await cloudinary.v2.uploader.upload(fileUrl.content);

  const album = await createAlbumRecord({
    title,
    description,
    thumbnail: {
      id: cloud.public_id,
      url: cloud.secure_url,
    },
    year: year ? Number(year) : null,
    director,
    musicDirector,
    starCast,
  });

  // Create associated artists if provided
  if (artists && Array.isArray(artists)) {
    for (const artist of artists) {
      await createArtist({
        artistName: artist.name,
        albumId: album.id,
        albumName: album.title,
      });
    }
  }

  // Create music directors if provided
  if (musicDirector) {
    await createMusicDirector({
      directorName: musicDirector,
      albumId: album.id,
      albumName: album.title,
    });
  }

  res.json({
    message: "Album Added",
    album: formatAlbum(album),
  });
});

const getAllAlbums = TryCatch(async (req, res) => {
  const { language } = req.query;
  const albums = await fetchAlbums(language);

  res.json(albums.map(formatAlbum));
});

const addSong = TryCatch(async (req, res) => {
  if (req.user.role !== "admin")
    return res.status(403).json({
      message: "You are not admin",
    });

  const { title, description, singer, album, singers } = req.body;
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

  const song = await createSong({
    title,
    description,
    singer,
    audio: {
      id: cloud.public_id,
      url: cloud.secure_url,
    },
    albumId,
  });

  // Create associated singers if provided
  if (singers && Array.isArray(singers)) {
    for (const singerObj of singers) {
      await createSinger({
        singerName: singerObj.name,
      });
    }
  }

  res.json({
    message: "Song Added",
    song: formatSong(song),
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
  const { language } = req.query;
  const songs = await fetchSongs(language);

  res.json(songs.map(formatSong));
});

// Optimized endpoint for queue - returns only essential data
const getQueueData = TryCatch(async (req, res) => {
  const language = req.query.language || null;
  const songs = await getQueueSongs(language);
  res.json(songs);
});

// Get available years for queue pagination
const getQueueYears = TryCatch(async (req, res) => {
  const language = req.query.language || null;
  const years = await getAvailableYears(language);
  res.json({ years });
});

// Get queue songs by year for pagination
const getQueueByYear = TryCatch(async (req, res) => {
  const year = Number(req.params.year);
  const limit = Number(req.query.limit) || 50;
  const offset = Number(req.query.offset) || 0;
  const language = req.query.language || null;

  if (Number.isNaN(year)) {
    return res.status(400).json({
      message: "Invalid year parameter",
    });
  }

  const result = await getQueueSongsByYear(year, limit, offset, language);
  res.json(result);
});

const searchSongs = TryCatch(async (req, res) => {
  const { q: query, limit = 50, offset = 0, year, language } = req.query;

  if (!query || query.trim().length === 0) {
    return res.json({ songs: [], albums: [], artists: [], total: 0 });
  }

  const yearFilter = year ? parseInt(year) : null;
  const songsResult = await searchSongsRepo(query.trim(), parseInt(limit), parseInt(offset), yearFilter, language);

  // Search albums
  const { pool } = require('../database/db.js');
  let albumQuery = `
    SELECT DISTINCT a.id as _id, a.title, a.description, 
           a.thumbnail_id as thumbnailId, a.thumbnail_url as thumbnailUrl,
           a.year, a.director, a.music_director as musicDirector
    FROM albums a
    WHERE (a.title LIKE ? OR a.description LIKE ? OR a.director LIKE ? OR a.music_director LIKE ?)
  `;

  const albumParams = [`%${query.trim()}%`, `%${query.trim()}%`, `%${query.trim()}%`, `%${query.trim()}%`];

  if (yearFilter) {
    albumQuery += ' AND a.year = ?';
    albumParams.push(yearFilter);
  }

  if (language) {
    albumQuery += ' AND a.language = ?';
    albumParams.push(language);
  }

  albumQuery += ' ORDER BY a.year DESC LIMIT 50';

  const [albumRows] = await pool.execute(albumQuery, albumParams);

  const albums = albumRows.map(row => ({
    _id: String(row._id),
    title: row.title,
    description: row.description,
    thumbnail: row.thumbnailUrl ? { id: row.thumbnailId, url: row.thumbnailUrl } : null,
    year: row.year,
    director: row.director,
    musicDirector: row.musicDirector
  }));

  // Search artists
  const artistQuery = `
    SELECT DISTINCT ar.artist_name as artistName, ar.artist_id as artistId,
           COUNT(DISTINCT ar.album_id) as albumCount
    FROM artists ar
    WHERE ar.artist_name LIKE ?
    GROUP BY ar.artist_name, ar.artist_id
    ORDER BY albumCount DESC
    LIMIT 20
  `;

  const [artistRows] = await pool.execute(artistQuery, [`%${query.trim()}%`]);

  const artists = artistRows.map(row => ({
    artistId: row.artistId,
    artistName: row.artistName,
    albumCount: row.albumCount
  }));

  // Search singers - optimized with single query
  const singerQuery = `
    SELECT si.singer_name as singerName, si.singer_id as singerId,
           COUNT(DISTINCT s.id) as songCount
    FROM singers si
    LEFT JOIN songs s ON s.singer LIKE CONCAT('%', si.singer_name, '%')
    WHERE si.singer_name LIKE ?
    GROUP BY si.singer_name, si.singer_id
    HAVING songCount > 0
    ORDER BY songCount DESC
    LIMIT 20
  `;

  const [singerRows] = await pool.execute(singerQuery, [`%${query.trim()}%`]);

  const singers = singerRows.map(row => ({
    singerId: row.singerId,
    singerName: row.singerName,
    songCount: row.songCount
  }));

  res.json({
    songs: songsResult.songs,
    albums,
    artists,
    singers,
    total: songsResult.total + albums.length + artists.length + singers.length,
    songCount: songsResult.total,
    albumCount: albums.length,
    artistCount: artists.length,
    singerCount: singers.length
  });
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

  res.json({
    album: formatAlbum(album),
    songs: songs.map(formatSong),
  });
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

  const song = await findSongByIdForPlayer(songId);

  if (!song)
    return res.status(404).json({
      message: "Song not found",
    });

  // Don't increment play count here - will be done by separate endpoint after 30% played

  res.json(song); // Return optimized song data directly
});

module.exports = {
  createAlbum,
  getAllAlbums,
  addSong,
  addThumbnail,
  getAllSongs,
  getQueueData,
  getQueueYears,
  getQueueByYear,
  getAllSongsByAlbum,
  deleteSong,
  getSingleSong,
  // Artist controllers
  addArtistToAlbum: TryCatch(async (req, res) => {
    if (req.user.role !== "admin")
      return res.status(403).json({
        message: "You are not admin",
      });

    const { artistName, albumId, albumName } = req.body;

    if (!artistName || !albumId)
      return res.status(400).json({
        message: "artistName and albumId are required",
      });

    const artist = await createArtist({
      artistName,
      albumId,
      albumName,
    });

    res.json({
      message: "Artist added to album",
      artist,
    });
  }),

  // Singer controllers
  addSingerToSong: TryCatch(async (req, res) => {
    if (req.user.role !== "admin")
      return res.status(403).json({
        message: "You are not admin",
      });

    const { singerName } = req.body;

    if (!singerName)
      return res.status(400).json({
        message: "singerName is required",
      });

    const singer = await createSinger({
      singerName,
    });

    res.json({
      message: "Singer added",
      singer,
    });
  }),

  // Music Director controllers
  addMusicDirectorToAlbum: TryCatch(async (req, res) => {
    if (req.user.role !== "admin")
      return res.status(403).json({
        message: "You are not admin",
      });

    const { directorName, albumId, albumName } = req.body;

    if (!directorName || !albumId)
      return res.status(400).json({
        message: "directorName and albumId are required",
      });

    const musicDirector = await createMusicDirector({
      directorName,
      albumId,
      albumName,
    });

    res.json({
      message: "Music director added to album",
      musicDirector,
    });
  }),
  searchSongs,

  // Play count update
  updatePlayCount: TryCatch(async (req, res) => {
    const { id } = req.params;
    await incrementPlayCount(id);
    res.json({ message: "Play count updated" });
  }),

  // Top played songs
  getTopPlayedSongs: TryCatch(async (req, res) => {
    const limit = parseInt(req.query.limit) || 20;
    const offset = parseInt(req.query.offset) || 0;
    const shuffle = req.query.shuffle === 'true';
    const language = req.query.language || null;
    console.log(`[DEBUG] getTopPlayedSongs - Language: ${language}, Limit: ${limit}`);

    let result = await getTopPlayedSongsRepo(limit, offset, language);

    // Shuffle if requested
    if (shuffle && result.songs.length > 0) {
      result.songs = result.songs.sort(() => Math.random() - 0.5);
    }

    res.json(result);
  }),

  // Top years
  getTopYears: TryCatch(async (req, res) => {
    const language = req.query.language || null;
    const years = await getTopYearsRepo(language);
    res.json({ years });
  }),

  // Albums by year
  getAlbumsByYear: TryCatch(async (req, res) => {
    const { year } = req.params;
    const language = req.query.language || null;
    const albums = await getAlbumsByYearRepo(parseInt(year), language);
    res.json({ year: parseInt(year), albums });
  }),

  // Queue with year-based ordering and batch loading
  getQueueByYearBatch: TryCatch(async (req, res) => {
    const limit = parseInt(req.query.limit) || 1000;
    const offset = parseInt(req.query.offset) || 0;
    const result = await getQueueSongsByYearBatch(limit, offset);
    res.json(result);
  }),

  // Get playlist songs by user ID from auth token
  getPlaylistSongs: TryCatch(async (req, res) => {
    const userId = req.user.id;

    // Get user with playlist
    const { getUserWithPlaylist } = require("../repositories/userRepository.js");
    const { getPlaylistSongs: fetchPlaylistSongs } = require("../repositories/songRepository.js");

    const user = await getUserWithPlaylist(userId);

    if (!user || !user.playlist || user.playlist.length === 0) {
      return res.json({ songs: [] });
    }

    // Optimized: Fetch only playlist songs directly from DB
    const playlistSongs = await fetchPlaylistSongs(user.playlist);

    res.json({ songs: playlistSongs.map(formatSong) });
  }),

  // Get distinct languages from albums
  getDistinctLanguages: TryCatch(async (req, res) => {
    const { getDistinctLanguages } = require("../repositories/albumRepository.js");
    const languages = await getDistinctLanguages();
    res.json(languages);
  }),
};

