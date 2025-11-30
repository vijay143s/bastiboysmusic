const express = require("express");
const dotenv = require("dotenv");
const path = require("path");
const { connectDb } = require("./database/db.js");
const cookieParser = require("cookie-parser");
const cloudinary = require("cloudinary");

// Load .env from backend directory
const envPath = path.resolve(__dirname, ".env");
dotenv.config({ path: envPath });

// Debug: Log environment variables
console.log("MySQL_HOST:", process.env.MYSQL_HOST);
console.log("MySQL_PORT:", process.env.MYSQL_PORT);
console.log("MySQL_USER:", process.env.MYSQL_USER);
console.log("MySQL_DATABASE:", process.env.MYSQL_DATABASE);

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
const homeRoutes = require("./routes/homeRoutes.js");

//using routes
app.use("/api/user", userRoutes);
app.use("/api/song", songRoutes);
app.use("/api/home", homeRoutes);


app.use(express.static(path.join(__dirname, "/frontend/dist")));

app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "frontend", "dist", "index.html"));
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
  connectDb();
});
