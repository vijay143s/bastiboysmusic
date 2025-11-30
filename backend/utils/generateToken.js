const jwt = require("jsonwebtoken");
const { jwtSecret } = require("../config/auth.js");

const generateToken = (id, res) => {
  const token = jwt.sign({ id }, jwtSecret, {
    expiresIn: "15d",
  });

  const isProduction = process.env.NODE_ENV === "production";

  res.cookie("token", token, {
    maxAge: 15 * 24 * 60 * 60 * 1000,
    httpOnly: true,
    sameSite: isProduction ? "none" : "lax",
    secure: isProduction,
  });
};

module.exports = generateToken;
