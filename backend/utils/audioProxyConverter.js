/**
 * Audio URL converter
 * Converts direct audio URLs to proxy URLs for CORS-free playback
 * Supports pre-generated stream URLs for instant playback
 */

const convertToProxyUrl = (audioUrl) => {
  if (!audioUrl) return null;

  // If it's already a proxy URL, return as-is
  if (audioUrl.includes("/api/audio/stream")) {
    return audioUrl;
  }

  // Convert direct URL to proxy URL
  return `/api/audio/stream?url=${encodeURIComponent(audioUrl)}`;
};

const convertToProxyUrlBatch = (items, urlField = "audio_url") => {
  return items.map((item) => ({
    ...item,
    [urlField]: convertToProxyUrl(item[urlField]),
  }));
};

/**
 * Generate stream URL for a given audio URL
 * This creates a relative URL that can be used directly by the player
 * Usage during scraping: generateStreamUrl(audio_url) for storage in DB
 */
const generateStreamUrl = (audioUrl) => {
  if (!audioUrl) return null;
  
  // Already a stream URL
  if (audioUrl.includes("/api/audio/stream")) {
    return audioUrl;
  }
  
  // Generate stream URL with encoded audio URL
  return `/api/audio/stream?url=${encodeURIComponent(audioUrl)}`;
};

module.exports = {
  convertToProxyUrl,
  convertToProxyUrlBatch,
  generateStreamUrl,
};
