const express = require('express');
const router = express.Router();
const mysql = require('mysql2/promise');
const dotenv = require('dotenv');
const path = require('path');

// Load environment variables
dotenv.config({ path: path.resolve(__dirname, '../.env') });

// Database connection config
const dbConfig = {
  host: process.env.MYSQL_HOST,
  port: Number(process.env.MYSQL_PORT),
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DATABASE,
  connectionLimit: 10
};

// Create connection pool
const pool = mysql.createPool(dbConfig);

// GET /api/database/stats
router.get('/stats', async (req, res) => {
  try {
    const connection = await pool.getConnection();

    try {
      // Get total counts
      const [albumsResult] = await connection.query('SELECT COUNT(*) as total FROM albums');
      const [songsResult] = await connection.query('SELECT COUNT(*) as total FROM songs');
      const [artistsResult] = await connection.query('SELECT COUNT(*) as total FROM artists');
      const [singersResult] = await connection.query('SELECT COUNT(*) as total FROM singers');
      const [directorsResult] = await connection.query('SELECT COUNT(*) as total FROM music_directors');

      // Get recent albums (last 10)
      const [recentAlbums] = await connection.query(`
        SELECT id, title, year, director, music_director, created_at,
               (SELECT COUNT(*) FROM songs WHERE album_id = albums.id) as song_count
        FROM albums 
        ORDER BY created_at DESC 
        LIMIT 10
      `);

      // Get year distribution
      const [yearDistribution] = await connection.query(`
        SELECT 
          COALESCE(year, 'Unknown') as year,
          COUNT(*) as album_count,
          SUM((SELECT COUNT(*) FROM songs WHERE album_id = albums.id)) as song_count
        FROM albums 
        GROUP BY year 
        ORDER BY year DESC
      `);

      // Get top singers by song count
      const [topSingers] = await connection.query(`
        SELECT 
          singer_name,
          COUNT(DISTINCT s.id) as song_count
        FROM singers sg
        LEFT JOIN songs s ON s.singer LIKE CONCAT('%', sg.singer_name, '%')
        GROUP BY singer_name
        ORDER BY song_count DESC
        LIMIT 10
      `);

      // Get recent activity (albums added in last 7 days)
      const [recentActivity] = await connection.query(`
        SELECT DATE(created_at) as date, COUNT(*) as albums_added
        FROM albums 
        WHERE created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)
        GROUP BY DATE(created_at)
        ORDER BY date DESC
      `);

      const stats = {
        totals: {
          albums: albumsResult[0].total,
          songs: songsResult[0].total,
          artists: artistsResult[0].total,
          singers: singersResult[0].total,
          musicDirectors: directorsResult[0].total
        },
        recentAlbums,
        yearDistribution: yearDistribution.reduce((acc, item) => {
          acc[item.year] = {
            albums: item.album_count,
            songs: item.song_count
          };
          return acc;
        }, {}),
        topSingers,
        recentActivity
      };

      res.json({
        success: true,
        data: stats
      });

    } finally {
      connection.release();
    }

  } catch (error) {
    console.error('Error getting database stats:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to get database statistics',
      error: error.message
    });
  }
});

// GET /api/database/albums
router.get('/albums', async (req, res) => {
  try {
    const { page = 1, limit = 50, year, search } = req.query;
    const offset = (page - 1) * limit;

    const connection = await pool.getConnection();

    try {
      let whereClause = '';
      let params = [];

      if (year) {
        whereClause += ' WHERE year = ?';
        params.push(year);
      }

      if (search) {
        whereClause += (whereClause ? ' AND' : ' WHERE') + ' title LIKE ?';
        params.push(`%${search}%`);
      }

      const [albums] = await connection.query(`
        SELECT 
          a.id, a.title, a.year, a.director, a.music_director, a.created_at,
          COUNT(s.id) as song_count
        FROM albums a
        LEFT JOIN songs s ON a.id = s.album_id
        ${whereClause}
        GROUP BY a.id
        ORDER BY a.created_at DESC
        LIMIT ? OFFSET ?
      `, [...params, parseInt(limit), parseInt(offset)]);

      // Get total count
      const [countResult] = await connection.query(`
        SELECT COUNT(*) as total 
        FROM albums 
        ${whereClause}
      `, params);

      res.json({
        success: true,
        data: {
          albums,
          pagination: {
            page: parseInt(page),
            limit: parseInt(limit),
            total: countResult[0].total,
            pages: Math.ceil(countResult[0].total / limit)
          }
        }
      });

    } finally {
      connection.release();
    }

  } catch (error) {
    console.error('Error getting albums:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to get albums',
      error: error.message
    });
  }
});

// GET /api/database/songs
router.get('/songs', async (req, res) => {
  try {
    const { page = 1, limit = 50, albumId, search } = req.query;
    const offset = (page - 1) * limit;

    const connection = await pool.getConnection();

    try {
      let whereClause = '';
      let params = [];

      if (albumId) {
        whereClause += ' WHERE s.album_id = ?';
        params.push(albumId);
      }

      if (search) {
        whereClause += (whereClause ? ' AND' : ' WHERE') + ' s.title LIKE ?';
        params.push(`%${search}%`);
      }

      const [songs] = await connection.query(`
        SELECT 
          s.id, s.title, s.singer, s.audio_url, s.created_at,
          a.title as album_title, a.year as album_year
        FROM songs s
        JOIN albums a ON s.album_id = a.id
        ${whereClause}
        ORDER BY s.created_at DESC
        LIMIT ? OFFSET ?
      `, [...params, parseInt(limit), parseInt(offset)]);

      // Get total count
      const [countResult] = await connection.query(`
        SELECT COUNT(*) as total 
        FROM songs s
        JOIN albums a ON s.album_id = a.id
        ${whereClause}
      `, params);

      res.json({
        success: true,
        data: {
          songs,
          pagination: {
            page: parseInt(page),
            limit: parseInt(limit),
            total: countResult[0].total,
            pages: Math.ceil(countResult[0].total / limit)
          }
        }
      });

    } finally {
      connection.release();
    }

  } catch (error) {
    console.error('Error getting songs:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to get songs',
      error: error.message
    });
  }
});

// GET /api/database/search
router.get('/search', async (req, res) => {
  try {
    const { q, type = 'all' } = req.query;

    if (!q) {
      return res.status(400).json({
        success: false,
        message: 'Search query is required'
      });
    }

    const connection = await pool.getConnection();

    try {
      const results = {
        albums: [],
        songs: [],
        artists: [],
        singers: []
      };

      if (type === 'all' || type === 'albums') {
        const [albums] = await connection.query(`
          SELECT id, title, year, director, music_director
          FROM albums 
          WHERE title LIKE ? OR director LIKE ? OR music_director LIKE ?
          LIMIT 20
        `, [`%${q}%`, `%${q}%`, `%${q}%`]);
        results.albums = albums;
      }

      if (type === 'all' || type === 'songs') {
        const [songs] = await connection.query(`
          SELECT s.id, s.title, s.singer, a.title as album_title
          FROM songs s
          JOIN albums a ON s.album_id = a.id
          WHERE s.title LIKE ? OR s.singer LIKE ?
          LIMIT 20
        `, [`%${q}%`, `%${q}%`]);
        results.songs = songs;
      }

      if (type === 'all' || type === 'artists') {
        const [artists] = await connection.query(`
          SELECT artist_name, album_name
          FROM artists 
          WHERE artist_name LIKE ?
          LIMIT 20
        `, [`%${q}%`]);
        results.artists = artists;
      }

      if (type === 'all' || type === 'singers') {
        const [singers] = await connection.query(`
          SELECT singer_name
          FROM singers 
          WHERE singer_name LIKE ?
          LIMIT 20
        `, [`%${q}%`]);
        results.singers = singers;
      }

      res.json({
        success: true,
        data: results,
        query: q
      });

    } finally {
      connection.release();
    }

  } catch (error) {
    console.error('Error searching database:', error);
    res.status(500).json({
      success: false,
      message: 'Search failed',
      error: error.message
    });
  }
});

// GET /api/database/health
router.get('/health', async (req, res) => {
  try {
    const connection = await pool.getConnection();
    
    try {
      await connection.ping();
      res.json({
        success: true,
        message: 'Database connection is healthy',
        timestamp: new Date().toISOString()
      });
    } finally {
      connection.release();
    }

  } catch (error) {
    console.error('Database health check failed:', error);
    res.status(500).json({
      success: false,
      message: 'Database connection failed',
      error: error.message
    });
  }
});

module.exports = router;