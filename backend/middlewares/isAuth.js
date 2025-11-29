import jwt from "jsonwebtoken";
import { findUserById } from "../repositories/userRepository.js";
import { jwtSecret } from "../config/auth.js";

export const isAuth = async (req, res, next) => {
  try {
    const token = req.cookies.token;

    if (!token)
      return res.status(403).json({
        message: "Please Login",
      });

  const decodedData = jwt.verify(token, jwtSecret);

    if (!decodedData || !decodedData.id)
      return res.status(403).json({
        message: "token expired",
      });

    const user = await findUserById(decodedData.id);

    if (!user)
      return res.status(403).json({
        message: "Please Login",
      });

    req.user = {
      id: user.id,
      _id: String(user.id),
      name: user.name,
      email: user.email,
      role: user.role,
    };

    next();
  } catch (error) {
    res.status(500).json({
      message: "Please Login",
    });
  }
};
