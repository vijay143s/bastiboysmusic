import React, { useState, useEffect } from 'react';
import { MdCheckCircle, MdError, MdWarning, MdContentCopy, MdDelete, MdRefresh, MdClear } from 'react-icons/md';

const DatabaseQueryPage = () => {
  const [query, setQuery] = useState('');
  const [selectedTemplate, setSelectedTemplate] = useState('');
  const [results, setResults] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [templates, setTemplates] = useState([]);
  const [operationType, setOperationType] = useState('SELECT');
  const [showConfirmation, setShowConfirmation] = useState(false);
  const [pendingQuery, setPendingQuery] = useState(null);
  const [queryWarnings, setQueryWarnings] = useState([]);
  const [copiedCell, setCopiedCell] = useState(null);

  // Fetch templates on component mount
  useEffect(() => {
    fetchTemplates();
  }, []);

  const fetchTemplates = async () => {
    try {
      const response = await fetch('/api/admin/query/templates');
      if (response.ok) {
        const data = await response.json();
        setTemplates(data.templates || []);
      }
    } catch (err) {
      console.error('Failed to fetch templates:', err);
    }
  };

  const detectOperationType = (queryStr) => {
    const normalized = queryStr.trim().toUpperCase();
    if (normalized.startsWith('SELECT')) return 'SELECT';
    if (normalized.startsWith('UPDATE')) return 'UPDATE';
    if (normalized.startsWith('DELETE')) return 'DELETE';
    if (normalized.startsWith('ALTER')) return 'ALTER';
    if (normalized.startsWith('INSERT')) return 'INSERT';
    return 'UNKNOWN';
  };

  const validateQuery = async (queryStr) => {
    try {
      const response = await fetch('/api/admin/query/validate', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ query: queryStr })
      });
      
      if (response.ok) {
        const data = await response.json();
        setQueryWarnings(data.warnings || []);
        return data.valid;
      }
    } catch (err) {
      console.error('Validation error:', err);
    }
    return true; // Proceed if validation endpoint fails
  };

  const handleTemplateSelect = (e) => {
    const templateId = e.target.value;
    setSelectedTemplate(templateId);
    
    if (templateId) {
      const template = templates.find(t => t.id === templateId);
      if (template) {
        setQuery(template.query);
        setOperationType(detectOperationType(template.query));
      }
    }
  };

  const handleQueryChange = (e) => {
    const newQuery = e.target.value;
    setQuery(newQuery);
    setOperationType(detectOperationType(newQuery));
    setQueryWarnings([]);
  };

  const executeQuery = async () => {
    if (!query.trim()) {
      setError('Please enter a query');
      return;
    }

    // Validate query first
    const isValid = await validateQuery(query);
    if (!isValid) {
      setError('Invalid query syntax');
      return;
    }

    // Check if this is a destructive operation
    const type = detectOperationType(query);
    if ((type === 'DELETE' || type === 'UPDATE') && queryWarnings.length > 0) {
      setPendingQuery(query);
      setShowConfirmation(true);
      return;
    }

    // If no warning or it's not destructive, execute directly
    performExecution(query);
  };

  const performExecution = async (queryToExecute) => {
    setLoading(true);
    setError(null);
    setResults(null);
    setShowConfirmation(false);

    try {
      const response = await fetch('/api/admin/query', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ 
          query: queryToExecute,
          allowedOperations: ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'ALTER', 'CREATE']
        })
      });

      const data = await response.json();

      if (response.ok) {
        setResults({
          success: true,
          affectedRows: data.affectedRows,
          rows: data.rows,
          message: data.message,
          operationType: data.operation
        });
        setError(null);
      } else {
        setError(data.message || 'Query execution failed');
        setResults(null);
      }
    } catch (err) {
      setError(err.message || 'Network error');
      setResults(null);
    } finally {
      setLoading(false);
    }
  };

  const copyToClipboard = (text, index) => {
    navigator.clipboard.writeText(text);
    setCopiedCell(index);
    setTimeout(() => setCopiedCell(null), 1500);
  };

  const clearResults = () => {
    setResults(null);
    setQuery('');
    setSelectedTemplate('');
    setQueryWarnings([]);
    setOperationType('SELECT');
  };

  const renderResults = () => {
    if (!results) return null;

    if (results.operationType === 'SELECT' && results.rows && results.rows.length > 0) {
      const columns = Object.keys(results.rows[0]);
      
      return (
        <div className="bg-[#1a1a1a] rounded-lg border border-gray-700 overflow-hidden">
          <div className="bg-green-900/30 border-b border-green-700 px-6 py-4 flex items-center gap-2">
            <MdCheckCircle className="w-5 h-5 text-green-500" />
            <span className="text-green-200 font-medium">{results.rows.length} row(s) returned</span>
          </div>
          
          <div className="overflow-x-auto">
            <table className="w-full border-collapse">
              <thead>
                <tr className="bg-gray-800 border-b border-gray-700">
                  {columns.map((col, idx) => (
                    <th 
                      key={idx}
                      className="px-4 py-3 text-left text-sm font-semibold text-gray-200"
                    >
                      {col}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {results.rows.map((row, rowIdx) => (
                  <tr 
                    key={rowIdx}
                    className={rowIdx % 2 === 0 ? 'bg-[#1a1a1a]' : 'bg-[#242424]'}
                  >
                    {columns.map((col, colIdx) => {
                      const cellKey = `${rowIdx}-${colIdx}`;
                      const value = row[col];
                      const displayValue = value === null ? 'NULL' : String(value);
                      
                      return (
                        <td 
                          key={colIdx}
                          className="px-4 py-3 text-sm text-gray-300 border-b border-gray-700 relative group cursor-pointer"
                          title={displayValue}
                        >
                          <div className="flex items-center justify-between gap-2">
                            <span className="truncate max-w-xs">
                              {displayValue.length > 50 ? `${displayValue.substring(0, 50)}...` : displayValue}
                            </span>
                            <button
                              onClick={() => copyToClipboard(displayValue, cellKey)}
                              className="opacity-0 group-hover:opacity-100 transition-opacity"
                              title="Copy cell"
                            >
                              {copiedCell === cellKey ? (
                                <MdCheckCircle className="w-4 h-4 text-green-600" />
                              ) : (
                                <MdContentCopy className="w-4 h-4 text-gray-400 hover:text-gray-600" />
                              )}
                            </button>
                          </div>
                        </td>
                      );
                    })}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      );
    } else if (results.operationType === 'SELECT' && (!results.rows || results.rows.length === 0)) {
      return (
        <div className="bg-blue-900/20 border border-blue-700 rounded-lg px-6 py-4 flex items-center gap-2">
          <MdWarning className="w-5 h-5 text-blue-500" />
          <span className="text-blue-200">Query executed successfully. No rows returned.</span>
        </div>
      );
    } else {
      return (
        <div className="bg-green-900/20 border border-green-700 rounded-lg px-6 py-4">
          <div className="flex items-center gap-2 mb-2">
            <MdCheckCircle className="w-5 h-5 text-green-500" />
            <span className="text-green-200 font-medium">{results.operationType} Successful</span>
          </div>
          <p className="text-green-300 text-sm">{results.message}</p>
          {results.affectedRows !== undefined && (
            <p className="text-green-300 text-sm mt-2">Affected rows: {results.affectedRows}</p>
          )}
        </div>
      );
    }
  };

  return (
    <div className="max-w-6xl mx-auto px-4 py-8">
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-white mb-2">Database Admin Panel</h1>
        <p className="text-gray-400">Execute SQL queries directly on the database. Use templates for common operations.</p>
      </div>

        {/* Template Selector */}
        <div className="bg-[#1a1a1a] rounded-lg border border-gray-700 p-6 mb-6">
          <label className="block text-sm font-medium text-gray-200 mb-3">
            Quick Templates
          </label>
          <select
            value={selectedTemplate}
            onChange={handleTemplateSelect}
            className="w-full px-4 py-2 border border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-[#2a2a2a] text-white"
          >
            <option value="">-- Select a template --</option>
            {templates.map((template) => (
              <option key={template.id} value={template.id}>
                {template.name}
              </option>
            ))}
          </select>
        </div>

        {/* Query Editor */}
        <div className="bg-[#1a1a1a] rounded-lg border border-gray-700 p-6 mb-6">
          <div className="flex items-center justify-between mb-4">
            <label className="block text-sm font-medium text-gray-200">
              SQL Query
            </label>
            <span className="text-xs font-semibold px-2 py-1 rounded-full bg-blue-100 text-blue-800">
              {operationType}
            </span>
          </div>
          
          <textarea
            value={query}
            onChange={handleQueryChange}
            placeholder="Enter your SQL query here..."
            className="w-full h-40 px-4 py-3 border border-gray-600 rounded-lg font-mono text-sm focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-vertical bg-[#2a2a2a] text-white placeholder-gray-500"
          />

          {/* Query Warnings */}
          {queryWarnings.length > 0 && (
            <div className="mt-4 bg-yellow-900/20 border border-yellow-700 rounded-lg p-4">
              <div className="flex items-start gap-3">
                <MdWarning className="w-5 h-5 text-yellow-500 flex-shrink-0 mt-0.5" />
                <div>
                  <h4 className="font-medium text-yellow-200 mb-2">Warnings</h4>
                  <ul className="text-sm text-yellow-300 space-y-1">
                    {queryWarnings.map((warning, idx) => (
                      <li key={idx}>• {warning}</li>
                    ))}
                  </ul>
                  {queryWarnings.some(w => w.toLowerCase().includes('destructive')) && (
                    <p className="text-yellow-200 font-medium mt-2">
                      ⚠️ This operation requires confirmation
                    </p>
                  )}
                </div>
              </div>
            </div>
          )}
        </div>

        {/* Action Buttons */}
        <div className="flex gap-3 mb-6">
          <button
            onClick={executeQuery}
            disabled={loading || !query.trim()}
            className="flex items-center gap-2 px-6 py-3 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
          >
            {loading ? (
              <>
                <MdRefresh className="w-4 h-4 animate-spin" />
                Executing...
              </>
            ) : (
              'Execute Query'
            )}
          </button>
          
          {results && (
            <button
              onClick={clearResults}
              className="flex items-center gap-2 px-6 py-3 bg-gray-300 text-gray-800 rounded-lg font-medium hover:bg-gray-400 transition-colors"
            >
              <MdDelete className="w-4 h-4" />
              Clear
            </button>
          )}
        </div>

        {/* Error Display */}
        {error && (
          <div className="bg-red-900/20 border border-red-700 rounded-lg px-6 py-4 mb-6 flex items-start gap-3">
            <MdError className="w-5 h-5 text-red-500 flex-shrink-0 mt-0.5" />
            <div>
              <h4 className="font-medium text-red-200">Query Error</h4>
              <p className="text-red-300 text-sm mt-1">{error}</p>
            </div>
          </div>
        )}

        {/* Results Display */}
        {results && (
          <div>
            {renderResults()}
          </div>
        )}

      {/* Confirmation Modal */}
      {showConfirmation && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <div className="bg-[#1a1a1a] rounded-lg p-6 max-w-md shadow-lg border border-gray-700">
            <div className="flex items-start gap-3 mb-4">
              <MdWarning className="w-6 h-6 text-red-500 flex-shrink-0 mt-0.5" />
              <div>
                <h3 className="text-lg font-bold text-white">Confirm Destructive Operation</h3>
                <p className="text-gray-400 text-sm mt-1">
                  This operation will modify data in the database. This action cannot be undone.
                </p>
              </div>
            </div>

            <div className="bg-gray-900 rounded-lg p-3 mb-6 border border-gray-700">
              <p className="text-xs font-mono text-gray-300 break-all">{pendingQuery}</p>
            </div>

            <div className="flex gap-3">
              <button
                onClick={() => setShowConfirmation(false)}
                className="flex-1 px-4 py-2 border border-gray-600 rounded-lg text-gray-300 font-medium hover:bg-gray-800 transition-colors"
              >
                Cancel
              </button>
              <button
                onClick={() => performExecution(pendingQuery)}
                className="flex-1 px-4 py-2 bg-red-600 text-white rounded-lg font-medium hover:bg-red-700 transition-colors"
              >
                Execute
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default DatabaseQueryPage;
