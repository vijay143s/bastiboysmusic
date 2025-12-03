import React, { useMemo, useEffect, useCallback, useState } from "react";
import { SongData } from "../context/Song";
import { UserData } from "../context/User";
import { RiPulseLine } from "react-icons/ri";
import { RiSearchLine, RiCloseLine } from "react-icons/ri";
import axios from "axios";

const Queue = () => {
  const isDev = process.env.NODE_ENV === 'development';
  const { 
    queue, 
    queueIndex, 
    queueLabel, 
    playQueue, 
    albums,
    fetchSongs,
    loadDefaultQueue,
  } = SongData();
  const { user, addToPlaylist } = UserData();
  
  // Search functionality state - must be declared before performSearch
  const [searchTerm, setSearchTerm] = useState("");
  const [isSearching, setIsSearching] = useState(false);
  const [searchResults, setSearchResults] = useState([]);
  const [searchLoading, setSearchLoading] = useState(false);
  const [searchTotal, setSearchTotal] = useState(0);
  const [isLoading, setIsLoading] = useState(true);
  
  // Context menu state
  const [contextMenu, setContextMenu] = useState(null);
  const [selectedSong, setSelectedSong] = useState(null);
  
  // Debounced search function - searches for songs only
  const performSearch = useCallback(async (query) => {
    if (!query.trim()) {
      setSearchResults([]);
      setSearchTotal(0);
      setSearchLoading(false);
      return;
    }
    
    setSearchLoading(true);
    try {
      const { data } = await axios.get(
        `/api/song/search?q=${encodeURIComponent(query)}&limit=100`
      );
      
      // Use only song results - albums are already included via song metadata
      const songs = data.songs || [];
      
      setSearchResults(songs);
      setSearchTotal(songs.length);
    } catch (error) {
      if (process.env.NODE_ENV === 'development') {
        console.error('Search error:', error);
      }
      setSearchResults([]);
      setSearchTotal(0);
    } finally {
      setSearchLoading(false);
    }
  }, []);
  
  // Debounce search input
  useEffect(() => {
    if (!searchTerm.trim()) {
      setSearchResults([]);
      setSearchTotal(0);
      return;
    }
    
    const timer = setTimeout(() => {
      performSearch(searchTerm);
    }, 300);
    
    return () => clearTimeout(timer);
  }, [searchTerm, performSearch]);

  // Load queue from user interactions and playlists on mount
  useEffect(() => {
    const initQueue = async () => {
      if (!queue || queue.length === 0) {
        try {
          // Load queue from user interactions and all user playlists
          const { data } = await axios.get('/api/interaction/queue?limit=50');
          if (data.success && data.songs && data.songs.length > 0) {
            playQueue(data.songs, data.songs[0]._id, 'Community Activity');
          } else {
            // Fallback to default queue if no interaction data
            await loadDefaultQueue();
          }
        } catch (error) {
          // Fallback to default queue on error
          await loadDefaultQueue();
        }
      }
      setIsLoading(false);
    };
    initQueue();
  }, []);

  const albumTitleMap = useMemo(() => {
    const map = new Map();
    if (albums && Array.isArray(albums)) {
      albums.forEach((album) => map.set(album._id, album.title));
    }
    return map;
  }, [albums]);

  const playlistSet = useMemo(() => {
    if (!user || !Array.isArray(user.playlist)) return new Set();
    return new Set(user.playlist);
  }, [user]);

  // Use queue from context with safe defaults
  const displayQueue = Array.isArray(queue) ? queue : [];
  const nowPlaying = displayQueue[queueIndex];
  const upcoming = displayQueue.slice(queueIndex + 1);
  const previouslyPlayed = displayQueue.slice(0, queueIndex).reverse();

  const handlePlayFromQueue = (songId) => {
    playQueue(displayQueue, songId, queueLabel || "Queue");
  };

  const handlePlayFromSearch = (songId) => {
    playQueue(searchResults, songId, "Search Results");
  };

  // Context menu handlers
  const handleContextMenu = (e, song) => {
    e.preventDefault();
    e.stopPropagation();
    setSelectedSong(song);
    setContextMenu({
      x: e.clientX,
      y: e.clientY,
      show: true
    });
  };

  const handlePlayNow = () => {
    if (selectedSong && searchResults.length > 0) {
      if (isDev) {
        console.log("🎵 Playing now:", selectedSong.title, "ID:", selectedSong._id);
        console.log("🎵 Search results:", searchResults.map(s => ({ id: s._id, title: s.title })));
      }
      // Ensure the selected song is in the search results
      const songExists = searchResults.find(s => s._id === selectedSong._id);
      if (songExists) {
        playQueue(searchResults, selectedSong._id, "Search Results");
        if (isDev) {
          console.log("✅ Song found and playing");
        }
      } else {
        if (isDev) {
          console.log("❌ Song not found in search results, playing anyway");
        }
        playQueue(searchResults, selectedSong._id, "Search Results");
      }
    } else {
      if (isDev) {
        console.log("❌ No selected song or empty search results");
      }
    }
    setContextMenu(null);
    setSelectedSong(null);
  };

  const handlePlayNext = () => {
    if (selectedSong && Array.isArray(queue)) {
      if (isDev) {
        console.log("🎵 Adding to play next:", selectedSong.title, "at position", queueIndex + 1);
      }
      // Add song to play next in the current queue
      const currentIndex = queueIndex;
      const newQueue = [...queue];
      newQueue.splice(currentIndex + 1, 0, selectedSong);
      // Update the queue but keep the current song playing
      playQueue(newQueue, queue[queueIndex]?._id, queueLabel || "Queue");
    }
    setContextMenu(null);
    setSelectedSong(null);
  };

  const handleAddToQueue = () => {
    if (selectedSong && Array.isArray(queue)) {
      if (isDev) {
        console.log("🎵 Adding to end of queue:", selectedSong.title, "queue length:", queue.length);
      }
      // Add song to end of current queue
      const newQueue = [...queue, selectedSong];
      // Update the queue but keep the current song playing
      playQueue(newQueue, queue[queueIndex]?._id, queueLabel || "Queue");
    }
    setContextMenu(null);
    setSelectedSong(null);
  };

  // Close context menu when clicking outside
  useEffect(() => {
    const handleClickOutside = () => {
      setContextMenu(null);
      setSelectedSong(null);
    };
    
    if (contextMenu) {
      document.addEventListener('click', handleClickOutside);
      return () => document.removeEventListener('click', handleClickOutside);
    }
  }, [contextMenu]);

  const renderSongRow = (song, indexDisplay, isActive = false, isFromSearch = false) => {
    const isSaved = playlistSet.has(song._id);
    return (
      <div
        key={song._id}
        className={`flex items-center justify-between px-2 md:px-4 py-2 md:py-3 rounded transition cursor-pointer active:scale-95 ${
          isActive ? "bg-[#1db9541a] border border-green-500" : "bg-[#1b1b1b] hover:bg-[#1f1f1f]"
        }`}
        onClick={(e) => {
          if (isFromSearch) {
            handleContextMenu(e, song);
          } else {
            handlePlayFromQueue(song._id);
          }
        }}
        onContextMenu={(e) => isFromSearch ? handleContextMenu(e, song) : null}
        style={{ cursor: 'pointer' }}
      >
        <div className="flex items-center gap-2 md:gap-4 flex-1 min-w-0">
          <div className="w-6 md:w-8 text-xs md:text-sm text-slate-400 text-center flex-shrink-0">{indexDisplay}</div>
          <img
            src={song.thumbnail?.url || song.thumbnail || "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='64' height='64'%3E%3Crect width='64' height='64' fill='%23333'/%3E%3C/svg%3E"}
            alt={song.title}
            className="w-10 h-10 md:w-12 md:h-12 rounded object-cover flex-shrink-0"
          />
          <div className="min-w-0 flex-1">
            <p className="font-semibold flex items-center gap-2 text-sm md:text-base truncate">
              {isActive && (
                <RiPulseLine
                  className={`text-green-400 text-lg md:text-xl flex-shrink-0 ${
                    isActive ? "animate-pulse" : "opacity-60"
                  }`}
                />
              )}
              <span className="truncate">{song.title}</span>
            </p>
            <p className="text-xs md:text-sm text-slate-400 truncate">
              {song.artist || song.singer || "Unknown artist"} • {song.albumName || albumTitleMap.get(song.album) || "Single"}
            </p>
          </div>
        </div>
        <div className="flex items-center gap-2 flex-shrink-0 ml-2">
          <button
            className={`p-2 rounded-full transition-all duration-200 ${
              isSaved ? "bg-green-500 shadow-lg" : ""
            }`}
            title={isSaved ? "Remove from playlist" : "Save to playlist"}
            onClick={async (event) => {
              event.stopPropagation();
              await addToPlaylist(song._id);
            }}
          >
            {isSaved ? (
              <span className="text-white text-lg">♥</span>
            ) : (
              <span className="text-white text-lg">♡</span>
            )}
        </button>
      </div>
    </div>
    );
  };

  return (
    <div className="py-4 md:py-8 space-y-6 md:space-y-8 px-2 md:px-0">
      {isLoading ? (
        <div className="flex flex-col items-center justify-center py-20">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-green-500 mb-4"></div>
          <p className="text-slate-400">Loading queue...</p>
        </div>
      ) : (
        <>
      <header className="space-y-2">
        <p className="uppercase text-xs tracking-[0.2em] text-slate-400">Current Queue</p>
        <h1 className="text-2xl md:text-3xl font-bold">{queueLabel || "Queue"}</h1>
        <p className="text-sm md:text-base text-slate-400">
          {searchTerm ? `${searchTotal} song${searchTotal === 1 ? '' : 's'} found` : `${queue?.length || 0} track${(queue?.length || 0) === 1 ? "" : "s"} queued`}
        </p>
      </header>

      {/* Search Input */}
      <div className="relative">
        <div className="relative">
          <RiSearchLine className="absolute left-3 top-1/2 transform -translate-y-1/2 text-slate-400 text-lg" />
          <input
            type="text"
            placeholder="Search by song, artist, album, or year..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-full bg-[#161616] text-white placeholder-slate-400 pl-10 pr-10 py-3 rounded-lg border border-slate-700 focus:border-blue-500 focus:outline-none transition-colors"
          />
          {searchTerm && (
            <button
              onClick={() => {
                setSearchTerm("");
                setSearchResults([]);
                setSearchTotal(0);
              }}
              className="absolute right-3 top-1/2 transform -translate-y-1/2 text-slate-400 hover:text-white transition-colors"
            >
              <RiCloseLine className="text-lg" />
            </button>
          )}
        </div>
        <p className="text-xs text-slate-500 mt-2">
          Search across all songs by title, artist name, album name, or year (e.g., "2024")
        </p>
      </div>

      {!queue || queue.length === 0 ? (
        <div className="bg-[#161616] border border-dashed border-slate-700 rounded-xl p-6 md:p-10 text-center">
          <p className="text-lg md:text-xl font-semibold mb-2">Your queue is empty</p>
          <p className="text-sm md:text-base text-slate-400">
            Start playing any song, album, or playlist and we will keep the music going for you.
          </p>
        </div>
      ) : (
        <div className="space-y-6 md:space-y-8">
          {searchTerm ? (
            /* Search Results */
            <section className="space-y-3 md:space-y-4">
              <h2 className="text-lg md:text-xl font-semibold">
                Search Results {searchLoading ? '(Searching...)' : `(${searchTotal})`}
              </h2>
              <div className="space-y-2 md:space-y-3">
                {searchLoading ? (
                  <div className="flex justify-center items-center py-8">
                    <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-500"></div>
                    <span className="ml-3 text-slate-400">Searching all songs...</span>
                  </div>
                ) : searchResults.length > 0 ? (
                  searchResults.map((song, index) => {
                    const originalQueueIndex = queue.findIndex(q => q._id === song._id);
                    const isCurrentlyPlaying = originalQueueIndex !== -1 && originalQueueIndex === queueIndex;
                    return renderSongRow(song, index + 1, isCurrentlyPlaying, true);
                  })
                ) : (
                  <div className="bg-[#161616] border border-dashed border-slate-700 rounded-xl p-6 md:p-10 text-center">
                    <RiSearchLine className="mx-auto text-4xl mb-3 text-slate-500" />
                    <p className="text-lg font-semibold mb-2">No songs found</p>
                    <p className="text-sm text-slate-400">No songs match "{searchTerm}"</p>
                  </div>
                )}
              </div>
            </section>
          ) : (
            /* Default Queue View */
            <>
              {nowPlaying && (
                <section className="space-y-3 md:space-y-4">
                  <h2 className="text-lg md:text-xl font-semibold">Now Playing</h2>
                  {renderSongRow(nowPlaying, queueIndex + 1, true)}
                </section>
              )}

              {upcoming.length > 0 && (
                <section className="space-y-3 md:space-y-4">
                  <h2 className="text-lg md:text-xl font-semibold">Up Next</h2>
                  <div className="space-y-2 md:space-y-3">
                    {upcoming.map((song, idx) => renderSongRow(song, queueIndex + idx + 2))}
                  </div>
                </section>
              )}

              {previouslyPlayed.length > 0 && (
                <section className="space-y-3 md:space-y-4">
                  <h2 className="text-lg md:text-xl font-semibold text-slate-300">Played Earlier</h2>
                  <div className="space-y-2 md:space-y-3">
                    {previouslyPlayed.map((song, idx) =>
                      renderSongRow(song, queueIndex - idx)
                    )}
                  </div>
                </section>
              )}
            </>
          )}

          {/* TODO: Reintroduce paginated queue controls if needed */}
        </div>
      )}
      
      {/* Context Menu */}
      {contextMenu && (
        <div
          className="fixed z-50 bg-[#282828] border border-slate-700 rounded-lg shadow-lg py-2 min-w-[160px]"
          style={{
            left: Math.min(contextMenu.x || 0, window.innerWidth - 180),
            top: Math.min(contextMenu.y || 0, window.innerHeight - 140),
            transform: 'translate(0, 10px)'
          }}
          onClick={(e) => e.stopPropagation()}
        >
          <button
            onClick={handlePlayNow}
            className="w-full px-4 py-2 text-left text-white hover:bg-[#3e3e3e] transition-colors flex items-center gap-3"
          >
            <RiPulseLine className="text-green-500" />
            Play Now
          </button>
          <button
            onClick={handlePlayNext}
            className="w-full px-4 py-2 text-left text-white hover:bg-[#3e3e3e] transition-colors flex items-center gap-3"
          >
            <RiPulseLine className="text-blue-500" />
            Play Next
          </button>
          <button
            onClick={handleAddToQueue}
            className="w-full px-4 py-2 text-left text-white hover:bg-[#3e3e3e] transition-colors flex items-center gap-3"
          >
            <RiPulseLine className="text-slate-400" />
            Add to Queue
          </button>
        </div>
      )}
      </>
      )}
    </div>
  );
};


export default Queue;
