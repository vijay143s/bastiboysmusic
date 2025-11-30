const express = require("express");
const dotenv = require("dotenv");
const { connectDb } = require("./database/db.js");
const cookieParser = require("cookie-parser");
const cloudinary = require("cloudinary");
const path = require("path");

dotenv.config();

cloudinary.v2.config({
  cloud_name: process.env.Cloud_Name,
  api_key: process.env.Cloud_Api,
  api_secret: process.env.Cloud_Secret,
});

const app = express();

// using middlewares
app.use(express.json());
app.use(cookieParser());

const port = Number(process.env.PORT) || 5000;

//importing routes
const userRoutes = require("./routes/userRoutes.js");
const songRoutes = require("./routes/songRoutes.js");

//using routes
app.use("/api/user", userRoutes);
app.use("/api/song", songRoutes);


app.use(express.static(path.join(__dirname, "/frontend/dist")));

app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "frontend", "dist", "index.html"));
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
  connectDb();
});
