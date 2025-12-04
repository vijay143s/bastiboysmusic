const EventEmitter = require('events');

class SocketManager extends EventEmitter {
  constructor(io) {
    super();
    this.io = io;
    this.sseClients = new Map(); // For Server-Sent Events clients
    this.socketClients = new Set(); // For WebSocket clients
    this.setupSocketHandlers();
  }

  setupSocketHandlers() {
    if (this.io) {
      this.io.on('connection', (socket) => {
        console.log('Client connected via WebSocket:', socket.id);
        this.socketClients.add(socket);

        // Handle client events
        socket.on('join-scraper', () => {
          socket.join('scraper-updates');
          socket.emit('joined', { room: 'scraper-updates' });
        });

        socket.on('disconnect', () => {
          console.log('Client disconnected:', socket.id);
          this.socketClients.delete(socket);
        });

        // Send initial status when client connects
        socket.emit('status', this.getInitialStatus());
      });
    }
  }

  // Add SSE client for /api/scrape/logs endpoint
  addSSEClient(clientId, response) {
    this.sseClients.set(clientId, response);
    console.log(`SSE client added: ${clientId}`);
  }

  // Remove SSE client
  removeSSEClient(clientId) {
    if (this.sseClients.has(clientId)) {
      this.sseClients.delete(clientId);
      console.log(`SSE client removed: ${clientId}`);
    }
  }

  // Broadcast log message to all connected clients
  broadcastLog(message) {
    const data = {
      type: 'log',
      message: message.trim(),
      timestamp: new Date().toISOString()
    };

    // Send to WebSocket clients
    if (this.io) {
      this.io.to('scraper-updates').emit('log', data);
    }

    // Send to SSE clients
    this.broadcastToSSE(data);
  }

  // Broadcast statistics update
  broadcastStats(stats) {
    const data = {
      type: 'stats',
      stats,
      timestamp: new Date().toISOString()
    };

    // Send to WebSocket clients
    if (this.io) {
      this.io.to('scraper-updates').emit('stats', data);
    }

    // Send to SSE clients
    this.broadcastToSSE(data);
  }

  // Broadcast progress update
  broadcastProgress(progress) {
    const data = {
      type: 'progress',
      progress,
      timestamp: new Date().toISOString()
    };

    // Send to WebSocket clients
    if (this.io) {
      this.io.to('scraper-updates').emit('progress', data);
    }

    // Send to SSE clients
    this.broadcastToSSE(data);
  }

  // Broadcast error message
  broadcastError(error) {
    const data = {
      type: 'error',
      error: error.toString(),
      timestamp: new Date().toISOString()
    };

    // Send to WebSocket clients
    if (this.io) {
      this.io.to('scraper-updates').emit('error', data);
    }

    // Send to SSE clients
    this.broadcastToSSE(data);
  }

  // Broadcast completion status
  broadcastComplete(code) {
    const data = {
      type: 'complete',
      exitCode: code,
      message: code === 0 ? 'Scraping completed successfully' : 'Scraping failed',
      timestamp: new Date().toISOString()
    };

    // Send to WebSocket clients
    if (this.io) {
      this.io.to('scraper-updates').emit('complete', data);
    }

    // Send to SSE clients
    this.broadcastToSSE(data);
  }

  // Broadcast current task update
  broadcastTask(task) {
    const data = {
      type: 'task',
      task,
      timestamp: new Date().toISOString()
    };

    // Send to WebSocket clients
    if (this.io) {
      this.io.to('scraper-updates').emit('task', data);
    }

    // Send to SSE clients
    this.broadcastToSSE(data);
  }

  // Send data to all SSE clients
  broadcastToSSE(data) {
    const message = `data: ${JSON.stringify(data)}\n\n`;
    
    this.sseClients.forEach((response, clientId) => {
      try {
        response.write(message);
      } catch (error) {
        console.error(`Error sending SSE to client ${clientId}:`, error);
        this.removeSSEClient(clientId);
      }
    });
  }

  // Get initial status for new connections
  getInitialStatus() {
    return {
      type: 'status',
      isRunning: false,
      progress: 0,
      stats: { albums: 0, songs: 0, errors: 0 },
      currentTask: 'Idle',
      timestamp: new Date().toISOString()
    };
  }

  // Send system notification
  broadcastNotification(message, type = 'info') {
    const data = {
      type: 'notification',
      message,
      notificationType: type, // 'info', 'success', 'warning', 'error'
      timestamp: new Date().toISOString()
    };

    // Send to WebSocket clients
    if (this.io) {
      this.io.emit('notification', data);
    }

    // Send to SSE clients
    this.broadcastToSSE(data);
  }

  // Get connected clients count
  getClientCount() {
    return {
      websocket: this.socketClients.size,
      sse: this.sseClients.size,
      total: this.socketClients.size + this.sseClients.size
    };
  }

  // Close all connections
  closeAllConnections() {
    // Close SSE connections
    this.sseClients.forEach((response, clientId) => {
      try {
        response.write('data: {"type": "close", "message": "Server shutting down"}\n\n');
        response.end();
      } catch (error) {
        console.error(`Error closing SSE client ${clientId}:`, error);
      }
    });
    this.sseClients.clear();

    // WebSocket connections will be closed by socket.io automatically
    this.socketClients.clear();
  }
}

module.exports = SocketManager;