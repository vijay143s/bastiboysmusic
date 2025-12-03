import React, { useState, useEffect } from "react";
import { useSearchParams } from "react-router-dom";
import axios from "axios";
import { SongData } from "../context/Song";
import { UserData } from "../context/User";
import { FaChevronDown, FaChevronUp, FaPlay } from "react-icons/fa6";
import Loading from "../components/Loading";

const Years = () => {
  const [searchParams] = useSearchParams();
  const { setSelectedSong, setIsPlaying } = SongData();
  const { user, addToPlaylist } = UserData();
  const [topYears, setTopYears] = useState([]);
  const [selectedYear, setSelectedYear] = useState(null);
  const [albums, setAlbums] = useState([]);
  const [expandedAlbums, setExpandedAlbums] = useState({});
  const [loading, setLoading] = useState(true);
  const [albumsLoading, setAlbumsLoading] = useState(false);
  const [albumsError, setAlbumsError] = useState(null);

  const playlistIds = Array.isArray(user?.playlist) ? user.playlist : [];

  useEffect(() => {
    fetchTopYears();
    
    // Check for year param and auto-load albums
    const yearParam = searchParams.get('year');
    if (yearParam) {
      fetchAlbumsByYear(parseInt(yearParam));
    }
  }, [searchParams]);

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

  const handleSongClick = async (song) => {
    setSelectedSong(song.id);
    setIsPlaying(true);
  };

  const savePlayListHandler = (id) => {
    addToPlaylist(id);
  };

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
            onClick={() => setSelectedYear(null)}
            className="mb-6 px-4 py-2 bg-gray-800 hover:bg-gray-700 text-white rounded-full transition-colors"
          >
            ← Back to Years
          </button>

          <h2 className="text-2xl font-bold text-white mb-4">Albums from {selectedYear}</h2>

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
                onClick={() => setSelectedYear(null)}
                className="px-6 py-2 bg-green-500 hover:bg-green-600 text-black rounded-full font-medium transition-colors"
              >
                Browse Other Years
              </button>
            </div>
          ) : (
            <div className="space-y-4">
              {albums.map((album) => (
                <div
                  key={album.id}
                  className="bg-gray-800 rounded-lg overflow-hidden"
                >
                  <div
                    onClick={() => toggleAlbum(album.id)}
                    className="flex items-center gap-4 p-4 cursor-pointer hover:bg-gray-700 transition-colors"
                  >
                    <img
                      src={album.thumbnail?.url || "/placeholder.jpg"}
                      alt={album.title}
                      className="w-16 h-16 object-cover rounded"
                    />
                    <div className="flex-1">
                      <h3 className="text-white font-semibold">{album.title}</h3>
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
                      <FaChevronUp className="text-gray-400" />
                    ) : (
                      <FaChevronDown className="text-gray-400" />
                    )}
                  </div>

                  {expandedAlbums[album.id] && album.songs && (
                    <div className="bg-gray-900 p-4">
                      <div className="space-y-2">
                        {album.songs.map((song, index) => {
                          const isSaved = playlistIds.includes(String(song.id));
                          return (
                            <div
                              key={song.id}
                              onClick={() => handleSongClick(song)}
                              className="flex items-center gap-3 p-3 hover:bg-gray-800 rounded cursor-pointer group transition-colors"
                            >
                              <span className="text-gray-400 text-sm w-6">{index + 1}</span>
                              <img
                                src={song.thumbnail?.url || album.thumbnail?.url || "/placeholder.jpg"}
                                alt={song.title}
                                className="w-10 h-10 object-cover rounded"
                              />
                              <div className="flex-1">
                                <h4 className="text-white text-sm group-hover:text-green-400 transition-colors">
                                  {song.title}
                                </h4>
                                <p className="text-gray-400 text-xs">{song.singer}</p>
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
              ))}
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default Years;
