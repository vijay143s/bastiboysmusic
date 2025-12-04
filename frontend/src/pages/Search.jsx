import React, { useMemo, useState, useEffect } from "react";
import { SongData } from "../context/Song";
import AlbumItem from "../components/AlbumItem";
import { FaPlay, FaFire, FaHistory, FaClock } from "react-icons/fa";
import { RiSearchLine, RiCloseLine, RiSparklingFill, RiMusicFill } from "react-icons/ri";
import { useNavigate } from "react-router-dom";
import { UserData } from "../context/User";
import axios from "axios";

const Search = () => {
  const { songs, albums, playQueue } = SongData();
  const { addToPlaylist, user } = UserData();
  const navigate = useNavigate();
  const [query, setQuery] = useState("");
  const [searchType, setSearchType] = useState("songs"); // 'songs', 'albums', 'artists', 'singers'
  const [yearFilter, setYearFilter] = useState("");
  const [availableYears, setAvailableYears] = useState([]);
  const [yearAlbums, setYearAlbums] = useState([]);
  const [loadingYearAlbums, setLoadingYearAlbums] = useState(false);
  const [apiSearchResults, setApiSearchResults] = useState([]);
  const [apiAlbumResults, setApiAlbumResults] = useState([]);
  const [apiArtistResults, setApiArtistResults] = useState([]);
  const [apiSingerResults, setApiSingerResults] = useState([]);
  const [searchLoading, setSearchLoading] = useState(false);
  const [trending, setTrending] = useState([]);
  const [recommendations, setRecommendations] = useState([]);
  const [recentSearches, setRecentSearches] = useState([]);
  const [loadingTrending, setLoadingTrending] = useState(false);
  const [loadingRecommendations, setLoadingRecommendations] = useState(false);

  // Fetch available years for filtering
  useEffect(() => {
    const fetchYears = async () => {
      try {
        const { data } = await axios.get("/api/song/years/top");
        const years = data.years.map(y => y.year).sort((a, b) => b - a);
        setAvailableYears(years);
      } catch (error) {
        if (process.env.NODE_ENV === 'development') {
          console.error("Error fetching years:", error);
        }
      }
    };
    fetchYears();
  }, []);

  // Fetch trending and recommendations when no search query
  useEffect(() => {
    if (!query.trim()) {
      fetchTrendingAndRecommendations();
      setApiSearchResults([]);
      setApiAlbumResults([]);
      setApiArtistResults([]);
      setApiSingerResults([]);
    } else {
      // Debounce API search
      const timer = setTimeout(() => {
        performApiSearch(query.trim());
      }, 300);
      return () => clearTimeout(timer);
    }
  }, [query, user, yearFilter]);

  // Set search type to albums when year filter is selected
  useEffect(() => {
    if (yearFilter && !query.trim()) {
      setSearchType("albums");
    }
  }, [yearFilter, query]);

  const fetchTrendingAndRecommendations = async () => {
    setLoadingTrending(true);
    setLoadingRecommendations(true);

    try {
      const trendingRes = await axios.get("/api/interaction/trending?limit=10");
      setTrending(trendingRes.data.trending || []);
    } catch (error) {
      if (process.env.NODE_ENV === 'development') {
        console.error("Error fetching trending:", error);
      }
      setTrending([]);
    } finally {
      setLoadingTrending(false);
    }

    if (user) {
      try {
        const recRes = await axios.get("/api/interaction/recommendations?limit=20");
        const recs = (recRes.data.recommendations || []).map((s) => {
          const id = s._id ?? s.id ?? s.songId ?? s.song_id;
          return id ? { ...s, _id: String(id) } : s;
        });
        setRecommendations(recs);
        
        const statsRes = await axios.get("/api/interaction/stats");
        setRecentSearches(statsRes.data.stats?.recentSearches || []);
      } catch (error) {
        if (process.env.NODE_ENV === 'development') {
          console.error("Error fetching recommendations:", error);
        }
        setRecommendations([]);
      } finally {
        setLoadingRecommendations(false);
      }
    } else {
      setLoadingRecommendations(false);
    }
  };

  const performApiSearch = async (searchQuery) => {
    if (!searchQuery) return;
    
    setSearchLoading(true);
    try {
      const params = new URLSearchParams({ q: searchQuery, limit: 100 });
      if (yearFilter) params.append('year', yearFilter);
      
      const { data } = await axios.get(`/api/song/search?${params}`);
      setApiSearchResults(data.songs || []);
      setApiAlbumResults(data.albums || []);
      setApiArtistResults(data.artists || []);
      setApiSingerResults(data.singers || []);
    } catch (error) {
      if (process.env.NODE_ENV === 'development') {
        console.error('Error searching:', error);
      }
      setApiSearchResults([]);
      setApiAlbumResults([]);
      setApiArtistResults([]);
      setApiSingerResults([]);
    } finally {
      setSearchLoading(false);
    }
  };
  
  // Load albums when year filter changes
  useEffect(() => {
    if (yearFilter) {
      loadAlbumsByYear(yearFilter);
    } else {
      setYearAlbums([]);
    }
  }, [yearFilter]);
  
  const loadAlbumsByYear = async (year) => {
    setLoadingYearAlbums(true);
    try {
      const { data } = await axios.get(`/api/song/years/${year}/albums`);
      setYearAlbums(data.albums || []);
    } catch (error) {
      if (process.env.NODE_ENV === 'development') {
        console.error("Error loading albums by year:", error);
      }
      setYearAlbums([]);
    } finally {
      setLoadingYearAlbums(false);
    }
  };

  const normalizedQuery = query.trim().toLowerCase();

  const albumMatches = useMemo(() => {
    if (yearFilter && !normalizedQuery) {
      return yearAlbums;
    }
    
    if (!normalizedQuery) return [];
    
    // Use API results if available
    if (apiAlbumResults.length > 0) {
      return apiAlbumResults;
    }
    
    // Fallback to client-side search
    const sourceAlbums = yearFilter ? yearAlbums : albums;
    const filtered = sourceAlbums.filter((album) =>
      [album.title, album.description]
        .filter(Boolean)
        .some((field) => field.toLowerCase().includes(normalizedQuery))
    );
    
    return filtered;
  }, [albums, yearAlbums, normalizedQuery, yearFilter, apiAlbumResults]);

  const artistMatches = useMemo(() => {
    if (!normalizedQuery) return [];
    return apiArtistResults;
  }, [normalizedQuery, apiArtistResults]);

  const singerMatches = useMemo(() => {
    if (!normalizedQuery) return [];
    return apiSingerResults;
  }, [normalizedQuery, apiSingerResults]);

  const songMatches = useMemo(() => {
    // If searching with query, use API results (even if empty)
    if (normalizedQuery) {
      if (apiSearchResults.length > 0) {
        return apiSearchResults;
      }
      // API returned no results, do client-side fallback
      let filtered = songs.filter((song) =>
        [song.title, song.singer, song.description]
          .filter(Boolean)
          .some((field) => field.toLowerCase().includes(normalizedQuery))
      );
      
      if (yearFilter) {
        filtered = filtered.filter(song => {
          const album = albums.find(a => a._id === song.album);
          return album && album.year && album.year.toString() === yearFilter;
        });
      }
      
      return filtered;
    }
    
    // If only year filter is active (no query), get songs by year
    if (yearFilter) {
      const filtered = songs.filter(song => {
        const album = albums.find(a => a._id === song.album);
        return album && album.year && album.year.toString() === yearFilter;
      });
      return filtered;
    }
    
    return [];
  }, [songs, albums, normalizedQuery, yearFilter, apiSearchResults]);

  const handlePlaySong = async (id, sourceList) => {
    // Prefer the explicit source list if provided (recommendations/trending/search results)
    let listToUse = Array.isArray(sourceList) && sourceList.length ? sourceList : null;
    let label = "All Songs";

    // If no explicit list, derive from current UI context
    if (!listToUse) {
      // When searching, use the active tab's matches
      if (normalizedQuery || yearFilter) {
        if (searchType === "songs") {
          listToUse = songMatches;
          label = "Search Results";
        } else if (searchType === "albums") {
          // Albums map to songs via album click; keep fallback minimal
          listToUse = songMatches;
          label = "Search Results";
        } else {
          listToUse = songMatches;
          label = "Search Results";
        }
      }
    }

    // Final fallback to global songs only if still missing
    if (!listToUse || !listToUse.length) {
      listToUse = songs;
      label = "All Songs";
    }

    // Specific labels for known sections
    if (sourceList === recommendations) label = "Recommendations";
    if (sourceList === trending) label = "Trending";

    // Ensure we have the correct ID format - normalize to string and handle both id and _id
    const normalizedId = String(id);
    
    // Debug log to check what's being passed
    if (process.env.NODE_ENV === 'development') {
      console.log('Playing song with ID:', normalizedId);
      console.log('From list:', label);
      console.log('List length:', listToUse.length);
      console.log('Song exists in list:', listToUse.some(s => String(s._id || s.id) === normalizedId));
    }

    playQueue(listToUse, normalizedId, label);

    // Track search click
    if (query.trim()) {
      try {
        await axios.post("/api/interaction/track/search", {
          query: query.trim(),
          resultsCount: songMatches.length + albumMatches.length,
          clickedSongId: id
        });
      } catch (error) {
        if (process.env.NODE_ENV === 'development') {
          console.error("Error tracking search:", error);
        }
      }
    }
  };

  const handleAddSong = async (songId) => {
    await addToPlaylist(songId);
  };

  const handleRecentSearchClick = (searchQuery) => {
    setQuery(searchQuery);
  };

  // Render horizontal song card for trending/recommendations
  const renderHorizontalCard = (song, sourceList) => {
    const songId = song._id || song.id;
    return (
    <div
      key={songId}
      className="flex-shrink-0 w-40 md:w-48 bg-[#181818] hover:bg-[#282828] rounded-lg p-3 transition-all cursor-pointer group"
      onClick={() => handlePlaySong(songId, sourceList)}
    >
      <div className="relative mb-3">
        <img
          src={song.thumbnail?.url || song.thumbnail || song.albumThumbnail || "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='160' height='160'%3E%3Crect width='160' height='160' fill='%23333'/%3E%3C/svg%3E"}
          alt={song.title}
          className="w-full aspect-square rounded-md object-cover"
        />
        <button
          className="absolute bottom-2 right-2 bg-green-500 hover:bg-green-400 text-black rounded-full p-3 opacity-0 group-hover:opacity-100 transform translate-y-2 group-hover:translate-y-0 transition-all shadow-lg"
          onClick={(e) => {
            e.stopPropagation();
            handlePlaySong(songId, sourceList);
          }}
        >
          <FaPlay className="text-sm" />
        </button>
      </div>
      <div className="space-y-1">
        <p className="font-semibold text-white truncate text-sm">{song.title}</p>
        <p className="text-xs text-slate-400 truncate">
          {song.singer || song.artist || "Unknown artist"}
        </p>
      </div>
    </div>
    );
  };

  // Render song card
  const renderSongCard = (song, sourceList) => (
    <div
      key={song._id}
      className="bg-[#1b1b1b] hover:bg-[#252525] rounded-lg p-3 md:p-4 transition-all cursor-pointer group"
      onClick={() => handlePlaySong(song._id, sourceList)}
    >
      <div className="flex items-center gap-3 md:gap-4">
        <div className="relative flex-shrink-0">
          <img
            src={song.thumbnail?.url || song.thumbnail || "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='64' height='64'%3E%3Crect width='64' height='64' fill='%23333'/%3E%3C/svg%3E"}
            alt={song.title}
            className="w-14 h-14 md:w-16 md:h-16 rounded object-cover"
          />
          <div className="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-40 rounded flex items-center justify-center transition-all">
            <FaPlay className="text-white opacity-0 group-hover:opacity-100 text-xl" />
          </div>
        </div>
        <div className="flex-1 min-w-0">
          <p className="font-semibold text-white truncate text-sm md:text-base">{song.title}</p>
          <p className="text-xs md:text-sm text-slate-400 truncate">
            {song.singer || "Unknown artist"}
          </p>
          {song.albumName && (
            <p className="text-xs text-slate-500 truncate mt-1">{song.albumName}</p>
          )}
        </div>
        <button
          className="p-2 rounded-full transition-all duration-200 flex-shrink-0"
          title="Save to playlist"
          onClick={(e) => {
            e.stopPropagation();
            handleAddSong(song._id);
          }}
        >
          <span className="text-white text-lg">♡</span>
        </button>
      </div>
    </div>
  );

  return (
    <div className="px-2 md:px-6 py-4 pb-24">
      {/* Search Header */}
      <div className="mb-6 md:mb-8">
        <h1 className="text-2xl md:text-3xl font-bold mb-4">Search</h1>
        
        {/* Search Input */}
        <div className="relative mb-4">
          <RiSearchLine className="absolute left-4 top-1/2 transform -translate-y-1/2 text-slate-400 text-xl" />
          <input
            type="text"
            placeholder="Search songs, albums, artists, or year..."
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            className="w-full bg-[#1b1b1b] text-white placeholder-slate-400 pl-12 pr-12 py-3 md:py-4 rounded-xl border border-slate-700 focus:border-green-500 focus:outline-none transition-all text-sm md:text-base"
          />
          {query && (
            <button
              onClick={() => setQuery("")}
              className="absolute right-4 top-1/2 transform -translate-y-1/2 text-slate-400 hover:text-white transition-colors"
            >
              <RiCloseLine className="text-2xl" />
            </button>
          )}
        </div>

        {/* Year Filter Chips - Always visible */}
        <div className="flex gap-2 overflow-x-auto pb-2 scrollbar-hide mb-4">
          <button
            onClick={() => setYearFilter("")}
            className={`px-4 py-2 rounded-full text-xs md:text-sm font-medium transition-all flex-shrink-0 ${
              !yearFilter
                ? "bg-green-500 text-black"
                : "bg-[#1b1b1b] text-slate-300 hover:bg-[#252525]"
            }`}
          >
            All Years
          </button>
          {availableYears.slice(0, 10).map((year) => (
            <button
              key={year}
              onClick={() => setYearFilter(year.toString())}
              className={`px-4 py-2 rounded-full text-xs md:text-sm font-medium transition-all flex-shrink-0 ${
                yearFilter === year.toString()
                  ? "bg-green-500 text-black"
                  : "bg-[#1b1b1b] text-slate-300 hover:bg-[#252525]"
              }`}
            >
              {year}
            </button>
          ))}
        </div>

        {/* Search Type Filter - Show when searching or year filter active */}
        {(normalizedQuery || yearFilter) && (
          <div className="flex gap-2 border-b border-slate-700 overflow-x-auto">
            <button
              onClick={() => setSearchType("songs")}
              className={`px-4 py-2 text-sm font-medium transition-all flex-shrink-0 ${
                searchType === "songs"
                  ? "text-green-500 border-b-2 border-green-500"
                  : "text-slate-400 hover:text-white"
              }`}
            >
              Songs ({songMatches.length})
            </button>
            <button
              onClick={() => setSearchType("albums")}
              className={`px-4 py-2 text-sm font-medium transition-all flex-shrink-0 ${
                searchType === "albums"
                  ? "text-green-500 border-b-2 border-green-500"
                  : "text-slate-400 hover:text-white"
              }`}
            >
              Albums ({albumMatches.length})
            </button>
            <button
              onClick={() => setSearchType("artists")}
              className={`px-4 py-2 text-sm font-medium transition-all flex-shrink-0 ${
                searchType === "artists"
                  ? "text-green-500 border-b-2 border-green-500"
                  : "text-slate-400 hover:text-white"
              }`}
            >
              Artists ({artistMatches.length})
            </button>
            <button
              onClick={() => setSearchType("singers")}
              className={`px-4 py-2 text-sm font-medium transition-all flex-shrink-0 ${
                searchType === "singers"
                  ? "text-green-500 border-b-2 border-green-500"
                  : "text-slate-400 hover:text-white"
              }`}
            >
              Singers ({singerMatches.length})
            </button>
          </div>
        )}
      </div>

      {/* Empty State - Show Trending and Recommendations */}
      {!normalizedQuery && !yearFilter ? (
        <div className="space-y-6 md:space-y-8">
          {/* Recent Searches */}
          {recentSearches.length > 0 && (
            <section>
              <div className="flex items-center gap-2 mb-4">
                <FaHistory className="text-slate-400 text-lg" />
                <h2 className="text-lg md:text-xl font-semibold">Recent Searches</h2>
              </div>
              <div className="flex flex-wrap gap-2">
                {recentSearches.map((search, idx) => (
                  <button
                    key={idx}
                    onClick={() => handleRecentSearchClick(search)}
                    className="bg-[#1b1b1b] hover:bg-[#252525] text-slate-300 px-4 py-2 rounded-full text-sm transition-all"
                  >
                    {search}
                  </button>
                ))}
              </div>
            </section>
          )}

          {/* Trending Now */}
          <section>
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center gap-2">
                <FaFire className="text-orange-500 text-lg" />
                <h2 className="text-lg md:text-xl font-semibold">Trending Now</h2>
                <span className="text-xs text-slate-500">Last 7 days</span>
              </div>
              {trending.length > 0 && (
                <span className="text-xs text-slate-400">{trending.length} songs</span>
              )}
            </div>
            {loadingTrending ? (
              <div className="flex items-center justify-center py-10">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-500"></div>
              </div>
            ) : trending.length > 0 ? (
              <div className="flex gap-4 overflow-x-auto pb-4 scrollbar-hide">
                {trending.map((song) => renderHorizontalCard(song, trending))}
              </div>
            ) : (
              <div className="bg-[#1b1b1b] rounded-lg p-8 text-center">
                <RiMusicFill className="text-4xl text-slate-600 mx-auto mb-2" />
                <p className="text-slate-400">No trending songs available</p>
              </div>
            )}
          </section>

          {/* Recommended For You */}
          {user && (
            <section>
              <div className="flex items-center justify-between mb-4">
                <div className="flex items-center gap-2">
                  <RiSparklingFill className="text-yellow-500 text-lg" />
                  <h2 className="text-lg md:text-xl font-semibold">Recommended For You</h2>
                </div>
                {recommendations.length > 0 && (
                  <span className="text-xs text-slate-400">{recommendations.length} songs</span>
                )}
              </div>
              {loadingRecommendations ? (
                <div className="flex items-center justify-center py-10">
                  <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-500"></div>
                </div>
              ) : recommendations.length > 0 ? (
                <div className="flex gap-4 overflow-x-auto pb-4 scrollbar-hide">
                  {recommendations.map((song) => renderHorizontalCard(song, recommendations))}
                </div>
              ) : (
                <div className="bg-[#1b1b1b] rounded-lg p-8 text-center">
                  <RiSparklingFill className="text-4xl text-slate-600 mx-auto mb-2" />
                  <p className="text-slate-400 mb-2">No recommendations yet</p>
                  <p className="text-xs text-slate-500">Start listening to get personalized recommendations</p>
                </div>
              )}
            </section>
          )}

          {/* Browse by Category - Quick Access */}
          <section>
            <h2 className="text-lg md:text-xl font-semibold mb-4">Browse</h2>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-3 md:gap-4">
              <button
                key="browse-albums"
                onClick={() => navigate("/albums")}
                className="bg-gradient-to-br from-blue-600 to-blue-800 hover:from-blue-500 hover:to-blue-700 rounded-lg p-6 text-left transition-all group"
              >
                <h3 className="font-bold text-lg mb-1">Albums</h3>
                <p className="text-sm text-blue-200">Browse all albums</p>
              </button>
              <button
                key="browse-artists"
                onClick={() => navigate("/artists")}
                className="bg-gradient-to-br from-purple-600 to-purple-800 hover:from-purple-500 hover:to-purple-700 rounded-lg p-6 text-left transition-all group"
              >
                <h3 className="font-bold text-lg mb-1">Artists</h3>
                <p className="text-sm text-purple-200">Explore artists</p>
              </button>
              <button
                key="browse-singers"
                onClick={() => navigate("/singers")}
                className="bg-gradient-to-br from-pink-600 to-pink-800 hover:from-pink-500 hover:to-pink-700 rounded-lg p-6 text-left transition-all group"
              >
                <h3 className="font-bold text-lg mb-1">Singers</h3>
                <p className="text-sm text-pink-200">Find singers</p>
              </button>
              <button
                key="browse-years"
                onClick={() => navigate("/years")}
                className="bg-gradient-to-br from-green-600 to-green-800 hover:from-green-500 hover:to-green-700 rounded-lg p-6 text-left transition-all group"
              >
                <h3 className="font-bold text-lg mb-1">Years</h3>
                <p className="text-sm text-green-200">Browse by year</p>
              </button>
            </div>
          </section>
        </div>
      ) : (
        /* Search Results */
        <div className="space-y-6 md:space-y-8">
          {/* Loading State */}
          {searchLoading && (
            <div className="flex justify-center items-center py-10">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-500"></div>
              <span className="ml-3 text-slate-400">Searching...</span>
            </div>
          )}

          {/* Results Count */}
          {!searchLoading && (normalizedQuery || yearFilter) && (
            <div className="text-sm text-slate-400">
              {albumMatches.length + songMatches.length + artistMatches.length + singerMatches.length} result
              {albumMatches.length + songMatches.length + artistMatches.length + singerMatches.length !== 1 ? "s" : ""} found
              {yearFilter && ` in ${yearFilter}`}
            </div>
          )}

          {/* Artists Section */}
          {!searchLoading && searchType === "artists" && artistMatches.length > 0 && (
            <section>
              <div className="flex items-center justify-between mb-4">
                <h2 className="text-lg md:text-xl font-semibold">Artists</h2>
                <span className="text-sm text-slate-400">{artistMatches.length}</span>
              </div>
              <div className="grid gap-3 md:gap-4 grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5">
                {artistMatches.map((artist) => (
                  <div
                    key={artist.artistId}
                    onClick={() => navigate(`/results/artist/${artist.artistId}`)}
                    className="bg-[#181818] hover:bg-[#282828] rounded-lg p-4 transition-all cursor-pointer group"
                  >
                    <div className="aspect-square rounded-full bg-gradient-to-br from-purple-600 to-blue-600 mb-3 flex items-center justify-center">
                      <span className="text-4xl font-bold text-white">
                        {artist.artistName?.charAt(0).toUpperCase()}
                      </span>
                    </div>
                    <p className="font-semibold text-white truncate text-sm">{artist.artistName}</p>
                    <p className="text-xs text-slate-400 truncate">
                      {artist.albumCount} album{artist.albumCount !== 1 ? 's' : ''}
                    </p>
                  </div>
                ))}
              </div>
            </section>
          )}

          {/* Singers Section */}
          {!searchLoading && searchType === "singers" && singerMatches.length > 0 && (
            <section>
              <div className="flex items-center justify-between mb-4">
                <h2 className="text-lg md:text-xl font-semibold">Singers</h2>
                <span className="text-sm text-slate-400">{singerMatches.length}</span>
              </div>
              <div className="grid gap-3 md:gap-4 grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5">
                {singerMatches.map((singer) => (
                  <div
                    key={singer.singerId}
                    onClick={() => navigate(`/results/singer/${encodeURIComponent(singer.singerName)}`)}
                    className="bg-[#181818] hover:bg-[#282828] rounded-lg p-4 transition-all cursor-pointer group"
                  >
                    <div className="aspect-square rounded-full bg-gradient-to-br from-pink-600 to-rose-600 mb-3 flex items-center justify-center">
                      <span className="text-4xl font-bold text-white">
                        {singer.singerName?.charAt(0).toUpperCase()}
                      </span>
                    </div>
                    <p className="font-semibold text-white truncate text-sm">{singer.singerName}</p>
                    <p className="text-xs text-slate-400 truncate">
                      {singer.songCount} song{singer.songCount !== 1 ? 's' : ''}
                    </p>
                  </div>
                ))}
              </div>
            </section>
          )}

          {/* Albums Section */}
          {loadingYearAlbums ? (
            <div className="flex justify-center items-center py-10">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-500"></div>
              <span className="ml-3 text-slate-400">Loading albums...</span>
            </div>
          ) : !searchLoading && searchType === "albums" && albumMatches.length > 0 && (
            <section>
              <div className="flex items-center justify-between mb-4">
                <h2 className="text-lg md:text-xl font-semibold">Albums</h2>
                <span className="text-sm text-slate-400">{albumMatches.length}</span>
              </div>
              <div className="grid gap-3 md:gap-4 grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5">
                {albumMatches.map((album) => (
                  <AlbumItem
                    key={album._id}
                    image={album.thumbnail?.url || ""}
                    name={album.title}
                    desc={album.description}
                    id={album._id}
                  />
                ))}
              </div>
            </section>
          )}

          {/* Songs Section */}
          {!searchLoading && searchType === "songs" && songMatches.length > 0 && (
            <section>
              <div className="flex items-center justify-between mb-4">
                <h2 className="text-lg md:text-xl font-semibold">Songs</h2>
                <span className="text-sm text-slate-400">{songMatches.length}</span>
              </div>
              <div className="grid gap-3 md:gap-4">
                {songMatches.map((song) => renderSongCard(song, songMatches))}
              </div>
            </section>
          )}

          {/* No Results */}
          {!searchLoading && albumMatches.length === 0 && songMatches.length === 0 && artistMatches.length === 0 && singerMatches.length === 0 && (
            <div className="bg-[#1b1b1b] rounded-lg p-12 text-center">
              <RiSearchLine className="text-5xl text-slate-600 mx-auto mb-4" />
              <h3 className="text-xl font-semibold mb-2">No results found</h3>
              <p className="text-slate-400 mb-4">
                {yearFilter 
                  ? `No matches for "${query}" in ${yearFilter}`
                  : `No matches for "${query}"`}
              </p>
              <button
                onClick={() => {
                  setQuery("");
                  setYearFilter("");
                }}
                className="bg-green-500 hover:bg-green-600 text-black px-6 py-2 rounded-full font-medium transition-all"
              >
                Clear filters
              </button>
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default Search;
