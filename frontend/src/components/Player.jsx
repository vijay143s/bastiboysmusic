import React, { useMemo, useRef } from "react";
import { SongData } from "../context/Song";
import { UserData } from "../context/User";
import { GrChapterNext, GrChapterPrevious } from "react-icons/gr";
import { FaPause, FaPlay } from "react-icons/fa";
import { FaShuffle } from "react-icons/fa6";
import { AiFillHeart, AiOutlineHeart } from "react-icons/ai";
import useSongTracking from "../hooks/useSongTracking";
import useAudioPlayer from "../hooks/useAudioPlayer";

const Player = () => {
  const {
    song,
    fetchSingleSong,
    selectedSong,
    isPlaying,
    setIsPlaying,
    nextMusic,
    prevMusic,
    albums,
    queue,
    loadDefaultQueue,
  } = SongData();

  const { user, addToPlaylist } = UserData();

  const audioRef = useRef(null);
  const { trackPlay, trackCompletion, trackSession } = useSongTracking();

  // Callbacks for audio player events
  const onThresholdReached = (songId, duration) => {
    trackPlay(songId, duration);
  };

  const onEnded = (songId, duration, totalDuration) => {
    trackCompletion(songId, duration, totalDuration);
    nextMusic("auto");
  };

  const onSessionEnd = (songId, duration, totalDuration) => {
    trackSession(songId, duration, totalDuration);
  };

  const {
    progress,
    duration,
    volume,
    setVolume,
    togglePlayPause,
    handleVolumeChange,
    handleProgressChange,
    audioRetryCount,
    setAudioRetryCount,
    maxRetries
  } = useAudioPlayer(
    audioRef,
    song,
    isPlaying,
    setIsPlaying,
    selectedSong,
    { onThresholdReached, onEnded, onSessionEnd }
  );

  const albumTitle = useMemo(() => {
    if (!song) return "Single";
    if (song.albumName) return song.albumName;
    if (!song.album || !albums) return "Single";
    const album = albums.find((albumItem) => albumItem._id === song.album);
    return album ? album.title : "Single";
  }, [song, albums]);

  const albumThumbnail = useMemo(() => {
    if (!song) return null;
    if (song.albumThumbnail) return song.albumThumbnail;
    if (song.thumbnail) return song.thumbnail.url;
    return null;
  }, [song]);

  const isInPlaylist = useMemo(() => {
    if (!user || !user.playlist || !song || !song._id) return false;
    return user.playlist.includes(String(song._id));
  }, [user, song]);

  const handleAddToPlaylist = async (e) => {
    if (e) e.stopPropagation();
    if (!song || !song._id) return;
    if (!user || !user._id) return;
    try {
      await addToPlaylist(song._id, { silent: true });
    } catch (error) {
      if (process.env.NODE_ENV === 'development') {
        console.error("Error adding to playlist:", error);
      }
    }
  };

  const handleShuffle = async () => {
    if (queue.length === 0) {
      await loadDefaultQueue();
    } else if (queue.length > 0) {
      const randomIndex = Math.floor(Math.random() * queue.length);
      const randomSong = queue[randomIndex];
      const songId = randomSong._id || randomSong.id;
      if (songId) {
        setIsPlaying(false);
        setTimeout(() => {
          nextMusic("manual");
          if (audioRef.current) {
            audioRef.current.currentTime = 0;
          }
        }, 50);
      }
    }
  };

  const formatTime = (time) => {
    if (!time) return "0:00";
    const minutes = Math.floor(time / 60);
    const seconds = Math.floor(time % 60);
    return `${minutes}:${seconds < 10 ? "0" : ""}${seconds}`;
  };

  const progressPercent = duration ? (progress / duration) * 100 : 0;

  return (
    <div className="w-full">
      {song && (
        <div className="glass rounded-[2rem] p-3 shadow-2xl backdrop-blur-xl border border-white/10 relative overflow-hidden group">

          {/* Animated Background Glow */}
          <div className="absolute top-0 left-0 w-full h-full opacity-20 pointer-events-none bg-gradient-to-r from-transparent via-white/5 to-transparent -translate-x-full group-hover:animate-[shimmer_2s_infinite]"></div>

          <div className="flex flex-col md:flex-row items-center justify-between gap-3 md:gap-4 relative z-10 px-3 py-2 md:px-2 md:py-0">

            {/* Audio Element */}
            {song && song.audio && song.audio.url && (
              <audio
                ref={audioRef}
                src={song.audio.url}
                preload="metadata"
                autoPlay={isPlaying}
                onContextMenu={(e) => e.preventDefault()}
                onError={(e) => {
                  if (process.env.NODE_ENV === 'development') {
                    console.error("Audio playback error:", e);
                  }
                  setIsPlaying(false);
                  if (audioRetryCount < maxRetries) {
                    setTimeout(() => {
                      setAudioRetryCount(prev => prev + 1);
                      if (e.target) e.target.load();
                    }, 1000);
                  }
                }}
              />
            )}

            {/* Song Info (Desktop & Mobile) - Top Row on Mobile */}
            <div className="flex items-center gap-4 w-full md:w-1/3 min-w-0 justify-between md:justify-start">
              <div className="flex items-center gap-3 md:gap-4 min-w-0">
                <div className="relative group/cover flex-shrink-0">
                  <img
                    src={albumThumbnail || "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='50' height='50'%3E%3Crect width='50' height='50' fill='%23333'/%3E%3C/svg%3E"}
                    className="w-12 h-12 md:w-14 md:h-14 rounded-2xl object-cover shadow-lg group-hover/cover:scale-105 transition-transform duration-500"
                    alt="Album Art"
                  />
                  <div className="absolute inset-0 rounded-2xl ring-1 ring-inset ring-white/10"></div>
                </div>

                <div className="flex-1 min-w-0 flex flex-col justify-center">
                  <div className="flex items-center gap-2">
                    <p className="font-bold text-sm md:text-base truncate text-white drop-shadow-sm max-w-[150px] md:max-w-none">{song.title}</p>
                    {/* Mobile Heart (Inline with Title) */}
                    <button
                      className="block md:hidden transition-all active:scale-95 ml-1"
                      onClick={handleAddToPlaylist}
                      disabled={!user || !user._id}
                    >
                      {isInPlaylist ? (
                        <AiFillHeart className="text-green-400 drop-shadow-md" size={18} />
                      ) : (
                        <AiOutlineHeart className="text-slate-400 hover:text-white" size={18} />
                      )}
                    </button>
                  </div>
                  <p className="text-xs text-slate-400 truncate font-medium max-w-[180px] md:max-w-none">{song.singer || albumTitle}</p>
                </div>
              </div>

              {/* Desktop Heart (Separate) */}
              <button
                className="hidden md:block transition-all active:scale-95 ml-2"
                onClick={handleAddToPlaylist}
                disabled={!user || !user._id}
              >
                {isInPlaylist ? (
                  <AiFillHeart className="text-green-400 drop-shadow-md" size={18} />
                ) : (
                  <AiOutlineHeart className="text-slate-400 hover:text-white" size={18} />
                )}
              </button>
            </div>

            {/* Controls (Desktop) */}
            <div className="hidden md:flex flex-col items-center gap-1 flex-1 max-w-lg">
              <div className="flex items-center gap-6">
                <button
                  onClick={handleShuffle}
                  className="text-slate-400 hover:text-white transition-colors p-2 rounded-full hover:bg-white/5 active:scale-90"
                  title="Shuffle"
                >
                  <FaShuffle size={16} />
                </button>

                <button
                  onClick={prevMusic}
                  className="text-white hover:text-green-400 transition-colors p-2 active:scale-90"
                >
                  <GrChapterPrevious size={22} />
                </button>

                <button
                  className="bg-white text-black rounded-full p-3 hover:scale-105 transition active:scale-95 shadow-lg shadow-white/10"
                  onClick={togglePlayPause}
                >
                  {isPlaying ? <FaPause size={16} /> : <FaPlay size={16} className="ml-1" />}
                </button>

                <button
                  onClick={() => nextMusic("manual")}
                  className="text-white hover:text-green-400 transition-colors p-2 active:scale-90"
                >
                  <GrChapterNext size={22} />
                </button>

                {/* Spacer to balance shuffle button */}
                <div className="w-8"></div>
              </div>

              <div className="w-full flex items-center gap-3 text-[10px] font-medium text-slate-400">
                <span className="min-w-[30px] text-right">{formatTime(progress)}</span>
                <div
                  className="relative flex-1 h-1.5 bg-white/10 rounded-full cursor-pointer group/progress"
                  onClick={(e) => {
                    const rect = e.currentTarget.getBoundingClientRect();
                    const percent = ((e.clientX - rect.left) / rect.width) * 100;
                    handleProgressChange({ target: { value: percent } });
                  }}
                >
                  <div
                    className="absolute top-0 left-0 h-full bg-gradient-to-r from-green-400 to-emerald-500 rounded-full transition-all duration-100 group-hover/progress:from-green-300 group-hover/progress:to-emerald-400"
                    style={{ width: `${progressPercent}%` }}
                  >
                    <div className="absolute right-0 top-1/2 -translate-y-1/2 w-3 h-3 bg-white rounded-full shadow-md opacity-0 group-hover/progress:opacity-100 transition-opacity"></div>
                  </div>
                </div>
                <span className="min-w-[30px]">{formatTime(duration)}</span>
              </div>
            </div>

            {/* Volume (Desktop) */}
            <div className="hidden md:flex w-1/3 justify-end items-center gap-4 pr-4">
              {/* Use standard range input with custom CSS in index.css */}
              <input
                type="range"
                className="w-24 accent-green-500 bg-white/10 h-1.5 rounded-lg appearance-none cursor-pointer"
                min="0"
                max="1"
                step="0.01"
                value={volume}
                onChange={handleVolumeChange}
              />
            </div>

            {/* Mobile Controls (Bottom Row) */}
            <div className="flex md:hidden w-full items-center justify-between px-6 pt-1">
              <button
                onClick={handleShuffle}
                className="text-slate-400 hover:text-white transition-colors p-2 active:scale-90"
              >
                <FaShuffle size={18} />
              </button>

              <button
                onClick={prevMusic}
                className="text-white hover:text-green-400 transition-colors p-2 active:scale-90"
              >
                <GrChapterPrevious size={26} />
              </button>

              <button
                className="bg-white text-black rounded-full p-4 hover:scale-105 transition active:scale-95 shadow-md"
                onClick={togglePlayPause}
              >
                {isPlaying ? <FaPause size={18} /> : <FaPlay size={18} className="ml-1" />}
              </button>

              <button
                onClick={() => nextMusic("manual")}
                className="text-white hover:text-green-400 transition-colors p-2 active:scale-90"
              >
                <GrChapterNext size={26} />
              </button>
            </div>
          </div>

          {/* Mobile Progress Bar (Bottom Edge) */}
          <div className="md:hidden absolute bottom-0 left-0 w-full h-1 bg-white/10">
            <div
              className="h-full bg-green-500 transition-all duration-100"
              style={{ width: `${progressPercent}%` }}
            />
          </div>
        </div>
      )}
    </div>
  );
};

export default Player;
