import { Audio } from 'expo-av';
import * as Notifications from 'expo-notifications';

class AudioPlayerService {
    constructor() {
        this.sound = null;
        this.isPlaying = false;
        this.currentPosition = 0;
        this.duration = 0;
        this.onPlaybackStatusUpdate = null;
        this.onTrackEnd = null;
        this.isInitialized = false;
    }

    async initialize() {
        if (this.isInitialized) return;

        try {
            // Configure audio mode for music playback
            await Audio.setAudioModeAsync({
                allowsRecordingIOS: false,
                staysActiveInBackground: true,
                playsInSilentModeIOS: true,
                shouldDuckAndroid: true,
                playThroughEarpieceAndroid: false,
            });

            // Configure notification handler
            Notifications.setNotificationHandler({
                handleNotification: async () => ({
                    shouldShowAlert: true,
                    shouldPlaySound: false,
                    shouldSetBadge: false,
                }),
            });

            this.isInitialized = true;
        } catch (error) {
            console.error('Error initializing audio:', error);
            throw error;
        }
    }

    async loadAudio(uri, songData = {}) {
        try {
            // Unload previous sound
            if (this.sound) {
                await this.sound.unloadAsync();
                this.sound = null;
            }

            // Create new sound
            const { sound, status } = await Audio.Sound.createAsync(
                { uri },
                { shouldPlay: false },
                this._onPlaybackStatusUpdate.bind(this)
            );

            this.sound = sound;
            this.duration = status.durationMillis || 0;

            // Update notification with song info
            await this._updateNotification(songData);

            return { success: true, duration: this.duration };
        } catch (error) {
            console.error('Error loading audio:', error);
            return { success: false, error: error.message };
        }
    }

    async play() {
        if (!this.sound) {
            console.warn('No sound loaded');
            return { success: false, error: 'No sound loaded' };
        }

        try {
            await this.sound.playAsync();
            this.isPlaying = true;
            return { success: true };
        } catch (error) {
            console.error('Error playing audio:', error);
            return { success: false, error: error.message };
        }
    }

    async pause() {
        if (!this.sound) {
            return { success: false, error: 'No sound loaded' };
        }

        try {
            await this.sound.pauseAsync();
            this.isPlaying = false;
            return { success: true };
        } catch (error) {
            console.error('Error pausing audio:', error);
            return { success: false, error: error.message };
        }
    }

    async stop() {
        if (!this.sound) {
            return { success: false, error: 'No sound loaded' };
        }

        try {
            await this.sound.stopAsync();
            this.isPlaying = false;
            this.currentPosition = 0;
            return { success: true };
        } catch (error) {
            console.error('Error stopping audio:', error);
            return { success: false, error: error.message };
        }
    }

    async seekTo(positionMillis) {
        if (!this.sound) {
            return { success: false, error: 'No sound loaded' };
        }

        try {
            await this.sound.setPositionAsync(positionMillis);
            this.currentPosition = positionMillis;
            return { success: true };
        } catch (error) {
            console.error('Error seeking audio:', error);
            return { success: false, error: error.message };
        }
    }

    async setVolume(volume) {
        if (!this.sound) {
            return { success: false, error: 'No sound loaded' };
        }

        try {
            await this.sound.setVolumeAsync(volume);
            return { success: true };
        } catch (error) {
            console.error('Error setting volume:', error);
            return { success: false, error: error.message };
        }
    }

    async getStatus() {
        if (!this.sound) {
            return null;
        }

        try {
            const status = await this.sound.getStatusAsync();
            return status;
        } catch (error) {
            console.error('Error getting status:', error);
            return null;
        }
    }

    setOnPlaybackStatusUpdate(callback) {
        this.onPlaybackStatusUpdate = callback;
    }

    setOnTrackEnd(callback) {
        this.onTrackEnd = callback;
    }

    _onPlaybackStatusUpdate(status) {
        if (status.isLoaded) {
            this.currentPosition = status.positionMillis;
            this.duration = status.durationMillis;
            this.isPlaying = status.isPlaying;

            // Call external callback if set
            if (this.onPlaybackStatusUpdate) {
                this.onPlaybackStatusUpdate(status);
            }

            // Check if track ended
            if (status.didJustFinish && !status.isLooping) {
                if (this.onTrackEnd) {
                    this.onTrackEnd();
                }
            }
        } else if (status.error) {
            console.error('Playback error:', status.error);
        }
    }

    async _updateNotification(songData) {
        try {
            await Notifications.scheduleNotificationAsync({
                content: {
                    title: songData.title || 'Now Playing',
                    body: songData.singer || 'BastiBoys Music',
                    data: { songId: songData._id },
                },
                trigger: null, // Show immediately
            });
        } catch (error) {
            console.error('Error updating notification:', error);
        }
    }

    async cleanup() {
        try {
            if (this.sound) {
                await this.sound.unloadAsync();
                this.sound = null;
            }
            this.isPlaying = false;
            this.currentPosition = 0;
            this.duration = 0;
        } catch (error) {
            console.error('Error cleaning up audio:', error);
        }
    }
}

// Export singleton instance
export default new AudioPlayerService();
