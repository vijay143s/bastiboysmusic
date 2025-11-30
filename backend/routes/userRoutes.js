const express = require("express");
const {
  loginUser,
  logoutUser,
  myProfile,
  registerUser,
  saveToPlaylist,
  getAllCommunityPlaylists,
} = require("../controllers/userControllers.js");
const { isAuth } = require("../middlewares/isAuth.js");
const { validateRequest } = require("../middlewares/validateRequest.js");
const { authRateLimiter } = require("../middlewares/rateLimiter.js");
const { registerSchema, loginSchema } = require("../validators/authSchemas.js");

const router = express.Router();

router.post(
  "/register",
  authRateLimiter,
  validateRequest(registerSchema),
  registerUser
);
router.post("/login", authRateLimiter, validateRequest(loginSchema), loginUser);
router.get("/me", isAuth, myProfile);
router.get("/logout", isAuth, logoutUser);
router.post("/song/:id", isAuth, saveToPlaylist);
router.get("/playlists/all", isAuth, getAllCommunityPlaylists);

module.exports = router;
