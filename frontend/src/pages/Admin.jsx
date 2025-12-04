import React, { useState, useEffect } from "react";
import { UserData } from "../context/User";
import { Link, useNavigate } from "react-router-dom";
import { SongData } from "../context/Song";
import { MdDelete, MdEdit, MdStar, MdStarBorder, MdAnalytics, MdPeople, MdLibraryMusic, MdBarChart, MdSettings, MdMonitorHeart, MdStorage } from "react-icons/md";
import "../components/AdminDashboard.css";

const Admin = () => {
  const { user } = UserData();
  const {
    albums,
    songs,
    addAlbum,
    loading,
    addSong,
    addThumbnail,
    deleteSong,
  } = SongData();
  const navigate = useNavigate();

  if (user && user.role !== "admin") return navigate("/");

  // Form states
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [file, setFile] = useState(null);
  const [singer, setSinger] = useState("");
  const [album, setAlbum] = useState("");
  
  // Dashboard states
  const [activeTab, setActiveTab] = useState('dashboard');
  const [dashboardStats, setDashboardStats] = useState(null);
  const [userAnalytics, setUserAnalytics] = useState(null);
  const [contentAnalytics, setContentAnalytics] = useState(null);
  const [systemHealth, setSystemHealth] = useState(null);
  const [activityLogs, setActivityLogs] = useState([]);
  const [selectedSongs, setSelectedSongs] = useState([]);
  const [editingSong, setEditingSong] = useState(null);
  const [statsLoading, setStatsLoading] = useState(false);

  const fileChangeHandler = (e) => {
    const file = e.target.files[0];
    setFile(file);
  };

  const addAlbumHandler = (e) => {
    e.preventDefault();

    const formData = new FormData();

    formData.append("title", title);
    formData.append("description", description);
    formData.append("file", file);
    addAlbum(formData, setTitle, setDescription, setFile);
  };

  const addSongHandler = (e) => {
    e.preventDefault();

    const formData = new FormData();

    formData.append("title", title);
    formData.append("description", description);
    formData.append("singer", singer);
    formData.append("album", album);
    formData.append("file", file);
    addSong(formData, setTitle, setDescription, setFile, setSinger, setAlbum);
  };

  const addThumbnailHandler = (id) => {
    const formData = new FormData();
    formData.append("file", file);

    addThumbnail(id, formData, setFile);
  };

  const deleteHandler = (id) => {
    const shouldDelete = window.confirm("Are you sure you want to delete this song? This action cannot be undone.");
    if (shouldDelete) {
      deleteSong(id);
    }
  };

  // Fetch dashboard data
  useEffect(() => {
    if (activeTab === 'dashboard') {
      fetchDashboardStats();
    } else if (activeTab === 'analytics') {
      fetchUserAnalytics();
      fetchContentAnalytics();
    } else if (activeTab === 'system') {
      fetchSystemHealth();
      fetchActivityLogs();
    }
  }, [activeTab]);

  const fetchDashboardStats = async () => {
    setStatsLoading(true);
    try {
      const response = await fetch('/api/admin/dashboard/stats', {
        credentials: 'include'
      });
      const data = await response.json();
      if (data.success) {
        setDashboardStats(data.stats);
      }
    } catch (error) {
      console.error('Error fetching dashboard stats:', error);
    } finally {
      setStatsLoading(false);
    }
  };

  const fetchUserAnalytics = async () => {
    try {
      const response = await fetch('/api/admin/analytics/users?period=7', {
        credentials: 'include'
      });
      const data = await response.json();
      if (data.success) {
        setUserAnalytics(data.analytics);
      }
    } catch (error) {
      console.error('Error fetching user analytics:', error);
    }
  };

  const fetchContentAnalytics = async () => {
    try {
      const response = await fetch('/api/admin/analytics/content?period=7', {
        credentials: 'include'
      });
      const data = await response.json();
      if (data.success) {
        setContentAnalytics(data.analytics);
      }
    } catch (error) {
      console.error('Error fetching content analytics:', error);
    }
  };

  const fetchSystemHealth = async () => {
    try {
      const response = await fetch('/api/admin/system/health', {
        credentials: 'include'
      });
      const data = await response.json();
      if (data.success) {
        setSystemHealth(data.health);
      }
    } catch (error) {
      console.error('Error fetching system health:', error);
    }
  };

  const fetchActivityLogs = async () => {
    try {
      const response = await fetch('/api/admin/activity/logs?limit=20', {
        credentials: 'include'
      });
      const data = await response.json();
      if (data.success) {
        setActivityLogs(data.activities);
      }
    } catch (error) {
      console.error('Error fetching activity logs:', error);
    }
  };

  const toggleSongSelection = (songId) => {
    setSelectedSongs(prev => 
      prev.includes(songId) 
        ? prev.filter(id => id !== songId)
        : [...prev, songId]
    );
  };

  const bulkDeleteSongs = async () => {
    if (selectedSongs.length === 0) return;
    
    const shouldDelete = window.confirm(`Are you sure you want to delete ${selectedSongs.length} songs? This action cannot be undone.`);
    if (!shouldDelete) return;

    try {
      const response = await fetch('/api/admin/songs/bulk', {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({ songIds: selectedSongs })
      });
      
      const data = await response.json();
      if (data.success) {
        alert('Songs deleted successfully');
        setSelectedSongs([]);
        // Refresh songs list
        window.location.reload();
      } else {
        alert('Error deleting songs: ' + data.message);
      }
    } catch (error) {
      alert('Error deleting songs: ' + error.message);
    }
  };

  const toggleFeaturedSong = async (songId) => {
    try {
      const response = await fetch(`/api/admin/songs/${songId}/featured`, {
        method: 'PATCH',
        credentials: 'include'
      });
      
      const data = await response.json();
      if (data.success) {
        // Refresh songs list to show updated status
        window.location.reload();
      } else {
        alert('Error updating song: ' + data.message);
      }
    } catch (error) {
      alert('Error updating song: ' + error.message);
    }
  };
  const renderDashboard = () => (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h2 className="text-2xl font-bold">Dashboard Overview</h2>
        <Link
          to="/"
          className="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded-lg transition-colors"
        >
          Go to Home
        </Link>
      </div>

      {statsLoading ? (
        <div className="flex justify-center items-center h-64">
          <div className="animate-spin rounded-full h-16 w-16 border-b-2 border-green-500"></div>
        </div>
      ) : dashboardStats ? (
        <>
          {/* Stats Grid */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <div className="bg-[#181818] p-6 rounded-lg border-l-4 border-blue-500">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-gray-400">Total Users</p>
                  <p className="text-2xl font-bold">{dashboardStats?.users?.total || 0}</p>
                  <p className="text-xs text-green-400">+{dashboardStats?.users?.recent || 0} today</p>
                </div>
                <MdPeople className="text-3xl text-blue-500" />
              </div>
            </div>

            <div className="bg-[#181818] p-6 rounded-lg border-l-4 border-green-500">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-gray-400">Total Songs</p>
                  <p className="text-2xl font-bold">{dashboardStats?.songs?.total || 0}</p>
                  <p className="text-xs text-green-400">+{dashboardStats?.songs?.recent || 0} today</p>
                </div>
                <MdLibraryMusic className="text-3xl text-green-500" />
              </div>
            </div>

            <div className="bg-[#181818] p-6 rounded-lg border-l-4 border-purple-500">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-gray-400">Total Albums</p>
                  <p className="text-2xl font-bold">{dashboardStats?.albums?.total || 0}</p>
                </div>
                <MdLibraryMusic className="text-3xl text-purple-500" />
              </div>
            </div>

            <div className="bg-[#181818] p-6 rounded-lg border-l-4 border-yellow-500">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-gray-400">Total Plays</p>
                  <p className="text-2xl font-bold">{dashboardStats?.plays?.total?.toLocaleString() || '0'}</p>
                </div>
                <MdBarChart className="text-3xl text-yellow-500" />
              </div>
            </div>
          </div>

          {/* Top Songs Today */}
          <div className="bg-[#181818] p-6 rounded-lg">
            <h3 className="text-xl font-bold mb-4">Top Played Songs</h3>
            <div className="space-y-3">
              {dashboardStats?.topSongsToday?.length > 0 ? dashboardStats.topSongsToday.map((song, index) => (
                <div key={index} className="flex items-center justify-between p-3 bg-[#212121] rounded">
                  <div>
                    <p className="font-medium">{song.title}</p>
                    <p className="text-sm text-gray-400">{song.album_title}</p>
                  </div>
                  <span className="bg-green-500 text-white px-2 py-1 rounded text-sm">
                    {song.play_count} plays
                  </span>
                </div>
              )) : (
                <div className="text-center text-gray-400 py-8">
                  <p>No song plays recorded yet</p>
                </div>
              )}
            </div>
          </div>
        </>
      ) : (
        <div className="bg-[#181818] p-6 rounded-lg text-center">
          <p className="text-gray-400">Failed to load dashboard stats</p>
          <button 
            onClick={fetchDashboardStats}
            className="mt-2 px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600"
          >
            Retry
          </button>
        </div>
      )}
    </div>
  );

  const renderContentManagement = () => (
    <div className="space-y-8">
      <h2 className="text-2xl font-bold">Content Management</h2>

      {/* Add Album Form */}
      <div className="bg-[#181818] p-6 rounded-lg">
        <h3 className="text-xl font-bold mb-4">Add New Album</h3>
        <form onSubmit={addAlbumHandler} className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium mb-2">Album Title</label>
              <input
                type="text"
                placeholder="Enter album title"
                className="auth-input"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium mb-2">Description</label>
              <input
                type="text"
                placeholder="Enter description"
                className="auth-input"
                value={description}
                onChange={(e) => setDescription(e.target.value)}
                required
              />
            </div>
          </div>
          <div>
            <label className="block text-sm font-medium mb-2">Album Thumbnail</label>
            <input
              type="file"
              className="auth-input"
              accept="image/*"
              onChange={fileChangeHandler}
              required
            />
          </div>
          <button
            disabled={loading}
            className="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-6 rounded-lg disabled:opacity-50"
          >
            {loading ? "Creating..." : "Create Album"}
          </button>
        </form>
      </div>

      {/* Add Song Form */}
      <div className="bg-[#181818] p-6 rounded-lg">
        <h3 className="text-xl font-bold mb-4">Add New Song</h3>
        <form onSubmit={addSongHandler} className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium mb-2">Song Title</label>
              <input
                type="text"
                placeholder="Enter song title"
                className="auth-input"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium mb-2">Singer</label>
              <input
                type="text"
                placeholder="Enter singer name"
                className="auth-input"
                value={singer}
                onChange={(e) => setSinger(e.target.value)}
                required
              />
            </div>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium mb-2">Description</label>
              <input
                type="text"
                placeholder="Enter description"
                className="auth-input"
                value={description}
                onChange={(e) => setDescription(e.target.value)}
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium mb-2">Album</label>
              <select
                className="auth-input"
                value={album}
                onChange={(e) => setAlbum(e.target.value)}
                required
              >
                <option value="">Select Album</option>
                {albums?.map((e, i) => (
                  <option value={e._id} key={i}>
                    {e.title}
                  </option>
                ))}
              </select>
            </div>
          </div>
          <div>
            <label className="block text-sm font-medium mb-2">Audio File</label>
            <input
              type="file"
              className="auth-input"
              accept="audio/*"
              onChange={fileChangeHandler}
              required
            />
          </div>
          <button
            disabled={loading}
            className="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-6 rounded-lg disabled:opacity-50"
          >
            {loading ? "Uploading..." : "Add Song"}
          </button>
        </form>
      </div>

      {/* Songs Management */}
      <div className="bg-[#181818] p-6 rounded-lg">
        <div className="flex justify-between items-center mb-4">
          <h3 className="text-xl font-bold">Manage Songs</h3>
          {selectedSongs.length > 0 && (
            <button
              onClick={bulkDeleteSongs}
              className="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg"
            >
              Delete Selected ({selectedSongs.length})
            </button>
          )}
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
          {songs?.map((song, i) => (
            <div key={i} className="bg-[#212121] p-4 rounded-lg relative">
              <input
                type="checkbox"
                className="absolute top-2 left-2 z-10"
                checked={selectedSongs.includes(song._id)}
                onChange={() => toggleSongSelection(song._id)}
              />
              
              {song.thumbnail ? (
                <img
                  src={song.thumbnail.url}
                  alt={song.title}
                  className="w-full h-40 object-cover rounded mb-3"
                />
              ) : (
                <div className="w-full h-40 bg-[#333] rounded mb-3 flex flex-col items-center justify-center">
                  <input 
                    type="file" 
                    onChange={fileChangeHandler}
                    className="hidden"
                    id={`thumbnail-${song._id}`}
                  />
                  <label
                    htmlFor={`thumbnail-${song._id}`}
                    className="text-xs text-gray-400 cursor-pointer hover:text-white"
                  >
                    Upload Thumbnail
                  </label>
                  <button
                    onClick={() => addThumbnailHandler(song._id)}
                    className="bg-green-500 text-white px-2 py-1 rounded text-xs mt-2"
                  >
                    Add
                  </button>
                </div>
              )}

              <div className="space-y-2">
                <h4 className="font-bold truncate">{song.title}</h4>
                <p className="text-sm text-gray-400 truncate">{song.singer}</p>
                <p className="text-xs text-gray-500 truncate">{song.description}</p>
                
                <div className="flex justify-between items-center pt-2">
                  <div className="flex gap-2">
                    <button
                      onClick={() => toggleFeaturedSong(song._id)}
                      className={`p-1 rounded ${song.is_featured ? 'text-yellow-500' : 'text-gray-400'}`}
                      title={song.is_featured ? 'Remove from featured' : 'Add to featured'}
                    >
                      {song.is_featured ? <MdStar /> : <MdStarBorder />}
                    </button>
                    <button
                      onClick={() => setEditingSong(song)}
                      className="p-1 text-blue-500 hover:text-blue-400"
                      title="Edit song"
                    >
                      <MdEdit />
                    </button>
                  </div>
                  <button
                    onClick={() => deleteHandler(song._id)}
                    className="p-1 text-red-500 hover:text-red-400"
                    title="Delete song"
                  >
                    <MdDelete />
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );

  const renderAnalytics = () => (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold">Analytics & Reports</h2>

      {userAnalytics && (
        <div className="bg-[#181818] p-6 rounded-lg">
          <h3 className="text-xl font-bold mb-4">User Analytics (Last 7 Days)</h3>
          
          {/* User Registrations */}
          <div className="mb-6">
            <h4 className="text-lg font-semibold mb-3">Daily Registrations</h4>
            <div className="space-y-2">
              {userAnalytics.registrations.map((reg, index) => (
                <div key={index} className="flex justify-between items-center p-2 bg-[#212121] rounded">
                  <span>{new Date(reg.date).toLocaleDateString()}</span>
                  <span className="bg-blue-500 text-white px-2 py-1 rounded text-sm">
                    {reg.count} users
                  </span>
                </div>
              ))}
            </div>
          </div>

          {/* Most Active Users */}
          <div>
            <h4 className="text-lg font-semibold mb-3">Most Active Users</h4>
            <div className="space-y-2">
              {userAnalytics.activeUsers.slice(0, 5).map((user, index) => (
                <div key={index} className="flex justify-between items-center p-3 bg-[#212121] rounded">
                  <div>
                    <p className="font-medium">{user.name}</p>
                    <p className="text-sm text-gray-400">{user.email}</p>
                  </div>
                  <span className="bg-green-500 text-white px-2 py-1 rounded text-sm">
                    {user.interactions} interactions
                  </span>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      {contentAnalytics && (
        <div className="bg-[#181818] p-6 rounded-lg">
          <h3 className="text-xl font-bold mb-4">Content Analytics</h3>
          
          {/* Most Played Songs */}
          <div className="mb-6">
            <h4 className="text-lg font-semibold mb-3">Most Played Songs</h4>
            <div className="space-y-2">
              {contentAnalytics.mostPlayedSongs.slice(0, 5).map((song, index) => (
                <div key={index} className="flex justify-between items-center p-3 bg-[#212121] rounded">
                  <div>
                    <p className="font-medium">{song.title}</p>
                    <p className="text-sm text-gray-400">{song.album_title}</p>
                    <p className="text-xs text-gray-500">{song.singers}</p>
                  </div>
                  <span className="bg-purple-500 text-white px-2 py-1 rounded text-sm">
                    {song.play_count} plays
                  </span>
                </div>
              ))}
            </div>
          </div>

          {/* Top Albums */}
          <div>
            <h4 className="text-lg font-semibold mb-3">Top Performing Albums</h4>
            <div className="space-y-2">
              {contentAnalytics.albumPerformance.slice(0, 5).map((album, index) => (
                <div key={index} className="flex justify-between items-center p-3 bg-[#212121] rounded">
                  <div>
                    <p className="font-medium">{album.title}</p>
                    <p className="text-sm text-gray-400">{album.year} • {album.song_count} songs</p>
                  </div>
                  <span className="bg-yellow-500 text-white px-2 py-1 rounded text-sm">
                    {album.total_plays} plays
                  </span>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}
    </div>
  );

  const renderSystemHealth = () => (
    <div className="space-y-6">
      <h2 className="text-2xl font-bold">System Health & Logs</h2>

      {systemHealth && (
        <div className="bg-[#181818] p-6 rounded-lg">
          <h3 className="text-xl font-bold mb-4">System Status</h3>
          
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
            <div className="bg-[#212121] p-4 rounded">
              <div className="flex items-center gap-2 mb-2">
                <MdMonitorHeart className={`text-xl ${systemHealth.database === 'healthy' ? 'text-green-500' : 'text-red-500'}`} />
                <span className="font-medium">Database</span>
              </div>
              <p className={`text-sm ${systemHealth.database === 'healthy' ? 'text-green-400' : 'text-red-400'}`}>
                {systemHealth.database === 'healthy' ? 'Connected' : 'Error'}
              </p>
            </div>

            <div className="bg-[#212121] p-4 rounded">
              <div className="flex items-center gap-2 mb-2">
                <MdSettings className="text-xl text-blue-500" />
                <span className="font-medium">Storage</span>
              </div>
              <p className="text-sm text-gray-400">
                Audio: ~{systemHealth.storage?.estimated_audio_mb || 0} MB
              </p>
              <p className="text-sm text-gray-400">
                Images: ~{systemHealth.storage?.estimated_image_mb || 0} MB
              </p>
            </div>

            <div className="bg-[#212121] p-4 rounded">
              <div className="flex items-center gap-2 mb-2">
                <MdBarChart className="text-xl text-yellow-500" />
                <span className="font-medium">Issues</span>
              </div>
              {systemHealth.issues?.map((issue, index) => (
                <p key={index} className="text-sm text-yellow-400">
                  {issue.type}: {issue.count}
                </p>
              ))}
            </div>
          </div>
        </div>
      )}

      {activityLogs.length > 0 && (
        <div className="bg-[#181818] p-6 rounded-lg">
          <h3 className="text-xl font-bold mb-4">Recent Activity</h3>
          <div className="space-y-2 max-h-96 overflow-y-auto">
            {activityLogs.map((log, index) => (
              <div key={index} className="flex justify-between items-center p-2 bg-[#212121] rounded text-sm">
                <div className="flex items-center gap-3">
                  <span className={`px-2 py-1 rounded text-xs ${
                    log.action === 'play' ? 'bg-green-600' :
                    log.action === 'registration' ? 'bg-blue-600' :
                    'bg-purple-600'
                  }`}>
                    {log.action}
                  </span>
                  <span>{log.user_name}</span>
                  <span className="text-gray-400">{log.song_title}</span>
                </div>
                <span className="text-gray-500">
                  {new Date(log.timestamp).toLocaleString()}
                </span>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  );

  return (
    <div className="min-h-screen bg-[#212121] text-white">
      {/* Navigation Tabs */}
      <div className="bg-[#181818] border-b border-gray-700">
        <div className="max-w-7xl mx-auto px-4">
          <nav className="flex space-x-8">
            {[
              { id: 'dashboard', label: 'Dashboard', icon: MdAnalytics },
              { id: 'content', label: 'Content Management', icon: MdLibraryMusic },
              { id: 'analytics', label: 'Analytics', icon: MdPeople },
              { id: 'system', label: 'System Health', icon: MdMonitorHeart }
            ].map(tab => (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id)}
                className={`flex items-center gap-2 py-4 px-2 border-b-2 font-medium text-sm transition-colors ${
                  activeTab === tab.id 
                    ? 'border-green-500 text-green-500' 
                    : 'border-transparent text-gray-400 hover:text-white'
                }`}
              >
                <tab.icon className="text-lg" />
                {tab.label}
              </button>
            ))}
            <Link
              to="/database-admin"
              className="flex items-center gap-2 py-4 px-2 border-b-2 font-medium text-sm transition-colors border-transparent text-gray-400 hover:text-white hover:border-blue-500"
              title="Database Admin Panel"
            >
              <MdStorage className="text-lg" />
              Database Admin
            </Link>
          </nav>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-7xl mx-auto p-6">
        {activeTab === 'dashboard' && renderDashboard()}
        {activeTab === 'content' && renderContentManagement()}
        {activeTab === 'analytics' && renderAnalytics()}
        {activeTab === 'system' && renderSystemHealth()}
      </div>
    </div>
  );
};

export default Admin;
