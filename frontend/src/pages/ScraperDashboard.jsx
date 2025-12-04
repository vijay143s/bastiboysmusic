import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import io from 'socket.io-client';
import { UserData } from '../context/User';
import '../components/ScraperDashboard.css';

const ScraperDashboard = () => {
  const { user } = UserData();
  const navigate = useNavigate();
  
  // Admin access control - redirect if not admin
  if (user && user.role !== "admin") return navigate("/");

  const [socket, setSocket] = useState(null);
  const [mode, setMode] = useState('');
  const [isRunning, setIsRunning] = useState(false);
  const [progress, setProgress] = useState(0);
  const [stats, setStats] = useState({
    albums: 0,
    songs: 0,
    errors: 0,
    status: 'Idle'
  });
  const [logs, setLogs] = useState([]);

  // Form state
  const [formData, setFormData] = useState({
    articleUrl: '',
    year: '',
    endYear: '',
    maxPages: 50,
    autoDiscover: false,
    tags: '',
    truncate: false,
    workers: 5,
    executeSql: true,
    generateSql: true,
    baseUrl: 'https://sensongsmp3.live/'
  });

  useEffect(() => {
    // Initialize Socket.IO connection
    const newSocket = io(window.location.origin);
    setSocket(newSocket);

    // Listen for scraper events
    newSocket.on('scraper_progress', (data) => {
      setProgress(data.progress);
      setStats(prev => ({
        ...prev,
        albums: data.albums || prev.albums,
        songs: data.songs || prev.songs,
        status: data.status || prev.status
      }));
    });

    newSocket.on('scraper_log', (data) => {
      setLogs(prev => [...prev.slice(-99), {
        timestamp: new Date().toLocaleTimeString(),
        message: data.message,
        level: data.level || 'info'
      }]);
    });

    newSocket.on('scraper_error', (data) => {
      setStats(prev => ({
        ...prev,
        errors: prev.errors + 1
      }));
      setLogs(prev => [...prev.slice(-99), {
        timestamp: new Date().toLocaleTimeString(),
        message: data.error,
        level: 'error'
      }]);
    });

    newSocket.on('scraper_complete', (data) => {
      setIsRunning(false);
      setStats(prev => ({
        ...prev,
        status: 'Complete'
      }));
      setLogs(prev => [...prev.slice(-99), {
        timestamp: new Date().toLocaleTimeString(),
        message: `Scraping completed! Albums: ${data.albums}, Songs: ${data.songs}`,
        level: 'success'
      }]);
    });

    return () => newSocket.close();
  }, []);

  const handleInputChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value
    }));
  };

  const startScraping = async () => {
    if (!mode) {
      alert('Please select a scraping mode');
      return;
    }

    setIsRunning(true);
    setProgress(0);
    setStats(prev => ({ ...prev, status: 'Starting...' }));

    const payload = {
      mode,
      ...formData
    };

    try {
      const response = await fetch('/api/scrape/start', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }

      const result = await response.json();
      setLogs(prev => [...prev.slice(-99), {
        timestamp: new Date().toLocaleTimeString(),
        message: result.message || 'Scraping started',
        level: 'info'
      }]);
    } catch (error) {
      setIsRunning(false);
      setStats(prev => ({ ...prev, status: 'Error' }));
      setLogs(prev => [...prev.slice(-99), {
        timestamp: new Date().toLocaleTimeString(),
        message: `Failed to start: ${error.message}`,
        level: 'error'
      }]);
    }
  };

  const stopScraping = async () => {
    try {
      await fetch('/api/scrape/stop', { method: 'POST' });
      setIsRunning(false);
      setStats(prev => ({ ...prev, status: 'Stopped' }));
    } catch (error) {
      console.error('Failed to stop scraping:', error);
    }
  };

  const clearLogs = () => {
    setLogs([]);
  };

  const downloadResults = async () => {
    try {
      const response = await fetch('/api/scrape/results');
      const blob = await response.blob();
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `scraper-results-${new Date().toISOString().slice(0, 10)}.json`;
      a.click();
      window.URL.revokeObjectURL(url);
    } catch (error) {
      alert('Failed to download results');
    }
  };

  return (
    <div className="scraper-dashboard">
      {/* Mode Selection */}
      <div className="mode-section">
        <h3>Scraping Mode</h3>
        <div className="mode-options">
          <label>
            <input 
              type="radio" 
              name="mode" 
              value="single" 
              checked={mode === 'single'}
              onChange={(e) => setMode(e.target.value)}
            /> 
            Single Article
          </label>
          <label>
            <input 
              type="radio" 
              name="mode" 
              value="incremental"
              checked={mode === 'incremental'}
              onChange={(e) => setMode(e.target.value)}
            /> 
            Incremental
          </label>
          <label>
            <input 
              type="radio" 
              name="mode" 
              value="year"
              checked={mode === 'year'}
              onChange={(e) => setMode(e.target.value)}
            /> 
            Year Range
          </label>
          <label>
            <input 
              type="radio" 
              name="mode" 
              value="full"
              checked={mode === 'full'}
              onChange={(e) => setMode(e.target.value)}
            /> 
            Full Reload
          </label>
        </div>
      </div>

      {/* Dynamic Input Fields */}
      <div className="input-section">
        {/* Single Article Mode */}
        {mode === 'single' && (
          <div className="mode-inputs">
            <label>Article URL:</label>
            <input 
              type="url" 
              name="articleUrl"
              value={formData.articleUrl}
              onChange={handleInputChange}
              placeholder="https://sensongsmp3.live/..."
            />
          </div>
        )}

        {/* Year Mode */}
        {mode === 'year' && (
          <div className="mode-inputs">
            <label>Start Year:</label>
            <input 
              type="number" 
              name="year"
              value={formData.year}
              onChange={handleInputChange}
              min="1950" 
              max="2025" 
              placeholder="1995"
            />
            <label>End Year (optional):</label>
            <input 
              type="number" 
              name="endYear"
              value={formData.endYear}
              onChange={handleInputChange}
              min="1950" 
              max="2025" 
              placeholder="Current year"
            />
          </div>
        )}

        {/* Incremental Mode */}
        {mode === 'incremental' && (
          <div className="mode-inputs">
            <label>Max Pages to Scan:</label>
            <input 
              type="number" 
              name="maxPages"
              value={formData.maxPages}
              onChange={handleInputChange}
              min="1" 
              max="500"
            />
            <label>
              <input 
                type="checkbox" 
                name="autoDiscover"
                checked={formData.autoDiscover}
                onChange={handleInputChange}
              /> 
              Auto-discover new articles
            </label>
          </div>
        )}

        {/* Full Mode */}
        {mode === 'full' && (
          <div className="mode-inputs">
            <label>Tags to scrape (comma-separated):</label>
            <input 
              type="text" 
              name="tags"
              value={formData.tags}
              onChange={handleInputChange}
              placeholder="1,a,b,c (leave empty for all)"
            />
            <label>
              <input 
                type="checkbox" 
                name="truncate"
                checked={formData.truncate}
                onChange={handleInputChange}
              /> 
              Truncate existing data
            </label>
          </div>
        )}
      </div>

      {/* Execution Options */}
      <div className="execution-section">
        <h3>Execution Settings</h3>
        <label>Workers:</label>
        <input 
          type="number" 
          name="workers"
          value={formData.workers}
          onChange={handleInputChange}
          min="1" 
          max="20"
        />
        
        <label>
          <input 
            type="checkbox" 
            name="executeSql"
            checked={formData.executeSql}
            onChange={handleInputChange}
          /> 
          Execute SQL to Database
        </label>
        <label>
          <input 
            type="checkbox" 
            name="generateSql"
            checked={formData.generateSql}
            onChange={handleInputChange}
          /> 
          Generate SQL Files
        </label>
        
        <label>Base URL:</label>
        <input 
          type="url" 
          name="baseUrl"
          value={formData.baseUrl}
          onChange={handleInputChange}
        />
      </div>

      {/* Action Buttons */}
      <div className="action-section">
        <button 
          onClick={startScraping} 
          className="btn-primary"
          disabled={isRunning}
        >
          {isRunning ? 'Running...' : 'Start Scraping'}
        </button>
        <button 
          onClick={stopScraping} 
          className="btn-danger"
          disabled={!isRunning}
        >
          Stop
        </button>
        <button 
          onClick={clearLogs} 
          className="btn-secondary"
        >
          Clear Logs
        </button>
        <button 
          onClick={downloadResults} 
          className="btn-info"
        >
          Download Results
        </button>
      </div>

      {/* Progress & Status */}
      <div className="status-section">
        <div className="progress-container">
          <div 
            className="progress-bar" 
            style={{ width: `${progress}%` }}
          ></div>
          <span className="progress-text">{progress}% Complete</span>
        </div>
        
        <div className="stats-grid">
          <div className="stat-item">
            <span className="stat-label">Albums Found:</span>
            <span className="stat-value">{stats.albums}</span>
          </div>
          <div className="stat-item">
            <span className="stat-label">Songs Found:</span>
            <span className="stat-value">{stats.songs}</span>
          </div>
          <div className="stat-item">
            <span className="stat-label">Errors:</span>
            <span className="stat-value error">{stats.errors}</span>
          </div>
          <div className="stat-item">
            <span className="stat-label">Status:</span>
            <span className="stat-value">{stats.status}</span>
          </div>
        </div>
      </div>

      {/* Real-time Logs */}
      <div className="logs-section">
        <h3>Live Output</h3>
        <div className="logs-display">
          {logs.map((log, index) => (
            <div key={index} className={`log-entry ${log.level}`}>
              <span className="log-time">{log.timestamp}</span>
              <span className="log-message">{log.message}</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default ScraperDashboard;