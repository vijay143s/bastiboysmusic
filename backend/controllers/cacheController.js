const TryCatch = require("../utils/TryCatch.js");
const { cacheManager } = require("../utils/cacheManager.js");

/**
 * Cache monitoring endpoints
 */

const getCacheStats = TryCatch(async (req, res) => {
  const stats = cacheManager.getStats();
  res.json({
    message: "Cache statistics",
    stats,
  });
});

const getCacheInfo = TryCatch(async (req, res) => {
  const info = cacheManager.getInfo();
  res.json({
    message: "Cache information",
    info,
  });
});

const clearCache = TryCatch(async (req, res) => {
  cacheManager.clear();
  res.json({
    message: "Cache cleared successfully",
  });
});

const clearDataCache = TryCatch(async (req, res) => {
  cacheManager.invalidateDataCaches();
  res.json({
    message: "Data cache cleared successfully",
  });
});

module.exports = {
  getCacheStats,
  getCacheInfo,
  clearCache,
  clearDataCache,
};
