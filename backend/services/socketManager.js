const EventEmitter = require('events');

class SocketManager extends EventEmitter {
  constructor(io) {
    super();
    this.io = io;
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
          console.log('Client joining scraper-updates room:', socket.id);
          socket.join('scraper-updates');
          socket.emit('joined-scraper', { room: 'scraper-updates' });
          console.log('Client joined scraper-updates room successfully:', socket.id);
        });

        socket.on('test-message', (message) => {
          console.log('Received test message from frontend:', message);
          socket.emit('test-response', 'Backend received your message');
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



  // Broadcast log message to all connected clients
  broadcastLog(message) {
    const data = {
      type: 'log',
      message: message.trim(),
      timestamp: new Date().toISOString()
    };

    console.log('Broadcasting log to scraper-updates room:', data.message.substring(0, 100) + '...');

    // Send to WebSocket clients
    if (this.io) {
      const room = this.io.sockets.adapter.rooms.get('scraper-updates');
      const clientCount = room ? room.size : 0;
      console.log(`Broadcasting to ${clientCount} clients in scraper-updates room`);
      this.io.to('scraper-updates').emit('log', data);
    }
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
  }

  // Get connected clients count
  getClientCount() {
    return {
      websocket: this.socketClients.size,
      total: this.socketClients.size
    };
  }

  // Close all connections
  closeAllConnections() {
    // WebSocket connections will be closed by socket.io automatically
    this.socketClients.clear();
  }
}

module.exports = SocketManager;