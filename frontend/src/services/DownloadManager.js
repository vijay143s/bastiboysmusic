import OfflineStorage from './OfflineStorage.js';
import axios from 'axios';

class DownloadManager {
  constructor() {
    this.queue = [];
    this.activeDownloads = new Map();
    this.maxConcurrent = 2;
    this.listeners = new Map();
  }

  async addToQueue(song) {
    const songId = song._id || song.id;
    const isDownloaded = await OfflineStorage.isSongDownloaded(songId);
    if (isDownloaded) {
      this.emit('already-downloaded', { songId });
      return;
    }
    if (this.isInQueue(songId) || this.activeDownloads.has(songId)) {
      this.emit('already-in-queue', { songId });
      return;
    }
    this.queue.push({ songId, song, status: 'queued', progress: 0, error: null, retryCount: 0 });
    this.emit('added-to-queue', { songId, song });
    this.processQueue();
  }

  async processQueue() {
    while (this.activeDownloads.size < this.maxConcurrent && this.queue.length > 0) {
      const item = this.queue.shift();
      await this.startDownload(item);
    }
  }

  async startDownload(item) {
    const { songId, song } = item;
    try {
      this.activeDownloads.set(songId, { ...item, status: 'downloading', abortController: new AbortController() });
      this.emit('download-started', { songId, song });

      const { data: urlData } = await axios.get(`/api/song/${songId}/download-url`);
      const downloadUrl = urlData.downloadUrl;

      const audioBlob = await this.downloadWithProgress(downloadUrl, songId, this.activeDownloads.get(songId).abortController);

      await OfflineStorage.saveSong(songId, audioBlob, {
        _id: songId,
        title: song.title,
        singer: song.singer,
        albumName: song.albumName,
        thumbnail: song.thumbnail || song.albumThumbnail,
        duration: song.duration
      });

      try {
        await axios.post(`/api/song/${songId}/mark-downloaded`);
      } catch (error) {
        console.warn('Failed to mark song as downloaded on backend:', error);
      }

      this.activeDownloads.delete(songId);
      this.emit('download-completed', { songId, song });
      this.processQueue();
    } catch (error) {
      console.error('Download error:', error);
      const activeItem = this.activeDownloads.get(songId);
      if (error.name === 'AbortError' || error.message === 'cancelled') {
        this.activeDownloads.delete(songId);
        this.emit('download-cancelled', { songId, song });
        this.processQueue();
        return;
      }
      if (activeItem && activeItem.retryCount < 3) {
        activeItem.retryCount++;
        activeItem.status = 'queued';
        activeItem.error = error.message;
        this.activeDownloads.delete(songId);
        this.queue.unshift(activeItem);
        this.emit('download-retry', { songId, song, retryCount: activeItem.retryCount });
        setTimeout(() => this.processQueue(), 2000);
      } else {
        this.activeDownloads.delete(songId);
        this.emit('download-failed', { songId, song, error: error.message });
        this.processQueue();
      }
    }
  }

  async downloadWithProgress(url, songId, abortController) {
    const response = await fetch(url, { signal: abortController.signal });
    if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
    const contentLength = response.headers.get('content-length');
    const total = parseInt(contentLength, 10);
    let loaded = 0;
    const reader = response.body.getReader();
    const chunks = [];
    while (true) {
      const { done, value } = await reader.read();
      if (done) break;
      chunks.push(value);
      loaded += value.length;
      const progress = total ? Math.round((loaded / total) * 100) : 0;
      const activeItem = this.activeDownloads.get(songId);
      if (activeItem) activeItem.progress = progress;
      this.emit('download-progress', { songId, progress, loaded, total });
    }
    return new Blob(chunks, { type: 'audio/mpeg' });
  }

  cancelDownload(songId) {
    const activeItem = this.activeDownloads.get(songId);
    if (activeItem && activeItem.abortController) {
      activeItem.abortController.abort();
      return;
    }
    const queueIndex = this.queue.findIndex(item => item.songId === songId);
    if (queueIndex !== -1) {
      const item = this.queue.splice(queueIndex, 1)[0];
      this.emit('download-cancelled', { songId, song: item.song });
    }
  }

  async retryDownload(songId, song) {
    this.activeDownloads.delete(songId);
    const queueIndex = this.queue.findIndex(item => item.songId === songId);
    if (queueIndex !== -1) this.queue.splice(queueIndex, 1);
    await this.addToQueue(song);
  }

  isInQueue(songId) {
    return this.queue.some(item => item.songId === songId);
  }

  getDownloadStatus(songId) {
    if (this.activeDownloads.has(songId)) {
      const item = this.activeDownloads.get(songId);
      return { status: item.status, progress: item.progress, retryCount: item.retryCount };
    }
    const queueItem = this.queue.find(item => item.songId === songId);
    if (queueItem) return { status: 'queued', progress: 0, position: this.queue.indexOf(queueItem) + 1 };
    return null;
  }

  on(event, callback) {
    if (!this.listeners.has(event)) this.listeners.set(event, []);
    this.listeners.get(event).push(callback);
  }

  off(event, callback) {
    if (!this.listeners.has(event)) return;
    const callbacks = this.listeners.get(event);
    const index = callbacks.indexOf(callback);
    if (index !== -1) callbacks.splice(index, 1);
  }

  emit(event, data) {
    if (!this.listeners.has(event)) return;
    this.listeners.get(event).forEach(callback => {
      try {
        callback(data);
      } catch (error) {
        console.error(`Error in ${event} listener:`, error);
      }
    });
  }
}

export default new DownloadManager();
