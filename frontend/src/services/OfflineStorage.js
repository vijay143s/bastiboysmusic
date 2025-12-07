import { Filesystem, Directory } from '@capacitor/filesystem';

class OfflineStorageService {
  constructor() {
    this.SONGS_DIR = 'downloaded_songs';
    this.METADATA_FILE = 'songs_metadata.json';
  }

  async init() {
    try {
      await Filesystem.mkdir({
        path: this.SONGS_DIR,
        directory: Directory.Data,
        recursive: true
      });
      console.log('✅ Offline storage initialized');
    } catch (error) {
      if (error.message && !error.message.includes('Directory exists')) {
        console.error('Error initializing storage:', error);
      }
    }
  }

  async saveSong(songId, audioBlob, metadata) {
    try {
      const base64Data = await this.blobToBase64(audioBlob);
      const fileName = `${songId}.mp3`;
      const filePath = `${this.SONGS_DIR}/${fileName}`;
      
      await Filesystem.writeFile({
        path: filePath,
        data: base64Data,
        directory: Directory.Data
      });

      await this.saveMetadata(songId, {
        ...metadata,
        fileName,
        filePath,
        downloadedAt: new Date().toISOString(),
        fileSize: audioBlob.size
      });

      console.log(`✅ Song saved: ${metadata.title}`);
      return { songId, fileName, filePath, fileSize: audioBlob.size };
    } catch (error) {
      console.error('Error saving song:', error);
      throw error;
    }
  }

  async getSong(songId) {
    try {
      const fileName = `${songId}.mp3`;
      const filePath = `${this.SONGS_DIR}/${fileName}`;
      const fileUri = await Filesystem.getUri({
        path: filePath,
        directory: Directory.Data
      });
      return fileUri.uri;
    } catch (error) {
      console.error('Error getting song:', error);
      throw error;
    }
  }

  async deleteSong(songId) {
    try {
      const fileName = `${songId}.mp3`;
      const filePath = `${this.SONGS_DIR}/${fileName}`;
      await Filesystem.deleteFile({
        path: filePath,
        directory: Directory.Data
      });
      await this.removeMetadata(songId);
      console.log(`✅ Song deleted: ${songId}`);
    } catch (error) {
      console.error('Error deleting song:', error);
      throw error;
    }
  }

  async isSongDownloaded(songId) {
    try {
      const metadata = await this.getAllMetadata();
      return metadata.hasOwnProperty(songId);
    } catch (error) {
      return false;
    }
  }

  async getAllMetadata() {
    try {
      const result = await Filesystem.readFile({
        path: this.METADATA_FILE,
        directory: Directory.Data,
        encoding: 'utf8'
      });
      return JSON.parse(result.data);
    } catch (error) {
      return {};
    }
  }

  async saveMetadata(songId, metadata) {
    try {
      const allMetadata = await this.getAllMetadata();
      allMetadata[songId] = metadata;
      await Filesystem.writeFile({
        path: this.METADATA_FILE,
        data: JSON.stringify(allMetadata, null, 2),
        directory: Directory.Data,
        encoding: 'utf8'
      });
    } catch (error) {
      console.error('Error saving metadata:', error);
      throw error;
    }
  }

  async removeMetadata(songId) {
    try {
      const allMetadata = await this.getAllMetadata();
      delete allMetadata[songId];
      await Filesystem.writeFile({
        path: this.METADATA_FILE,
        data: JSON.stringify(allMetadata, null, 2),
        directory: Directory.Data,
        encoding: 'utf8'
      });
    } catch (error) {
      console.error('Error removing metadata:', error);
      throw error;
    }
  }

  async getStorageStats() {
    try {
      const metadata = await this.getAllMetadata();
      const songIds = Object.keys(metadata);
      const totalSize = songIds.reduce((sum, id) => {
        return sum + (metadata[id].fileSize || 0);
      }, 0);
      return {
        totalSongs: songIds.length,
        totalSize,
        totalSizeMB: (totalSize / (1024 * 1024)).toFixed(2)
      };
    } catch (error) {
      return { totalSongs: 0, totalSize: 0, totalSizeMB: '0.00' };
    }
  }

  blobToBase64(blob) {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.onloadend = () => {
        const base64 = reader.result.split(',')[1];
        resolve(base64);
      };
      reader.onerror = reject;
      reader.readAsDataURL(blob);
    });
  }
}

export default new OfflineStorageService();
