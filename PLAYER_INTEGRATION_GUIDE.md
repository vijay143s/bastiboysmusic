# Player Component Integration Guide

## Overview
This guide shows how to integrate user interaction tracking into the Player component.

## Required Changes to Player.jsx

### 1. Import axios
```javascript
import axios from "axios";
```

### 2. Track Play Event (When Song Starts)
Add this when a new song starts playing:

```javascript
const trackPlay = async (songId, source = 'unknown') => {
  if (!user) return; // Only track for authenticated users
  
  try {
    await axios.post(`/api/interaction/track/play/${songId}`, {
      source: source, // 'album', 'playlist', 'search', 'queue', 'artist'
      listenDuration: 0
    });
  } catch (error) {
    if (process.env.NODE_ENV === 'development') {
      console.error('Error tracking play:', error);
    }
  }
};

// Call when song starts
useEffect(() => {
  if (selectedSong && isPlaying) {
    trackPlay(selectedSong._id, queueLabel || 'unknown');
  }
}, [selectedSong, isPlaying]);
```

### 3. Track Completion Event (When Song Ends or Changes)
Add this to track listening duration:

```javascript
const trackCompletion = async (songId, listenDuration, totalDuration, source = 'unknown') => {
  if (!user || listenDuration < 5) return; // Don't track very short plays
  
  try {
    await axios.post(`/api/interaction/track/completion/${songId}`, {
      listenDuration: Math.floor(listenDuration),
      totalDuration: Math.floor(totalDuration),
      source: source
    });
  } catch (error) {
    if (process.env.NODE_ENV === 'development') {
      console.error('Error tracking completion:', error);
    }
  }
};

// Track when song ends or user changes song
useEffect(() => {
  return () => {
    // Cleanup: track completion when component unmounts or song changes
    if (selectedSong && audioRef.current) {
      const currentTime = audioRef.current.currentTime;
      const duration = audioRef.current.duration;
      if (currentTime > 5 && duration > 0) {
        trackCompletion(selectedSong._id, currentTime, duration, queueLabel || 'unknown');
      }
    }
  };
}, [selectedSong]);
```

### 4. Track Skip Event (When User Skips)
Add this to the skip/next song handler:

```javascript
const handleNext = async () => {
  if (!selectedSong || !audioRef.current) return;
  
  // Track skip if song wasn't completed
  const currentTime = audioRef.current.currentTime;
  const duration = audioRef.current.duration;
  const completionPercentage = (currentTime / duration) * 100;
  
  if (user && completionPercentage < 80 && currentTime > 5) {
    try {
      await axios.post(`/api/interaction/track/skip/${selectedSong._id}`, {
        skipPosition: Math.floor(currentTime),
        totalDuration: Math.floor(duration)
      });
    } catch (error) {
      if (process.env.NODE_ENV === 'development') {
        console.error('Error tracking skip:', error);
      }
    }
  }
  
  // Then proceed with normal next song logic
  // ... existing next song code
};
```

### 5. Track on Audio End Event
Modify the audio `onEnded` handler:

```javascript
const handleAudioEnd = async () => {
  if (selectedSong && audioRef.current) {
    // Track completion
    const duration = audioRef.current.duration;
    await trackCompletion(selectedSong._id, duration, duration, queueLabel || 'unknown');
  }
  
  // Then play next song
  handleNext();
};

// In audio element
<audio
  ref={audioRef}
  onEnded={handleAudioEnd}
  // ... other props
/>
```

## Complete Example Implementation

```javascript
// Add state for tracking
const [lastPlayedSong, setLastPlayedSong] = useState(null);
const [playStartTime, setPlayStartTime] = useState(null);

// Track play
useEffect(() => {
  if (selectedSong && isPlaying && selectedSong._id !== lastPlayedSong) {
    setLastPlayedSong(selectedSong._id);
    setPlayStartTime(Date.now());
    
    if (user) {
      axios.post(`/api/interaction/track/play/${selectedSong._id}`, {
        source: queueLabel || 'unknown',
        listenDuration: 0
      }).catch(error => {
        if (process.env.NODE_ENV === 'development') {
          console.error('Error tracking play:', error);
        }
      });
    }
  }
}, [selectedSong, isPlaying, user]);

// Track completion on song change or unmount
useEffect(() => {
  return () => {
    if (lastPlayedSong && audioRef.current && user) {
      const currentTime = audioRef.current.currentTime;
      const duration = audioRef.current.duration;
      
      if (currentTime > 5 && duration > 0) {
        axios.post(`/api/interaction/track/completion/${lastPlayedSong}`, {
          listenDuration: Math.floor(currentTime),
          totalDuration: Math.floor(duration),
          source: queueLabel || 'unknown'
        }).catch(error => {
          if (process.env.NODE_ENV === 'development') {
            console.error('Error tracking completion:', error);
          }
        });
      }
    }
  };
}, [lastPlayedSong, user]);

// Modified handleNext with skip tracking
const handleNext = async () => {
  if (selectedSong && audioRef.current && user) {
    const currentTime = audioRef.current.currentTime;
    const duration = audioRef.current.duration;
    const completionPercentage = (currentTime / duration) * 100;
    
    // Track skip if not completed
    if (completionPercentage < 80 && currentTime > 5) {
      try {
        await axios.post(`/api/interaction/track/skip/${selectedSong._id}`, {
          skipPosition: Math.floor(currentTime),
          totalDuration: Math.floor(duration)
        });
      } catch (error) {
        if (process.env.NODE_ENV === 'development') {
          console.error('Error tracking skip:', error);
        }
      }
    }
  }
  
  // Existing next song logic
  nextSong();
};

// Audio ended handler
const handleAudioEnd = () => {
  if (selectedSong && audioRef.current && user) {
    const duration = audioRef.current.duration;
    axios.post(`/api/interaction/track/completion/${selectedSong._id}`, {
      listenDuration: Math.floor(duration),
      totalDuration: Math.floor(duration),
      source: queueLabel || 'unknown'
    }).catch(error => {
      if (process.env.NODE_ENV === 'development') {
        console.error('Error tracking completion:', error);
      }
    });
  }
  
  handleNext();
};
```

## Testing

### 1. Play a Song
- Open browser dev tools
- Check Network tab for POST request to `/api/interaction/track/play/:songId`
- Verify 200 response

### 2. Let Song Complete
- Let song play to end
- Check for POST request to `/api/interaction/track/completion/:songId`
- Verify completion percentage is ~100

### 3. Skip a Song
- Play a song for a few seconds
- Click next/skip
- Check for POST request to `/api/interaction/track/skip/:songId`
- Verify skip position is recorded

### 4. Check Database
```sql
-- Check interactions
SELECT * FROM user_interactions WHERE user_id = YOUR_USER_ID ORDER BY created_at DESC LIMIT 10;

-- Check listening history
SELECT * FROM user_listening_history WHERE user_id = YOUR_USER_ID ORDER BY created_at DESC LIMIT 10;

-- Check skips
SELECT * FROM song_skips WHERE user_id = YOUR_USER_ID ORDER BY created_at DESC LIMIT 10;
```

## Important Notes

1. **Always check for user authentication** before tracking
2. **Don't track very short plays** (< 5 seconds) to avoid spam
3. **Use try-catch** to prevent tracking errors from breaking playback
4. **Development-only logging** to avoid console spam in production
5. **Fire and forget** - Don't wait for tracking responses to continue playback

## Benefits

Once integrated, you'll have:
- ✅ Real-time play tracking
- ✅ Accurate listening statistics
- ✅ Skip pattern analysis
- ✅ Better recommendations
- ✅ User engagement metrics

## Troubleshooting

### Tracking not working?
1. Check if user is authenticated (`user` exists)
2. Verify backend server is running
3. Check browser console for errors
4. Verify database tables exist
5. Check API endpoint URLs

### Duplicate tracking?
1. Ensure `lastPlayedSong` state is updated correctly
2. Add proper cleanup in useEffect
3. Check for multiple Player component instances

### Performance issues?
1. Use debouncing for frequent events
2. Batch requests if needed
3. Don't wait for responses (fire and forget)
4. Consider using a queue for offline tracking
