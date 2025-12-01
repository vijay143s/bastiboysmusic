const express = require("express");
const dotenv = require("dotenv");
const path = require("path");
const { connectDb } = require("./database/db.js");
const cookieParser = require("cookie-parser");
const cloudinary = require("cloudinary");

// Load .env from backend directory
const envPath = path.resolve(__dirname, ".env");
dotenv.config({ path: envPath });

// Debug: Log database environment variables
console.log("POSTGRES_HOST:", process.env.POSTGRES_HOST || "<via DATABASE_URL>");
console.log("POSTGRES_PORT:", process.env.POSTGRES_PORT || "<via DATABASE_URL>");
console.log("POSTGRES_USER:", process.env.POSTGRES_USER || "<via DATABASE_URL>");
console.log("POSTGRES_DATABASE:", process.env.POSTGRES_DATABASE || "<via DATABASE_URL>");

cloudinary.v2.config({
  cloud_name: process.env.Cloud_Name,
  api_key: process.env.Cloud_Api,
  api_secret: process.env.Cloud_Secret,
});

const app = express();
app.set('trust proxy', 1);
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
