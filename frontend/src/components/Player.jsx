import React, { useEffect, useMemo, useRef, useState } from "react";
import { SongData } from "../context/Song";
import { UserData } from "../context/User";
import { GrChapterNext, GrChapterPrevious } from "react-icons/gr";
import { FaPause, FaPlay } from "react-icons/fa";
import { FaShuffle } from "react-icons/fa6";
import { AiFillHeart, AiOutlineHeart } from "react-icons/ai";
import axios from "axios";

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
  
  const albumTitle = useMemo(() => {
    if (!song) return "Single";
    // Use albumName from song data if available
    if (song.albumName) return song.albumName;
    if (!song.album || !albums) return "Single";
    const album = albums.find((albumItem) => albumItem._id === song.album);
    return album ? album.title : "Single";
  }, [song, albums]);
  
  const albumThumbnail = useMemo(() => {
    if (!song) return null;
    // Use albumThumbnail from song data if available
    if (song.albumThumbnail) return song.albumThumbnail;
    // Fallback to song thumbnail
    if (song.thumbnail) return song.thumbnail.url;
    return null;
  }, [song]);

  const [playCountUpdated, setPlayCountUpdated] = useState(false);
  const [audioRetryCount, setAudioRetryCount] = useState(0);
  const maxRetries = 2;
  const playCountThreshold = 0.3; // 30% of song duration
  
  const isInPlaylist = useMemo(() => {
    if (!user || !user.playlist || !song || !song._id) return false;
    return user.playlist.includes(String(song._id));
  }, [user, song]);

  const handleAddToPlaylist = async (e) => {
    if (e) e.stopPropagation();
    if (!song || !song._id) {
      if (process.env.NODE_ENV === 'development') {
        console.error("No song selected");
      }
      return;
    }
    if (!user || !user._id) {
      if (process.env.NODE_ENV === 'development') {
        console.error("User not authenticated");
      }
      return;
    }
    try {
      await addToPlaylist(song._id, { silent: true });
    } catch (error) {
      if (process.env.NODE_ENV === 'development') {
        console.error("Error adding to playlist:", error);
      }
    }
  };

  useEffect(() => {
    // Track listening session for previous song before changing
    const previousSong = audioRef.current?.getAttribute('data-song-id');
    if (previousSong && previousSong !== selectedSong && audioRef.current) {
      const listenDuration = audioRef.current.currentTime || 0;
      const totalDuration = audioRef.current.duration || 0;
      
      if (listenDuration > 5 && totalDuration > 0) { // Only track if listened for more than 5 seconds
        axios.post(`/api/interaction/track/completion/${previousSong}`, {
          listenDuration,
          totalDuration,
          source: 'player'
        }).catch(err => {
          if (process.env.NODE_ENV === 'development') {
            console.error("Error tracking listening session on song change:", err);
          }
        });
      }
    }
    
    // Fetch song (will use cache if available for instant playback, or API as fallback)
    fetchSingleSong();
    setPlayCountUpdated(false); // Reset when song changes
    setAudioRetryCount(0); // Reset retry counter when song changes
    
    // Store current song ID for tracking
    if (audioRef.current && selectedSong) {
      audioRef.current.setAttribute('data-song-id', selectedSong);
    }
  }, [selectedSong]);

  const audioRef = useRef(null);

  const handlePlayPause = () => {
    if (!audioRef.current) return;
    
    // Check if song has valid audio source
    if (!song || !song.audio || !song.audio.url) {
      if (process.env.NODE_ENV === 'development') {
        console.warn("Cannot play song: no valid audio source", song);
      }
      return; // Don't auto-skip, just return
    }
    
    if (isPlaying) {
      audioRef.current.pause();
    } else {
      audioRef.current.play().catch(error => {
        if (process.env.NODE_ENV === 'development') {
          console.error("Audio play failed:", error);
        }
        setIsPlaying(false);
        // Don't auto-skip on play failure - let user manually skip
      });
    }
    setIsPlaying(!isPlaying);
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
          // Force navigation to random index
          const audio = audioRef.current;
          if (audio) {
            audio.currentTime = 0;
          }
        }, 50);
      }
    }
  };

  const [volume, setVolume] = useState(1);

  const handleVolumeChange = (e) => {
    const newVolume = e.target.value;
    setVolume(newVolume);
    if (audioRef.current) {
      audioRef.current.volume = newVolume;
    }
  };
  const [progress, setProgress] = useState(0);
  const [duration, setDuration] = useState(0);

  useEffect(() => {
    const audio = audioRef.current;

    if (!audio) return;

    const handleLoadedMetaData = () => {
      const duration = audio.duration || 0;
      setDuration(duration);
      if (process.env.NODE_ENV === 'development') {
        console.log(`Audio loaded - Duration: ${duration}s, Song:`, selectedSong);
      }
    };

    const handleTimeUpdate = () => {
      const currentTime = audio.currentTime || 0;
      setProgress(currentTime);

      // Track play interaction when 30% of song is played
      if (!playCountUpdated && audio.duration > 0 && currentTime >= audio.duration * playCountThreshold) {
        setPlayCountUpdated(true);
        axios.post(`/api/interaction/track/play/${selectedSong}`, {
          source: 'player',
          listenDuration: currentTime
        }).catch(err => {
          if (process.env.NODE_ENV === 'development') {
            console.error("Error tracking play interaction:", err);
          }
        });
      }
    };

    const handleEnded = () => {
      // Only proceed if audio has actually played (not just ended immediately on load)
      if (!audio || audio.currentTime < 1) {
        if (process.env.NODE_ENV === 'development') {
          console.warn("Song ended immediately, might be invalid audio source");
        }
        return; // Don't auto-advance if song didn't actually play
      }
      
      // Track completion
      if (selectedSong && audio && audio.duration) {
        axios.post(`/api/interaction/track/completion/${selectedSong}`, {
          listenDuration: audio.duration,
          totalDuration: audio.duration,
          source: 'player'
        }).catch(err => {
          if (process.env.NODE_ENV === 'development') {
            console.error("Error tracking completion:", err);
          }
        });
      }
      nextMusic("auto");
    };

    audio.addEventListener("loadedmetadata", handleLoadedMetaData);
    audio.addEventListener("timeupdate", handleTimeUpdate);
    audio.addEventListener("ended", handleEnded);

    return () => {
      audio.removeEventListener("loadedmetadata", handleLoadedMetaData);
      audio.removeEventListener("timeupdate", handleTimeUpdate);
      audio.removeEventListener("ended", handleEnded);
    };
  }, [song, nextMusic, playCountUpdated, selectedSong]); // Removed duration from dependencies

  const handleProgressChange = (e) => {
    if (!audioRef.current) return;
    const oldTime = audioRef.current.currentTime;
    const newTime = (e.target.value / 100) * duration;
    audioRef.current.currentTime = newTime;
    setProgress(newTime);
    
    // Track listening session if significant time has passed
    if (selectedSong && oldTime > 30 && duration > 0) {
      const completionPercentage = (oldTime / duration) * 100;
      axios.post(`/api/interaction/track/completion/${selectedSong}`, {
        listenDuration: oldTime,
        totalDuration: duration,
        source: 'player'
      }).catch(err => {
        if (process.env.NODE_ENV === 'development') {
          console.error("Error tracking listening session:", err);
        }
      });
    }
  };
  const progressPercent = duration ? (progress / duration) * 100 : 0;
  
  const formatTime = (time) => {
    if (!time) return "0:00";
    const minutes = Math.floor(time / 60);
    const seconds = Math.floor(time % 60);
    return `${minutes}:${seconds < 10 ? "0" : ""}${seconds}`;
  };

  return (
    <div>
      {song && (
        <div className="bg-black border-t border-white/10 text-white px-3 md:px-4 py-2 md:py-3 lg:pb-4 z-20 relative">
          {/* Audio Element */}
          {song && song.audio && song.audio.url && (
            <>
              {isPlaying ? (
                <audio 
                  ref={audioRef} 
                  src={song.audio.url} 
                  preload="metadata"
                  autoPlay
                  onError={(e) => {
                    if (process.env.NODE_ENV === 'development') {
                      console.error("Audio playback error:", e);
                      console.error("Song data:", song);
                      console.error("Audio URL:", song.audio?.url);
                      const error = e.target.error;
                      if (error) {
                        console.error("Error code:", error.code);
                        console.error("Error message:", error.message);
                        switch(error.code) {
                          case 1: console.error("MEDIA_ERR_ABORTED: Audio load was aborted"); break;
                          case 2: console.error("MEDIA_ERR_NETWORK: Network error"); break;
                          case 3: console.error("MEDIA_ERR_DECODE: Audio decode error"); break;
                          case 4: console.error("MEDIA_ERR_SRC_NOT_SUPPORTED: Audio format not supported"); break;
                        }
                      }
                    }
                    setIsPlaying(false);
                    
                    // Try to reload audio if we haven't exceeded max retries
                    if (audioRetryCount < maxRetries) {
                      setTimeout(() => {
                        if (process.env.NODE_ENV === 'development') {
                          console.log(`Retrying audio load (attempt ${audioRetryCount + 1}/${maxRetries})`);
                        }
                        setAudioRetryCount(prev => prev + 1);
                        e.target.load(); // Reload the audio
                      }, 1000);
                    } else {
                      if (process.env.NODE_ENV === 'development') {
                        console.error('Max audio retry attempts reached');
                      }
                    }
                  }}
                />
              ) : (
                <audio 
                  ref={audioRef} 
                  src={song.audio.url}
                  preload="metadata"
                  onError={(e) => {
                    if (process.env.NODE_ENV === 'development') {
                      console.error("Audio load error:", e);
                      console.error("Song data:", song);
                      console.error("Audio URL:", song.audio?.url);
                      const error = e.target.error;
                      if (error) {
                        console.error("Error code:", error.code);
                        console.error("Error message:", error.message);
                        switch(error.code) {
                          case 1: console.error("MEDIA_ERR_ABORTED: Audio load was aborted"); break;
                          case 2: console.error("MEDIA_ERR_NETWORK: Network error"); break;
                          case 3: console.error("MEDIA_ERR_DECODE: Audio decode error"); break;
                          case 4: console.error("MEDIA_ERR_SRC_NOT_SUPPORTED: Audio format not supported"); break;
                        }
                      }
                    }
                  }}
                />
              )}
            </>
          )}
          
          {/* Show message if no valid audio source */}
          {song && (!song.audio || !song.audio.url) && (
            <div className="text-center text-red-400 text-sm p-2">
              No audio source available for this song
            </div>
          )}

          {/* Mobile Player (Compact) */}
          <div className="lg:hidden">
            <div className="flex items-center gap-2 mb-2">
              <img
                src={
                  albumThumbnail || "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='40' height='40'%3E%3Crect width='40' height='40' fill='%23333'/%3E%3C/svg%3E"
                }
                className="w-10 h-10 rounded"
                alt={`${song.title} album cover`}
              />
              <div className="flex-1 min-w-0">
                <p className="text-xs font-semibold text-white truncate">{song.title}</p>
                <p className="text-xs text-gray-400 truncate">{song.singer || albumTitle}</p>
              </div>
            </div>

            {/* Progress Bar */}
            <div className="flex items-center gap-1 mb-2">
              <span className="text-xs text-gray-400">{formatTime(progress)}</span>
              <input
                type="range"
                min="0"
                max="100"
                className="progress-bar flex-1"
                value={progressPercent}
                onChange={handleProgressChange}
              />
              <span className="text-xs text-gray-400">{formatTime(duration)}</span>
            </div>

            {/* Mobile Controls */}
            <div className="flex justify-center items-center gap-6">
              <span
                className="cursor-pointer text-lg hover:text-green-400 transition"
                onClick={prevMusic}
              >
                <GrChapterPrevious />
              </span>
              <button
                className="bg-green-500 text-black rounded-full p-3 hover:bg-green-400 transition active:scale-95"
                onClick={handlePlayPause}
              >
                {isPlaying ? <FaPause size={18} /> : <FaPlay size={18} />}
              </button>
              <span
                className="cursor-pointer text-lg hover:text-green-400 transition"
                onClick={() => nextMusic("manual")}
              >
                <GrChapterNext />
              </span>
              <span
                className="cursor-pointer text-lg hover:text-green-400 transition"
                onClick={handleShuffle}
                title="Shuffle"
              >
                <FaShuffle />
              </span>
              <button
                className="cursor-pointer text-lg hover:scale-110 transition active:scale-95"
                onClick={handleAddToPlaylist}
                title={isInPlaylist ? "In Playlist" : "Add to Playlist"}
                disabled={!user || !user._id}
              >
                {isInPlaylist ? (
                  <AiFillHeart className="text-red-500" size={22} />
                ) : (
                  <AiOutlineHeart className="text-white hover:text-red-500" size={22} />
                )}
              </button>
            </div>
          </div>

          {/* Desktop Player (Full) */}
          <div className="hidden lg:flex items-center justify-between gap-4">
            <div className="flex items-center gap-4 w-1/4">
              <img
                src={
                  albumThumbnail || "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='50' height='50'%3E%3Crect width='50' height='50' fill='%23333'/%3E%3C/svg%3E"
                }
                className="w-12 h-12 rounded"
                alt={`${song.title} album cover`}
              />
              <div className="flex-1 min-w-0">
                <p className="font-semibold text-sm truncate">{song.title}</p>
                <p className="text-xs text-gray-400 truncate">{song.singer || albumTitle}</p>
              </div>
              <button
                className="cursor-pointer hover:scale-110 transition active:scale-95"
                onClick={handleAddToPlaylist}
                title={isInPlaylist ? "In Playlist" : "Add to Playlist"}
                disabled={!user || !user._id}
              >
                {isInPlaylist ? (
                  <AiFillHeart className="text-red-500" size={24} />
                ) : (
                  <AiOutlineHeart className="text-white hover:text-red-500" size={24} />
                )}
              </button>
            </div>

            <div className="flex flex-col items-center gap-2 flex-1">
              <div className="w-full flex items-center justify-center gap-4">
                <span
                  className="cursor-pointer hover:text-green-400 transition"
                  onClick={prevMusic}
                >
                  <GrChapterPrevious size={20} />
                </span>
                <button
                  className="bg-white text-black rounded-full p-2 hover:scale-105 transition active:scale-95"
                  onClick={handlePlayPause}
                >
                  {isPlaying ? <FaPause /> : <FaPlay />}
                </button>
                <span
                  className="cursor-pointer hover:text-green-400 transition"
                  onClick={() => nextMusic("manual")}
                >
                  <GrChapterNext size={20} />
                </span>
                <span
                  className="cursor-pointer hover:text-green-400 transition"
                  onClick={handleShuffle}
                  title="Shuffle"
                >
                  <FaShuffle size={20} />
                </span>
              </div>

              <div className="w-full flex items-center gap-2 text-xs text-gray-400">
                <span>{formatTime(progress)}</span>
                <input
                  type="range"
                  min="0"
                  max="100"
                  className="progress-bar flex-1"
                  value={progressPercent}
                  onChange={handleProgressChange}
                />
                <span>{formatTime(duration)}</span>
              </div>
            </div>

            <div className="w-1/4 flex justify-end items-center">
              <input
                type="range"
                className="w-24"
                min="0"
                max="1"
                step="0.01"
                value={volume}
                onChange={handleVolumeChange}
              />
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default Player;
