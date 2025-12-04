const TryCatch = require("../utils/TryCatch.js");
const db = require("../database/db.js");

// Get overall platform statistics
const getDashboardStats = TryCatch(async (req, res) => {
  const [
    [{ total_users }],
    [{ total_songs }],
    [{ total_albums }],
    [{ total_artists }],
    [{ total_singers }],
    [{ total_music_directors }],
    [{ total_plays }],
  ] = await Promise.all([
    db.execute("SELECT COUNT(*) as total_users FROM users"),
    db.execute("SELECT COUNT(*) as total_songs FROM songs"),
    db.execute("SELECT COUNT(*) as total_albums FROM albums"),
    db.execute("SELECT COUNT(DISTINCT name) as total_artists FROM artists"),
    db.execute("SELECT COUNT(DISTINCT name) as total_singers FROM singers"),
    db.execute("SELECT COUNT(DISTINCT name) as total_music_directors FROM music_directors"),
    db.execute("SELECT IFNULL(SUM(play_count), 0) as total_plays FROM songs"),
  ]);

  // Get recent activity (last 24 hours)
  const [recentRegistrations] = await db.execute(`
    SELECT COUNT(*) as count FROM users 
    WHERE created_at > DATE_SUB(NOW(), INTERVAL 24 HOUR)
  `);

  const [recentSongs] = await db.execute(`
    SELECT COUNT(*) as count FROM songs 
    WHERE created_at > DATE_SUB(NOW(), INTERVAL 24 HOUR)
  `);

  // Get top played songs today
  const [topSongsToday] = await db.execute(`
    SELECT s.title, s.play_count, a.title as album_title
    FROM songs s
    LEFT JOIN albums a ON s.album_id = a.id
    ORDER BY s.play_count DESC
    LIMIT 5
  `);

  res.json({
    success: true,
    stats: {
      users: {
        total: total_users,
        recent: recentRegistrations[0].count,
      },
      songs: {
        total: total_songs,
        recent: recentSongs[0].count,
      },
      albums: {
        total: total_albums,
      },
      artists: {
        total: total_artists,
      },
      singers: {
        total: total_singers,
      },
      musicDirectors: {
        total: total_music_directors,
      },
      plays: {
        total: total_plays,
      },
      topSongsToday,
    },
  });
});

// Get user analytics
const getUserAnalytics = TryCatch(async (req, res) => {
  const { period = '7' } = req.query; // days

  // User registrations over time
  const [registrations] = await db.execute(`
    SELECT DATE(created_at) as date, COUNT(*) as count
    FROM users
    WHERE created_at > DATE_SUB(NOW(), INTERVAL ? DAY)
    GROUP BY DATE(created_at)
    ORDER BY date DESC
  `, [period]);

  // User roles distribution
  const [roleDistribution] = await db.execute(`
    SELECT role, COUNT(*) as count
    FROM users
    GROUP BY role
  `);

  // Most active users
  const [activeUsers] = await db.execute(`
    SELECT u.name, u.email, COUNT(ui.id) as interactions, 
           MAX(ui.created_at) as last_activity
    FROM users u
    LEFT JOIN user_interactions ui ON u.id = ui.user_id
    WHERE ui.created_at > DATE_SUB(NOW(), INTERVAL ? DAY)
    GROUP BY u.id
    ORDER BY interactions DESC
    LIMIT 10
  `, [period]);

  res.json({
    success: true,
    analytics: {
      registrations,
      roleDistribution,
      activeUsers,
    },
  });
});

// Get content analytics
const getContentAnalytics = TryCatch(async (req, res) => {
  const { period = '7' } = req.query; // days

  // Most played songs
  const [mostPlayedSongs] = await db.execute(`
    SELECT s.title, s.play_count, a.title as album_title,
           GROUP_CONCAT(DISTINCT si.name) as singers
    FROM songs s
    LEFT JOIN albums a ON s.album_id = a.id
    LEFT JOIN song_singers ss ON s.id = ss.song_id
    LEFT JOIN singers si ON ss.singer_id = si.id
    GROUP BY s.id
    ORDER BY s.play_count DESC
    LIMIT 10
  `);

  // Album performance
  const [albumPerformance] = await db.execute(`
    SELECT a.title, a.year, COUNT(s.id) as song_count, 
           IFNULL(SUM(s.play_count), 0) as total_plays
    FROM albums a
    LEFT JOIN songs s ON a.id = s.album_id
    GROUP BY a.id
    ORDER BY total_plays DESC
    LIMIT 10
  `);

  // Content uploads over time
  const [contentUploads] = await db.execute(`
    SELECT DATE(created_at) as date, COUNT(*) as song_count
    FROM songs
    WHERE created_at > DATE_SUB(NOW(), INTERVAL ? DAY)
    GROUP BY DATE(created_at)
    ORDER BY date DESC
  `, [period]);

  res.json({
    success: true,
    analytics: {
      mostPlayedSongs,
      albumPerformance,
      contentUploads,
    },
  });
});

// Get system health
const getSystemHealth = TryCatch(async (req, res) => {
  // Database connection test
  let dbStatus = 'healthy';
  try {
    await db.execute('SELECT 1');
  } catch (error) {
    dbStatus = 'error';
  }

  // Storage info (approximate)
  const [storageInfo] = await db.execute(`
    SELECT 
      ROUND(SUM(LENGTH(song_url))/1024/1024, 2) as estimated_audio_mb,
      ROUND(SUM(LENGTH(thumbnail_url))/1024/1024, 2) as estimated_image_mb
    FROM songs
  `);

  // Recent errors/issues
  const [recentErrors] = await db.execute(`
    SELECT 'missing_thumbnail' as type, COUNT(*) as count
    FROM songs 
    WHERE thumbnail_url IS NULL OR thumbnail_url = ''
    UNION ALL
    SELECT 'missing_audio' as type, COUNT(*) as count
    FROM songs 
    WHERE song_url IS NULL OR song_url = ''
  `);

  res.json({
    success: true,
    health: {
      database: dbStatus,
      storage: storageInfo[0],
      issues: recentErrors,
      timestamp: new Date().toISOString(),
    },
  });
});

// Bulk operations
const bulkDeleteSongs = TryCatch(async (req, res) => {
  const { songIds } = req.body;

  if (!Array.isArray(songIds) || songIds.length === 0) {
    return res.status(400).json({
      success: false,
      message: "Please provide an array of song IDs",
    });
  }

  const placeholders = songIds.map(() => '?').join(',');
  
  // Delete songs and related data
  await db.execute(`DELETE FROM songs WHERE id IN (${placeholders})`, songIds);
  
  res.json({
    success: true,
    message: `${songIds.length} songs deleted successfully`,
  });
});

// Update song metadata
const updateSongMetadata = TryCatch(async (req, res) => {
  const { songId } = req.params;
  const { title, year, playCount } = req.body;

  const updates = [];
  const values = [];

  if (title) {
    updates.push('title = ?');
    values.push(title);
  }
  if (year) {
    updates.push('year = ?');
    values.push(year);
  }
  if (playCount !== undefined) {
    updates.push('play_count = ?');
    values.push(playCount);
  }

  if (updates.length === 0) {
    return res.status(400).json({
      success: false,
      message: "No valid fields to update",
    });
  }

  values.push(songId);

  await db.execute(`
    UPDATE songs 
    SET ${updates.join(', ')}, updated_at = NOW()
    WHERE id = ?
  `, values);

  res.json({
    success: true,
    message: "Song metadata updated successfully",
  });
});

// Featured content management
const toggleFeaturedSong = TryCatch(async (req, res) => {
  const { songId } = req.params;

  // Check if song exists and get current status
  const [songResult] = await db.execute(
    'SELECT id, is_featured FROM songs WHERE id = ?',
    [songId]
  );

  if (songResult.length === 0) {
    return res.status(404).json({
      success: false,
      message: "Song not found",
    });
  }

  const currentStatus = songResult[0].is_featured || false;
  const newStatus = !currentStatus;

  await db.execute(
    'UPDATE songs SET is_featured = ? WHERE id = ?',
    [newStatus, songId]
  );

  res.json({
    success: true,
    message: `Song ${newStatus ? 'featured' : 'unfeatured'} successfully`,
    is_featured: newStatus,
  });
});

// Get recent activity logs
const getActivityLogs = TryCatch(async (req, res) => {
  const { limit = 50 } = req.query;

  // Get recent user interactions
  const [activities] = await db.execute(`
    SELECT 
      'play' as action,
      u.name as user_name,
      s.title as song_title,
      ui.created_at as timestamp
    FROM user_interactions ui
    JOIN users u ON ui.user_id = u.id
    JOIN songs s ON ui.song_id = s.id
    WHERE ui.interaction_type = 'play'
    
    UNION ALL
    
    SELECT 
      'registration' as action,
      u.name as user_name,
      'New user registered' as song_title,
      u.created_at as timestamp
    FROM users u
    
    UNION ALL
    
    SELECT 
      'upload' as action,
      'Admin' as user_name,
      s.title as song_title,
      s.created_at as timestamp
    FROM songs s
    
    ORDER BY timestamp DESC
    LIMIT ?
  `, [parseInt(limit)]);

  res.json({
    success: true,
    activities,
  });
});

module.exports = {
  getDashboardStats,
  getUserAnalytics,
  getContentAnalytics,
  getSystemHealth,
  bulkDeleteSongs,
  updateSongMetadata,
  toggleFeaturedSong,
  getActivityLogs,
};