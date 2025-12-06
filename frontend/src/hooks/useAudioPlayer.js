import { useState, useEffect, useRef } from "react";

/**
 * Hook to manage audio playback state and events
 */
const useAudioPlayer = (
    audioRef,
    song,
    isPlaying,
    setIsPlaying,
    selectedSong,
    callbacks = {}
) => {
    const { onThresholdReached, onEnded, onSessionEnd } = callbacks;

    const [progress, setProgress] = useState(0);
    const [duration, setDuration] = useState(0);
    const [volume, setVolume] = useState(1);
    const [playCountUpdated, setPlayCountUpdated] = useState(false);
    const [audioRetryCount, setAudioRetryCount] = useState(0);

    const maxRetries = 2;
    const playCountThreshold = 0.3; // 30% of song duration

    // Handle Play/Pause
    const togglePlayPause = () => {
        if (!audioRef.current) return;

        if (!song || !song.audio || !song.audio.url) {
            if (process.env.NODE_ENV === 'development') {
                console.warn("Cannot play song: no valid audio source", song);
            }
            return;
        }

        if (isPlaying) {
            audioRef.current.pause();
        } else {
            audioRef.current.play().catch(error => {
                if (process.env.NODE_ENV === 'development') {
                    console.error("Audio play failed:", error);
                }
                setIsPlaying(false);
            });
        }
        setIsPlaying(!isPlaying);
    };

    // Handle Volume
    const handleVolumeChange = (e) => {
        const newVolume = e.target.value;
        setVolume(newVolume);
        if (audioRef.current) {
            audioRef.current.volume = newVolume;
        }
    };

    // Handle Progress Seek
    const handleProgressChange = (e) => {
        if (!audioRef.current) return;
        const oldTime = audioRef.current.currentTime;
        const newTime = (e.target.value / 100) * duration;
        audioRef.current.currentTime = newTime;
        setProgress(newTime);

        // Track session if skipped after listening for a while
        if (selectedSong && oldTime > 30 && duration > 0 && onSessionEnd) {
            onSessionEnd(selectedSong, oldTime, duration);
        }
    };

    // Setup Audio Events
    useEffect(() => {
        const audio = audioRef.current;
        if (!audio) return;

        const handleLoadedMetaData = () => {
            const duration = audio.duration || 0;
            setDuration(duration);
            if (process.env.NODE_ENV === 'development') {
                console.log(`Audio loaded - Duration: ${duration}s`);
            }
        };

        const handleTimeUpdate = () => {
            const currentTime = audio.currentTime || 0;
            setProgress(currentTime);

            // Track play interaction when 30% of song is played
            if (!playCountUpdated && audio.duration > 0 && currentTime >= audio.duration * playCountThreshold) {
                setPlayCountUpdated(true);
                if (onThresholdReached) {
                    onThresholdReached(selectedSong, currentTime);
                }
            }
        };

        const handleAudioEnded = () => {
            // Only proceed if actually played
            if (!audio || audio.currentTime < 1) return;

            if (onEnded) {
                onEnded(selectedSong, audio.duration, audio.duration);
            }
        };

        audio.addEventListener("loadedmetadata", handleLoadedMetaData);
        audio.addEventListener("timeupdate", handleTimeUpdate);
        audio.addEventListener("ended", handleAudioEnded);

        return () => {
            audio.removeEventListener("loadedmetadata", handleLoadedMetaData);
            audio.removeEventListener("timeupdate", handleTimeUpdate);
            audio.removeEventListener("ended", handleAudioEnded);
        };
    }, [song, playCountUpdated, selectedSong, onThresholdReached, onEnded]); // Removed duration

    // Reset state when song changes
    useEffect(() => {
        setPlayCountUpdated(false);
        setAudioRetryCount(0);

        // Track previous song session
        const previousSongId = audioRef.current?.getAttribute('data-song-id');
        if (previousSongId && previousSongId !== selectedSong && audioRef.current && onSessionEnd) {
            const listenDuration = audioRef.current.currentTime || 0;
            const totalDuration = audioRef.current.duration || 0;
            if (listenDuration > 5 && totalDuration > 0) {
                onSessionEnd(previousSongId, listenDuration, totalDuration);
            }
        }

        if (audioRef.current && selectedSong) {
            audioRef.current.setAttribute('data-song-id', selectedSong);
        }
    }, [selectedSong]);

    return {
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
    };
};

export default useAudioPlayer;
