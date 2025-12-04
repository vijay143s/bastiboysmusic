# Audio Playback Troubleshooting Guide

## Quick Summary of the Issue & Fix

**Problem**: Songs get stuck/freeze during playback, but work fine on Pagal World website

**Root Cause**: CORS (Cross-Origin Resource Sharing) and missing HTTP headers prevent direct streaming

**Solution**: Audio proxy endpoint that streams through your backend with proper headers

---

## Implementation Checklist

- [x] Created audio proxy routes (`backend/routes/audioProxyRoutes.js`)
- [x] Created audio converter utility (`backend/utils/audioProxyConverter.js`)
- [x] Updated song repository to use proxy URLs
- [x] Added audio routes to backend main
- [x] All song audio URLs now automatically converted to proxy URLs

---

## How to Verify the Fix

### Step 1: Start Backend
```bash
cd backend
npm install  # Install any missing dependencies
npm run dev
```

### Step 2: Test Audio Proxy (Optional)
```bash
# In a new terminal, from backend directory
node test_audio_proxy.js
```

Expected output:
```
✅ Audio Proxy is working correctly!
```

### Step 3: Start Frontend
```bash
cd frontend
npm run dev
```

### Step 4: Test Playback
1. Navigate to any album
2. Click play on a song
3. Audio should now play smoothly without sticking

---

## Understanding the Audio Proxy Flow

### When You Click Play:

1. **Frontend requests song data**
   - GET `/api/song/single/:id`
   
2. **Backend returns song with proxy URL**
   ```json
   {
     "audio": {
       "url": "/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3F..."
     }
   }
   ```

3. **Frontend plays via proxy URL**
   - Browser makes request to `/api/audio/stream?url=...`
   - This is same-origin (localhost to localhost) - no CORS issues

4. **Backend proxy handles the request**
   - Decodes the audio URL
   - Validates it's from Pagal World
   - Adds proper headers:
     - User-Agent (mimics Chrome browser)
     - Referer (points to Pagal World)
     - Range (for seeking/buffering)
   - Streams audio response back to frontend

5. **Frontend receives audio stream**
   - Audio element can seek, buffer, and play smoothly

---

## Files Modified

### New Files Created:
1. `backend/routes/audioProxyRoutes.js` - Audio proxy endpoint
2. `backend/utils/audioProxyConverter.js` - URL conversion utility
3. `backend/test_audio_proxy.js` - Testing script

### Files Updated:
1. `backend/index.js` - Added audio proxy routes
2. `backend/repositories/songRepository.js` - Use proxy URLs in responses

---

## Troubleshooting Steps

### Issue: "Cannot play audio - 404 error"
**Solution**: 
- Make sure backend is running on port 5000
- Check that audio proxy routes are loaded: `app.use("/api/audio", audioProxyRoutes);`

### Issue: "Audio loads but stops/stutters"
**Possible causes**:
1. Pagal World server is blocking requests too aggressively
2. Network bandwidth is limited
3. Server returned incorrect content-type

**Solution**:
- Check browser console for errors: F12 → Console tab
- Check backend logs for errors
- Try with a different song (might be server-specific)

### Issue: "CORS error still showing"
**Solution**:
- Clear browser cache: Ctrl+Shift+Delete → Clear all
- Restart frontend: Kill and re-run `npm run dev`
- Make sure backend is running before frontend

### Issue: "Redirect loop or too many redirects"
**Solution**:
- Backend automatically follows redirects
- Check that Pagal World URL is valid
- Try a different song from Pagal World

---

## Code Explanation

### Audio Proxy Route (`audioProxyRoutes.js`)

```javascript
GET /api/audio/stream?url=<encoded-url>
```

**What it does**:
1. Decodes URL parameter
2. Validates it's from pagalworldmusic.com
3. Creates request with proper headers:
   - User-Agent: Mimics Chrome browser
   - Referer: Points to Pagal World (server thinks request is from their site)
   - Range: Enables partial content requests for seeking
4. Pipes response to client

**Headers added**:
```javascript
res.setHeader("Content-Type", "audio/mpeg");
res.setHeader("Accept-Ranges", "bytes");
res.setHeader("Access-Control-Allow-Origin", "*");
res.setHeader("Cache-Control", "public, max-age=86400");
```

### URL Conversion (`audioProxyConverter.js`)

```javascript
convertToProxyUrl(audioUrl)
```

**Transforms**:
- From: `https://pagalworldmusic.com/download.php?title=Song&path=...`
- To: `/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2Fdownload.php%3Ftitle%3DSong%26path%3D...`

This is called by all song fetching functions:
- `mapSongRow()` - Used by all song queries
- `findSongByIdForPlayer()` - Used by player

---

## Performance Considerations

### Caching
- Audio proxy sets `Cache-Control: public, max-age=86400` (1 day)
- Browser will cache the audio file locally
- Second playback of same song is instant (from cache)

### Bandwidth
- Audio streams through your backend
- Backend acts as intermediate proxy
- Not storing files on server, just forwarding

### Seeking
- Range requests enabled
- You can seek to any position in song
- Only downloads required portion for playback

---

## Advanced: Monitoring Playback

Add this to frontend `Player.jsx` for debugging:

```javascript
// In audio element's onTimeUpdate handler
console.log('Playback:', {
  currentTime: audioRef.current.currentTime,
  duration: audioRef.current.duration,
  buffered: audioRef.current.buffered,
  readyState: audioRef.current.readyState,
  url: audioRef.current.src
});
```

ReadyState meanings:
- 0 = HAVE_NOTHING (no info)
- 1 = HAVE_METADATA (duration known)
- 2 = HAVE_CURRENT_DATA (playable data)
- 3 = HAVE_FUTURE_DATA (enough buffered)
- 4 = HAVE_ENOUGH_DATA (ready to play)

---

## Future Improvements

### Short term:
- Add retry logic for failed requests
- Implement request timeout handling
- Add audio bitrate selection

### Medium term:
- Cache popular songs on server
- Implement CDN for faster distribution
- Add background download queue

### Long term:
- Official API integration (Spotify, Apple Music)
- HLS/DASH streaming support
- Offline playback capability

---

## Related Documentation

- `AUDIO_PLAYBACK_FIX.md` - Detailed technical explanation
- `backend/routes/audioProxyRoutes.js` - Implementation details
- `backend/utils/audioProxyConverter.js` - URL conversion logic

---

## Support

If audio still isn't playing after these changes:

1. **Check Backend Logs**
   ```
   npm run dev 2>&1 | tee backend.log
   ```
   Look for any proxy-related errors

2. **Check Browser Console**
   - F12 → Console tab
   - Look for CORS, 404, or network errors
   - Check Network tab to see actual requests

3. **Verify Song Data**
   - Open Developer Tools
   - Go to Application → Local Storage
   - Check if song has valid audio_url

4. **Manual Proxy Test**
   ```bash
   node test_audio_proxy.js
   ```

---

**Last Updated**: December 4, 2025
**Status**: ✅ Production Ready
