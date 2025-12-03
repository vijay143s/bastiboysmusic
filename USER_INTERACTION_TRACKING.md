# User Interaction Tracking & Recommendation System

## Overview
This document describes the newly implemented user interaction tracking and recommendation system for BastiBoys Music app.

## Database Schema

### New Tables Created

#### 1. `user_interactions`
Tracks all user interactions with songs (plays, likes, skips, completions)
- `id` - Primary key
- `user_id` - Foreign key to users table
- `song_id` - Foreign key to songs table
- `interaction_type` - ENUM('play', 'like', 'skip', 'complete')
- `created_at` - Timestamp

**Indexes:**
- `idx_user_song` - For quick user-song lookups
- `idx_interaction_type` - For filtering by interaction type
- `idx_created_at` - For time-based queries

#### 2. `user_listening_history`
Tracks detailed listening sessions with duration and completion rates
- `id` - Primary key
- `user_id` - Foreign key to users table
- `song_id` - Foreign key to songs table
- `listen_duration_seconds` - How long the user listened
- `completion_percentage` - Percentage of song played (0-100)
- `source` - Where the song was played from ('album', 'playlist', 'search', 'queue', 'artist')
- `created_at` - Timestamp

**Indexes:**
- `idx_user_history` - For user listening history queries
- `idx_song_history` - For song popularity analysis
- `idx_completion` - For completion rate analysis

#### 3. `user_search_history`
Tracks search queries for trend analysis
- `id` - Primary key
- `user_id` - Foreign key to users table (nullable for anonymous searches)
- `search_query` - The search text
- `results_count` - Number of results returned
- `clicked_song_id` - Song that was clicked from results (nullable)
- `created_at` - Timestamp

**Indexes:**
- `idx_user_searches` - For user search history
- `idx_search_query` - For trending searches
- `idx_created_at` - For recent searches

#### 4. `song_skips`
Tracks when and where users skip songs
- `id` - Primary key
- `user_id` - Foreign key to users table
- `song_id` - Foreign key to songs table
- `skip_position_seconds` - Where in the song the skip occurred
- `reason` - 'beginning', 'middle', or 'end'
- `created_at` - Timestamp

**Indexes:**
- `idx_user_skips` - For user skip patterns
- `idx_skip_patterns` - For song skip analysis

### Enhanced Existing Tables

#### `songs` table - New columns
- `play_count` - Total play count
- `skip_count` - Total skip count
- `like_count` - Total likes
- `avg_completion_rate` - Average completion percentage

#### `user_playlists` table - New columns
- `last_played_at` - When the song was last played from playlist
- `play_count` - How many times played from playlist

## Backend API Endpoints

### Tracking Endpoints

#### POST `/api/interaction/track/play/:songId`
Track when a user plays a song
- **Auth Required:** Yes
- **Body:** 
  ```json
  {
    "source": "album|playlist|search|queue|artist",
    "listenDuration": 120
  }
  ```
- **Response:** Success message

#### POST `/api/interaction/track/completion/:songId`
Track song completion with listening duration
- **Auth Required:** Yes
- **Body:**
  ```json
  {
    "listenDuration": 180,
    "totalDuration": 200,
    "source": "album"
  }
  ```
- **Response:** 
  ```json
  {
    "success": true,
    "message": "Completion tracked successfully",
    "completionPercentage": 90
  }
  ```

#### POST `/api/interaction/track/skip/:songId`
Track when a user skips a song
- **Auth Required:** Yes
- **Body:**
  ```json
  {
    "skipPosition": 30,
    "totalDuration": 200
  }
  ```
- **Response:** Success message with skip reason

#### POST `/api/interaction/track/search`
Track search queries
- **Auth Required:** No (optional)
- **Body:**
  ```json
  {
    "query": "search term",
    "resultsCount": 15,
    "clickedSongId": 123
  }
  ```
- **Response:** Success message

### Recommendation Endpoints

#### GET `/api/interaction/recommendations?limit=20`
Get personalized recommendations based on user behavior
- **Auth Required:** Yes
- **Query Params:**
  - `limit` - Number of recommendations (default: 20)
- **Response:**
  ```json
  {
    "success": true,
    "recommendations": [...songs],
    "reason": "Based on your listening history"
  }
  ```

#### GET `/api/interaction/stats`
Get user's listening statistics
- **Auth Required:** Yes
- **Response:**
  ```json
  {
    "success": true,
    "stats": {
      "totalPlays": 1234,
      "totalListeningTime": 5678,
      "topSongs": [...],
      "recentSearches": [...]
    }
  }
  ```

#### GET `/api/interaction/trending?limit=20&days=7`
Get trending songs based on recent activity
- **Auth Required:** No
- **Query Params:**
  - `limit` - Number of songs (default: 20)
  - `days` - Time period (default: 7)
- **Response:**
  ```json
  {
    "success": true,
    "trending": [...songs],
    "period": "Last 7 days"
  }
  ```

## Frontend Implementation

### Search Page Enhancements

#### Empty State Content
When no search query is entered, users see:
1. **Recent Searches** - Quick access to previous searches
2. **Trending Now** - Popular songs from last 7 days
3. **Recommended For You** - Personalized suggestions (auth required)
4. **Browse Categories** - Quick navigation cards

#### Search Results
- Year filter chips for quick filtering
- Enhanced song cards with play buttons
- Album grid display
- Result counts
- Clear empty states with actionable buttons

#### Interaction Tracking
- Automatically tracks search queries when users click results
- Records clicked songs for better recommendations
- Logs search result counts

### Home Page - Years Section (Mobile Only)

Added a "Browse by Year" section visible only on mobile devices:
- Shows 6 most recent years
- Year cards with album counts
- Direct navigation to year details
- Responsive grid layout

### Years Page Improvements

- Years now sorted from latest to oldest (descending order)
- URL query param support (`?year=2024`)
- Auto-loads albums when year param is present
- Better mobile experience

## How to Use

### 1. Apply Database Schema
```bash
mysql -u your_user -p your_database < backend/database/user_interactions_schema.sql
```

### 2. Restart Backend Server
The interaction routes are automatically loaded in `backend/index.js`

### 3. Frontend Usage Example

```javascript
// Track a play
await axios.post(`/api/interaction/track/play/${songId}`, {
  source: 'album',
  listenDuration: 0
});

// Track completion when song ends
await axios.post(`/api/interaction/track/completion/${songId}`, {
  listenDuration: currentTime,
  totalDuration: duration,
  source: 'album'
});

// Track skip
await axios.post(`/api/interaction/track/skip/${songId}`, {
  skipPosition: currentTime,
  totalDuration: duration
});

// Get recommendations
const { data } = await axios.get('/api/interaction/recommendations?limit=20');
```

## Recommendation Algorithm

The system uses the following logic:

1. **For New Users (No History)**
   - Returns globally popular songs (by play count)

2. **For Existing Users**
   - Analyzes last 10 well-listened songs (>50% completion)
   - Finds albums from those songs
   - Recommends other popular songs from same albums
   - Prioritizes songs user hasn't played much
   - Sorts by: play count → completion rate → user play count

3. **Trending Songs**
   - Counts unique listeners in time period
   - Counts total plays
   - Ranks by unique listeners first, then plays

## Privacy Considerations

- Search tracking works for both authenticated and anonymous users
- Anonymous searches have `user_id` set to NULL
- All user data respects foreign key cascades for GDPR compliance
- Users can be deleted and all their interaction data will cascade delete

## Performance Optimization

All tables include proper indexes for:
- Fast user lookups
- Efficient time-based queries
- Quick aggregations for statistics
- Optimized recommendation queries

## Future Enhancements

1. **Machine Learning Integration**
   - Train ML models on user behavior
   - Collaborative filtering
   - Content-based filtering

2. **Advanced Analytics**
   - Listen-through rate by time of day
   - Genre preferences
   - Artist affinity scoring

3. **Social Features**
   - Friend recommendations
   - Shared playlists tracking
   - Social listening sessions

4. **A/B Testing**
   - Test different recommendation algorithms
   - Track algorithm performance
   - Optimize for engagement

## Troubleshooting

### Recommendations Not Showing
- Check if user has listening history (`user_listening_history` table)
- Verify songs have `play_count` > 0
- Check if albums are properly linked to songs

### Trending Section Empty
- Verify there are recent entries in `user_listening_history`
- Check the `days` parameter (default is 7)
- Ensure songs have proper album relationships

### Search Tracking Not Working
- Check if search endpoint is called after user clicks a result
- Verify search queries are being logged
- Check browser console for API errors
