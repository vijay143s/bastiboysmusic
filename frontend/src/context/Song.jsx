import axios from "axios";
import { createContext, useContext, useEffect, useState } from "react";
import toast from "react-hot-toast";

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

  async function fetchSongs() {
    try {
      const { data } = await axios.get("/api/song/all");

      setSongs(data);
      if (!selectedSong && data.length) {
        setSelectedSong(data[0]._id);
      }
      if (!queue.length && data.length) {
        setQueue(data);
        setQueueIndex(0);
        setQueueLabel("All Songs");
      } else if (queueLabel === "All Songs" && data.length) {
        setQueue(data);
      }
      setIsPlaying(false);
    } catch (error) {
      console.log(error);
    }
  }

  const [song, setSong] = useState([]);

  async function fetchSingleSong() {
    try {
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

      setAlbums(data);
    } catch (error) {
      console.log(error);
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
    fetchSongs();
    fetchAlbums();
  }, []);

  const playQueue = (collection = [], startSongId, label = "Queue") => {
    if (!collection.length) return;

    const normalizedQueue = collection.filter(Boolean);
    const startIndex = startSongId
      ? normalizedQueue.findIndex((item) => item._id === startSongId)
      : 0;
    const safeIndex = startIndex === -1 ? 0 : startIndex;

    setQueue(normalizedQueue);
    setQueueLabel(label);
    setQueueIndex(safeIndex);
    setSelectedSong(normalizedQueue[safeIndex]._id);
    setIsPlaying(true);
  };

  const playFromSongs = (songId) => playQueue(songs, songId, "All Songs");

  const nextMusic = (mode = "manual") => {
    if (!queue.length) return;

    if (queueIndex === queue.length - 1) {
      if (mode === "auto") {
        setIsPlaying(false);
        return;
      }
      setQueueIndex(0);
      setSelectedSong(queue[0]._id);
      setIsPlaying(true);
      return;
    }

    const nextIndex = queueIndex + 1;
    setQueueIndex(nextIndex);
    setSelectedSong(queue[nextIndex]._id);
    setIsPlaying(true);
  };

  const prevMusic = () => {
    if (!queue.length) return;
    const nextIndex = queueIndex === 0 ? queue.length - 1 : queueIndex - 1;
    setQueueIndex(nextIndex);
    setSelectedSong(queue[nextIndex]._id);
    setIsPlaying(true);
  };

  const [albumSong, setAlbumSong] = useState([]);
  const [albumData, setAlbumData] = useState([]);

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
        setSelectedSong,
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
        fetchAlbumSong,
        albumSong,
        albumData,
        fetchSongs,
        fetchAlbums,
      }}
    >
      {children}
    </SongContext.Provider>
  );
};

export const SongData = () => useContext(SongContext);
