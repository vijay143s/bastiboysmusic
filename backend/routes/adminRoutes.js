const express = require("express");
const { isAuth } = require("../middlewares/isAuth.js");
const {
  getDashboardStats,
  getUserAnalytics,
  getContentAnalytics,
  getSystemHealth,
  bulkDeleteSongs,
  updateSongMetadata,
  toggleFeaturedSong,
  getActivityLogs,
} = require("../controllers/adminControllers.js");

const router = express.Router();

// Dashboard statistics
router.get("/dashboard/stats", isAuth, getDashboardStats);
router.get("/analytics/users", isAuth, getUserAnalytics);
router.get("/analytics/content", isAuth, getContentAnalytics);

// System management
router.get("/system/health", isAuth, getSystemHealth);
router.get("/activity/logs", isAuth, getActivityLogs);

// Content management
router.delete("/songs/bulk", isAuth, bulkDeleteSongs);
router.put("/songs/:songId/metadata", isAuth, updateSongMetadata);
router.patch("/songs/:songId/featured", isAuth, toggleFeaturedSong);

module.exports = router;