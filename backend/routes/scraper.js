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

const attachServiceListeners = (service) => {
  if (!service) return;

  service.on('log', (message) => {
    if (socketManager) {
      socketManager.broadcastLog(message);
    }
  });

  service.on('stats', (stats) => {
    if (socketManager) {
      socketManager.broadcastStats(stats);
    }
  });

  service.on('progress', (progress) => {
    if (socketManager) {
      socketManager.broadcastProgress(progress);
    }
  });

  service.on('error', (error) => {
    if (socketManager) {
      socketManager.broadcastError(error);
    }
  });

  service.on('complete', (code) => {
    if (socketManager) {
      socketManager.broadcastComplete(code);
    }
  });
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
    attachServiceListeners(scraperService);

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

// POST /api/scrape/pagalworld
router.post('/pagalworld', async (req, res) => {
  try {
    if (scraperService && scraperService.isRunning) {
      return res.status(400).json({
        success: false,
        message: 'Another scraping process is already running'
      });
    }

    const {
      articleUrl,
      executeSql = true,
      sqlOutput = 'sql_output/pagalworld',
      timeout = 45
    } = req.body;

    if (!articleUrl) {
      return res.status(400).json({
        success: false,
        message: 'Pagalworld album URL is required'
      });
    }

    scraperService = new PythonScraperService();
    attachServiceListeners(scraperService);

    const scriptPath = path.join(__dirname, '../python-scripts/pagalworld_scraper.py');
    const args = ['--url', articleUrl];

    if (sqlOutput) {
      args.push('--sql-output', sqlOutput);
    }

    if (executeSql) {
      args.push('--execute-sql');
    }

    if (timeout) {
      args.push('--timeout', timeout.toString());
    }

    scraperService.startPythonScript(scriptPath, args);

    res.json({
      success: true,
      message: 'Pagalworld scraping started successfully',
      options: { articleUrl, executeSql, sqlOutput, timeout }
    });

  } catch (error) {
    console.error('Error starting Pagalworld scraper:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to start Pagalworld scraping',
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

// SSE endpoint removed - using polling approach instead

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

// GET /api/scrape/logs - Read logs from file
router.get('/logs', async (req, res) => {
  try {
    const { lines = 100, offset = 0 } = req.query;
    const logFile = path.join(__dirname, '../python-scripts/logs/ingestion.log');
    
    if (!fs.existsSync(logFile)) {
      return res.json({
        success: true,
        logs: [],
        stats: { albums: 0, songs: 0, errors: 0 },
        hasMore: false
      });
    }

    const fileContent = fs.readFileSync(logFile, 'utf8');
    const allLines = fileContent.split('\n').filter(line => line.trim() !== '');
    
    // Get the requested slice of lines
    const startIndex = Math.max(0, allLines.length - lines - offset);
    const endIndex = allLines.length - offset;
    const requestedLines = allLines.slice(startIndex, endIndex);
    
    // Parse logs and extract statistics
    const logs = requestedLines.map(line => {
      const timestampMatch = line.match(/^(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2},\d{3})/);
      const levelMatch = line.match(/ - (\w+) - /);
      
      return {
        timestamp: timestampMatch ? new Date(timestampMatch[1]).toLocaleTimeString() : new Date().toLocaleTimeString(),
        message: line,
        level: levelMatch ? levelMatch[1].toLowerCase() : 'info'
      };
    });

    // Extract statistics from the logs
    const stats = { albums: 0, songs: 0, errors: 0 };
    const fullContent = allLines.join('\n');
    
    // Look for statistics patterns
    const albumMatch = fullContent.match(/Albums: (\d+)/g);
    const songMatch = fullContent.match(/Songs: (\d+)/g);
    const errorLines = allLines.filter(line => line.includes('ERROR') || line.includes('Exception'));
    
    if (albumMatch) {
      const lastAlbumMatch = albumMatch[albumMatch.length - 1];
      stats.albums = parseInt(lastAlbumMatch.match(/(\d+)/)[1]) || 0;
    }
    
    if (songMatch) {
      const lastSongMatch = songMatch[songMatch.length - 1];
      stats.songs = parseInt(lastSongMatch.match(/(\d+)/)[1]) || 0;
    }
    
    stats.errors = errorLines.length;

    res.json({
      success: true,
      logs,
      stats,
      hasMore: startIndex > 0,
      totalLines: allLines.length
    });
    
  } catch (error) {
    console.error('Error reading logs:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to read logs',
      error: error.message
    });
  }
});

// POST /api/scrape/clear-logs - Clear the log file
router.post('/clear-logs', async (req, res) => {
  try {
    const logFile = path.join(__dirname, '../python-scripts/logs/ingestion.log');
    
    // Clear the log file
    fs.writeFileSync(logFile, '', 'utf8');
    
    res.json({
      success: true,
      message: 'Logs cleared successfully'
    });
    
  } catch (error) {
    console.error('Error clearing logs:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to clear logs',
      error: error.message
    });
  }
});

// POST /api/scrape/remove-duplicates
router.post('/remove-duplicates', async (req, res) => {
  try {
    const { dryRun = true } = req.body;
    
    if (scraperService && scraperService.isRunning) {
      return res.status(400).json({ 
        success: false, 
        message: 'Cannot remove duplicates while scraping is running' 
      });
    }

    // Create new Python service for duplicate removal
    const duplicateService = new PythonScraperService();
    
    // Set up event listeners for real-time updates
    duplicateService.on('log', (message) => {
      if (socketManager) {
        socketManager.broadcastLog(message);
      }
    });

    duplicateService.on('error', (error) => {
      if (socketManager) {
        socketManager.broadcastError(error);
      }
    });

    duplicateService.on('complete', (code) => {
      if (socketManager) {
        socketManager.broadcastComplete(code);
      }
    });

    // Start duplicate removal
    const scriptPath = path.join(__dirname, '../python-scripts/remove_duplicates.py');
    const args = [];
    
    if (dryRun) {
      args.push('--dry-run');
    }

    // Start the Python script
    duplicateService.startPythonScript(scriptPath, args);

    res.json({
      success: true,
      message: dryRun ? 'Duplicate analysis started (dry run)' : 'Duplicate removal started',
      dryRun
    });

  } catch (error) {
    console.error('Error starting duplicate removal:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to start duplicate removal',
      error: error.message
    });
  }
});

module.exports = { router, initSocketManager };