import express from "express";
import {
  loginUser,
  logoutUser,
  myProfile,
  registerUser,
  saveToPlaylist,
} from "../controllers/userControllers.js";
import { isAuth } from "../middlewares/isAuth.js";
import { validateRequest } from "../middlewares/validateRequest.js";
import { authRateLimiter } from "../middlewares/rateLimiter.js";
import { registerSchema, loginSchema } from "../validators/authSchemas.js";

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

export default router;
