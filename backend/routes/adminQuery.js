const express = require('express');
const router = express.Router();
const path = require('path');

// Import database connection
const { pool } = require('../database/db');

// Middleware to verify admin access
const verifyAdmin = (req, res, next) => {
  // In production, verify user session and role
  // For now, we'll add this check later with auth middleware
  next();
};

// POST /api/admin/query - Execute SQL query
router.post('/', verifyAdmin, async (req, res) => {
  try {
    const { query, allowedOperations = ['SELECT'] } = req.body;

    if (!query || !query.trim()) {
      return res.status(400).json({
        success: false,
        message: 'Query cannot be empty'
      });
    }

    const trimmedQuery = query.trim().toUpperCase();

    // Determine query type
    let operationType = 'UNKNOWN';
    if (trimmedQuery.startsWith('SELECT')) operationType = 'SELECT';
    else if (trimmedQuery.startsWith('INSERT')) operationType = 'INSERT';
    else if (trimmedQuery.startsWith('UPDATE')) operationType = 'UPDATE';
    else if (trimmedQuery.startsWith('DELETE')) operationType = 'DELETE';
    else if (trimmedQuery.startsWith('ALTER')) operationType = 'ALTER';
    else if (trimmedQuery.startsWith('CREATE')) operationType = 'CREATE';
    else if (trimmedQuery.startsWith('DROP')) operationType = 'DROP';

    // Check if operation is allowed
    if (!allowedOperations.includes(operationType)) {
      return res.status(403).json({
        success: false,
        message: `Operation ${operationType} is not allowed. Allowed: ${allowedOperations.join(', ')}`
      });
    }

    // Prevent dangerous operations
    const dangerousPatterns = [
      /DROP\s+TABLE/i,
      /TRUNCATE\s+TABLE/i
    ];

    for (const pattern of dangerousPatterns) {
      if (pattern.test(query)) {
        return res.status(403).json({
          success: false,
          message: 'This operation is too dangerous and has been blocked',
          operation: operationType
        });
      }
    }

    // Check if DELETE has WHERE clause
    if (operationType === 'DELETE' && !/WHERE/i.test(query)) {
      return res.status(403).json({
        success: false,
        message: 'DELETE queries must include a WHERE clause for safety',
        operation: operationType
      });
    }

    // Execute query directly from pool
    try {
      let results;
      
      if (operationType === 'SELECT') {
        // For SELECT queries
        const [rows] = await pool.query(query);
        results = rows;
      } else {
        // For INSERT, UPDATE, DELETE, ALTER
        const [result] = await pool.query(query);
        results = result;
      }

      // Format response based on operation type
      let responseData = {
        success: true,
        operation: operationType,
        timestamp: new Date().toISOString()
      };

      if (operationType === 'SELECT') {
        responseData.rows = results;
        responseData.rowCount = results.length;
      } else if (['INSERT', 'UPDATE', 'DELETE'].includes(operationType)) {
        responseData.affectedRows = results.affectedRows || 0;
        responseData.message = `${operationType} executed successfully`;
      } else if (operationType === 'ALTER') {
        responseData.message = 'ALTER statement executed successfully';
      }

      // Log the operation
      console.log(`[ADMIN QUERY] ${operationType}: Rows affected: ${responseData.affectedRows || responseData.rowCount || 0}`);

      res.json(responseData);

    } catch (queryError) {
      throw queryError;
    }

  } catch (error) {
    console.error('Query execution error:', error);
    res.status(500).json({
      success: false,
      message: 'Query execution failed',
      error: error.message,
      code: error.code
    });
  }
});

// GET /api/admin/query-templates - Get predefined query templates
router.get('/templates', verifyAdmin, (req, res) => {
  const templates = [
    {
      id: 'albums-count',
      name: 'Albums Count',
      query: 'SELECT COUNT(*) as total FROM albums;',
      type: 'SELECT'
    },
    {
      id: 'songs-count',
      name: 'Songs Count',
      query: 'SELECT COUNT(*) as total FROM songs;',
      type: 'SELECT'
    },
    {
      id: 'albums-with-year',
      name: 'All Albums with Year',
      query: 'SELECT id, title, year, language FROM albums ORDER BY created_at DESC LIMIT 100;',
      type: 'SELECT'
    },
    {
      id: 'songs-no-audio',
      name: 'Songs without Audio URL',
      query: 'SELECT id, title, album_id FROM songs WHERE audio_url IS NULL OR audio_url = "" LIMIT 50;',
      type: 'SELECT'
    },
    {
      id: 'recent-albums',
      name: 'Recent Albums',
      query: 'SELECT id, title, year, language FROM albums ORDER BY created_at DESC LIMIT 10;',
      type: 'SELECT'
    },
    {
      id: 'update-language',
      name: 'Add Language to Album',
      query: 'UPDATE albums SET language = "Hindi" WHERE id = ? LIMIT 1;',
      type: 'UPDATE'
    },
    {
      id: 'delete-album',
      name: 'Delete Album (USE WITH CAUTION)',
      query: 'DELETE FROM albums WHERE id = ? LIMIT 1;',
      type: 'DELETE'
    },
    {
      id: 'add-language-column',
      name: 'Add Column if Missing',
      query: 'ALTER TABLE albums ADD COLUMN IF NOT EXISTS language VARCHAR(100);',
      type: 'ALTER'
    }
  ];

  res.json({
    success: true,
    templates
  });
});

// POST /api/admin/query-validate - Validate query syntax
router.post('/validate', verifyAdmin, (req, res) => {
  try {
    const { query } = req.body;

    if (!query || !query.trim()) {
      return res.status(400).json({
        success: false,
        valid: false,
        message: 'Query cannot be empty'
      });
    }

    const trimmedQuery = query.trim().toUpperCase();

    // Check basic syntax
    let operationType = 'UNKNOWN';
    if (trimmedQuery.startsWith('SELECT')) operationType = 'SELECT';
    else if (trimmedQuery.startsWith('INSERT')) operationType = 'INSERT';
    else if (trimmedQuery.startsWith('UPDATE')) operationType = 'UPDATE';
    else if (trimmedQuery.startsWith('DELETE')) operationType = 'DELETE';
    else if (trimmedQuery.startsWith('ALTER')) operationType = 'ALTER';
    else if (trimmedQuery.startsWith('CREATE')) operationType = 'CREATE';
    else if (trimmedQuery.startsWith('DROP')) operationType = 'DROP';

    // Check for dangerous patterns
    const dangerousPatterns = [
      { pattern: /DROP\s+TABLE/i, warning: 'DROP TABLE detected' },
      { pattern: /TRUNCATE\s+TABLE/i, warning: 'TRUNCATE TABLE detected' }
    ];

    const warnings = [];
    for (const { pattern, warning } of dangerousPatterns) {
      if (pattern.test(query)) {
        warnings.push(warning);
      }
    }

    // Check if DELETE has WHERE clause
    if (operationType === 'DELETE' && !/WHERE/i.test(query)) {
      warnings.push('DELETE without WHERE clause');
    }

    res.json({
      success: true,
      valid: true,
      operation: operationType,
      warnings: warnings,
      isDangerous: warnings.length > 0
    });

  } catch (error) {
    res.status(500).json({
      success: false,
      valid: false,
      message: error.message
    });
  }
});

module.exports = router;
