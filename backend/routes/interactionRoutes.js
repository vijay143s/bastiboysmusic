const express = require("express");
const { isAuth } = require("../middlewares/isAuth.js");
const {
  trackPlay,
  trackCompletion,
  trackSkip,
  trackSearch,
  getRecommendations,
  getListeningStats,
  getTrendingSongs,
  getQueueSongs,
} = require("../controllers/interactionControllers.js");

const router = express.Router();

// Tracking endpoints
router.post("/track/play/:songId", isAuth, trackPlay);
router.post("/track/completion/:songId", isAuth, trackCompletion);
router.post("/track/skip/:songId", isAuth, trackSkip);
router.post("/track/search", trackSearch); // Can work without auth for anonymous searches

// Recommendation endpoints
router.get("/recommendations", isAuth, getRecommendations);
router.get("/stats", isAuth, getListeningStats);
router.get("/trending", getTrendingSongs);
router.get("/queue", getQueueSongs);

module.exports = router;
