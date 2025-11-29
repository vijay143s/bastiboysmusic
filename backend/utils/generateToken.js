import jwt from "jsonwebtoken";

const generateToken = (id, res) => {
  const token = jwt.sign({ id }, process.env.Jwt_secret, {
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

export default generateToken;
