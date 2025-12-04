const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');
const EventEmitter = require('events');

class PythonScraperService extends EventEmitter {
  constructor() {
    super();
    this.currentProcess = null;
    this.isRunning = false;
    this.progress = 0;
    this.stats = { albums: 0, songs: 0, errors: 0 };
    this.currentTask = 'Idle';
    this.startTime = null;
    this.logFile = path.join(__dirname, '../python-scripts/logs/ingestion.log');
  }

  // Clear log file at start of new session
  clearLogFile() {
    try {
      const logDir = path.dirname(this.logFile);
      if (!fs.existsSync(logDir)) {
        fs.mkdirSync(logDir, { recursive: true });
      }
      fs.writeFileSync(this.logFile, '', 'utf8');
    } catch (error) {
      console.error('Error clearing log file:', error);
    }
  }

  // Write log to file for HTTP polling
  writeLogToFile(message) {
    try {
      const logDir = path.dirname(this.logFile);
      if (!fs.existsSync(logDir)) {
        fs.mkdirSync(logDir, { recursive: true });
      }
      
      const timestamp = new Date().toISOString().replace('T', ' ').replace('Z', '');
      const logEntry = `${timestamp} - INFO - ${message}\n`;
      fs.appendFileSync(this.logFile, logEntry, 'utf8');
    } catch (error) {
      console.error('Error writing to log file:', error);
    }
  }

  // Method to start any Python script (for scraping or duplicate removal)
  startPythonScript(scriptPath, args = []) {
    if (this.isRunning) {
      throw new Error('A Python script is already running');
    }

    console.log('Starting Python script:', scriptPath, 'with args:', args);

    this.currentProcess = spawn('python', [scriptPath, ...args], {
      cwd: path.dirname(scriptPath),
      env: { ...process.env },
      stdio: ['pipe', 'pipe', 'pipe']
    });

    this.isRunning = true;
    this.startTime = new Date();
    this.progress = 0;
    this.stats = { albums: 0, songs: 0, errors: 0 };
    this.currentTask = 'Starting script...';

    // Clear previous log file
    this.clearLogFile();
    
    this.setupProcessHandlers();

    // Emit start event
    this.emit('start', { 
      scriptPath,
      args, 
      startTime: this.startTime,
      pid: this.currentProcess.pid 
    });
  }

  async startScraping(options) {
    if (this.isRunning) {
      throw new Error('Scraping is already running');
    }

    try {
      const args = this.buildPythonArgs(options);
      const scriptPath = path.join(__dirname, '../python-scripts/senslive_incremental.py');
      
      console.log('Starting Python scraper with args:', args);

      this.currentProcess = spawn('python', [scriptPath, ...args], {
        cwd: path.dirname(scriptPath),
        env: { ...process.env },
        stdio: ['pipe', 'pipe', 'pipe']
      });

      this.isRunning = true;
      this.startTime = new Date();
      this.progress = 0;
      this.stats = { albums: 0, songs: 0, errors: 0 };
      this.currentTask = 'Starting scraper...';

      // Clear previous log file
      this.clearLogFile();
      
      this.setupProcessHandlers();

      // Emit start event
      this.emit('start', { 
        options, 
        startTime: this.startTime,
        pid: this.currentProcess.pid 
      });

    } catch (error) {
      this.isRunning = false;
      throw error;
    }
  }

  buildPythonArgs(options) {
    const args = ['--mode', options.mode];
    
    // Add mode-specific arguments
    if (options.articleUrl) {
      args.push('--article-url', options.articleUrl);
    }
    
    if (options.year) {
      args.push('--year', options.year.toString());
    }
    
    if (options.endYear) {
      args.push('--end-year', options.endYear.toString());
    }
    
    if (options.maxPages) {
      args.push('--max-pages', options.maxPages.toString());
    }
    
    if (options.tags) {
      args.push('--tags', options.tags);
    }
    
    if (options.workers) {
      args.push('--workers', options.workers.toString());
    }
    
    if (options.baseUrl) {
      args.push('--base-url', options.baseUrl);
    }

    // Boolean flags
    if (options.executeSql) {
      args.push('--execute-sql');
    }
    
    if (options.truncate) {
      args.push('--truncate');
    }
    
    if (options.autoDiscover) {
      args.push('--auto-discover-articles');
    }

    // Always add sql-output directory
    args.push('--sql-output', 'sql_output');
    
    return args;
  }

  setupProcessHandlers() {
    // Handle stdout (normal output)
    this.currentProcess.stdout.on('data', (data) => {
      const output = data.toString();
      console.log('Python stdout:', output);
      
      this.emit('log', output);
      this.writeLogToFile(output.trim());
      this.parseOutput(output);
    });

    // Handle stderr (error output and logging)
    this.currentProcess.stderr.on('data', (data) => {
      const output = data.toString();
      console.error('Python stderr:', output);
      
      // Check if this is actually an error or just logging output
      if (output.includes('ERROR') || output.includes('CRITICAL') || output.includes('Exception') || output.includes('Traceback')) {
        this.emit('error', output);
        this.parseError(data);
      } else {
        // Treat INFO, DEBUG, WARNING logs as regular log output
        console.log('Emitting log:', output.substring(0, 100) + '...');
        this.emit('log', output);
        this.writeLogToFile(output.trim());
        this.parseOutput(output);
      }
    });

    // Handle process exit
    this.currentProcess.on('close', (code, signal) => {
      console.log(`Python process exited with code ${code}, signal: ${signal}`);
      
      this.isRunning = false;
      this.currentTask = code === 0 ? 'Completed successfully' : 'Failed';
      this.progress = code === 0 ? 100 : this.progress;

      this.emit('complete', {
        code,
        signal,
        duration: this.startTime ? Date.now() - this.startTime.getTime() : 0,
        stats: this.stats
      });
    });

    // Handle process errors
    this.currentProcess.on('error', (error) => {
      console.error('Python process error:', error);
      
      this.isRunning = false;
      this.currentTask = 'Failed to start';
      
      this.emit('error', `Process error: ${error.message}`);
    });
  }

  parseOutput(output) {
    const lines = output.split('\n').filter(line => line.trim());

    for (const line of lines) {
      // Parse progress indicators
      if (line.includes('Processing') || line.includes('Scraping') || line.includes('EXECUTING SQL')) {
        this.currentTask = line.includes('INFO -') ? line.split('INFO -')[1].trim() : line.trim();
        this.emit('task', this.currentTask);
      }

      // Parse album count from generated SQL
      const albumMatch = line.match(/Albums:\s*(\d+)/i);
      if (albumMatch) {
        this.stats.albums = parseInt(albumMatch[1]);
        this.emit('stats', this.stats);
      }

      // Parse song count from generated SQL
      const songMatch = line.match(/Songs:\s*(\d+)/i);
      if (songMatch) {
        this.stats.songs = parseInt(songMatch[1]);
        this.emit('stats', this.stats);
      }

      // Parse artists count
      const artistMatch = line.match(/Artists:\s*(\d+)/i);
      if (artistMatch) {
        this.stats.artists = parseInt(artistMatch[1]);
        this.emit('stats', this.stats);
      }

      // Parse singers count
      const singerMatch = line.match(/Singers:\s*(\d+)/i);
      if (singerMatch) {
        this.stats.singers = parseInt(singerMatch[1]);
        this.emit('stats', this.stats);
      }

      // Parse music directors count
      const directorMatch = line.match(/Music Directors:\s*(\d+)/i);
      if (directorMatch) {
        this.stats.musicDirectors = parseInt(directorMatch[1]);
        this.emit('stats', this.stats);
      }

      // Parse progress percentage
      const progressMatch = line.match(/(\d+)%/);
      if (progressMatch) {
        this.progress = parseInt(progressMatch[1]);
        this.emit('progress', this.progress);
      }

      // Parse specific status messages
      if (line.includes('STARTING') || line.includes('COMPLETED')) {
        const status = line.includes('STARTING') ? 'Running' : 'Completed';
        this.stats.status = status;
        this.currentTask = line.includes('INFO -') ? line.split('INFO -')[1].trim() : line.trim();
        this.emit('task', this.currentTask);
        this.emit('stats', this.stats);
      }

      // Parse database execution status
      if (line.includes('Successfully executed') || line.includes('Database connection established')) {
        this.currentTask = line.includes('INFO -') ? line.split('INFO -')[1].trim() : line.trim();
        this.emit('task', this.currentTask);
      }

      if (line.includes('Completed') || line.includes('Finished')) {
        this.currentTask = line.trim();
        this.progress = 100;
        this.emit('task', this.currentTask);
        this.emit('progress', this.progress);
      }
    }
  }

  parseError(error) {
    // Convert to string if it's a Buffer
    const errorStr = error.toString ? error.toString() : String(error);
    
    // Count errors
    if (errorStr.toLowerCase().includes('error')) {
      this.stats.errors++;
      this.emit('stats', this.stats);
    }

    // Update task if it's a significant error
    if (errorStr.includes('Failed') || errorStr.includes('Exception')) {
      this.currentTask = `Error: ${errorStr.trim().substring(0, 50)}...`;
      this.emit('task', this.currentTask);
    }
  }

  stop() {
    if (this.currentProcess && this.isRunning) {
      console.log('Stopping Python scraper...');
      
      // Try graceful shutdown first
      this.currentProcess.kill('SIGTERM');
      
      // Force kill after 10 seconds if still running
      setTimeout(() => {
        if (this.isRunning && this.currentProcess) {
          console.log('Force killing Python scraper...');
          this.currentProcess.kill('SIGKILL');
        }
      }, 10000);

      this.currentTask = 'Stopping...';
      this.emit('task', this.currentTask);
    }
  }

  getStatus() {
    return {
      isRunning: this.isRunning,
      progress: this.progress,
      stats: this.stats,
      currentTask: this.currentTask,
      startTime: this.startTime,
      pid: this.currentProcess ? this.currentProcess.pid : null
    };
  }

  // Send input to the Python process (if needed)
  sendInput(input) {
    if (this.currentProcess && this.isRunning) {
      this.currentProcess.stdin.write(input + '\n');
    }
  }
}

module.exports = PythonScraperService;