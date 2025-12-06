# Database Schema Update Summary

## Overview
Updated the Bastiboys Music backend database schema to support new tables for managing artists, singers, and music directors. The schema now includes enhanced album and song tables with additional metadata.

## Changes Made

### 1. Database Schema Updates (`backend/database/schema.sql`)
- **Albums Table**: Added fields for `year`, `director`, `music_director`, and `star_cast`
- **Songs Table**: Maintained original structure with proper foreign key to albums
- **New Tables**:
  - `artists`: Manage album artists with unique constraints
  - `singers`: Manage song singers with unique constraints
  - `music_directors`: Manage album music directors with unique constraints
- **Indexes**: Added performance indexes on all new tables for commonly queried fields

### 2. Database Initialization Script (`backend/database/init_db.py`)
Created a Python script to automate SQL file execution:
- Connects to MySQL using environment variables
- Executes SQL files in order (schema.sql, insert.sql)
- Provides clear error handling and logging
- Usage: `python init_db.py`
- Requires: `mysql-connector-python` package

### 3. Repository Layer Updates

#### Updated Repositories:
- **albumRepository.js**: Enhanced to include new fields (year, director, musicDirector, starCast)

#### New Repositories:
- **artistRepository.js**: Full CRUD operations for managing artists per album
- **singerRepository.js**: Full CRUD operations for managing singers per song
- **musicDirectorRepository.js**: Full CRUD operations for managing music directors per album

### 4. Controller Updates (`backend/controllers/songControllers.js`)

#### Enhanced Existing Functions:
- **createAlbum**: Now accepts year, director, musicDirector, starCast, and optional artists array
- **addSong**: Now accepts optional singers array for song singers
- **getAllSongsByAlbum**: Returns artists and music directors associated with the album
- **getSingleSong**: Returns singers associated with the song

#### New Controller Functions:
- **addArtistToAlbum**: Add individual artist to album
- **addSingerToSong**: Add individual singer to song
- **addMusicDirectorToAlbum**: Add music director to album

### 5. Routes Updates (`backend/routes/songRoutes.js`)

#### New Routes:
```
POST   /album/:id/artist                    - Add artist to album
POST   /album/:id/musicdirector            - Add music director to album
POST   /:id/singer                         - Add singer to song
GET    /album/:id                          - Get album with songs, artists, and directors
GET    /single/:id                         - Get song with singers
```

#### Updated Routes:
- Reorganized route structure for better clarity
- Changed `/album/:id` route to `/album/:id` (from `/album/:id` position)
- Better route ordering and documentation

## Data Structure Examples

### Creating an Album (Enhanced)
```javascript
{
  title: "Album Title",
  description: "Album description",
  year: 2024,
  director: "Director Name",
  musicDirector: "Music Director Name",
  starCast: "Star Cast",
  artists: [
    { name: "Artist 1" },
    { name: "Artist 2" }
  ]
}
```

### Creating a Song (Enhanced)
```javascript
{
  title: "Song Title",
  description: "Song description",
  singer: "Primary Singer",
  album: 1,
  singers: [
    { name: "Singer 1" },
    { name: "Singer 2" }
  ]
}
```

### Album Response (Enhanced)
```javascript
{
  id: 1,
  title: "Album Title",
  description: "Description",
  year: 2024,
  director: "Director Name",
  musicDirector: "Music Director Name",
  starCast: "Star Cast",
  thumbnail: { id: "...", url: "..." },
  songs: [...],
  artists: [
    { artistId: 1, artistName: "Artist 1", ... }
  ],
  musicDirectors: [
    { directorId: 1, directorName: "Director 1", ... }
  ]
}
```

## Setup Instructions

### 1. Install Python Dependencies
```bash
pip install mysql-connector-python python-dotenv
```

### 2. Initialize Database
```bash
cd backend/database
python init_db.py
```

### 3. Environment Variables
Ensure your `.env` file contains:
```
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=your_password
MYSQL_DATABASE=bastiboysmusic
```

## Backward Compatibility
- All existing endpoints remain functional
- New fields are optional in album creation
- Existing songs continue to work without singers data
- The `singer` field remains in the songs table for backward compatibility

## Database Relationships
```
albums (1) ----< (many) songs
albums (1) ----< (many) artists
albums (1) ----< (many) music_directors
songs (1) ----< (many) singers
```

## Testing
After schema update, test the following:
1. Create album with new fields
2. Create album with artists array
3. Create song with singers array
4. Fetch album with artists and directors
5. Fetch song with singers
6. Add individual artist to existing album
7. Add individual singer to existing song
8. Add music director to existing album
