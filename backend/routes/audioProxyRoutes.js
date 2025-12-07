const express = require("express");
const https = require("https");
const http = require("http");
const { URL } = require("url");

const router = express.Router();

/**
 * Audio Proxy Route
 * Streams audio from Pagal World through backend to avoid CORS issues
 * Usage: GET /api/audio/stream?url=<encoded-url>
 * 
 * NOTE: Only works for pagalworldmusic.com URLs
 * Other audio sources (like sentunes.online) should be played directly
 */
router.get("/stream", async (req, res) => {
  try {
    const audioUrl = req.query.url;

    if (!audioUrl) {
      return res.status(400).json({
        message: "Missing audio URL parameter",
      });
    }

    // Decode the URL
    let decodedUrl;
    try {
      decodedUrl = decodeURIComponent(audioUrl);
    } catch (e) {
      return res.status(400).json({
        message: "Invalid URL encoding",
      });
    }

    // Validate URL is from Pagal World only
    const urlObj = new URL(decodedUrl);
    // Allow Pagal World and Google Drive
    const allowedDomains = ["pagalworldmusic.com", "drive.google.com", "drive.usercontent.google.com"];
    const isAllowed = allowedDomains.some(domain => urlObj.hostname.includes(domain));

    if (!isAllowed) {
      return res.status(403).json({
        message: "This audio source is not allowed via proxy.",
      });
    }

    // Set response headers for audio streaming
    res.setHeader("Content-Type", "audio/mpeg");
    res.setHeader("Accept-Ranges", "bytes");
    res.setHeader("Cache-Control", "public, max-age=86400");
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Cross-Origin-Resource-Policy", "cross-origin");

    // Add user agent to avoid being blocked
    // Add user agent to avoid being blocked
    const headers = {
      "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
      Range: req.headers.range || undefined,
    };

    // Only add Referer for Pagal World
    if (urlObj.hostname.includes("pagalworldmusic.com")) {
      headers["Referer"] = "https://pagalworldmusic.com/";
    }

    const requestOptions = { headers };

    // Remove undefined Range header
    if (!requestOptions.headers.Range) {
      delete requestOptions.headers.Range;
    }

    // Make request to Pagal World server
    const protocol = urlObj.protocol === "https:" ? https : http;

    const remoteRequest = protocol.get(
      decodedUrl,
      requestOptions,
      (remoteRes) => {
        // Handle redirects
        if (
          remoteRes.statusCode >= 300 &&
          remoteRes.statusCode < 400 &&
          remoteRes.headers.location
        ) {
          // Recursively handle redirect
          const redirectUrl = remoteRes.headers.location;
          return res.redirect(
            `/api/audio/stream?url=${encodeURIComponent(redirectUrl)}`
          );
        }

        // Handle range requests
        if (remoteRes.statusCode === 206) {
          res.status(206);
          res.setHeader(
            "Content-Range",
            remoteRes.headers["content-range"] || "bytes */*"
          );
        }

        // Set content length if available
        if (remoteRes.headers["content-length"]) {
          res.setHeader("Content-Length", remoteRes.headers["content-length"]);
        }

        // Pipe the response
        remoteRes.pipe(res);
      }
    );

    remoteRequest.on("error", (error) => {
      console.error("Audio proxy error:", error);
      res.status(500).json({
        message: "Failed to stream audio",
        error: process.env.NODE_ENV === "development" ? error.message : undefined,
      });
    });

    req.on("aborted", () => {
      remoteRequest.destroy();
    });
  } catch (error) {
    console.error("Audio proxy error:", error);
    res.status(500).json({
      message: "Failed to stream audio",
      error: process.env.NODE_ENV === "development" ? error.message : undefined,
    });
  }
});

/**
 * Direct Audio Fetch (for testing/debugging)
 * Returns audio metadata and playable URL
 */
router.get("/fetch", async (req, res) => {
  try {
    const audioUrl = req.query.url;

    if (!audioUrl) {
      return res.status(400).json({
        message: "Missing audio URL parameter",
      });
    }

    let decodedUrl;
    try {
      decodedUrl = decodeURIComponent(audioUrl);
    } catch (e) {
      return res.status(400).json({
        message: "Invalid URL encoding",
      });
    }

    // Use proxy URL for playback
    const proxyUrl = `/api/audio/stream?url=${encodeURIComponent(decodedUrl)}`;

    res.json({
      original_url: decodedUrl,
      proxy_url: proxyUrl,
      message: "Use proxy_url for audio playback to avoid CORS issues",
    });
  } catch (error) {
    console.error("Audio fetch error:", error);
    res.status(500).json({
      message: "Failed to fetch audio",
      error: process.env.NODE_ENV === "development" ? error.message : undefined,
    });
  }
});

module.exports = router;
