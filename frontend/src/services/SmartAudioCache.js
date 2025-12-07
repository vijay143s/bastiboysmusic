/**
 * Smart Audio Cache Service
 * Hybrid approach: Automatic caching for streamed songs + explicit offline downloads
 * 
 * Layer 1: Service Worker Cache (automatic, temporary)
 * - Caches songs as they're played
 * - Browser manages storage automatically
 * - Fast repeat playback
 * 
 * Layer 2: Persistent Offline Storage (explicit, permanent)
 * - User clicks "Make Available Offline"
 * - Stored in app data directory
 * - Survives cache clearing
 */

import { Capacitor } from '@capacitor/core';
import OfflineStorage from './OfflineStorage.js';

class SmartAudioCache {
    constructor() {
        this.CACHE_NAME = 'bastiboys-audio-cache-v1';
        this.MAX_CACHE_SIZE_MB = 500; // 500MB for automatic cache
        this.isNative = Capacitor.isNativePlatform();
    }

    /**
     * Initialize smart caching
     */
    async init() {
        if ('serviceWorker' in navigator) {
            try {
                // Register service worker for automatic caching
                await this.registerServiceWorker();
                console.log('✅ Smart audio cache initialized');
            } catch (error) {
                console.warn('Service Worker not available:', error);
            }
        }

        // Initialize offline storage for explicit downloads
        await OfflineStorage.init();
    }

    /**
     * Register Service Worker for automatic caching
     */
    async registerServiceWorker() {
        if (!('serviceWorker' in navigator)) return;

        try {
            const registration = await navigator.serviceWorker.register('/service-worker.js');
            console.log('Service Worker registered:', registration);
        } catch (error) {
            console.error('Service Worker registration failed:', error);
        }
    }

    /**
     * Get audio URL with smart caching
     * Priority: Offline Storage > Service Worker Cache > Network
     * 
     * @param {Object} song - Song object
     * @returns {Promise<string>} - Audio URL to play
     */
    async getAudioUrl(song) {
        const songId = song._id || song.id;
        const originalUrl = song.audio?.url;

        if (!originalUrl) {
            throw new Error('No audio URL available');
        }

        // Priority 1: Check if explicitly downloaded (offline storage)
        const isOffline = await OfflineStorage.isSongDownloaded(songId);
        if (isOffline) {
            console.log('🎵 Playing from offline storage:', song.title);
            return await OfflineStorage.getSong(songId);
        }

        // Priority 2 & 3: Return network URL (Service Worker will cache automatically)
        console.log('🎵 Streaming with auto-cache:', song.title);
        return originalUrl;
    }

    /**
     * Check if song is cached (either layer)
     * @param {string} songId
     * @returns {Promise<Object>} - Cache status
     */
    async getCacheStatus(songId) {
        // Check offline storage (explicit download)
        const isOffline = await OfflineStorage.isSongDownloaded(songId);

        // Check service worker cache (automatic)
        let isAutoCached = false;
        if ('caches' in window) {
            try {
                const cache = await caches.open(this.CACHE_NAME);
                const keys = await cache.keys();
                isAutoCached = keys.some(req => req.url.includes(songId));
            } catch (error) {
                console.warn('Could not check cache:', error);
            }
        }

        return {
            isOffline,        // Explicitly downloaded
            isAutoCached,     // Automatically cached from playback
            isCached: isOffline || isAutoCached
        };
    }

    /**
     * Prefetch a song for faster playback (add to auto-cache)
     * @param {string} audioUrl
     */
    async prefetchSong(audioUrl) {
        if (!('caches' in window)) return;

        try {
            const cache = await caches.open(this.CACHE_NAME);
            await cache.add(audioUrl);
            console.log('✅ Song prefetched to cache');
        } catch (error) {
            console.warn('Prefetch failed:', error);
        }
    }

    /**
     * Clear automatic cache (keep offline downloads)
     */
    async clearAutoCache() {
        if (!('caches' in window)) return;

        try {
            await caches.delete(this.CACHE_NAME);
            console.log('✅ Auto-cache cleared');
        } catch (error) {
            console.error('Error clearing cache:', error);
        }
    }

    /**
     * Get cache statistics
     * @returns {Promise<Object>}
     */
    async getCacheStats() {
        const offlineStats = await OfflineStorage.getStorageStats();

        let autoCacheSize = 0;
        let autoCacheCount = 0;

        if ('caches' in window) {
            try {
                const cache = await caches.open(this.CACHE_NAME);
                const keys = await cache.keys();
                autoCacheCount = keys.length;

                // Estimate size (rough calculation)
                for (const request of keys) {
                    const response = await cache.match(request);
                    if (response) {
                        const blob = await response.blob();
                        autoCacheSize += blob.size;
                    }
                }
            } catch (error) {
                console.warn('Could not get cache stats:', error);
            }
        }

        return {
            offline: offlineStats,
            autoCache: {
                count: autoCacheCount,
                sizeMB: (autoCacheSize / (1024 * 1024)).toFixed(2)
            },
            total: {
                count: offlineStats.totalSongs + autoCacheCount,
                sizeMB: (parseFloat(offlineStats.totalSizeMB) + (autoCacheSize / (1024 * 1024))).toFixed(2)
            }
        };
    }

    /**
     * Request persistent storage (prevents auto-eviction)
     */
    async requestPersistentStorage() {
        if (!navigator.storage || !navigator.storage.persist) {
            console.warn('Persistent storage not supported');
            return false;
        }

        try {
            const isPersisted = await navigator.storage.persist();
            if (isPersisted) {
                console.log('✅ Persistent storage granted');
            } else {
                console.warn('⚠️ Persistent storage denied');
            }
            return isPersisted;
        } catch (error) {
            console.error('Error requesting persistent storage:', error);
            return false;
        }
    }

    /**
     * Check storage quota
     * @returns {Promise<Object>}
     */
    async checkStorageQuota() {
        if (!navigator.storage || !navigator.storage.estimate) {
            return { available: 'unknown', used: 'unknown' };
        }

        try {
            const estimate = await navigator.storage.estimate();
            return {
                used: (estimate.usage / (1024 * 1024)).toFixed(2) + ' MB',
                available: (estimate.quota / (1024 * 1024)).toFixed(2) + ' MB',
                percentUsed: ((estimate.usage / estimate.quota) * 100).toFixed(1) + '%'
            };
        } catch (error) {
            console.error('Error checking storage quota:', error);
            return { available: 'unknown', used: 'unknown' };
        }
    }
}

export default new SmartAudioCache();
