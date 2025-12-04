const TryCatch = require("../utils/TryCatch.js");
const {
  getLatestAlbums,
  getLatestAlbumsSmart,
  getAlbumsPaginated,
  getAlbumsForSearch,
} = require("../repositories/albumRepository.js");
const {
  getTopArtists,
  getArtistsPaginated,
  getAlbumsByArtist,
  getArtistsForSearch,
} = require("../repositories/artistRepository.js");
const {
  getTopSingers,
  getSingersPaginated,
  getSingersForSearch,
} = require("../repositories/singerRepository.js");
const {
  getTopMusicDirectors,
  getMusicDirectorsPaginated,
  getAlbumsByMusicDirectorName,
  getMusicDirectorsForSearch,
} = require("../repositories/musicDirectorRepository.js");
const {
  getSongsBySinger,
} = require("../repositories/songRepository.js");

const formatAlbum = (album) => ({
  ...album,
  _id: String(album.id),
});

// Latest Albums from a specific year (default 2025)
const getLatestAlbumsByYear = TryCatch(async (req, res) => {
  const year = req.query.year ? Number(req.query.year) : 2025;
  const limit = req.query.limit ? Number(req.query.limit) : 10;

  if (Number.isNaN(year) || Number.isNaN(limit)) {
    return res.status(400).json({
      message: "Invalid year or limit parameter",
    });
  }

  const albums = await getLatestAlbums(year, limit);

  res.json({
    message: "Latest albums retrieved successfully",
    data: albums.map(formatAlbum),
    count: albums.length,
  });
});

// Smart Latest Albums (fetches from max year and previous year if max year != current year)
const getLatestAlbumsSmart_Controller = TryCatch(async (req, res) => {
  const limit = req.query.limit ? Number(req.query.limit) : 10;
  const language = req.query.language || null;

  if (Number.isNaN(limit)) {
    return res.status(400).json({
      message: "Invalid limit parameter",
    });
  }

  const result = await getLatestAlbumsSmart(limit, language);

  res.json({
    message: "Latest albums retrieved successfully",
    data: result.albums.map(formatAlbum),
    maxYear: result.maxYear,
    currentYear: result.currentYear,
    years: result.years,
    count: result.albums.length,
  });
});

// Get all albums with pagination
const getAllAlbumsPaginated = TryCatch(async (req, res) => {
  const page = req.query.page ? Number(req.query.page) : 1;
  const limit = req.query.limit ? Number(req.query.limit) : 12;

  if (Number.isNaN(page) || Number.isNaN(limit) || page < 1 || limit < 1) {
    return res.status(400).json({
      message: "Invalid pagination parameters",
    });
  }

  const result = await getAlbumsPaginated(page, limit);

  res.json({
    message: "Albums retrieved successfully",
    data: result.data.map(formatAlbum),
    pagination: result.pagination,
  });
});

// Get top artists
const getTopArtistsSection = TryCatch(async (req, res) => {
  const limit = req.query.limit ? Number(req.query.limit) : 10;
  const language = req.query.language || null;

  if (Number.isNaN(limit) || limit < 1) {
    return res.status(400).json({
      message: "Invalid limit parameter",
    });
  }

  const artists = await getTopArtists(limit, language);

  res.json({
    message: "Top artists retrieved successfully",
    data: artists,
    count: artists.length,
  });
});

// Get all artists with pagination
const getAllArtistsPaginated = TryCatch(async (req, res) => {
  const page = req.query.page ? Number(req.query.page) : 1;
  const limit = req.query.limit ? Number(req.query.limit) : 12;

  if (Number.isNaN(page) || Number.isNaN(limit) || page < 1 || limit < 1) {
    return res.status(400).json({
      message: "Invalid pagination parameters",
    });
  }

  const result = await getArtistsPaginated(page, limit);

  res.json({
    message: "Artists retrieved successfully",
    data: result.data,
    pagination: result.pagination,
  });
});

// Get top singers
const getTopSingersSection = TryCatch(async (req, res) => {
  const limit = req.query.limit ? Number(req.query.limit) : 10;
  const language = req.query.language || null;

  if (Number.isNaN(limit) || limit < 1) {
    return res.status(400).json({
      message: "Invalid limit parameter",
    });
  }

  const singers = await getTopSingers(limit, language);

  res.json({
    message: "Top singers retrieved successfully",
    data: singers,
    count: singers.length,
  });
});

// Get all singers with pagination
const getAllSingersPaginated = TryCatch(async (req, res) => {
  const page = req.query.page ? Number(req.query.page) : 1;
  const limit = req.query.limit ? Number(req.query.limit) : 12;

  if (Number.isNaN(page) || Number.isNaN(limit) || page < 1 || limit < 1) {
    return res.status(400).json({
      message: "Invalid pagination parameters",
    });
  }

  const result = await getSingersPaginated(page, limit);

  res.json({
    message: "Singers retrieved successfully",
    data: result.data,
    pagination: result.pagination,
  });
});

// Get top music directors
const getTopMusicDirectorsSection = TryCatch(async (req, res) => {
  const limit = req.query.limit ? Number(req.query.limit) : 10;
  const language = req.query.language || null;

  if (Number.isNaN(limit) || limit < 1) {
    return res.status(400).json({
      message: "Invalid limit parameter",
    });
  }

  const directors = await getTopMusicDirectors(limit, language);

  res.json({
    message: "Top music directors retrieved successfully",
    data: directors,
    count: directors.length,
  });
});

// Get all music directors with pagination
const getAllMusicDirectorsPaginated = TryCatch(async (req, res) => {
  const page = req.query.page ? Number(req.query.page) : 1;
  const limit = req.query.limit ? Number(req.query.limit) : 12;

  if (Number.isNaN(page) || Number.isNaN(limit) || page < 1 || limit < 1) {
    return res.status(400).json({
      message: "Invalid pagination parameters",
    });
  }

  const result = await getMusicDirectorsPaginated(page, limit);

  res.json({
    message: "Music directors retrieved successfully",
    data: result.data,
    pagination: result.pagination,
  });
});

// Get songs by album ID
const getSongsByAlbumId = TryCatch(async (req, res) => {
  const { albumId } = req.params;

  if (!albumId || Number.isNaN(Number(albumId))) {
    return res.status(400).json({
      message: "Invalid album ID",
    });
  }

  const songs = await require("../repositories/songRepository.js").getSongsByAlbum(
    Number(albumId)
  );

  res.json({
    message: "Songs retrieved successfully",
    data: songs.map(song => ({ ...song, _id: String(song.id) })),
    count: songs.length,
  });
});

// Get songs by singer name
const getSongsBySingerName = TryCatch(async (req, res) => {
  const { singerName } = req.params;

  if (!singerName) {
    return res.status(400).json({
      message: "Singer name is required",
    });
  }

  const songs = await getSongsBySinger(decodeURIComponent(singerName));

  res.json({
    message: "Songs retrieved successfully",
    data: songs.map(song => ({ ...song, _id: String(song.id) })),
    count: songs.length,
  });
});

// Get albums by artist ID
const getAlbumsByArtistId = TryCatch(async (req, res) => {
  const { artistId } = req.params;

  if (!artistId || Number.isNaN(Number(artistId))) {
    return res.status(400).json({
      message: "Invalid artist ID",
    });
  }

  const albums = await getAlbumsByArtist(Number(artistId));

  res.json({
    message: "Albums retrieved successfully",
    data: albums.map(formatAlbum),
    count: albums.length,
  });
});

// Get albums by music director name
const getAlbumsByMusicDirector = TryCatch(async (req, res) => {
  const { directorName } = req.params;

  if (!directorName) {
    return res.status(400).json({
      message: "Director name is required",
    });
  }

  const albums = await getAlbumsByMusicDirectorName(
    decodeURIComponent(directorName)
  );

  res.json({
    message: "Albums retrieved successfully",
    data: albums.map(formatAlbum),
    count: albums.length,
  });
});

// Optimized search endpoints - minimal data for search functionality
const getAlbumsForSearchEndpoint = TryCatch(async (req, res) => {
  const albums = await getAlbumsForSearch();
  
  res.json({
    message: "Albums for search retrieved successfully",
    data: albums,
    count: albums.length,
  });
});

const getArtistsForSearchEndpoint = TryCatch(async (req, res) => {
  const q = req.query.q ? String(req.query.q) : null;
  const limit = req.query.limit ? Number(req.query.limit) : null;

  if (limit !== null && (Number.isNaN(limit) || limit < 1)) {
    return res.status(400).json({ message: "Invalid limit parameter" });
  }

  const artists = await getArtistsForSearch(q, limit);
  
  res.json({
    message: "Artists for search retrieved successfully",
    data: artists,
    count: artists.length,
    query: q || undefined,
  });
});

const getSingersForSearchEndpoint = TryCatch(async (req, res) => {
  const singers = await getSingersForSearch();
  
  res.json({
    message: "Singers for search retrieved successfully",
    data: singers,
    count: singers.length,
  });
});

const getMusicDirectorsForSearchEndpoint = TryCatch(async (req, res) => {
  const directors = await getMusicDirectorsForSearch();
  
  res.json({
    message: "Music directors for search retrieved successfully",
    data: directors,
    count: directors.length,
  });
});

module.exports = {
  getLatestAlbumsByYear,
  getLatestAlbumsSmart_Controller,
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
  // Optimized search endpoints
  getAlbumsForSearchEndpoint,
  getArtistsForSearchEndpoint,
  getSingersForSearchEndpoint,
  getMusicDirectorsForSearchEndpoint,
};
