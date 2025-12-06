import React, { useMemo, useRef } from "react";
import { SongData } from "../context/Song";
import { UserData } from "../context/User";
import { GrChapterNext, GrChapterPrevious } from "react-icons/gr";
import { FaPause, FaPlay, FaSearch } from "react-icons/fa";
import { FaShuffle } from "react-icons/fa6";
import { AiFillHeart, AiOutlineHeart } from "react-icons/ai";
import useSongTracking from "../hooks/useSongTracking";
import useAudioPlayer from "../hooks/useAudioPlayer";

const Player = ({ onSearchClick }) => {
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
        <div className="bg-black/90 backdrop-blur-3xl rounded-none lg:rounded-[1.5rem] p-2 shadow-2xl border-t border-white/30 lg:border relative overflow-hidden group">

          {/* Mobile Progress Bar (Top Edge) */}
          <div
            className="md:hidden absolute top-0 left-0 w-full h-1 bg-white/10 cursor-pointer rounded-t-[1.5rem] overflow-hidden z-30"
            onClick={(e) => {
              const rect = e.currentTarget.getBoundingClientRect();
              const percent = ((e.clientX - rect.left) / rect.width) * 100;
              handleProgressChange({ target: { value: percent } });
            }}
          >
            <div
              className="h-full bg-green-500 transition-all duration-100 pointer-events-none"
              style={{ width: `${progressPercent}%` }}
            />
          </div>

          {/* Animated Background Glow */}
          <div className="absolute top-0 left-0 w-full h-full opacity-20 pointer-events-none bg-gradient-to-r from-transparent via-white/5 to-transparent -translate-x-full group-hover:animate-[shimmer_2s_infinite]"></div>

          <div className="flex flex-col md:flex-row items-center justify-between gap-2 md:gap-3 relative z-10 px-2 py-1 md:px-2 md:py-0">

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
            <div className="flex items-center gap-3 w-full md:w-1/3 min-w-0 justify-between md:justify-start">
              <div className="flex items-center gap-2 md:gap-3 min-w-0">
                <div className="relative group/cover flex-shrink-0">
                  <img
                    src={albumThumbnail || "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='50' height='50'%3E%3Crect width='50' height='50' fill='%23333'/%3E%3C/svg%3E"}
                    className="w-10 h-10 md:w-12 md:h-12 rounded-xl object-cover shadow-lg group-hover/cover:scale-105 transition-transform duration-500"
                    alt="Album Art"
                  />
                  <div className="absolute inset-0 rounded-xl ring-1 ring-inset ring-white/10"></div>
                </div>

                <div className="flex-1 min-w-0 flex flex-col justify-center">
                  <div className="flex items-center gap-1.5">
                    <p className="font-bold text-xs md:text-sm truncate text-white drop-shadow-sm max-w-[130px] md:max-w-none">{song.title}</p>
                    {/* Mobile Heart (Inline with Title) */}
                    <button
                      className="block md:hidden transition-all active:scale-95 ml-1"
                      onClick={handleAddToPlaylist}
                      disabled={!user || !user._id}
                    >
                      {isInPlaylist ? (
                        <AiFillHeart className="text-green-400 drop-shadow-md" size={16} />
                      ) : (
                        <AiOutlineHeart className="text-slate-400 hover:text-white" size={16} />
                      )}
                    </button>
                  </div>
                  <p className="text-[10px] md:text-xs text-slate-400 truncate font-medium max-w-[150px] md:max-w-none">{song.singer || albumTitle}</p>
                </div>
              </div>

              {/* Desktop Heart (Separate) */}
              <button
                className="hidden md:block transition-all active:scale-95 ml-1"
                onClick={handleAddToPlaylist}
                disabled={!user || !user._id}
              >
                {isInPlaylist ? (
                  <AiFillHeart className="text-green-400 drop-shadow-md" size={16} />
                ) : (
                  <AiOutlineHeart className="text-slate-400 hover:text-white" size={16} />
                )}
              </button>
            </div>

            {/* Controls (Desktop) */}
            <div className="hidden md:flex flex-col items-center gap-0.5 flex-1 max-w-lg">
              <div className="flex items-center gap-4">
                <button
                  onClick={handleShuffle}
                  className="text-slate-400 hover:text-white transition-colors p-1.5 rounded-full hover:bg-white/5 active:scale-90"
                  title="Shuffle"
                >
                  <FaShuffle size={14} />
                </button>

                <button
                  onClick={prevMusic}
                  className="text-white hover:text-green-400 transition-colors p-1.5 active:scale-90"
                >
                  <GrChapterPrevious size={18} />
                </button>

                <button
                  className="bg-white text-black rounded-full p-2.5 hover:scale-105 transition active:scale-95 shadow-lg shadow-white/10"
                  onClick={togglePlayPause}
                >
                  {isPlaying ? <FaPause size={14} /> : <FaPlay size={14} className="ml-0.5" />}
                </button>

                <button
                  onClick={() => nextMusic("manual")}
                  className="text-white hover:text-green-400 transition-colors p-1.5 active:scale-90"
                >
                  <GrChapterNext size={18} />
                </button>

                {/* Spacer to balance shuffle button */}
                <div className="w-8"></div>
              </div>

              <div className="w-full flex items-center gap-2 text-[9px] font-medium text-slate-400">
                <span className="min-w-[28px] text-right">{formatTime(progress)}</span>
                <div
                  className="relative flex-1 h-1 bg-white/10 rounded-full cursor-pointer group/progress"
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
                    <div className="absolute right-0 top-1/2 -translate-y-1/2 w-2.5 h-2.5 bg-white rounded-full shadow-md opacity-0 group-hover/progress:opacity-100 transition-opacity"></div>
                  </div>
                </div>
                <span className="min-w-[28px]">{formatTime(duration)}</span>
              </div>
            </div>

            {/* Volume (Desktop) */}
            <div className="hidden md:flex w-1/3 justify-end items-center gap-3 pr-3">
              {/* Use standard range input with custom CSS in index.css */}
              <input
                type="range"
                className="w-20 accent-green-500 bg-white/10 h-1 rounded-lg appearance-none cursor-pointer"
                min="0"
                max="1"
                step="0.01"
                value={volume}
                onChange={handleVolumeChange}
              />
            </div>

            {/* Mobile Controls (Bottom Row) */}
            <div className="flex md:hidden w-full items-center justify-between px-2 pt-0.5">
              <button
                onClick={handleShuffle}
                className="text-slate-400 hover:text-white transition-colors p-1.5 active:scale-90"
              >
                <FaShuffle size={16} />
              </button>

              <button
                onClick={prevMusic}
                className="text-white hover:text-green-400 transition-colors p-1.5 active:scale-90"
              >
                <GrChapterPrevious size={20} />
              </button>

              <button
                className="bg-white text-black rounded-full p-3 hover:scale-105 transition active:scale-95 shadow-md"
                onClick={togglePlayPause}
              >
                {isPlaying ? <FaPause size={16} /> : <FaPlay size={16} className="ml-0.5" />}
              </button>

              <button
                onClick={() => nextMusic("manual")}
                className="text-white hover:text-green-400 transition-colors p-1.5 active:scale-90"
              >
                <GrChapterNext size={20} />
              </button>

              {onSearchClick && (
                <button
                  onClick={onSearchClick}
                  className="text-green-400 hover:text-green-300 transition-colors p-1.5 active:scale-90"
                  aria-label="Search"
                >
                  <FaSearch size={18} />
                </button>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default Player;
