/**
 * Service Worker for Smart Audio Caching
 * Automatically caches audio files as they're streamed
 */

const CACHE_NAME = 'bastiboys-audio-cache-v1';
const CACHE_URLS = [
    '/',
    '/index.html',
    '/manifest.json'
];

// Install event - cache essential files
self.addEventListener('install', (event) => {
    event.waitUntil(
        caches.open(CACHE_NAME).then((cache) => {
            console.log('Service Worker: Caching essential files');
            return cache.addAll(CACHE_URLS);
        })
    );
    self.skipWaiting();
});

// Activate event - clean up old caches
self.addEventListener('activate', (event) => {
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cacheName) => {
                    if (cacheName !== CACHE_NAME) {
                        console.log('Service Worker: Clearing old cache');
                        return caches.delete(cacheName);
                    }
                })
            );
        })
    );
    self.clients.claim();
});

// Fetch event - smart caching strategy
self.addEventListener('fetch', (event) => {
    const { request } = event;
    const url = new URL(request.url);

    // Only cache audio files (mp3, m4a, etc.)
    const isAudioFile = /\.(mp3|m4a|aac|ogg|wav|flac)$/i.test(url.pathname) ||
        request.headers.get('accept')?.includes('audio');

    if (isAudioFile) {
        // Cache-first strategy for audio files
        event.respondWith(
            caches.match(request).then((cachedResponse) => {
                if (cachedResponse) {
                    console.log('Service Worker: Serving from cache:', url.pathname);
                    return cachedResponse;
                }

                // Not in cache, fetch from network and cache it
                return fetch(request).then((response) => {
                    // Only cache successful responses
                    if (!response || response.status !== 200 || response.type === 'error') {
                        return response;
                    }

                    // Clone the response
                    const responseToCache = response.clone();

                    caches.open(CACHE_NAME).then((cache) => {
                        console.log('Service Worker: Caching new audio:', url.pathname);
                        cache.put(request, responseToCache);
                    });

                    return response;
                }).catch((error) => {
                    console.error('Service Worker: Fetch failed:', error);
                    throw error;
                });
            })
        );
    } else {
        // Network-first strategy for other resources
        event.respondWith(
            fetch(request).catch(() => {
                return caches.match(request);
            })
        );
    }
});

// Message event - handle cache management commands
self.addEventListener('message', (event) => {
    if (event.data && event.data.type === 'CLEAR_CACHE') {
        event.waitUntil(
            caches.delete(CACHE_NAME).then(() => {
                console.log('Service Worker: Cache cleared');
                event.ports[0].postMessage({ success: true });
            })
        );
    }

    if (event.data && event.data.type === 'PREFETCH_AUDIO') {
        const { url } = event.data;
        event.waitUntil(
            caches.open(CACHE_NAME).then((cache) => {
                return cache.add(url).then(() => {
                    console.log('Service Worker: Prefetched audio:', url);
                    event.ports[0].postMessage({ success: true });
                });
            })
        );
    }
});
