import React, { createContext, useContext, useEffect, useState, useCallback, useRef } from 'react';
import Toast from 'react-native-toast-message';
import AsyncStorage from '@react-native-async-storage/async-storage';
import api from '../services/api';
import audioPlayer from '../services/audioPlayer';
import { UserData } from './User';
import { useLanguage } from './Language';

const SongContext = createContext();

export const SongProvider = ({ children }) => {
    const [songs, setSongs] = useState([]);
    const [loading, setLoading] = useState(false);
    const [selectedSong, setSelectedSong] = useState(null);
    const [song, setSong] = useState(null);
    const [isPlaying, setIsPlaying] = useState(false);
    const [queue, setQueue] = useState([]);
    const [queueIndex, setQueueIndex] = useState(0);
    const [queueLabel, setQueueLabel] = useState('All Songs');
    const [currentPosition, setCurrentPosition] = useState(0);
    const [duration, setDuration] = useState(0);

    const { user } = UserData();
    const { selectedLanguage } = useLanguage();

    // Initialize audio player
    useEffect(() => {
        audioPlayer.initialize();

        // Set up playback status callback
        audioPlayer.setOnPlaybackStatusUpdate((status) => {
            if (status.isLoaded) {
                setCurrentPosition(status.positionMillis);
                setDuration(status.durationMillis);
                setIsPlaying(status.isPlaying);
            }
        });

        // Set up track end callback
        audioPlayer.setOnTrackEnd(() => {
            nextMusic('auto');
        });

        // Cleanup on unmount
        return () => {
            audioPlayer.cleanup();
        };
    }, []);

    // Helper functions
    const normalizeSongId = (value) => {
        if (value === undefined || value === null) return null;
        return String(value);
    };

    const getSongId = (song) => {
        if (!song) return null;
        if (typeof song === 'string' || typeof song === 'number') {
            return normalizeSongId(song);
        }
        return normalizeSongId(song._id ?? song.id ?? song.songId ?? song.song_id);
    };

    // Save last played song
    const saveLastPlayedSong = async (songId) => {
        const normalizedId = normalizeSongId(songId);
        if (!normalizedId || !user?._id) return;

        try {
            await api.post('/api/user/last-played', { songId: normalizedId });
        } catch (error) {
            console.error('Error saving last played song:', error);
        }
    };

    // Fetch all songs
    const fetchSongs = async () => {
        try {
            const params = new URLSearchParams();
            if (selectedLanguage) {
                params.append('language', selectedLanguage);
            }

            const { data } = await api.get(`/api/song/all?${params}`);
            setSongs(data);

            if (!selectedSong && data.length) {
                const lastPlayedId = user?.lastPlayedSongId ? normalizeSongId(user.lastPlayedSongId) : null;
                const songIdToSet = lastPlayedId || getSongId(data[0]);
                if (songIdToSet) {
                    setSelectedSong(songIdToSet);
                }
            }

            if (!queue.length && data.length) {
                setQueue(data);
                setQueueIndex(0);
                setQueueLabel('All Songs');
            }
        } catch (error) {
            console.error('Error fetching songs:', error);
        }
    };

    // Fetch single song details
    const fetchSingleSong = async () => {
        if (!selectedSong) return;

        try {
            const { data } = await api.get('/api/song/single/' + selectedSong);
            setSong(data);

            // Load audio
            if (data?.audio?.url) {
                const result = await audioPlayer.loadAudio(data.audio.url, data);
                if (result.success) {
                    setDuration(result.duration);
                }
            }
        } catch (error) {
            console.error('Error fetching single song:', error);
        }
    };

    // Playback controls
    const play = async () => {
        const result = await audioPlayer.play();
        if (result.success) {
            setIsPlaying(true);
        }
    };

    const pause = async () => {
        const result = await audioPlayer.pause();
        if (result.success) {
            setIsPlaying(false);
        }
    };

    const togglePlayPause = async () => {
        if (isPlaying) {
            await pause();
        } else {
            await play();
        }
    };

    const seekTo = async (position) => {
        await audioPlayer.seekTo(position);
        setCurrentPosition(position);
    };

    // Queue management
    const playQueue = (collection = [], startSongId, label = 'Queue') => {
        if (!collection.length) return;

        const normalizedQueue = collection
            .map((item) => {
                if (!item) return null;
                const normalizedId = getSongId(item);
                if (!normalizedId) return null;

                if (typeof item === 'object') {
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
            setSelectedSong(nextSongId);
            saveLastPlayedSong(nextSongId);
            setIsPlaying(true);

            // Save queue to AsyncStorage
            AsyncStorage.setItem('lastQueue', JSON.stringify({
                queue: normalizedQueue,
                queueIndex: safeIndex,
                queueLabel: label,
                selectedSong: nextSongId,
            })).catch(console.error);
        }
    };

    const jumpToIndex = (index) => {
        if (!queue.length) return;
        if (index < 0 || index >= queue.length) return;

        const songId = getSongId(queue[index]);
        if (!songId) return;

        setQueueIndex(index);
        setSelectedSong(songId);
        saveLastPlayedSong(songId);
        setIsPlaying(true);

        // Save to AsyncStorage
        AsyncStorage.setItem('lastQueue', JSON.stringify({
            queue,
            queueIndex: index,
            queueLabel,
            selectedSong: songId,
        })).catch(console.error);
    };

    const nextMusic = async (mode = 'manual') => {
        if (!queue.length) return;

        const lastIndex = queue.length - 1;

        if (queueIndex >= lastIndex) {
            if (mode === 'auto') {
                setIsPlaying(false);
            } else {
                jumpToIndex(0);
            }
            return;
        }

        jumpToIndex(queueIndex + 1);
    };

    const previousMusic = () => {
        if (!queue.length) return;

        if (queueIndex <= 0) {
            jumpToIndex(queue.length - 1);
            return;
        }

        jumpToIndex(queueIndex - 1);
    };

    const addToQueue = (songToAdd) => {
        if (!songToAdd) return;
        const normalizedSong = getSongId(songToAdd)
            ? (songToAdd._id ? songToAdd : { ...songToAdd, _id: getSongId(songToAdd) })
            : null;
        if (!normalizedSong) return;

        setQueue((prev) => {
            const newQueue = [...prev, normalizedSong];
            AsyncStorage.setItem('lastQueue', JSON.stringify({
                queue: newQueue,
                queueIndex,
                queueLabel,
                selectedSong,
            })).catch(console.error);
            return newQueue;
        });

        Toast.show({
            type: 'success',
            text1: 'Added to queue',
        });
    };

    const removeFromQueue = (index) => {
        if (index < 0 || index >= queue.length) return;

        setQueue((prev) => {
            const newQueue = [...prev];
            newQueue.splice(index, 1);

            // Adjust queue index if needed
            if (index < queueIndex) {
                setQueueIndex(queueIndex - 1);
            } else if (index === queueIndex && newQueue.length > 0) {
                // If removing current song, play next one
                const newIndex = Math.min(queueIndex, newQueue.length - 1);
                setQueueIndex(newIndex);
                const nextSongId = getSongId(newQueue[newIndex]);
                if (nextSongId) {
                    setSelectedSong(nextSongId);
                }
            }

            AsyncStorage.setItem('lastQueue', JSON.stringify({
                queue: newQueue,
                queueIndex,
                queueLabel,
                selectedSong,
            })).catch(console.error);

            return newQueue;
        });
    };

    // Restore last queue on mount
    useEffect(() => {
        const restoreQueue = async () => {
            try {
                const saved = await AsyncStorage.getItem('lastQueue');
                if (saved && !queue.length) {
                    const parsed = JSON.parse(saved);
                    if (parsed.queue && Array.isArray(parsed.queue) && parsed.queue.length > 0) {
                        setQueue(parsed.queue);
                        setQueueIndex(parsed.queueIndex || 0);
                        setQueueLabel(parsed.queueLabel || 'Queue');
                        if (parsed.selectedSong) {
                            setSelectedSong(parsed.selectedSong);
                        }
                    }
                }
            } catch (error) {
                console.error('Error restoring queue:', error);
            }
        };

        restoreQueue();
        fetchSongs();
    }, []);

    // Fetch song details when selectedSong changes
    useEffect(() => {
        if (selectedSong) {
            fetchSingleSong();
        }
    }, [selectedSong]);

    // Refetch songs when language changes
    useEffect(() => {
        if (selectedLanguage) {
            fetchSongs();
        }
    }, [selectedLanguage]);

    return (
        <SongContext.Provider
            value={{
                songs,
                loading,
                selectedSong,
                song,
                isPlaying,
                queue,
                queueIndex,
                queueLabel,
                currentPosition,
                duration,
                fetchSongs,
                play,
                pause,
                togglePlayPause,
                seekTo,
                playQueue,
                jumpToIndex,
                nextMusic,
                previousMusic,
                addToQueue,
                removeFromQueue,
                setSelectedSong,
            }}
        >
            {children}
        </SongContext.Provider>
    );
};

export const SongData = () => useContext(SongContext);
