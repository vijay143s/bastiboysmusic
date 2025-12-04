const express = require('express');
const router = express.Router();
const PythonScraperService = require('../services/pythonRunner');
const SocketManager = require('../services/socketManager');
const path = require('path');
const fs = require('fs');

// Global scraper instance
let scraperService = null;
let socketManager = null;

// Initialize socket manager
const initSocketManager = (io) => {
  socketManager = new SocketManager(io);
};

// POST /api/scrape/start
router.post('/start', async (req, res) => {
  try {
    if (scraperService && scraperService.isRunning) {
      return res.status(400).json({ 
        success: false, 
        message: 'Scraping is already running' 
      });
    }

    const {
      mode,
      articleUrl,
      year,
      endYear,
      maxPages,
      autoDiscover,
      tags,
      truncate,
      workers = 5,
      executeSql = true,
      generateSql = true,
      baseUrl = 'https://sensongsmp3.live/'
    } = req.body;

    // Validate required fields
    if (!mode || !['single', 'incremental', 'year', 'full'].includes(mode)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid or missing mode'
      });
    }

    if (mode === 'single' && !articleUrl) {
      return res.status(400).json({
        success: false,
        message: 'Article URL is required for single mode'
      });
    }

    if (mode === 'year' && !year) {
      return res.status(400).json({
        success: false,
        message: 'Year is required for year mode'
      });
    }

    // Create new scraper service
    scraperService = new PythonScraperService();

    // Set up event listeners for real-time updates
    scraperService.on('log', (message) => {
      if (socketManager) {
        socketManager.broadcastLog(message);
      }
    });

    scraperService.on('stats', (stats) => {
      if (socketManager) {
        socketManager.broadcastStats(stats);
      }
    });

    scraperService.on('progress', (progress) => {
      if (socketManager) {
        socketManager.broadcastProgress(progress);
      }
    });

    scraperService.on('error', (error) => {
      if (socketManager) {
        socketManager.broadcastError(error);
      }
    });

    scraperService.on('complete', (code) => {
      if (socketManager) {
        socketManager.broadcastComplete(code);
      }
    });

    // Start scraping
    const options = {
      mode,
      articleUrl,
      year,
      endYear,
      maxPages,
      autoDiscover,
      tags,
      truncate,
      workers,
      executeSql,
      generateSql,
      baseUrl
    };

    await scraperService.startScraping(options);

    res.json({
      success: true,
      message: 'Scraping started successfully',
      options
    });

  } catch (error) {
    console.error('Error starting scraper:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to start scraping',
      error: error.message
    });
  }
});

// POST /api/scrape/stop
router.post('/stop', (req, res) => {
  try {
    if (!scraperService || !scraperService.isRunning) {
      return res.status(400).json({
        success: false,
        message: 'No scraping process is running'
      });
    }

    scraperService.stop();

    res.json({
      success: true,
      message: 'Scraping stopped successfully'
    });

  } catch (error) {
    console.error('Error stopping scraper:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to stop scraping',
      error: error.message
    });
  }
});

// GET /api/scrape/status
router.get('/status', (req, res) => {
  try {
    const status = {
      isRunning: scraperService ? scraperService.isRunning : false,
      progress: scraperService ? scraperService.progress : 0,
      stats: scraperService ? scraperService.stats : { albums: 0, songs: 0, errors: 0 },
      currentTask: scraperService ? scraperService.currentTask : 'Idle'
    };

    res.json(status);

  } catch (error) {
    console.error('Error getting status:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to get status',
      error: error.message
    });
  }
});

// GET /api/scrape/logs (Server-Sent Events)
router.get('/logs', (req, res) => {
  // Set headers for Server-Sent Events
  res.writeHead(200, {
    'Content-Type': 'text/event-stream',
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Cache-Control'
  });

  // Send initial connection message
  res.write('data: {"type": "connected", "message": "Connected to logs"}\n\n');

  // Add client to socket manager for real-time updates
  if (socketManager) {
    const clientId = Date.now().toString();
    socketManager.addSSEClient(clientId, res);

    // Handle client disconnect
    req.on('close', () => {
      socketManager.removeSSEClient(clientId);
    });
  }

  // Keep connection alive
  const heartbeat = setInterval(() => {
    res.write('data: {"type": "heartbeat"}\n\n');
  }, 30000);

  req.on('close', () => {
    clearInterval(heartbeat);
  });
});

// GET /api/scrape/results/:format
router.get('/results/:format', (req, res) => {
  try {
    const { format } = req.params;
    const validFormats = ['csv', 'json', 'sql'];

    if (!validFormats.includes(format)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid format. Supported: csv, json, sql'
      });
    }

    const sqlOutputDir = path.join(__dirname, '../python-scripts/sql_output');
    
    if (format === 'sql') {
      // Return latest SQL files as zip or individual files
      const sqlFiles = fs.readdirSync(sqlOutputDir)
        .filter(file => file.endsWith('.sql'))
        .map(file => ({
          filename: file,
          path: path.join(sqlOutputDir, file),
          size: fs.statSync(path.join(sqlOutputDir, file)).size
        }));

      res.json({
        success: true,
        files: sqlFiles,
        downloadUrl: '/api/scrape/download/sql'
      });

    } else if (format === 'csv') {
      // Look for CSV exports
      const csvFiles = fs.readdirSync(process.cwd())
        .filter(file => file.endsWith('.csv'))
        .map(file => ({
          filename: file,
          path: path.join(process.cwd(), file),
          size: fs.statSync(path.join(process.cwd(), file)).size
        }));

      res.json({
        success: true,
        files: csvFiles,
        downloadUrl: '/api/scrape/download/csv'
      });

    } else if (format === 'json') {
      // Generate JSON from database or return existing JSON files
      res.json({
        success: true,
        message: 'JSON export functionality to be implemented',
        downloadUrl: '/api/scrape/download/json'
      });
    }

  } catch (error) {
    console.error('Error getting results:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to get results',
      error: error.message
    });
  }
});

// GET /api/scrape/download/:type
router.get('/download/:type', (req, res) => {
  try {
    const { type } = req.params;
    const { file } = req.query;

    if (type === 'sql' && file) {
      const filePath = path.join(__dirname, '../python-scripts/sql_output', file);
      if (fs.existsSync(filePath)) {
        res.download(filePath);
      } else {
        res.status(404).json({ success: false, message: 'File not found' });
      }
    } else if (type === 'csv' && file) {
      const filePath = path.join(process.cwd(), file);
      if (fs.existsSync(filePath)) {
        res.download(filePath);
      } else {
        res.status(404).json({ success: false, message: 'File not found' });
      }
    } else {
      res.status(400).json({ success: false, message: 'Invalid download request' });
    }

  } catch (error) {
    console.error('Error downloading file:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to download file',
      error: error.message
    });
  }
});

module.exports = { router, initSocketManager };