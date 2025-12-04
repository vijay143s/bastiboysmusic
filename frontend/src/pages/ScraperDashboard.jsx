import React, { useState, useEffect } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { UserData } from '../context/User';

const ScraperDashboard = () => {
  const { user } = UserData();
  const navigate = useNavigate();
  
  // Admin access control - redirect if not admin
  if (user && user.role !== "admin") return navigate("/");

  const [mode, setMode] = useState('');
  const [isRunning, setIsRunning] = useState(false);
  const [isDuplicateRemovalRunning, setIsDuplicateRemovalRunning] = useState(false);
  const [progress, setProgress] = useState(0);
  const [stats, setStats] = useState({
    albums: 0,
    songs: 0,
    errors: 0,
    status: 'Idle'
  });
  const [logs, setLogs] = useState([]);
  const [lastClearTime, setLastClearTime] = useState(0);
  const [consecutiveEmptyPolls, setConsecutiveEmptyPolls] = useState(0);

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
  const [pagalworldForm, setPagalworldForm] = useState({
    articleUrl: '',
    executeSql: true,
    sqlOutput: 'sql_output/pagalworld',
    timeout: 45
  });

  useEffect(() => {
    let pollInterval;
    
    const pollLogs = async () => {
      try {
        const response = await fetch('/api/scrape/logs?lines=50');
        const data = await response.json();
        
        if (data.success) {
          setLogs(data.logs);
          setStats(prev => ({
            ...prev,
            albums: data.stats.albums,
            songs: data.stats.songs,
            errors: data.stats.errors
          }));
          
          // Track consecutive empty polls
          if (data.logs.length === 0 && data.totalLines === 0) {
            setConsecutiveEmptyPolls(prev => prev + 1);
          } else {
            setConsecutiveEmptyPolls(0); // Reset if we got logs
          }
          
          // Determine status based on latest logs
          if (data.logs.length > 0) {
            const latestLog = data.logs[data.logs.length - 1];
            const normalizedMessage = latestLog.message.toLowerCase();
            const completionKeywords = [
              'completed',
              'complete',
              'analysis complete',
              'removal complete',
              'run complete'
            ];
            const hasCompletedKeyword = completionKeywords.some(keyword => normalizedMessage.includes(keyword));
            if (hasCompletedKeyword) {
              setStats(prev => ({ ...prev, status: 'Completed' }));
              setIsRunning(false);
              setIsDuplicateRemovalRunning(false);
              setProgress(100);
            } else if (normalizedMessage.includes('error') || normalizedMessage.includes('exception')) {
              setStats(prev => ({ ...prev, status: 'Error' }));
              setIsRunning(false);
              setIsDuplicateRemovalRunning(false);
            } else if (isRunning || isDuplicateRemovalRunning) {
              const status = isDuplicateRemovalRunning ? 'Removing Duplicates' : 'Scraping';
              setStats(prev => ({ ...prev, status }));
              // Calculate progress based on current stats
              const totalExpected = 10; // Rough estimate
              const currentTotal = data.stats.albums + data.stats.songs;
              setProgress(Math.min(90, (currentTotal / totalExpected) * 100));
            }
          }
        }
      } catch (error) {
        console.error('Error polling logs:', error);
      }
    };

    // Only poll if any operation is running
    if (isRunning || isDuplicateRemovalRunning) {
      // Start immediate poll
      pollLogs();
      
      // Set up regular polling
      let nextPollDelay;
      if (consecutiveEmptyPolls > 5) {
        nextPollDelay = 30000; // Poll every 30s if no activity for a while
      } else if (consecutiveEmptyPolls > 2) {
        nextPollDelay = 10000; // Poll every 10s if no recent activity
      } else {
        nextPollDelay = 1000; // Poll every 1s when actively running
      }
      
      pollInterval = setInterval(pollLogs, nextPollDelay);
    }

    return () => {
      if (pollInterval) {
        clearInterval(pollInterval);
      }
    };
  }, [isRunning, isDuplicateRemovalRunning, consecutiveEmptyPolls]);

  const handleInputChange = (e) => {
    setFormData(prev => ({
      ...prev,
      [e.target.name]: e.target.value
    }));
  };

  const handleCheckboxChange = (e) => {
    setFormData(prev => ({
      ...prev,
      [e.target.name]: e.target.checked
    }));
  };

  const handlePagalworldInputChange = (e) => {
    const { name, value } = e.target;
    setPagalworldForm(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handlePagalworldCheckboxChange = (e) => {
    const { name, checked } = e.target;
    setPagalworldForm(prev => ({
      ...prev,
      [name]: checked
    }));
  };

  const startScraping = async () => {
    if (isRunning || isDuplicateRemovalRunning) {
      alert('Another operation is already running. Please wait until it finishes.');
      return;
    }

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

  const startPagalworldScrape = async () => {
    if (isRunning || isDuplicateRemovalRunning) {
      alert('Another operation is already running. Please wait until it finishes.');
      return;
    }

    if (!pagalworldForm.articleUrl) {
      alert('Please enter a Pagalworld album URL');
      return;
    }

    setIsRunning(true);
    setProgress(0);
    setStats(prev => ({ ...prev, status: 'Pagalworld Scrape Starting...' }));

    const payload = {
      articleUrl: pagalworldForm.articleUrl,
      executeSql: pagalworldForm.executeSql,
      sqlOutput: pagalworldForm.sqlOutput,
      timeout: Number(pagalworldForm.timeout) || undefined
    };

    try {
      const response = await fetch('/api/scrape/pagalworld', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });

      if (!response.ok) {
        const text = await response.text();
        throw new Error(text || `HTTP ${response.status}`);
      }

      const result = await response.json();
      setLogs(prev => [...prev.slice(-99), {
        timestamp: new Date().toLocaleTimeString(),
        message: result.message || 'Pagalworld scraping started',
        level: 'info'
      }]);
    } catch (error) {
      setIsRunning(false);
      setStats(prev => ({ ...prev, status: 'Error' }));
      setLogs(prev => [...prev.slice(-99), {
        timestamp: new Date().toLocaleTimeString(),
        message: `Pagalworld start failed: ${error.message}`,
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

  const handleRemoveDuplicates = async (dryRun = true) => {
    if (isRunning || isDuplicateRemovalRunning) {
      alert('Cannot remove duplicates while another operation is running');
      return;
    }

    const confirmMessage = dryRun 
      ? 'This will analyze the database for duplicate records without removing them. Continue?'
      : 'This will permanently remove duplicate records from all tables. This action cannot be undone! Continue?';
    
    if (!confirm(confirmMessage)) {
      return;
    }

    try {
      // Set running status
      setIsDuplicateRemovalRunning(true);
      setProgress(0);
      setStats(prev => ({ ...prev, status: dryRun ? 'Analyzing Duplicates' : 'Removing Duplicates' }));
      
      setLogs(prev => [...prev.slice(-99), {
        timestamp: new Date().toLocaleTimeString(),
        message: dryRun ? 'Starting duplicate analysis (dry run)...' : 'Starting duplicate removal...',
        level: 'info'
      }]);

      const response = await fetch('/api/scrape/remove-duplicates', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ dryRun })
      });

      const result = await response.json();
      
      if (!response.ok) {
        setIsDuplicateRemovalRunning(false);
        setStats(prev => ({ ...prev, status: 'Error' }));
        throw new Error(result.message || 'Failed to start duplicate removal');
      }

      setLogs(prev => [...prev.slice(-99), {
        timestamp: new Date().toLocaleTimeString(),
        message: result.message,
        level: 'info'
      }]);

    } catch (error) {
      setLogs(prev => [...prev.slice(-99), {
        timestamp: new Date().toLocaleTimeString(),
        message: `Duplicate removal failed: ${error.message}`,
        level: 'error'
      }]);
    }
  };

  const clearLogs = async () => {
    try {
      // Clear logs on backend
      const response = await fetch('/api/scrape/clear-logs', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' }
      });
      
      if (response.ok) {
        // Clear frontend state
        setLogs([]);
        setStats(prev => ({
          ...prev,
          albums: 0,
          songs: 0,
          errors: 0,
          status: 'Idle'
        }));
        setProgress(0);
        setLastClearTime(Date.now());
        setConsecutiveEmptyPolls(0);
      } else {
        console.error('Failed to clear logs on backend');
      }
    } catch (error) {
      console.error('Error clearing logs:', error);
      // Still clear frontend state even if backend fails
      setLogs([]);
    }
  };

  const downloadResults = async () => {
    try {
      const response = await fetch('/api/scrape/results');
      const blob = await response.blob();
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `scraper-results-${new Date().toISOString().split('T')[0]}.zip`;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(url);
    } catch (error) {
      console.error('Failed to download results:', error);
    }
  };

  return (
    <div className="min-h-screen bg-[#0a0a0a] text-white p-6">
      <div className="max-w-7xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex justify-between items-center mb-8">
          <h1 className="text-3xl font-bold bg-gradient-to-r from-green-400 to-blue-500 bg-clip-text text-transparent">
            Telugu Songs Scraper Dashboard
          </h1>
          <div className="flex items-center gap-4">
            <Link
              to="/admin"
              className="bg-gray-600 hover:bg-gray-500 text-white font-bold py-2 px-4 rounded-lg transition-colors"
            >
              Back to Admin
            </Link>
            <div className={`px-3 py-1 rounded-full text-sm font-medium ${
              stats.status === 'Idle' ? 'bg-gray-600' :
              stats.status.includes('Error') ? 'bg-red-600' :
              isRunning ? 'bg-green-600 animate-pulse' : 'bg-blue-600'
            }`}>
              {stats.status}
            </div>
          </div>
        </div>
        
        {/* Mode Selection */}
        <div className="bg-[#181818] rounded-lg p-6 border border-gray-700">
          <h3 className="text-xl font-bold mb-4 text-green-400">Scraping Mode</h3>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            {[
              { value: 'single', label: 'Single Article' },
              { value: 'incremental', label: 'Incremental' },
              { value: 'year', label: 'Year Range' },
              { value: 'full', label: 'Full Reload' }
            ].map(({ value, label }) => (
              <label key={value} className={`flex items-center space-x-3 p-4 bg-[#212121] rounded-lg border cursor-pointer transition-colors ${
                mode === value ? 'border-green-400 bg-green-400/10' : 'border-gray-600 hover:border-green-400'
              }`}>
                <input 
                  type="radio" 
                  name="mode" 
                  value={value}
                  checked={mode === value}
                  onChange={(e) => setMode(e.target.value)}
                  className="text-green-500 focus:ring-green-500"
                /> 
                <span className="text-sm font-medium">{label}</span>
              </label>
            ))}
          </div>
        </div>

        {/* Dynamic Input Fields */}
        {mode && (
          <div className="bg-[#181818] rounded-lg p-6 border border-gray-700 space-y-4">
            <h3 className="text-xl font-bold mb-4 text-blue-400">Configuration</h3>
            
            {/* Single Article Mode */}
            {mode === 'single' && (
              <div>
                <label className="block text-sm font-medium text-gray-300 mb-2">Article URL</label>
                <input 
                  type="url" 
                  name="articleUrl"
                  value={formData.articleUrl}
                  onChange={handleInputChange}
                  placeholder="https://sensongsmp3.live/..."
                  className="w-full p-3 bg-[#212121] border border-gray-600 rounded-lg text-white placeholder-gray-400 focus:border-green-400 focus:outline-none"
                />
              </div>
            )}

            {/* Year Mode */}
            {mode === 'year' && (
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-300 mb-2">Start Year</label>
                  <input 
                    type="number" 
                    name="year"
                    value={formData.year}
                    onChange={handleInputChange}
                    min="1950" 
                    max="2025" 
                    placeholder="1995"
                    className="w-full p-3 bg-[#212121] border border-gray-600 rounded-lg text-white placeholder-gray-400 focus:border-green-400 focus:outline-none"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-300 mb-2">End Year</label>
                  <input 
                    type="number" 
                    name="endYear"
                    value={formData.endYear}
                    onChange={handleInputChange}
                    min="1950" 
                    max="2025" 
                    placeholder="2025"
                    className="w-full p-3 bg-[#212121] border border-gray-600 rounded-lg text-white placeholder-gray-400 focus:border-green-400 focus:outline-none"
                  />
                </div>
              </div>
            )}

            {/* Common Settings */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-300 mb-2">Max Pages</label>
                <input 
                  type="number" 
                  name="maxPages"
                  value={formData.maxPages}
                  onChange={handleInputChange}
                  min="1" 
                  max="1000"
                  className="w-full p-3 bg-[#212121] border border-gray-600 rounded-lg text-white placeholder-gray-400 focus:border-green-400 focus:outline-none"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-300 mb-2">Tags</label>
                <input 
                  type="text" 
                  name="tags"
                  value={formData.tags}
                  onChange={handleInputChange}
                  placeholder="Optional tags"
                  className="w-full p-3 bg-[#212121] border border-gray-600 rounded-lg text-white placeholder-gray-400 focus:border-green-400 focus:outline-none"
                />
              </div>
            </div>

            <div className="flex flex-wrap gap-6">
              <label className="flex items-center space-x-3 cursor-pointer">
                <input 
                  type="checkbox"
                  name="autoDiscover"
                  checked={formData.autoDiscover}
                  onChange={handleCheckboxChange}
                  className="w-4 h-4 text-green-500 focus:ring-green-500 focus:ring-2"
                />
                <span className="text-sm font-medium text-gray-300">Auto Discover</span>
              </label>
              <label className="flex items-center space-x-3 cursor-pointer">
                <input 
                  type="checkbox"
                  name="truncate"
                  checked={formData.truncate}
                  onChange={handleCheckboxChange}
                  className="w-4 h-4 text-green-500 focus:ring-green-500 focus:ring-2"
                />
                <span className="text-sm font-medium text-gray-300">Truncate Data</span>
              </label>
            </div>
          </div>
        )}

        {/* Execution Settings */}
        <div className="bg-[#181818] rounded-lg p-6 border border-gray-700 space-y-4">
          <h3 className="text-xl font-bold mb-4 text-purple-400">Execution Settings</h3>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-300 mb-2">Workers</label>
              <input 
                type="number" 
                name="workers"
                value={formData.workers}
                onChange={handleInputChange}
                min="1" 
                max="20"
                className="w-full p-3 bg-[#212121] border border-gray-600 rounded-lg text-white placeholder-gray-400 focus:border-green-400 focus:outline-none"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-300 mb-2">Base URL</label>
              <input 
                type="url" 
                name="baseUrl"
                value={formData.baseUrl}
                onChange={handleInputChange}
                placeholder="https://sensongsmp3.live/"
                className="w-full p-3 bg-[#212121] border border-gray-600 rounded-lg text-white placeholder-gray-400 focus:border-green-400 focus:outline-none"
              />
            </div>
          </div>

          <div className="flex flex-wrap gap-6">
            <label className="flex items-center space-x-3 cursor-pointer">
              <input 
                type="checkbox"
                name="executeSql"
                checked={formData.executeSql}
                onChange={handleCheckboxChange}
                className="w-4 h-4 text-green-500 focus:ring-green-500 focus:ring-2"
              />
              <span className="text-sm font-medium text-gray-300">Execute SQL to Database</span>
            </label>
            <label className="flex items-center space-x-3 cursor-pointer">
              <input 
                type="checkbox"
                name="generateSql"
                checked={formData.generateSql}
                onChange={handleCheckboxChange}
                className="w-4 h-4 text-green-500 focus:ring-green-500 focus:ring-2"
              />
              <span className="text-sm font-medium text-gray-300">Generate SQL Files</span>
            </label>
          </div>
        </div>

        {/* Pagalworld Quick Run */}
        <div className="bg-[#181818] rounded-lg p-6 border border-gray-700 space-y-4">
          <div className="flex justify-between items-center flex-wrap gap-4">
            <h3 className="text-xl font-bold text-pink-400">Pagalworld Single Run</h3>
            <button
              onClick={startPagalworldScrape}
              disabled={isRunning || isDuplicateRemovalRunning}
              className="px-5 py-2 bg-pink-600 hover:bg-pink-700 disabled:bg-gray-600 disabled:cursor-not-allowed text-white font-semibold rounded-lg transition-colors"
            >
              {isRunning ? 'Processing...' : 'Start Pagalworld Scrape'}
            </button>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">Pagalworld Album URL</label>
            <input
              type="url"
              name="articleUrl"
              value={pagalworldForm.articleUrl}
              onChange={handlePagalworldInputChange}
              placeholder="https://pagalworldmusic.com/..."
              className="w-full p-3 bg-[#212121] border border-gray-600 rounded-lg text-white placeholder-gray-400 focus:border-pink-400 focus:outline-none"
            />
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-300 mb-2">SQL Output Folder</label>
              <input
                type="text"
                name="sqlOutput"
                value={pagalworldForm.sqlOutput}
                onChange={handlePagalworldInputChange}
                className="w-full p-3 bg-[#212121] border border-gray-600 rounded-lg text-white placeholder-gray-400 focus:border-pink-400 focus:outline-none"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-300 mb-2">Request Timeout (seconds)</label>
              <input
                type="number"
                min="10"
                max="120"
                name="timeout"
                value={pagalworldForm.timeout}
                onChange={handlePagalworldInputChange}
                className="w-full p-3 bg-[#212121] border border-gray-600 rounded-lg text-white placeholder-gray-400 focus:border-pink-400 focus:outline-none"
              />
            </div>
          </div>

          <label className="flex items-center space-x-3 cursor-pointer">
            <input
              type="checkbox"
              name="executeSql"
              checked={pagalworldForm.executeSql}
              onChange={handlePagalworldCheckboxChange}
              className="w-4 h-4 text-pink-500 focus:ring-pink-500 focus:ring-2"
            />
            <span className="text-sm font-medium text-gray-300">Execute generated SQL automatically</span>
          </label>

          <p className="text-xs text-gray-400">
            Use this panel for pagalworldmusic.com links. The scraper automatically handles Pagalworld-specific HTML structure and logs full album/song details before SQL generation.
          </p>
        </div>

        {/* Action Buttons */}
        <div className="flex flex-wrap gap-4 justify-center">
          <button 
            onClick={startScraping} 
            disabled={isRunning || !mode}
            className="px-6 py-3 bg-green-600 hover:bg-green-700 disabled:bg-gray-600 disabled:cursor-not-allowed text-white font-bold rounded-lg transition-colors flex items-center space-x-2"
          >
            <span>{isRunning ? 'Running...' : 'Start Scraping'}</span>
            {isRunning && <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>}
          </button>
          <button 
            onClick={stopScraping} 
            disabled={!isRunning}
            className="px-6 py-3 bg-red-600 hover:bg-red-700 disabled:bg-gray-600 disabled:cursor-not-allowed text-white font-bold rounded-lg transition-colors"
          >
            Stop
          </button>
          <button 
            onClick={clearLogs} 
            className="px-6 py-3 bg-gray-600 hover:bg-gray-700 text-white font-bold rounded-lg transition-colors"
          >
            Clear Logs
          </button>
          <button 
            onClick={downloadResults} 
            className="px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded-lg transition-colors"
          >
            Download Results
          </button>
        </div>

        {/* Database Maintenance */}
        <div className="bg-[#181818] rounded-lg p-6 border border-gray-700 space-y-4">
          <h3 className="text-xl font-bold mb-4 text-purple-400">Database Maintenance</h3>
          <p className="text-gray-300 text-sm mb-4">
            Remove duplicate records from all tables. Keeps oldest entries (lowest ID) and removes newer duplicates.
            Analyzes: Songs, Albums, Artists, Singers, and Music Directors.
          </p>
          
          <div className="flex flex-wrap gap-3 justify-center">
            <button 
              onClick={() => handleRemoveDuplicates(true)} 
              disabled={isRunning || isDuplicateRemovalRunning}
              className="px-4 py-2 bg-blue-600 hover:bg-blue-700 disabled:bg-gray-600 disabled:cursor-not-allowed text-white font-medium rounded-lg transition-colors"
            >
              {isDuplicateRemovalRunning ? 'Running...' : 'Preview Duplicates (Dry Run)'}
            </button>
            <button 
              onClick={() => handleRemoveDuplicates(false)} 
              disabled={isRunning || isDuplicateRemovalRunning}
              className="px-4 py-2 bg-orange-600 hover:bg-red-600 disabled:bg-gray-600 disabled:cursor-not-allowed text-white font-medium rounded-lg transition-colors"
            >
              {isDuplicateRemovalRunning ? 'Running...' : 'Remove Duplicates'}
            </button>
          </div>
          
          <div className="text-xs text-gray-400 text-center mt-2">
            ⚠️ Duplicate removal cannot be undone. Always run dry run first!
          </div>
        </div>

        {/* Progress & Status */}
        <div className="bg-[#181818] rounded-lg p-6 border border-gray-700">
          <h3 className="text-xl font-bold mb-4 text-yellow-400">Progress & Statistics</h3>
          
          {/* Progress Bar */}
          <div className="mb-6">
            <div className="flex justify-between items-center mb-2">
              <span className="text-sm text-gray-300">Overall Progress</span>
              <span className="text-sm text-gray-300">{progress}% Complete</span>
            </div>
            <div className="w-full bg-gray-700 rounded-full h-3">
              <div 
                className="bg-gradient-to-r from-green-400 to-blue-500 h-3 rounded-full transition-all duration-300 ease-out"
                style={{ width: `${progress}%` }}
              ></div>
            </div>
          </div>
          
          {/* Stats Grid */}
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <div className="bg-[#212121] p-4 rounded-lg border border-gray-600">
              <div className="text-2xl font-bold text-blue-400">{stats.albums}</div>
              <div className="text-sm text-gray-400">Albums Found</div>
            </div>
            <div className="bg-[#212121] p-4 rounded-lg border border-gray-600">
              <div className="text-2xl font-bold text-green-400">{stats.songs}</div>
              <div className="text-sm text-gray-400">Songs Found</div>
            </div>
            <div className="bg-[#212121] p-4 rounded-lg border border-gray-600">
              <div className="text-2xl font-bold text-red-400">{stats.errors}</div>
              <div className="text-sm text-gray-400">Errors</div>
            </div>
            <div className="bg-[#212121] p-4 rounded-lg border border-gray-600">
              <div className={`text-2xl font-bold ${
                stats.status === 'Running' || stats.status === 'Removing Duplicates' || stats.status === 'Analyzing Duplicates' 
                  ? 'text-yellow-400' 
                  : stats.status === 'Completed' 
                    ? 'text-green-400' 
                    : stats.status === 'Error' 
                      ? 'text-red-400' 
                      : 'text-purple-400'
              }`}>
                {stats.status}
              </div>
              <div className="text-sm text-gray-400">Status</div>
            </div>
          </div>
        </div>

        {/* Real-time Logs */}
        <div className="bg-[#181818] rounded-lg p-6 border border-gray-700">
          <h3 className="text-xl font-bold mb-4 text-cyan-400">Live Output</h3>
          <div className="bg-[#0a0a0a] rounded-lg p-4 h-80 overflow-y-auto border border-gray-600">
            {logs.length === 0 ? (
              <div className="text-gray-400 text-center py-8">
                No logs yet. Start scraping to see live output...
              </div>
            ) : (
              logs.map((log, index) => (
                <div key={index} className={`mb-2 text-sm ${
                  log.level === 'error' ? 'text-red-400' :
                  log.level === 'warning' ? 'text-yellow-400' :
                  log.level === 'success' ? 'text-green-400' :
                  'text-gray-300'
                }`}>
                  <span className="text-gray-500 mr-2">[{log.timestamp}]</span>
                  <span>{log.message}</span>
                </div>
              ))
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default ScraperDashboard;