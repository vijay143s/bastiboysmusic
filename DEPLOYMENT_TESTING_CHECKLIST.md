# Deployment & Testing Checklist

## ✅ Code Changes Complete

### Backend
- ✅ `/api/song/single/{id}` endpoint - Already optimized (uses index)
- ✅ No backend changes needed

### Frontend
- ✅ Song context: Added cache state
- ✅ Song context: Pre-populate cache in playQueue()
- ✅ Song context: Check cache in fetchSingleSong()
- ✅ Player component: Uses optimized fetchSingleSong()
- ✅ Context export: songDataCache exported

## 🚀 Deployment Steps

### Step 1: Restart Frontend Dev Server
```bash
cd frontend
# Kill current server (Ctrl+C)
npm run dev
```

### Step 2: Test Basic Playback
1. Open http://localhost:5173/
2. Load a queue (click "All Songs" or any album)
3. Click play on first song
4. Verify audio plays

### Step 3: Test Next Button (Main Test)
1. Click "Next" button
2. **Expected**: Song changes INSTANTLY
3. **Before**: 200-500ms delay
4. **After**: <10ms (should feel instant)

### Step 4: Test Multiple Skips
1. Click "Next" 5-10 times rapidly
2. Each should be instant
3. Listen for console messages:
   ```
   ✅ Using CACHED song data (no API call): [Song Name]
   ```

### Step 5: Test API Fallback
1. Open DevTools → Console → Network
2. Jump to a specific song (not in current queue)
3. Should see API request: GET /api/song/single/{id}
4. Song should load after ~200ms (normal speed)

## 📊 Performance Verification

### Console Logging
Open DevTools (F12) → Console

**Good signs:**
```
✅ Using CACHED song data (no API call): Bohemian Rhapsody
✅ Using CACHED song data (no API call): Imagine
✅ Using CACHED song data (no API call): Stairway to Heaven
```

**Indicates fallback working:**
```
⏳ Fetching song from API with ID: 12345
📡 Fetched song data from API
```

### Network Tab
**Before**: Every "Next" click shows GET /api/song/single/
**After**: No GET requests when clicking next in same queue ✅

## 🎯 Test Cases

### Test 1: Album Queue
1. Click any album
2. Click "Play"
3. Click "Next" 3 times
4. **Expected**: All instant ✅

### Test 2: Top Played Queue
1. Click "Top Played" (loads from API)
2. Wait for queue to load
3. Click "Next" 5 times
4. **Expected**: All instant ✅

### Test 3: Mixed Actions
1. Play song 1
2. Click Next 2 times
3. Click Prev 1 time
4. Click Next 3 times
5. **Expected**: All instant ✅

### Test 4: Edge Cases
1. Queue has 50+ songs
2. Click through entire queue
3. Verify no slowdown
4. **Expected**: Consistent speed throughout ✅

### Test 5: Browser Cache
1. Clear browser cache (F12 → Storage → Clear All)
2. Reload page
3. Load queue
4. Click Next
5. **Expected**: First few instant, then all ✅

## ✨ Expected Results

✅ Next button: <10ms response (was 200-500ms)  
✅ No "Loading..." delays  
✅ Smooth user experience  
✅ No API requests for queue songs  
✅ Fallback API working for non-queue songs  

## 📋 Troubleshooting

### Issue: Still slow on next click
**Check:**
1. Browser cache cleared?
2. Frontend server restarted?
3. No console errors?
4. Check Network tab - is API being called?

**Solution:**
- Hard refresh: Ctrl+Shift+R
- Restart: `npm run dev` in frontend
- Check DevTools console for errors

### Issue: No cache messages in console
**Check:**
1. Are you in queue playback?
2. Is NODE_ENV development mode?
3. Check console for "Fetching from API" instead

**Solution:**
- Verify queue is loaded (status bar shows queue)
- Check browser console (F12)
- Look for either cache ✅ or API ⏳ message

### Issue: Audio not playing after fix
**Check:**
1. Is stream_url being used correctly?
2. Are errors in console?
3. Check audio URL format

**Solution:**
- See AUDIO_PLAYBACK_FIX_TEST.md
- See STREAM_URL_PREGENERATION.md

## 🔄 Rollback (if needed)

If something breaks:
1. Revert frontend changes
2. Restart dev server
3. Should be back to original state

But it shouldn't! Changes are purely additive with fallback.

## 📞 Success Criteria

✅ Clicking "Next" feels instant  
✅ No 200-500ms delay  
✅ Console shows "✅ Using CACHED"  
✅ Network tab shows NO GET requests for queue songs  
✅ All songs in queue play instantly  

---

**Status**: Ready for Testing ✅
**Expected Improvement**: 20-50x faster ✅
