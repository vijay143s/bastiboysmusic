const jwt = require("jsonwebtoken");
const { findUserById } = require("../repositories/userRepository.js");
const { jwtSecret } = require("../config/auth.js");

const isAuth = async (req, res, next) => {
  try {
    // Check for token in cookies first, then Authorization header
    let token = req.cookies.token;
    
    if (!token) {
      const authHeader = req.headers.authorization;
      if (authHeader && authHeader.startsWith('Bearer ')) {
        token = authHeader.substring(7);
      }
    }

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

module.exports = { isAuth };
