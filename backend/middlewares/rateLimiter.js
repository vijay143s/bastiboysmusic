const rateLimit = require("express-rate-limit");

const authLimiterMessage = "Too many authentication attempts. Please try again soon.";

const authRateLimiter = rateLimit({
  windowMs: 60 * 1000,
  max: 10,
  standardHeaders: true,
  legacyHeaders: false,
  message: {
    success: false,
    message: authLimiterMessage
  },
  handler: (_req, res) => {
    res.status(429).json({ success: false, message: authLimiterMessage });
  }
});

module.exports = { authRateLimiter };
