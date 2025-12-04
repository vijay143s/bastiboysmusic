# Stream URL Pre-Generation Strategy

**Status**: ✅ Complete | **Date**: December 4, 2025

## Problem
Audio playback was getting 403 Forbidden errors because:
1. The player was getting URLs from multiple sources (pagalworldmusic.com, sentunes.online, etc.)
2. The proxy endpoint was rejecting non-Pagal World URLs
3. Conversion was happening at runtime, causing delays

## Solution
**Smart Stream URL Generation**: Only generate proxy URLs for Pagal World, use direct URLs for others

### Architecture

```
Scraper (pagalworld_incremental_scraper.py)
    ↓
    For pagalworldmusic.com URLs:
        Generate: /api/audio/stream?url=<encoded>  → stream_url column
    
    For other domains (sentunes.online, etc.):
        Leave as NULL  → Use audio_url directly
    ↓
Database (songs table)
    - audio_url: Direct link (for all sources)
    - stream_url: Proxy link (only for Pagal World, NULL for others)
    ↓
Repository (songRepository.js)
    Priority: stream_url || audio_url
    ↓
Player
    - stream_url available? → Use proxy (Pagal World)
    - stream_url NULL? → Use audio_url directly (sentunes, etc.)
```

### Key Changes

#### 1. **Audio Proxy (audioProxyRoutes.js)**
- ✅ Reverted to Pagal World ONLY
- ❌ Rejects any non-pagalworldmusic.com URLs with 403

```javascript
// Only accepts pagalworldmusic.com URLs
if (!urlObj.hostname.includes("pagalworldmusic.com")) {
  return res.status(403).json({
    message: "Only Pagal World music streams are allowed..."
  });
}
```

#### 2. **Scraper (pagalworld_incremental_scraper.py)**
- ✅ Added `_generate_stream_url()` method
- ✅ Generates proxy URL ONLY for pagalworldmusic.com
- ✅ Returns NULL for other domains

```python
def _generate_stream_url(self, audio_url):
    """ONLY for pagalworldmusic.com URLs"""
    absolute_url = self._make_absolute_url(audio_url)
    
    if "pagalworldmusic.com" in absolute_url:
        return f"/api/audio/stream?url={quote(absolute_url, safe='')}"
    
    return None  # Other domains use audio_url directly
```

#### 3. **Database Schema (schema.sql)**
- ✅ Added `stream_url VARCHAR(500)` column after audio_url
- ✅ NEW column created during scraping

```sql
CREATE TABLE songs (
    ...
    audio_url VARCHAR(500),      -- Direct URL for all sources
    stream_url VARCHAR(500),     -- Proxy URL for Pagal World only (NULL for others)
    ...
);
```

#### 4. **SQL Generation (_generate_songs_sql)**
- ✅ Now includes stream_url in INSERT statement
- ✅ Populates stream_url during scraping if pagalworldmusic.com

```sql
INSERT INTO songs (
    album_id, title, singer, thumbnail_url, 
    audio_url, stream_url,  -- NEW
    created_at, updated_at
) VALUES (...)
```

#### 5. **Repository (songRepository.js)**
- ✅ Updated mapSongRow to use intelligent fallback

```javascript
audio: {
    id: row.audio_id,
    // stream_url (Pagal World proxy) OR audio_url (direct, other domains)
    url: row.stream_url || row.audio_url,
}
```

- ✅ Updated all queries to SELECT stream_url:
  - getAllSongs()
  - getPlaylistSongs()
  - getSongsByAlbum()

### Behavior by Source

| Source | audio_url | stream_url | Player Uses |
|--------|-----------|-----------|------------|
| pagalworldmusic.com | Direct link | `/api/audio/stream?url=...` | **stream_url** (proxy) |
| sentunes.online | Direct link | NULL | **audio_url** (direct) |
| Other domains | Direct link | NULL | **audio_url** (direct) |

### Migration

#### For New Database (Fresh Install)
Just run scraper - stream_url will be auto-populated during scraping

#### For Existing Database
**Option 1**: Run migration script (recommended)
```bash
cd backend/python-scripts
python migrate_stream_urls.py
```

This will:
1. Add stream_url column if missing
2. Find all pagalworldmusic.com songs without stream_url
3. Generate proxy URLs for them
4. Update database

**Option 2**: Manual SQL
```sql
ALTER TABLE songs 
ADD COLUMN IF NOT EXISTS stream_url VARCHAR(500) AFTER audio_url;
```
Then re-scrape with updated scraper - new songs will have stream_url.

### Expected Results

✅ **Pagal World songs**
- audio_url: `https://pagalworldmusic.com/.../song.mp3`
- stream_url: `/api/audio/stream?url=https%3A%2F%2Fpagalworldmusic.com%2F...%2Fsong.mp3`
- Player receives: `stream_url` → plays through proxy ✓

✅ **Sentunes/Other domain songs**
- audio_url: `https://sentunes.online/.../song.mp3`
- stream_url: `NULL`
- Player receives: `audio_url` → plays directly ✓

### Benefits

1. **No runtime conversion** - Stream URL pre-generated during scraping
2. **Instant playback** - No conversion delay when clicking next
3. **Domain-specific handling** - Only Pagal World through proxy, others direct
4. **CORS bypass** - Pagal World audio works through proxy
5. **No breaking changes** - Other domains continue working with direct URLs

### Testing

```bash
# Run scraper to populate stream_url
cd backend/python-scripts
python pagalworld_incremental_scraper.py --mode full --language hindi --pages 1 --execute-sql

# Migration for existing data (optional)
python migrate_stream_urls.py

# Restart backend
cd ../..
npm run dev (in backend/)
```

### Debugging

If songs still fail:

1. **Check stream_url in database**
   ```sql
   SELECT id, title, audio_url, stream_url FROM songs LIMIT 5;
   ```
   - Pagal World songs should have stream_url populated
   - Other domain songs should have stream_url = NULL

2. **Check audio URL in player**
   - Browser DevTools → Network tab
   - Look for `/api/audio/stream?url=...` (Pagal World)
   - Or direct URL (other domains)

3. **Check proxy response**
   ```
   Status: 200 OK
   Content-Type: audio/mpeg
   Access-Control-Allow-Origin: *
   ```

## Files Modified

- ✅ `backend/routes/audioProxyRoutes.js` - Restricted to Pagal World
- ✅ `backend/python-scripts/pagalworld_incremental_scraper.py` - Added stream URL generation
- ✅ `backend/database/schema.sql` - Added stream_url column
- ✅ `backend/repositories/songRepository.js` - Updated to use stream_url
- ✅ `backend/database/add_stream_url_column.sql` - Migration file
- ✅ `backend/python-scripts/migrate_stream_urls.py` - Python migration script

## Deployment Steps

1. Update backend code (all files above)
2. Run migration:
   ```bash
   python backend/python-scripts/migrate_stream_urls.py
   ```
3. Run fresh scrape with updated scraper:
   ```bash
   python pagalworld_incremental_scraper.py --mode full --execute-sql
   ```
4. Restart backend: `npm run dev`
5. Test playback: Click on a Pagal World song → should play instantly

---

**Summary**: Pre-generated stream URLs for Pagal World only, direct playback for other domains. Zero runtime conversion, instant playback, no breaking changes.
