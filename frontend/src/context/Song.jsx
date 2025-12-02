import axios from "axios";
import { createContext, useContext, useEffect, useState } from "react";
import toast from "react-hot-toast";
import { UserData } from "./User";

const SongContext = createContext();

export const SongProvider = ({ children }) => {
  const [songs, setSongs] = useState([]);
  const [loading, setLoading] = useState(false);
  const [songLoading, setSongLoading] = useState(true);

  const [selectedSong, setSelectedSong] = useState(null);
  const [isPlaying, setIsPlaying] = useState(false);
  const [queue, setQueue] = useState([]);
  const [queueIndex, setQueueIndex] = useState(0);
  const [queueLabel, setQueueLabel] = useState("All Songs");
  const [onQueueEnd, setOnQueueEnd] = useState(null);

  // Year-based queue pagination state
  const [availableYears, setAvailableYears] = useState([]);
  const [loadedYears, setLoadedYears] = useState(new Set());
  const [isLoadingMore, setIsLoadingMore] = useState(false);
  const [currentYearIndex, setCurrentYearIndex] = useState(0);
  const [yearOffsets, setYearOffsets] = useState(new Map()); // Track offset for each year
  const [hasMoreInCurrentYear, setHasMoreInCurrentYear] = useState(true);

  const { user } = UserData();

  const normalizeSongId = (value) => {
    if (value === undefined || value === null) return null;
    return String(value);
  };

  const getSongId = (song) => {
    if (!song) return null;
    if (typeof song === "string" || typeof song === "number") {
      return normalizeSongId(song);
    }
    return normalizeSongId(
      song._id ?? song.id ?? song.songId ?? song.song_id
    );
  };

  // Function to save last played song
  const saveLastPlayedSong = async (songId) => {
    const normalizedId = normalizeSongId(songId);
    if (!normalizedId || !user?._id) return;

    try {
      await axios.post("/api/user/last-played", { songId: normalizedId });
    } catch (error) {
      console.error("Error saving last played song:", error);
    }
  };

  // Wrapper for setSelectedSong that also saves to backend
  const setSelectedSongAndSave = (songId) => {
    const normalizedId = normalizeSongId(songId);
    setSelectedSong(normalizedId);
    if (normalizedId) {
      saveLastPlayedSong(normalizedId);
    }
  };

  // Restore last played song on app load
  useEffect(() => {
    const lastPlayedId = normalizeSongId(user?.lastPlayedSongId);
    if (lastPlayedId && !selectedSong && !queue.length) {
      setSelectedSong(lastPlayedId);
      // Don't auto-play on restore, let user manually play
      // setIsPlaying(true);
    }
  }, [user?.lastPlayedSongId]);

  async function fetchSongs() {
    try {
      const { data } = await axios.get("/api/song/all");

      setSongs(data);
      if (!selectedSong && data.length) {
        const firstSongId = getSongId(data[0]);
        if (firstSongId) {
          setSelectedSong(firstSongId);
        }
      }
      if (!queue.length && data.length) {
        setQueue(data);
        setQueueIndex(0);
        setQueueLabel("All Songs");
      } else if (queueLabel === "All Songs" && data.length) {
        setQueue(data);
      }
    } catch (error) {
      console.log(error);
    }
  }

  // Optimized function for queue - fetches only essential data
  async function fetchQueueSongs() {
    try {
      const { data } = await axios.get("/api/song/queue");
      
      if (!selectedSong && data.length) {
        const firstSongId = getSongId(data[0]);
        if (firstSongId) {
          setSelectedSong(firstSongId);
        }
      }
      if (!queue.length && data.length) {
        setQueue(data);
        setQueueIndex(0);
        setQueueLabel("All Songs");
      } else if (queueLabel === "All Songs" && data.length) {
        setQueue(data);
      }
    } catch (error) {
      console.log(error);
      // Fallback to regular fetch if queue endpoint fails
      await fetchSongs();
    }
  }

  // Fetch available years for queue pagination
  async function fetchAvailableYears() {
    try {
      const { data } = await axios.get("/api/song/queue/years");
      setAvailableYears(data.years);
      return data.years;
    } catch (error) {
      console.log(error);
      return [];
    }
  }

  // Load songs for a specific year with offset support
  async function loadSongsByYear(year, limit = 50, offset = 0) {
    try {
      setIsLoadingMore(true);
      const { data } = await axios.get(`/api/song/queue/year/${year}?limit=${limit}&offset=${offset}`);
      
      if (data.songs.length > 0) {
        setQueue(prevQueue => [...prevQueue, ...data.songs]);
        setLoadedYears(prev => new Set([...prev, year]));
        
        // Update offset for this year
        setYearOffsets(prev => new Map([...prev, [year, data.nextOffset]]));
        
        // Check if this year has more songs
        if (!data.hasMore) {
          setHasMoreInCurrentYear(false);
        }
      }
      
      return {
        songsLoaded: data.songs.length,
        hasMore: data.hasMore,
        total: data.total
      };
    } catch (error) {
      console.log(error);
      return {
        songsLoaded: 0,
        hasMore: false,
        total: 0
      };
    } finally {
      setIsLoadingMore(false);
    }
  }

  // Initialize queue with year-based pagination
  async function initializeYearBasedQueue() {
    try {
      // Clear existing queue first
      setQueue([]);
      setLoadedYears(new Set());
      setYearOffsets(new Map());
      setCurrentYearIndex(0);
      setHasMoreInCurrentYear(true);
      
      const years = await fetchAvailableYears();
      if (years.length > 0) {
        // Load songs from the most recent year first
        const { data } = await axios.get(`/api/song/queue/year/${years[0]}?limit=50&offset=0`);
        
        if (data.songs.length > 0) {
          setQueue(data.songs);
          setLoadedYears(new Set([years[0]]));
          setYearOffsets(new Map([[years[0], data.nextOffset]]));
          setHasMoreInCurrentYear(data.hasMore);
          
          if (!selectedSong) {
            const firstSongId = getSongId(data.songs[0]);
            if (firstSongId) {
              setSelectedSong(firstSongId);
            }
          }
          
          setQueueIndex(0);
          setQueueLabel("All Songs");
        }
      }
    } catch (error) {
      console.log(error);
      // Fallback to old method
      await fetchQueueSongs();
    }
  }

  // Load next batch of songs (for Load More button)
  async function loadNextYearSongs() {
    if (isLoadingMore || availableYears.length === 0) {
      return false;
    }
    
    const currentYear = availableYears[currentYearIndex];
    
    // First, try to load more songs from the current year
    if (hasMoreInCurrentYear && currentYear) {
      const currentOffset = yearOffsets.get(currentYear) || 0;
      const result = await loadSongsByYear(currentYear, 50, currentOffset);
      
      if (result.songsLoaded > 0) {
        return true;
      } else {
        // No more songs in current year, try next year
        setHasMoreInCurrentYear(false);
      }
    }
    
    // Move to next year if current year is exhausted
    if (!hasMoreInCurrentYear && currentYearIndex + 1 < availableYears.length) {
      const nextYearIndex = currentYearIndex + 1;
      const nextYear = availableYears[nextYearIndex];
      
      setCurrentYearIndex(nextYearIndex);
      setHasMoreInCurrentYear(true);
      
      const result = await loadSongsByYear(nextYear, 50, 0);
      return result.songsLoaded > 0;
    }
    
    // No more years to load
    return false;
  }

  const [song, setSong] = useState([]);

  async function fetchSingleSong() {
    try {
      if (!selectedSong) return;
      const { data } = await axios.get("/api/song/single/" + selectedSong);

      setSong(data);
    } catch (error) {
      console.log(error);
    }
  }

  async function addAlbum(formData, setTitle, setDescription, setFile) {
    setLoading(true);
    try {
      const { data } = await axios.post("/api/song/album/new", formData);
      toast.success(data.message);
      setLoading(false);
      fetchAlbums();
      setTitle("");
      setDescription("");
      setFile(null);
    } catch (error) {
      toast.error(error.response.data.message);
      setLoading(false);
    }
  }

  async function addSong(
    formData,
    setTitle,
    setDescription,
    setFile,
    setSinger,
    setAlbum
  ) {
    setLoading(true);
    try {
      const { data } = await axios.post("/api/song/new", formData);
      toast.success(data.message);
      setLoading(false);
      fetchSongs();
      setTitle("");
      setDescription("");
      setFile(null);
      setSinger("");
      setAlbum("");
    } catch (error) {
      toast.error(error.response.data.message);
      setLoading(false);
    }
  }

  async function addThumbnail(id, formData, setFile) {
    setLoading(true);
    try {
      const { data } = await axios.post("/api/song/" + id, formData);
      toast.success(data.message);
      setLoading(false);
      fetchSongs();
      setFile(null);
    } catch (error) {
      toast.error(error.response.data.message);
      setLoading(false);
    }
  }

  const [albums, setAlbums] = useState([]);

  async function fetchAlbums() {
    try {
      const { data } = await axios.get("/api/song/album/all");

      setAlbums(data || []);
    } catch (error) {
      console.error("Error fetching albums:", error);
      setAlbums([]);
    }
  }

  async function deleteSong(id) {
    try {
      const { data } = await axios.delete("/api/song/" + id);

      toast.success(data.message);
      fetchSongs();
    } catch (error) {
      toast.error(error.response.data.message);
    }
  }

  useEffect(() => {
    // Don't auto-load queue on mount - let individual pages decide what to load
    // initializeYearBasedQueue(); 
    fetchAlbums();
  }, []);

  const playQueue = (collection = [], startSongId, label = "Queue") => {
    if (!collection.length) return;

    const normalizedQueue = collection
      .map((item) => {
        if (!item) return null;
        const normalizedId = getSongId(item);
        if (!normalizedId) return null;

        if (typeof item === "object") {
          return item._id === normalizedId ? { ...item } : { ...item, _id: normalizedId };
        }

        return { _id: normalizedId };
      })
      .filter(Boolean);

    if (!normalizedQueue.length) return;

    const targetId = startSongId ? normalizeSongId(startSongId) : null;
    const startIndex = targetId
      ? normalizedQueue.findIndex((item) => getSongId(item) === targetId)
      : 0;
    const safeIndex = startIndex === -1 ? 0 : startIndex;

    setQueue(normalizedQueue);
    setQueueLabel(label);
    setQueueIndex(safeIndex);

    const nextSongId = getSongId(normalizedQueue[safeIndex]);
    if (nextSongId) {
      setSelectedSongAndSave(nextSongId);
      setIsPlaying(true);
    }
  };

  const playFromSongs = (songId) => playQueue(songs, songId, "All Songs");

  const jumpToIndex = (index) => {
    if (!queue.length) return;
    if (index < 0 || index >= queue.length) return;

    const songId = getSongId(queue[index]);
    if (!songId) return;

    setQueueIndex(index);
    setSelectedSongAndSave(songId);
    setIsPlaying(true);
  };

  const loadDefaultQueue = async () => {
    try {
      const { data } = await axios.get("/api/song/top-played?limit=50&offset=0");
      if (data.songs && data.songs.length) {
        const firstSongId = getSongId(data.songs[0]);
        if (firstSongId) {
          playQueue(data.songs, firstSongId, "Top Played Songs");
          return true;
        }
      }
    } catch (error) {
      console.error("Failed to load default queue:", error);
    }
    return false;
  };

  const nextMusic = async (mode = "manual") => {
    if (!queue.length) {
      if (mode === "manual") {
        await loadDefaultQueue();
      }
      return;
    }

    const lastIndex = queue.length - 1;

    if (queueIndex >= lastIndex) {
      if (mode === "auto") {
        if (onQueueEnd) {
          const maybePromise = onQueueEnd();
          if (maybePromise && typeof maybePromise.then === "function") {
            maybePromise.catch((error) => console.error("Queue end handler failed", error));
          }
        } else {
          setIsPlaying(false);
        }
      } else {
        jumpToIndex(0);
      }
      return;
    }

    jumpToIndex(queueIndex + 1);
  };

  const prevMusic = () => {
    if (!queue.length) return;
    const nextIndex = queueIndex === 0 ? queue.length - 1 : queueIndex - 1;
    jumpToIndex(nextIndex);
  };

  const [albumSong, setAlbumSong] = useState([]);
  const [albumData, setAlbumData] = useState(null);

  async function fetchAlbumSong(id) {
    try {
      const { data } = await axios.get("/api/song/album/" + id);
      setAlbumSong(data.songs);
      setAlbumData(data.album);
    } catch (error) {
      console.log(error);
    }
  }
  return (
    <SongContext.Provider
      value={{
        songs,
        addAlbum,
        loading,
        songLoading,
        albums,
        addSong,
        addThumbnail,
        deleteSong,
        fetchSingleSong,
        song,
        setSelectedSong: setSelectedSongAndSave,
        isPlaying,
        setIsPlaying,
        selectedSong,
        nextMusic,
        prevMusic,
        queue,
        queueLabel,
        queueIndex,
        playQueue,
        playFromSongs,
        loadDefaultQueue,
        fetchAlbumSong,
        albumSong,
        albumData,
        fetchSongs,
        fetchAlbums,
        // Year-based queue pagination
        availableYears,
        loadedYears,
        isLoadingMore,
        loadNextYearSongs,
        hasMoreInCurrentYear,
        currentYearIndex,
        setOnQueueEnd,
      }}
    >
      {children}
    </SongContext.Provider>
  );
};

export const SongData = () => useContext(SongContext);
