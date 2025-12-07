const jwt = require('jsonwebtoken');
const crypto = require('crypto');

/**
 * Download Controller
 * Handles signed download URLs and download tracking
 */

/**
 * Generate signed download URL for a song
 * GET /api/song/:id/download-url
 */
exports.getDownloadUrl = async (req, res) => {
    try {
        const { id: songId } = req.params;
        const userId = req.user._id;

        // Get song details from database
        const [songs] = await req.db.query(
            'SELECT * FROM songs WHERE _id = ?',
            [songId]
        );

        if (!songs || songs.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Song not found'
            });
        }

        const song = songs[0];
        const audioUrl = song.audio_url;

        if (!audioUrl) {
            return res.status(404).json({
                success: false,
                message: 'Audio file not available'
            });
        }

        // Generate signed URL with expiration (1 hour)
        const expiresAt = new Date(Date.now() + 60 * 60 * 1000); // 1 hour from now
        const expiresAtTimestamp = Math.floor(expiresAt.getTime() / 1000);

        // Create signature
        const payload = {
            songId,
            userId,
            audioUrl,
            exp: expiresAtTimestamp
        };

        const signature = jwt.sign(payload, process.env.Jwt_secret);

        // For external URLs (Cloudinary, etc.), return the original URL with signature as query param
        // For internal URLs, you could proxy through your server with signature validation

        const signedUrl = `${audioUrl}${audioUrl.includes('?') ? '&' : '?'}token=${signature}`;

        res.json({
            success: true,
            downloadUrl: audioUrl, // Use original URL (Cloudinary handles security)
            signedUrl, // Optional: use this if you want to add extra security layer
            expiresAt: expiresAt.toISOString(),
            expiresAtTimestamp
        });

    } catch (error) {
        console.error('Error generating download URL:', error);
        res.status(500).json({
            success: false,
            message: 'Failed to generate download URL',
            error: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }
};

/**
 * Mark song as downloaded for user
 * POST /api/song/:id/mark-downloaded
 */
exports.markDownloaded = async (req, res) => {
    try {
        const { id: songId } = req.params;
        const userId = req.user._id;

        // Check if song exists
        const [songs] = await req.db.query(
            'SELECT _id FROM songs WHERE _id = ?',
            [songId]
        );

        if (!songs || songs.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Song not found'
            });
        }

        // Create downloads table if it doesn't exist
        await req.db.query(`
      CREATE TABLE IF NOT EXISTS user_downloads (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id VARCHAR(255) NOT NULL,
        song_id VARCHAR(255) NOT NULL,
        downloaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE KEY unique_user_song (user_id, song_id),
        INDEX idx_user_id (user_id),
        INDEX idx_song_id (song_id)
      )
    `);

        // Insert or update download record
        await req.db.query(
            `INSERT INTO user_downloads (user_id, song_id, downloaded_at)
       VALUES (?, ?, NOW())
       ON DUPLICATE KEY UPDATE downloaded_at = NOW()`,
            [userId, songId]
        );

        res.json({
            success: true,
            message: 'Song marked as downloaded'
        });

    } catch (error) {
        console.error('Error marking song as downloaded:', error);
        res.status(500).json({
            success: false,
            message: 'Failed to mark song as downloaded',
            error: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }
};

/**
 * Get user's downloaded songs
 * GET /api/song/downloads
 */
exports.getUserDownloads = async (req, res) => {
    try {
        const userId = req.user._id;

        const [downloads] = await req.db.query(
            `SELECT 
        ud.song_id,
        ud.downloaded_at,
        s.title,
        s.singer,
        s.thumbnail_url
      FROM user_downloads ud
      LEFT JOIN songs s ON ud.song_id = s._id
      WHERE ud.user_id = ?
      ORDER BY ud.downloaded_at DESC`,
            [userId]
        );

        res.json({
            success: true,
            downloads
        });

    } catch (error) {
        console.error('Error fetching user downloads:', error);
        res.status(500).json({
            success: false,
            message: 'Failed to fetch downloads',
            error: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }
};

/**
 * Remove download record
 * DELETE /api/song/:id/download
 */
exports.removeDownload = async (req, res) => {
    try {
        const { id: songId } = req.params;
        const userId = req.user._id;

        await req.db.query(
            'DELETE FROM user_downloads WHERE user_id = ? AND song_id = ?',
            [userId, songId]
        );

        res.json({
            success: true,
            message: 'Download record removed'
        });

    } catch (error) {
        console.error('Error removing download:', error);
        res.status(500).json({
            success: false,
            message: 'Failed to remove download',
            error: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }
};
