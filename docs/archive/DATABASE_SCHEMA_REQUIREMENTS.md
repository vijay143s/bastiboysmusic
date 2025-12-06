# Database Schema Analysis - Required Fields

## Current Schema Overview

Your database has the following main tables for storing music content:

### 1. **USERS Table**
```sql
CREATE TABLE users (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(191) NOT NULL,
  email VARCHAR(191) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('user', 'admin') NOT NULL DEFAULT 'user',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

**Fields Required:**
- `name` - User's full name
- `email` - Unique email address
- `password_hash` - Encrypted password
- `role` - 'user' or 'admin'

---

### 2. **ALBUMS Table** ⭐ KEY TABLE FOR SCRAPER
```sql
CREATE TABLE albums (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) UNIQUE,
    description TEXT,
    thumbnail_id INT,
    thumbnail_url VARCHAR(500),
    year INT,
    director VARCHAR(255),
    music_director VARCHAR(255),
    star_cast TEXT,
    language VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

**Fields Required (from Pagal World scraper):**
- ✅ `title` - Album name
- ❓ `description` - Album description (not in scraper output)
- ❓ `thumbnail_id` - Cloudinary/local storage ID
- ✅ `thumbnail_url` - Album image URL
- ✅ `year` - Release year (need to extract from album page)
- ❓ `director` - Film director
- ❓ `music_director` - Music composer
- ❓ `star_cast` - Cast information
- ✅ `language` - Language (automatically captured!)

**Data from Scraper:**
```json
{
  "title": "Dhurandhar",
  "thumbnail_url": "https://c.saavncdn.com/475/Dhurandhar-Hindi-2025-20251202104241-150x150.jpg",
  "language": "Hindi",
  "song_count": 6
}
```

**Mapping:**
```
Scraper Data → Database Field
─────────────────────────────
.title → albums.title
.image → albums.thumbnail_url
.language → albums.language
.song_count → (informational, not stored)
```

---

### 3. **SONGS Table** ⭐ NEEDS DATA FROM ALBUM PAGES
```sql
CREATE TABLE songs (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    album_id INT UNSIGNED NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    singer VARCHAR(255),
    thumbnail_id INT,
    thumbnail_url VARCHAR(500),
    audio_id INT,
    audio_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (album_id) REFERENCES albums(id) ON DELETE CASCADE
);
```

**Fields Required:**
- `album_id` - Reference to parent album
- ✅ `title` - Song title
- ❓ `description` - Song description
- ✅ `singer` - Singer/artist name
- ❓ `thumbnail_id` - Song image ID
- ✅ `thumbnail_url` - Song image URL
- ❓ `audio_id` - Audio file storage ID
- ❓ `audio_url` - Direct link to MP3 file

**Note:** Current scraper gets song titles from language pages, but full song details require scraping individual album pages.

---

### 4. **ARTISTS Table**
```sql
CREATE TABLE artists (
    artist_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    artist_name VARCHAR(255),
    album_id INT UNSIGNED NOT NULL,
    album_name VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (album_id) REFERENCES albums(id) ON DELETE CASCADE,
    UNIQUE KEY unique_artist_album (artist_id, album_id)
);
```

**Fields Required:**
- `artist_name` - Artist/performer name
- `album_id` - Reference to album
- `album_name` - Album name (redundant, available in albums table)

---

### 5. **SINGERS Table**
```sql
CREATE TABLE singers (
    singer_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    singer_name VARCHAR(255) NOT NULL,
    UNIQUE KEY unique_singer_name (singer_name)
);
```

**Fields Required:**
- `singer_name` - Unique singer name

---

### 6. **MUSIC_DIRECTORS Table**
```sql
CREATE TABLE music_directors (
    director_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    director_name VARCHAR(255) NOT NULL,
    album_id INT UNSIGNED NOT NULL,
    album_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (album_id) REFERENCES albums(id) ON DELETE CASCADE,
    UNIQUE KEY unique_director_album (director_id, album_id)
);
```

**Fields Required:**
- `director_name` - Music director name
- `album_id` - Reference to album
- `album_name` - Album name

---

### 7. **USER_PLAYLISTS Table**
```sql
CREATE TABLE user_playlists (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  song_id INT UNSIGNED NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_playlist_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_playlist_song FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE,
  CONSTRAINT uniq_playlist UNIQUE (user_id, song_id)
);
```

**Fields Required:**
- `user_id` - User who created playlist
- `song_id` - Song in playlist

---

## Data Extraction Priority

### Phase 1: Scraper Already Provides ✅
From `pagalworld_language_scraper_working.py`:
```
✅ Album Title
✅ Album Image URL
✅ Album Language
✅ Song Count per Album
✅ Song Titles
```

### Phase 2: Need Additional Scraping 🔄
Need to scrape individual album pages:
```
❌ Song Audio URL (MP3 download link)
❌ Song Singer/Artist name
❌ Album Description
❌ Album Release Year
❌ Album Director
❌ Music Director
❌ Star Cast
```

### Phase 3: Manual/Optional 📝
```
❌ Thumbnail IDs (use Cloudinary)
❌ Audio IDs (use storage service)
❌ Song Descriptions
```

---

## Data Mapping Example

### From Scraper Output to Database

**Input from Scraper:**
```json
{
  "type": "album",
  "title": "Dhurandhar",
  "url": "https://pagalworldmusic.com/album/ft4MGKjYem0_/dhurandhar",
  "slug": "dhurandhar",
  "language": "Hindi",
  "image": "https://c.saavncdn.com/475/Dhurandhar-Hindi-2025-20251202104241-150x150.jpg",
  "song_count": 6,
  "scrape_timestamp": "2025-12-04T18:55:08.027579"
}
```

**Insert into ALBUMS:**
```sql
INSERT INTO albums (title, thumbnail_url, language) VALUES (
  'Dhurandhar',
  'https://c.saavncdn.com/475/Dhurandhar-Hindi-2025-20251202104241-150x150.jpg',
  'Hindi'
);
```

**Songs from same album (need to scrape album page):**
```sql
INSERT INTO songs (album_id, title, singer, thumbnail_url) VALUES (
  1,
  'Song Title 1',
  'Singer Name',
  'image_url'
);
```

---

## Complete Field Checklist

### Required Fields (MUST HAVE)
- [x] Album Title
- [x] Album Language
- [x] Album Image URL
- [x] Song Title
- [x] Song Album Reference

### Recommended Fields (SHOULD HAVE)
- [ ] Album Description
- [ ] Album Year
- [ ] Album Director
- [ ] Music Director
- [ ] Star Cast
- [ ] Singer Name
- [ ] Song Audio URL

### Optional Fields (NICE TO HAVE)
- [ ] Song Description
- [ ] Thumbnail IDs
- [ ] Audio IDs
- [ ] Release Date
- [ ] Duration

---

## SQL Queries for Data Import

### Insert Album from Scraper:
```sql
INSERT INTO albums (title, thumbnail_url, language, created_at)
VALUES ('Album Title', 'https://...', 'Hindi', NOW())
ON DUPLICATE KEY UPDATE updated_at = NOW();
```

### Insert Song with Album Reference:
```sql
INSERT INTO songs (album_id, title, singer, thumbnail_url, created_at)
SELECT id, 'Song Title', 'Singer Name', 'https://...', NOW()
FROM albums WHERE title = 'Album Title';
```

### Insert Singer:
```sql
INSERT IGNORE INTO singers (singer_name) VALUES ('Singer Name');
```

### Create Playlist Entry:
```sql
INSERT INTO user_playlists (user_id, song_id, created_at)
SELECT users.id, songs.id, NOW()
FROM users, songs
WHERE users.email = 'user@example.com' AND songs.title = 'Song Title';
```

---

## Summary

**Total Tables:** 7
- Users: User management
- Albums: Music collection metadata
- Songs: Individual tracks
- Artists: Album artists
- Singers: Unique singers
- Music Directors: Composers
- User Playlists: User favorites

**Scraper Contribution:** ✅ Provides 5 out of 10 key fields
**Additional Work Needed:** 🔄 Album detail scraping, Song audio URL extraction
**Manual Entry:** 📝 Director, cast, descriptions (optional)

The scraper successfully captures **language** metadata for all entries automatically!
