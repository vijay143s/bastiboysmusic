/**
 * Cache Manager for Songs and Albums
 * Implements in-memory caching with TTL (Time To Live)
 * Uses LRU (Least Recently Used) eviction policy
 */

class CacheManager {
  constructor(options = {}) {
    this.cache = new Map();
    this.ttl = options.ttl || 60 * 60 * 1000; // Default 1 hour
    this.maxSize = options.maxSize || 1000; // Max 1000 items
    this.stats = {
      hits: 0,
      misses: 0,
      sets: 0,
      deletes: 0,
    };
  }

  /**
   * Generate cache key from params
   * @param {string} prefix - Cache key prefix
   * @param {object} params - Parameters to include in key
   * @returns {string} - Cache key
   */
  generateKey(prefix, params = {}) {
    const sortedParams = Object.keys(params)
      .sort()
      .map(key => `${key}=${params[key]}`)
      .join('&');
    return sortedParams ? `${prefix}:${sortedParams}` : prefix;
  }

  /**
   * Get value from cache
   * @param {string} key - Cache key
   * @returns {any} - Cached value or null
   */
  get(key) {
    const item = this.cache.get(key);
    
    if (!item) {
      this.stats.misses++;
      return null;
    }

    // Check if expired
    if (item.expiredAt && Date.now() > item.expiredAt) {
      this.cache.delete(key);
      this.stats.misses++;
      return null;
    }

    // Update access time for LRU
    item.lastAccessed = Date.now();
    this.stats.hits++;
    return item.value;
  }

  /**
   * Set value in cache
   * @param {string} key - Cache key
   * @param {any} value - Value to cache
   * @param {number} ttl - Time to live in ms (optional, uses default if not provided)
   */
  set(key, value, ttl = this.ttl) {
    // Evict if cache is full
    if (this.cache.size >= this.maxSize && !this.cache.has(key)) {
      this.evictLRU();
    }

    this.cache.set(key, {
      value,
      expiredAt: Date.now() + ttl,
      lastAccessed: Date.now(),
    });
    this.stats.sets++;
  }

  /**
   * Remove least recently used item
   */
  evictLRU() {
    let lruKey = null;
    let lruTime = Infinity;

    for (const [key, item] of this.cache.entries()) {
      if (item.lastAccessed < lruTime) {
        lruTime = item.lastAccessed;
        lruKey = key;
      }
    }

    if (lruKey) {
      this.cache.delete(lruKey);
    }
  }

  /**
   * Delete specific key
   * @param {string} key - Cache key
   */
  delete(key) {
    if (this.cache.has(key)) {
      this.cache.delete(key);
      this.stats.deletes++;
    }
  }

  /**
   * Delete all keys matching pattern
   * @param {string} pattern - Regex pattern to match
   */
  deletePattern(pattern) {
    const regex = new RegExp(pattern);
    let deleted = 0;

    for (const key of this.cache.keys()) {
      if (regex.test(key)) {
        this.cache.delete(key);
        deleted++;
      }
    }

    this.stats.deletes += deleted;
    return deleted;
  }

  /**
   * Clear all cache
   */
  clear() {
    const size = this.cache.size;
    this.cache.clear();
    this.stats.deletes += size;
  }

  /**
   * Get cache statistics
   * @returns {object} - Cache stats
   */
  getStats() {
    const total = this.stats.hits + this.stats.misses;
    return {
      ...this.stats,
      hitRate: total > 0 ? ((this.stats.hits / total) * 100).toFixed(2) + '%' : 'N/A',
      size: this.cache.size,
      maxSize: this.maxSize,
    };
  }

  /**
   * Get cache info
   * @returns {object} - Cache info
   */
  getInfo() {
    return {
      size: this.cache.size,
      stats: this.getStats(),
    };
  }

  /**
   * Invalidate cache for data changes
   * Call this when songs or albums are created/updated
   */
  invalidateDataCaches() {
    // Invalidate all song and album caches
    this.deletePattern('^songs:');
    this.deletePattern('^albums:');
    this.deletePattern('^years:');
    this.deletePattern('^artists:');
    this.deletePattern('^singers:');
    this.deletePattern('^directors:');
  }

  /**
   * Invalidate songs cache
   */
  invalidateSongsCaches() {
    this.deletePattern('^songs:');
  }

  /**
   * Invalidate albums cache
   */
  invalidateAlbumsCaches() {
    this.deletePattern('^albums:');
    this.deletePattern('^years:'); // Years depend on albums
  }

  /**
   * Invalidate artist cache
   */
  invalidateArtistsCaches() {
    this.deletePattern('^artists:');
  }

  /**
   * Invalidate singer cache
   */
  invalidateSingersCaches() {
    this.deletePattern('^singers:');
  }

  /**
   * Invalidate director cache
   */
  invalidateDirectorsCaches() {
    this.deletePattern('^directors:');
  }
}

// Create singleton instance for application
const cacheManager = new CacheManager({
  ttl: 60 * 60 * 1000, // 1 hour default
  maxSize: 2000, // Store up to 2000 items
});

module.exports = { CacheManager, cacheManager };
