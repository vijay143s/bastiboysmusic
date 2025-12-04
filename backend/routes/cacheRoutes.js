const express = require("express");
const { isAuth } = require("../middlewares/isAuth.js");
const {
  getCacheStats,
  getCacheInfo,
  clearCache,
  clearDataCache,
} = require("../controllers/cacheController.js");

const router = express.Router();

// Cache monitoring endpoints (admin only)
router.get("/stats", isAuth, getCacheStats);
router.get("/info", isAuth, getCacheInfo);
router.post("/clear", isAuth, clearCache);
router.post("/clear-data", isAuth, clearDataCache);

module.exports = router;
