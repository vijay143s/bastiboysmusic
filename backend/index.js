const express = require("express");
const dotenv = require("dotenv");
const path = require("path");
const cors = require("cors");
const { connectDb } = require("./database/db.js");
const cookieParser = require("cookie-parser");
const cloudinary = require("cloudinary");
const http = require('http');
const socketIo = require('socket.io');

// Import scraper routes
const { router: scraperRoutes, initSocketManager } = require('./routes/scraper');
const scraperDatabaseRoutes = require('./routes/database');
const adminQueryRoutes = require('./routes/adminQuery');

// Load .env from backend directory
const envPath = path.resolve(__dirname, ".env");
dotenv.config({ path: envPath });

cloudinary.v2.config({
  cloud_name: process.env.Cloud_Name,
  api_key: process.env.Cloud_Api,
  api_secret: process.env.Cloud_Secret,
});

const app = express();
const server = http.createServer(app);

// CORS configuration for cPanel and local development
const corsOptions = {
  origin: process.env.NODE_ENV === 'production'
    ? (process.env.ALLOWED_ORIGINS?.split(',') || ['http://localhost:3000'])
    : '*',
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS', 'PATCH'],
  allowedHeaders: ['Content-Type', 'Authorization']
};

const io = socketIo(server, {
  cors: corsOptions
});

// using middlewares
app.use(cors(corsOptions));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

// Initialize socket manager for scraper
initSocketManager(io);

// Port configuration: Use 8080 for cPanel, 5000 for local development
const port = Number(process.env.PORT) || (process.env.NODE_ENV === 'production' ? 8080 : 5001);

//importing existing routes
const userRoutes = require("./routes/userRoutes.js");
const songRoutes = require("./routes/songRoutes.js");
const homeRoutes = require("./routes/homeRoutes.js");
const interactionRoutes = require("./routes/interactionRoutes.js");
const adminRoutes = require("./routes/adminRoutes.js");
const audioProxyRoutes = require("./routes/audioProxyRoutes.js");
const cacheRoutes = require("./routes/cacheRoutes.js");

//using existing routes
app.use("/api/user", userRoutes);
app.use("/api/song", songRoutes);
app.use("/api/home", homeRoutes);
app.use("/api/interaction", interactionRoutes);
app.use("/api/admin", adminRoutes);
app.use("/api/audio", audioProxyRoutes);
app.use("/api/cache", cacheRoutes);

// Add scraper routes
app.use('/api/scrape', scraperRoutes);
app.use('/api/scraper-database', scraperDatabaseRoutes);
app.use('/api/admin/query', adminQueryRoutes);

// Health check endpoint for scraper
app.get('/api/scraper/health', (req, res) => {
  res.json({
    success: true,
    message: 'Telugu Songs Scraper API is running',
    timestamp: new Date().toISOString(),
    version: '1.0.0'
  });
});

app.use(express.static(path.join(__dirname, "/frontend/dist")));

app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "frontend", "dist", "index.html"));
});

// Error handling middleware
app.use((error, req, res, next) => {
  console.error('API Error:', error);
  res.status(error.status || 500).json({
    success: false,
    message: error.message || 'Internal Server Error',
    ...(process.env.NODE_ENV === 'development' && { stack: error.stack })
  });
});

server.listen(port, () => {
  connectDb();
  console.log(`
╔═══════════════════════════════════════════════════════════╗
║         🚀 Telugu Songs App Starting                      ║
╠═══════════════════════════════════════════════════════════╣
║ Server Port:     ${port}
║ Environment:     ${process.env.NODE_ENV || 'development'}
║ Scraper API:     http://localhost:${port}/api/scrape
║ Health Check:    http://localhost:${port}/api/scraper/health
║ WebSocket:       http://localhost:${port}
╚═══════════════════════════════════════════════════════════╝
  `);
});

// Simple shutdown handlers
process.on('SIGTERM', () => {
  console.log('Received SIGTERM, shutting down gracefully...');
  server.close(() => {
    process.exit(0);
  });
});

process.on('SIGINT', () => {
  console.log('Received SIGINT, shutting down gracefully...');
  server.close(() => {
    process.exit(0);
  });
});

module.exports = app;
