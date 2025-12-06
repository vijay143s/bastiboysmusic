# Data Extraction Guide - Complete Reference

## Database Tables & Required Fields

### TABLE 1: USERS
**Purpose:** User account management

| Field | Type | Required | Source | Example |
|-------|------|----------|--------|---------|
| id | INT UNSIGNED | ✅ Auto | System | 1 |
| name | VARCHAR(191) | ✅ Yes | User Input | "John Doe" |
| email | VARCHAR(191) | ✅ Yes | User Input | "john@example.com" |
| password_hash | VARCHAR(255) | ✅ Yes | Hash Function | "$2y$10$..." |
| role | ENUM('user','admin') | ✅ Yes | Default 'user' | "admin" |
| created_at | TIMESTAMP | ✅ Auto | System | 2025-12-04 18:00:00 |
| updated_at | TIMESTAMP | ✅ Auto | System | 2025-12-04 18:00:00 |

**Sample Insert:**
```sql
INSERT INTO users (name, email, password_hash, role) 
VALUES ('Admin User', 'admin@music.com', 'hashed_password', 'admin');
```

---

### TABLE 2: ALBUMS ⭐ PRIMARY DATA TABLE
**Purpose:** Store album/movie metadata

| Field | Type | Required | Scraper | Example |
|-------|------|----------|---------|---------|
| id | INT UNSIGNED | ✅ Auto | - | 1 |
| title | VARCHAR(255) | ✅ Yes | ✅ YES | "Dhurandhar" |
| description | TEXT | ❌ Optional | NO | "An action thriller..." |
| thumbnail_id | INT | ❌ Optional | NO | 12345 |
| thumbnail_url | VARCHAR(500) | ✅ Yes | ✅ YES | "https://c.saavncdn.com/..." |
| year | INT | ❌ Optional | NO | 2025 |
| director | VARCHAR(255) | ❌ Optional | NO | "Director Name" |
| music_director | VARCHAR(255) | ❌ Optional | NO | "Composer Name" |
| star_cast | TEXT | ❌ Optional | NO | "Actor1, Actor2, Actor3" |
| **language** | VARCHAR(100) | ✅ Yes | ✅ YES | "Hindi" |
| created_at | TIMESTAMP | ✅ Auto | - | 2025-12-04 18:55:08 |
| updated_at | TIMESTAMP | ✅ Auto | - | 2025-12-04 18:55:08 |

**Sample Insert (from Scraper):**
```sql
INSERT INTO albums (title, thumbnail_url, language) 
VALUES (
  'Dhurandhar',
  'https://c.saavncdn.com/475/Dhurandhar-Hindi-2025-20251202104241-150x150.jpg',
  'Hindi'
);
```

**Data from Scraper Output:**
```json
{
  "title": "Dhurandhar",
  "image": "https://c.saavncdn.com/475/Dhurandhar-Hindi-2025-20251202104241-150x150.jpg",
  "language": "Hindi",
  "song_count": 6
}
```

---

### TABLE 3: SONGS
**Purpose:** Store individual tracks

| Field | Type | Required | Source | Example |
|-------|------|----------|--------|---------|
| id | INT UNSIGNED | ✅ Auto | System | 1 |
| album_id | INT UNSIGNED | ✅ Yes | Album Table FK | 1 |
| title | VARCHAR(255) | ✅ Yes | Scraper/Album Page | "Tu Meri Main Tera" |
| description | TEXT | ❌ Optional | Album Page | "Title track from..." |
| singer | VARCHAR(255) | ✅ Yes | Album Page | "Singer Name" |
| thumbnail_id | INT | ❌ Optional | Storage | 67890 |
| thumbnail_url | VARCHAR(500) | ✅ Yes | Album Page | "https://..." |
| audio_id | INT | ❌ Optional | Storage | 11111 |
| audio_url | VARCHAR(500) | ✅ Yes | Album Page | "https://...mp3" |
| created_at | TIMESTAMP | ✅ Auto | System | 2025-12-04 18:55:08 |
| updated_at | TIMESTAMP | ✅ Auto | System | 2025-12-04 18:55:08 |

**Sample Insert:**
```sql
INSERT INTO songs (album_id, title, singer, thumbnail_url, audio_url) 
VALUES (
  1,
  'Tu Meri Main Tera',
  'Reble',
  'https://c.saavncdn.com/...',
  'https://pagalworldmusic.com/download/...'
);
```

---

### TABLE 4: ARTISTS
**Purpose:** Track album artists/contributors

| Field | Type | Required | Source | Example |
|-------|------|----------|--------|---------|
| artist_id | INT UNSIGNED | ✅ Auto | System | 1 |
| artist_name | VARCHAR(255) | ✅ Yes | Manual/Scraper | "Reble" |
| album_id | INT UNSIGNED | ✅ Yes | Album FK | 1 |
| album_name | VARCHAR(255) | ✅ Yes | Album Title | "Dhurandhar" |
| created_at | TIMESTAMP | ✅ Auto | System | 2025-12-04 18:55:08 |
| updated_at | TIMESTAMP | ✅ Auto | System | 2025-12-04 18:55:08 |

**Sample Insert:**
```sql
INSERT INTO artists (artist_name, album_id, album_name) 
VALUES ('Reble', 1, 'Dhurandhar');
```

---

### TABLE 5: SINGERS
**Purpose:** Maintain unique singer/artist registry

| Field | Type | Required | Source | Example |
|-------|------|----------|--------|---------|
| singer_id | INT UNSIGNED | ✅ Auto | System | 1 |
| singer_name | VARCHAR(255) | ✅ Yes | Songs/Artists | "Reble" |

**Sample Insert:**
```sql
INSERT IGNORE INTO singers (singer_name) VALUES ('Reble');
```

---

### TABLE 6: MUSIC_DIRECTORS
**Purpose:** Store music composers linked to albums

| Field | Type | Required | Source | Example |
|-------|------|----------|--------|---------|
| director_id | INT UNSIGNED | ✅ Auto | System | 1 |
| director_name | VARCHAR(255) | ✅ Yes | Album Info | "Music Composer Name" |
| album_id | INT UNSIGNED | ✅ Yes | Album FK | 1 |
| album_name | VARCHAR(255) | ✅ Yes | Album Title | "Dhurandhar" |
| created_at | TIMESTAMP | ✅ Auto | System | 2025-12-04 18:55:08 |
| updated_at | TIMESTAMP | ✅ Auto | System | 2025-12-04 18:55:08 |

**Sample Insert:**
```sql
INSERT INTO music_directors (director_name, album_id, album_name) 
VALUES ('Composer Name', 1, 'Dhurandhar');
```

---

### TABLE 7: USER_PLAYLISTS
**Purpose:** Store user favorites/playlists

| Field | Type | Required | Source | Example |
|-------|------|----------|--------|---------|
| id | INT UNSIGNED | ✅ Auto | System | 1 |
| user_id | INT UNSIGNED | ✅ Yes | User FK | 1 |
| song_id | INT UNSIGNED | ✅ Yes | Song FK | 42 |
| created_at | TIMESTAMP | ✅ Auto | System | 2025-12-04 18:55:08 |
| updated_at | TIMESTAMP | ✅ Auto | System | 2025-12-04 18:55:08 |

**Sample Insert:**
```sql
INSERT INTO user_playlists (user_id, song_id) VALUES (1, 42);
```

---

## Complete Data Flow for Scraper Integration

### Step 1: Import Albums from Scraper
```
Scraper Output
    ↓
    ├─ title → albums.title
    ├─ image → albums.thumbnail_url
    ├─ language → albums.language
    └─ song_count → (informational)
    ↓
Database: ALBUMS table
```

### Step 2: Scrape Album Details
```
Album Page (https://pagalworldmusic.com/album/{id}/{slug})
    ↓
    ├─ Release Year → albums.year
    ├─ Director → albums.director
    ├─ Music Director → albums.music_director
    ├─ Star Cast → albums.star_cast
    ├─ Description → albums.description
    └─ Songs List:
        ├─ Title → songs.title
        ├─ Singer → songs.singer
        ├─ Image → songs.thumbnail_url
        └─ Audio URL → songs.audio_url
    ↓
Database: ALBUMS + SONGS tables
```

### Step 3: Create Relationships
```
Songs + Artists + Singers + Music Directors
    ↓
Link to Albums via Foreign Keys
    ↓
Database: All lookup tables
```

### Step 4: User Interactions
```
User + Songs
    ↓
Add to Playlist
    ↓
Database: USER_PLAYLISTS table
```

---

## Field Data Types & Validation

### VARCHAR Fields
| Field | Max Length | Purpose |
|-------|-----------|---------|
| name | 191 | User's full name |
| email | 191 | User's email address |
| title | 255 | Album/Song title |
| singer | 255 | Single singer name |
| director | 255 | Single director name |
| artist_name | 255 | Artist name |
| singer_name | 255 | Singer name |
| director_name | 255 | Music director name |
| language | 100 | Language code/name |
| password_hash | 255 | Encrypted password |
| thumbnail_url | 500 | Image URL |
| audio_url | 500 | MP3 download URL |

### TEXT Fields
| Field | Purpose |
|-------|---------|
| description | Album/song description (long text) |
| star_cast | Multiple actors (comma-separated) |

### INT Fields
| Field | Purpose | Range |
|-------|---------|-------|
| year | Release year | 1900-2100 |
| thumbnail_id | Image storage ID | Any positive integer |
| audio_id | Audio storage ID | Any positive integer |

### ENUM Fields
| Field | Values | Purpose |
|-------|--------|---------|
| role | 'user', 'admin' | User permission level |

---

## Complete Extraction Checklist

### From Scraper (Ready Now ✅)
- [x] Album titles
- [x] Album images/thumbnails
- [x] Album language
- [x] Song titles
- [x] Song count per album

### Need Album Page Scraping 🔄
- [ ] Album release year
- [ ] Album director
- [ ] Music director
- [ ] Star cast
- [ ] Album description
- [ ] Song singers
- [ ] Song audio URLs
- [ ] Song images

### Manual Entry 📝
- [ ] User accounts (created in UI)
- [ ] Director/composer details
- [ ] Cast information
- [ ] Song descriptions
- [ ] Cloudinary image IDs
- [ ] Audio storage IDs

---

## Current Scraper Output Structure

```json
{
  "albums": [
    {
      "type": "album",
      "title": "Album Title",
      "url": "https://pagalworldmusic.com/album/{id}/{slug}",
      "slug": "album-slug",
      "language": "Hindi",
      "image": "https://c.saavncdn.com/...",
      "song_count": 10,
      "scrape_timestamp": "2025-12-04T18:55:08.027579"
    }
  ],
  "songs": [
    {
      "type": "song",
      "title": "Song Title",
      "url": "https://pagalworldmusic.com/song/...",
      "slug": "song-slug",
      "language": "Hindi",
      "image": "image_url",
      "artist": "Singer Name",
      "scrape_timestamp": "2025-12-04T18:55:08.027579"
    }
  ]
}
```

**Mapping to Database:**
| JSON Field | DB Table | DB Column | Status |
|-----------|----------|-----------|--------|
| title | albums | title | ✅ Ready |
| image | albums | thumbnail_url | ✅ Ready |
| language | albums | language | ✅ Ready |
| song_count | - | - | ℹ️ Info only |
| songs.title | songs | title | ✅ Ready |
| songs.artist | songs | singer | ✅ Ready |
| songs.image | songs | thumbnail_url | ✅ Ready |

---

## Ready-to-Use SQL Import Template

```sql
-- Insert Album
INSERT INTO albums (title, thumbnail_url, language) 
VALUES ('Album Title', 'image_url', 'Hindi');

-- Get Album ID
SET @album_id = LAST_INSERT_ID();

-- Insert Singer
INSERT IGNORE INTO singers (singer_name) VALUES ('Singer Name');

-- Insert Song
INSERT INTO songs (album_id, title, singer, thumbnail_url)
VALUES (@album_id, 'Song Title', 'Singer Name', 'song_image_url');

-- Insert Artist
INSERT INTO artists (artist_name, album_id, album_name)
VALUES ('Singer Name', @album_id, 'Album Title');
```

This guide provides complete mapping between your scraper data and database schema!
