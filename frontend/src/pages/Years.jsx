import React, { useState, useEffect, useRef } from "react";
import { useSearchParams } from "react-router-dom";
import axios from "axios";
import { SongData } from "../context/Song";
import { UserData } from "../context/User";
import { FaChevronDown, FaChevronUp } from "react-icons/fa6";
import { FaPlay } from "react-icons/fa";
import Loading from "../components/Loading";

const Years = () => {
  const [searchParams] = useSearchParams();
  const { setSelectedSong, setIsPlaying, playQueue, setOnQueueEnd, song, selectedSong, isPlaying, queue, queueLabel } = SongData();
  const { user, addToPlaylist } = UserData();
  const [topYears, setTopYears] = useState([]);
  const [selectedYear, setSelectedYear] = useState(null);
  const [albums, setAlbums] = useState([]);
  const [expandedAlbums, setExpandedAlbums] = useState({});
  const [loading, setLoading] = useState(true);
  const [albumsLoading, setAlbumsLoading] = useState(false);
  const [albumsError, setAlbumsError] = useState(null);
  const [searchTerm, setSearchTerm] = useState("");

  // Use refs to store current values to avoid stale closures
  const selectedYearRef = useRef(selectedYear);
  const topYearsRef = useRef(topYears);
  const albumsRef = useRef(albums);

  // Update refs when values change
  useEffect(() => {
    selectedYearRef.current = selectedYear;
  }, [selectedYear]);

  useEffect(() => {
    topYearsRef.current = topYears;
  }, [topYears]);

  useEffect(() => {
    albumsRef.current = albums;
  }, [albums]);

  const playlistIds = Array.isArray(user?.playlist) ? user.playlist : [];

  useEffect(() => {
    fetchTopYears();
    
    // Check for year param and auto-load albums
    const yearParam = searchParams.get('year');
    if (yearParam) {
      fetchAlbumsByYear(parseInt(yearParam));
    }
  }, [searchParams]); // fetchTopYears and fetchAlbumsByYear are defined below, not in dependencies to avoid stale closures

  // Note: Removed automatic year progression - when a year's songs finish, player will stop
  // This matches expected behavior where user manually selects next year if desired

  const fetchTopYears = async () => {
    try {
      setLoading(true);
      const { data } = await axios.get(
        `/api/song/years/top`
      );
      // Sort years from latest to oldest
      setTopYears((data.years || []).sort((a, b) => b.year - a.year));
    } catch (error) {
      if (process.env.NODE_ENV === 'development') {
        console.error("Error fetching top years:", error);
      }
    } finally {
      setLoading(false);
    }
  };

  const fetchAlbumsByYear = async (year) => {
    try {
      setAlbumsLoading(true);
      setAlbumsError(null);
      const { data } = await axios.get(
        `/api/song/years/${year}/albums`
      );
      
      if (!data.albums || data.albums.length === 0) {
        setAlbumsError(`No albums found for year ${year}`);
        setAlbums([]);
      } else {
        setAlbums(data.albums || []);
        setAlbumsError(null);
      }
      
      setSelectedYear(year);
      setExpandedAlbums({});
    } catch (error) {
      if (process.env.NODE_ENV === 'development') {
        console.error("Error fetching albums by year:", error);
      }
      setAlbumsError(`Failed to load albums for year ${year}`);
      setAlbums([]);
    } finally {
      setAlbumsLoading(false);
    }
  };

  const toggleAlbum = (albumId) => {
    setExpandedAlbums((prev) => ({
      ...prev,
      [albumId]: !prev[albumId],
    }));
  };

  const handleSongClick = async (song, currentAlbumId) => {
    // Create a queue with all songs from all albums in the selected year
    const allSongs = albums.flatMap(album => 
      (album.songs || []).map(s => ({
        ...s,
        albumTitle: album.title,
        albumId: album.id
      }))
    );
    
    if (allSongs.length > 0) {
      const songId = song.id || song._id;
      
      if (process.env.NODE_ENV === 'development') {
        console.log(`Creating queue for year ${selectedYear} with ${allSongs.length} songs, starting with song ID: ${songId}`);
      }
      
      // Clear any existing queue end handler to prevent conflicts
      setOnQueueEnd(null);
      
      // Play the queue with a different label to avoid conflicts
      playQueue(allSongs, String(songId), `${selectedYear} Year Songs`);
      
      // Don't set up automatic year progression - let it stop when year is finished
      if (process.env.NODE_ENV === 'development') {
        console.log(`Year ${selectedYear} queue created. Will stop when all songs finish.`);
      }
    }
  };

  const savePlayListHandler = (id) => {
    addToPlaylist(id);
  };

  // Filter albums and songs based on search term
  const filteredAlbums = albums
    // First, ensure we have unique albums by ID
    .filter((album, index, self) => 
      index === self.findIndex(a => a.id === album.id)
    )
    // Then filter based on search term
    .filter(album => {
      if (!searchTerm) return true;
      
      const searchLower = searchTerm.toLowerCase();
      
      // Check if album title matches
      if (album.title?.toLowerCase().includes(searchLower)) return true;
      
      // Check if director matches
      if (album.director?.toLowerCase().includes(searchLower)) return true;
      
      // Check if music director matches
      if (album.musicDirector?.toLowerCase().includes(searchLower)) return true;
      
      // Check if any song in the album matches
      return album.songs?.some(song => 
        song.title?.toLowerCase().includes(searchLower) ||
        song.singer?.toLowerCase().includes(searchLower)
      );
    })
    // Finally, map to handle song filtering
    .map(album => {
      if (!searchTerm) return album;
      
      const searchLower = searchTerm.toLowerCase();
      
      // If album itself matches (title, director, or music director), show all songs
      const albumMatches = album.title?.toLowerCase().includes(searchLower) ||
                          album.director?.toLowerCase().includes(searchLower) ||
                          album.musicDirector?.toLowerCase().includes(searchLower);
      
      if (albumMatches) {
        return album; // Return album with all songs
      }
      
      // Otherwise, filter songs within the album
      return {
        ...album,
        songs: album.songs?.filter(song => 
          song.title?.toLowerCase().includes(searchLower) ||
          song.singer?.toLowerCase().includes(searchLower)
        )
      };
    });

  if (loading) {
    return <Loading />;
  }

  return (
    <div className="p-6 pb-24">
      <h1 className="text-3xl font-bold text-white mb-6">Top Years</h1>

      {!selectedYear ? (
        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4">
          {topYears.map((yearData) => (
            <div
              key={yearData.year}
              onClick={() => fetchAlbumsByYear(yearData.year)}
              className="bg-gradient-to-br from-gray-800 to-gray-900 hover:from-gray-700 hover:to-gray-800 rounded-lg p-6 cursor-pointer transition-all group"
            >
              <div className="text-center">
                <h2 className="text-5xl font-bold text-green-500 mb-3 group-hover:text-green-400 transition-colors">
                  {yearData.year}
                </h2>
                <p className="text-white text-sm mb-1">
                  {yearData.songCount} song{yearData.songCount !== 1 ? "s" : ""}
                </p>
                <p className="text-gray-400 text-xs">
                  {yearData.albumCount} album{yearData.albumCount !== 1 ? "s" : ""}
                </p>
              </div>
            </div>
          ))}
        </div>
      ) : (
        <div>
          <button
            onClick={() => {
              setSelectedYear(null);
              setSearchTerm(""); // Clear search when going back
              setOnQueueEnd(null); // Clear queue end handler when going back
            }}
            className="mb-6 px-4 py-2 bg-gray-800 hover:bg-gray-700 text-white rounded-full transition-colors"
          >
            ← Back to Years
          </button>

          <div className="flex flex-col sm:flex-row gap-4 items-start sm:items-center justify-between mb-6">
            <h2 className="text-2xl font-bold text-white">Albums from {selectedYear}</h2>
            <div className="relative w-full sm:w-80">
              <input
                type="text"
                placeholder="Search albums, songs, directors..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="w-full px-4 py-2 bg-gray-800 border border-gray-700 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent"
              />
              {searchTerm && (
                <button
                  onClick={() => setSearchTerm("")}
                  className="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-white transition-colors"
                >
                  ✕
                </button>
              )}
            </div>
          </div>

          {albumsLoading ? (
            <Loading />
          ) : albumsError || albums.length === 0 ? (
            <div className="bg-gray-800 rounded-lg p-12 text-center">
              <div className="text-6xl mb-4">📅</div>
              <h3 className="text-xl font-semibold text-white mb-2">
                {albumsError || `No Albums Found`}
              </h3>
              <p className="text-gray-400 mb-6">
                {albumsError 
                  ? "This year might not exist in our database or there was an error loading the data." 
                  : `No albums available for year ${selectedYear}.`}
              </p>
              <button
                onClick={() => {
                  setSelectedYear(null);
                  setSearchTerm(""); // Clear search when going back
                  setOnQueueEnd(null); // Clear queue end handler when going back
                }}
                className="px-6 py-2 bg-green-500 hover:bg-green-600 text-black rounded-full font-medium transition-colors"
              >
                Browse Other Years
              </button>
            </div>
          ) : filteredAlbums.length === 0 && searchTerm ? (
            <div className="bg-gray-800 rounded-lg p-12 text-center">
              <div className="text-6xl mb-4">🔍</div>
              <h3 className="text-xl font-semibold text-white mb-2">No Results Found</h3>
              <p className="text-gray-400 mb-6">
                No albums or songs match "{searchTerm}" in {selectedYear}
              </p>
              <button
                onClick={() => setSearchTerm("")}
                className="px-6 py-2 bg-green-500 hover:bg-green-600 text-black rounded-full font-medium transition-colors"
              >
                Clear Search
              </button>
            </div>
          ) : (
            <div className="space-y-4">
              {searchTerm && (
                <div className="text-sm text-gray-400 mb-4">
                  {filteredAlbums.length} album{filteredAlbums.length !== 1 ? 's' : ''} found for "{searchTerm}"
                </div>
              )}
              {filteredAlbums.map((album) => {
                // Check if this album contains the currently playing song
                const isCurrentAlbum = song && album.songs?.some(s => 
                  String(s.id) === String(selectedSong) || String(s._id) === String(selectedSong)
                );
                const isFromCurrentYear = queueLabel?.includes(`${selectedYear} Year Songs`);
                const shouldHighlight = isCurrentAlbum && isFromCurrentYear;
                
                return (
                <div
                  key={album.id}
                  className={`rounded-lg overflow-hidden transition-all ${
                    shouldHighlight 
                      ? 'bg-green-900/30 border border-green-500/50 shadow-lg shadow-green-500/20' 
                      : 'bg-gray-800'
                  }`}
                >
                  <div
                    onClick={() => toggleAlbum(album.id)}
                    className={`flex items-center gap-4 p-4 cursor-pointer transition-colors ${
                      shouldHighlight 
                        ? 'hover:bg-green-800/30' 
                        : 'hover:bg-gray-700'
                    }`}
                  >
                    <img
                      src={album.thumbnail?.url || "/placeholder.jpg"}
                      alt={album.title}
                      className="w-16 h-16 object-cover rounded"
                    />
                    <div className="flex-1">
                      <div className="flex items-center gap-2">
                        <h3 className={`font-semibold ${
                          shouldHighlight ? 'text-green-400' : 'text-white'
                        }`}>{album.title}</h3>
                        {shouldHighlight && isPlaying && (
                          <div className="flex items-center gap-1">
                            <div className="w-2 h-2 bg-green-500 rounded-full animate-pulse"></div>
                            <span className="text-green-400 text-xs font-medium">Playing</span>
                          </div>
                        )}
                      </div>
                      <p className="text-gray-400 text-sm">
                        {album.songs?.length || 0} song{album.songs?.length !== 1 ? "s" : ""}
                      </p>
                      {album.director && (
                        <p className="text-gray-500 text-xs">Director: {album.director}</p>
                      )}
                      {album.musicDirector && (
                        <p className="text-gray-500 text-xs">Music: {album.musicDirector}</p>
                      )}
                    </div>
                    {expandedAlbums[album.id] ? (
                      <FaChevronUp className={shouldHighlight ? "text-green-400" : "text-gray-400"} />
                    ) : (
                      <FaChevronDown className={shouldHighlight ? "text-green-400" : "text-gray-400"} />
                    )}
                  </div>

                  {expandedAlbums[album.id] && album.songs && (
                    <div className="bg-gray-900 p-4">
                      <div className="space-y-2">
                        {album.songs.map((song, index) => {
                          const isSaved = playlistIds.includes(String(song.id));
                          const isCurrentSong = String(song.id) === String(selectedSong) || String(song._id) === String(selectedSong);
                          const isCurrentlyPlaying = isCurrentSong && isFromCurrentYear;
                          
                          return (
                            <div
                              key={song.id}
                              onClick={() => handleSongClick(song, album.id)}
                              className={`flex items-center gap-3 p-3 rounded cursor-pointer group transition-colors ${
                                isCurrentlyPlaying 
                                  ? 'bg-green-900/40 hover:bg-green-800/50 border-l-4 border-green-500' 
                                  : 'hover:bg-gray-800'
                              }`}
                            >
                              <span className={`text-sm w-6 ${
                                isCurrentlyPlaying ? 'text-green-400 font-semibold' : 'text-gray-400'
                              }`}>
                                {isCurrentlyPlaying && isPlaying ? (
                                  <FaPlay className="w-3 h-3" />
                                ) : (
                                  index + 1
                                )}
                              </span>
                              <img
                                src={song.thumbnail?.url || album.thumbnail?.url || "/placeholder.jpg"}
                                alt={song.title}
                                className="w-10 h-10 object-cover rounded"
                              />
                              <div className="flex-1">
                                <h4 className={`text-sm transition-colors ${
                                  isCurrentlyPlaying 
                                    ? 'text-green-400 font-semibold' 
                                    : 'text-white group-hover:text-green-400'
                                }`}>
                                  {song.title}
                                  {isCurrentlyPlaying && (
                                    <span className="ml-2 text-xs text-green-400 font-normal">
                                      {isPlaying ? '(Playing)' : '(Paused)'}
                                    </span>
                                  )}
                                </h4>
                                <p className={`text-xs ${
                                  isCurrentlyPlaying ? 'text-green-300' : 'text-gray-400'
                                }`}>{song.singer}</p>
                              </div>
                              {song.playCount > 0 && (
                                <span className="text-gray-500 text-xs">
                                  {song.playCount.toLocaleString()} plays
                                </span>
                              )}
                              <button
                                className={`p-2 rounded-full transition-all ${
                                  isSaved ? "bg-green-500" : "hover:bg-white/10"
                                }`}
                                onClick={(event) => {
                                  event.stopPropagation();
                                  savePlayListHandler(String(song.id));
                                }}
                              >
                                <span className="text-white text-lg">{isSaved ? '\u2665' : '\u2661'}</span>
                              </button>
                            </div>
                          );
                        })}
                      </div>
                    </div>
                  )}
                </div>
                );
              })}
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default Years;
