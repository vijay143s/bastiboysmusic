// frontend/scraper-ui.js
class ScraperUI {
  constructor() {
    this.isRunning = false;
    this.eventSource = null;
    this.bindEvents();
  }

  bindEvents() {
    document.getElementById('start-scraping').onclick = () => this.startScraping();
    document.getElementById('stop-scraping').onclick = () => this.stopScraping();
    
    // Mode switching
    document.querySelectorAll('input[name="mode"]').forEach(radio => {
      radio.onchange = (e) => this.switchMode(e.target.value);
    });
  }

  async startScraping() {
    const options = this.collectFormData();
    
    try {
      const response = await fetch('/api/scrape/start', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(options)
      });

      if (response.ok) {
        this.startLiveUpdates();
        this.toggleButtons(true);
      }
    } catch (error) {
      console.error('Error starting scraper:', error);
    }
  }

  collectFormData() {
    const mode = document.querySelector('input[name="mode"]:checked').value;
    const options = { mode };

    // Collect mode-specific inputs
    if (mode === 'single') {
      options.articleUrl = document.getElementById('article-url').value;
    } else if (mode === 'year') {
      options.year = parseInt(document.getElementById('year').value);
    }
    // ... etc for other modes

    options.workers = parseInt(document.getElementById('workers').value);
    options.executeSql = document.getElementById('execute-sql').checked;

    return options;
  }

  startLiveUpdates() {
    this.eventSource = new EventSource('/api/scrape/logs');
    
    this.eventSource.onmessage = (event) => {
      const data = JSON.parse(event.data);
      this.updateUI(data);
    };
  }

  updateUI(data) {
    if (data.type === 'log') {
      this.appendLog(data.message);
    } else if (data.type === 'stats') {
      this.updateStats(data.stats);
    } else if (data.type === 'progress') {
      this.updateProgress(data.progress);
    }
  }
}

// Initialize when DOM loads
document.addEventListener('DOMContentLoaded', () => {
  new ScraperUI();
});