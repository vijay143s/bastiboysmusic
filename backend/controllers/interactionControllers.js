const { execute } = require("../database/db.js");
const TryCatch = require("../utils/TryCatch.js");

/**
 * Track when a user plays a song
 */
exports.trackPlay = TryCatch(async (req, res) => {
  const { songId } = req.params;
  const userId = req.user.id;
  const { source = 'unknown', listenDuration = 0 } = req.body;

  await execute(
    `INSERT INTO user_interactions (user_id, song_id, interaction_type) VALUES (?, ?, 'play')`,
    [userId, songId]
  );

  // Update song play count
  await execute(
    `UPDATE songs SET play_count = play_count + 1 WHERE id = ?`,
    [songId]
  );

  res.status(200).json({
    success: true,
    message: "Play tracked successfully"
  });
});

/**
 * Track song completion with duration
 */
exports.trackCompletion = TryCatch(async (req, res) => {
  const { songId } = req.params;
  const userId = req.user.id;
  const { listenDuration, totalDuration, source = 'unknown' } = req.body;

  const completionPercentage = totalDuration > 0 
    ? Math.min(100, (listenDuration / totalDuration) * 100) 
    : 0;

  // Insert listening history
  await execute(
    `INSERT INTO user_listening_history 
    (user_id, song_id, listen_duration_seconds, completion_percentage, source) 
    VALUES (?, ?, ?, ?, ?)`,
    [userId, songId, Math.floor(listenDuration), completionPercentage, source]
  );

  // Mark as complete if >80% played
  if (completionPercentage >= 80) {
    await execute(
      `INSERT INTO user_interactions (user_id, song_id, interaction_type) VALUES (?, ?, 'complete')`,
      [userId, songId]
    );
  }

  // Update average completion rate for the song
  const [avgResult] = await execute(
    `SELECT AVG(completion_percentage) as avg_completion FROM user_listening_history WHERE song_id = ?`,
    [songId]
  );
  
  if (avgResult.length > 0) {
    await execute(
      `UPDATE songs SET avg_completion_rate = ? WHERE id = ?`,
      [avgResult[0].avg_completion, songId]
    );
  }

  res.status(200).json({
    success: true,
    message: "Completion tracked successfully",
    completionPercentage
  });
});

/**
 * Track when a user skips a song
 */
exports.trackSkip = TryCatch(async (req, res) => {
  const { songId } = req.params;
  const userId = req.user.id;
  const { skipPosition = 0, totalDuration = 0 } = req.body;

  let reason = 'beginning';
  if (totalDuration > 0) {
    const percentage = (skipPosition / totalDuration) * 100;
    if (percentage < 20) reason = 'beginning';
    else if (percentage < 80) reason = 'middle';
    else reason = 'end';
  }

  await execute(
    `INSERT INTO song_skips (user_id, song_id, skip_position_seconds, reason) VALUES (?, ?, ?, ?)`,
    [userId, songId, Math.floor(skipPosition), reason]
  );

  await execute(
    `INSERT INTO user_interactions (user_id, song_id, interaction_type) VALUES (?, ?, 'skip')`,
    [userId, songId]
  );

  // Update song skip count
  await execute(
    `UPDATE songs SET skip_count = skip_count + 1 WHERE id = ?`,
    [songId]
  );

  res.status(200).json({
    success: true,
    message: "Skip tracked successfully"
  });
});

/**
 * Track search queries
 */
exports.trackSearch = TryCatch(async (req, res) => {
  const userId = req.user?.id || null;
  const { query, resultsCount = 0, clickedSongId = null } = req.body;

  if (!query) {
    return res.status(400).json({
      success: false,
      message: "Search query is required"
    });
  }

  await execute(
    `INSERT INTO user_search_history (user_id, search_query, results_count, clicked_song_id) 
    VALUES (?, ?, ?, ?)`,
    [userId, query, resultsCount, clickedSongId]
  );

  res.status(200).json({
    success: true,
    message: "Search tracked successfully"
  });
});

/**
 * Get personalized recommendations based on user behavior
 */
exports.getRecommendations = TryCatch(async (req, res) => {
  const userId = req.user.id;
  const { limit = 20 } = req.query;

  // Get user's most played songs to find similar patterns
  const [recentPlays] = await execute(
    `SELECT song_id, COUNT(*) as play_count 
    FROM user_listening_history 
    WHERE user_id = ? AND completion_percentage >= 40
    GROUP BY song_id 
    ORDER BY MAX(created_at) DESC 
    LIMIT 10`,
    [userId]
  );

  if (recentPlays.length === 0) {
    // If no history, return top played songs globally
    const [topSongs] = await execute(
      `SELECT s.*, a.title as albumName, a.thumbnail_url as albumThumbnail
      FROM songs s
      LEFT JOIN albums a ON s.album_id = a.id
      ORDER BY s.play_count DESC, s.created_at DESC
      LIMIT ?`,
      [parseInt(limit)]
    );

    return res.status(200).json({
      success: true,
      recommendations: topSongs,
      reason: "Popular songs (no listening history)"
    });
  }

  const songIds = recentPlays.map(p => p.song_id);

  // Find songs from same albums that user hasn't played much
  const [recommendations] = await execute(
    `SELECT DISTINCT s.*, a.title as albumName, a.thumbnail_url as albumThumbnail,
    (
      SELECT COUNT(*) FROM user_listening_history ulh 
      WHERE ulh.song_id = s.id AND ulh.user_id = ?
    ) as user_play_count
    FROM songs s
    INNER JOIN albums a ON s.album_id = a.id
    WHERE s.album_id IN (
      SELECT album_id FROM songs WHERE id IN (${songIds.map(() => '?').join(',')})
    )
    AND s.id NOT IN (${songIds.map(() => '?').join(',')})
    AND s.play_count > 0
    ORDER BY s.play_count DESC, s.avg_completion_rate DESC, user_play_count ASC
    LIMIT ?`,
    [userId, ...songIds, ...songIds, parseInt(limit)]
  );

  res.status(200).json({
    success: true,
    recommendations,
    reason: "Based on your listening history"
  });
});

/**
 * Get user's listening statistics
 */
exports.getListeningStats = TryCatch(async (req, res) => {
  const userId = req.user.id;

  const [totalPlays] = await execute(
    `SELECT COUNT(*) as count FROM user_listening_history WHERE user_id = ?`,
    [userId]
  );

  const [totalTime] = await execute(
    `SELECT SUM(listen_duration_seconds) as total_seconds FROM user_listening_history WHERE user_id = ?`,
    [userId]
  );

  // Do not include song lists here to keep payload light
  // If needed, a separate endpoint can provide detailed top songs

  const [recentSearches] = await execute(
    `SELECT DISTINCT search_query, MAX(created_at) as last_search
    FROM user_search_history
    WHERE user_id = ?
    GROUP BY search_query
    ORDER BY last_search DESC
    LIMIT 10`,
    [userId]
  );

  res.status(200).json({
    success: true,
    stats: {
      totalPlays: totalPlays[0]?.count || 0,
      totalListeningTime: Math.floor((totalTime[0]?.total_seconds || 0) / 60), // in minutes
      recentSearches: recentSearches.map(s => s.search_query)
    }
  });
});

/**
 * Get trending songs based on recent activity
 */
exports.getTrendingSongs = TryCatch(async (req, res) => {
  const { limit = 20, days = 7 } = req.query;

  const [trending] = await execute(
    `SELECT s.*, a.title as albumName, a.thumbnail_url as albumThumbnail,
    COUNT(DISTINCT ulh.user_id) as unique_listeners,
    COUNT(ulh.id) as recent_plays
    FROM songs s
    LEFT JOIN albums a ON s.album_id = a.id
    LEFT JOIN user_listening_history ulh ON s.id = ulh.song_id 
      AND ulh.created_at >= DATE_SUB(NOW(), INTERVAL ? DAY)
    WHERE ulh.id IS NOT NULL
    GROUP BY s.id
    ORDER BY unique_listeners DESC, recent_plays DESC
    LIMIT ?`,
    [parseInt(days), parseInt(limit)]
  );

  res.status(200).json({
    success: true,
    trending,
    period: `Last ${days} days`
  });
});

/**
 * Get queue songs from all user interactions and playlists
 * Combines recently played songs from all users and songs from all user playlists
 */
exports.getQueueSongs = TryCatch(async (req, res) => {
  const { limit = 50 } = req.query;

  // Get recently played songs from all users' interactions
  const [interactionSongs] = await execute(
    `SELECT DISTINCT s.*, a.title as albumName, a.thumbnail_url as albumThumbnail,
    MAX(ui.created_at) as last_played
    FROM user_interactions ui
    INNER JOIN songs s ON ui.song_id = s.id
    LEFT JOIN albums a ON s.album_id = a.id
    WHERE ui.interaction_type IN ('play', 'complete')
    GROUP BY s.id
    ORDER BY last_played DESC
    LIMIT ?`,
    [Math.floor(parseInt(limit) * 0.6)] // 60% from interactions
  );

  // Get songs from all user playlists
  const [playlistSongs] = await execute(
    `SELECT DISTINCT s.*, a.title as albumName, a.thumbnail_url as albumThumbnail,
    MAX(up.created_at) as added_at
    FROM user_playlists up
    INNER JOIN songs s ON up.song_id = s.id
    LEFT JOIN albums a ON s.album_id = a.id
    GROUP BY s.id
    ORDER BY added_at DESC
    LIMIT ?`,
    [Math.floor(parseInt(limit) * 0.4)] // 40% from playlists
  );

  // Combine and deduplicate songs
  const songMap = new Map();
  
  // Add interaction songs first (higher priority)
  interactionSongs.forEach(song => {
    if (!songMap.has(song.id)) {
      songMap.set(song.id, song);
    }
  });
  
  // Add playlist songs
  playlistSongs.forEach(song => {
    if (!songMap.has(song.id)) {
      songMap.set(song.id, song);
    }
  });

  const combinedSongs = Array.from(songMap.values()).slice(0, parseInt(limit));

  res.status(200).json({
    success: true,
    songs: combinedSongs,
    total: combinedSongs.length,
    sources: {
      interactions: interactionSongs.length,
      playlists: playlistSongs.length,
      combined: combinedSongs.length
    }
  });
});
