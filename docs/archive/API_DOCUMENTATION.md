# BastiBoys Music API Documentation

A comprehensive music streaming platform API built with Node.js, Express, and MySQL.

## Table of Contents

- [Getting Started](#getting-started)
- [Authentication](#authentication)
- [User APIs](#user-apis)
- [Song APIs](#song-apis)
- [Home/Content APIs](#homecontent-apis)
- [User Interaction APIs](#user-interaction-apis)
- [Error Handling](#error-handling)
- [Rate Limiting](#rate-limiting)

## Getting Started

### Base URL
```
http://localhost:5000/api
```

### Authentication
Most endpoints require authentication via JWT token sent as HTTP-only cookie. The token is automatically set upon login/register.

## User APIs

### 1. Register User
**POST** `/api/user/register`

Creates a new user account.

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "SecurePass123"
}
```

**Password Requirements:**
- Minimum 8 characters
- At least one uppercase letter
- At least one lowercase letter  
- At least one number

**Response:**
```json
{
  "success": true,
  "message": "User Registered",
  "user": {
    "id": 1,
    "_id": "1",
    "name": "John Doe",
    "email": "john@example.com",
    "role": "user",
    "playlist": [],
    "lastPlayedSongId": null,
    "createdAt": "2025-12-04T12:00:00Z",
    "updatedAt": "2025-12-04T12:00:00Z"
  }
}
```

### 2. Login User
**POST** `/api/user/login`

Authenticates user and sets JWT cookie.

**Request Body:**
```json
{
  "email": "john@example.com",
  "password": "SecurePass123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "User Logged In",
  "user": {
    "id": 1,
    "_id": "1",
    "name": "John Doe",
    "email": "john@example.com",
    "role": "user",
    "playlist": [
      {
        "id": 1,
        "title": "Song Title",
        "thumbnailUrl": "https://example.com/thumb.jpg"
      }
    ],
    "lastPlayedSongId": 5
  }
}
```

### 3. Get User Profile
**GET** `/api/user/me`

Returns current user's profile information.

**Headers:**
```
Cookie: token=jwt_token_here
```

**Response:**
```json
{
  "success": true,
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "role": "user",
    "playlist": [],
    "lastPlayedSongId": null
  }
}
```

### 4. Logout User
**GET** `/api/user/logout`

Clears authentication cookie.

**Response:**
```json
{
  "success": true,
  "message": "User Logged Out"
}
```

### 5. Add Song to Playlist
**POST** `/api/user/song/:id`

Adds or removes a song from user's playlist (toggle functionality).

**Parameters:**
- `id` (path): Song ID

**Response (Add):**
```json
{
  "success": true,
  "message": "Song added to playlist"
}
```

**Response (Remove):**
```json
{
  "success": true,
  "message": "Song removed from playlist"
}
```

### 6. Update Last Played Song
**POST** `/api/user/last-played`

Updates user's last played song.

**Request Body:**
```json
{
  "songId": 123
}
```

**Response:**
```json
{
  "success": true,
  "message": "Last played song updated"
}
```

### 7. Get Community Playlists
**GET** `/api/user/playlists/all`

Returns all users' playlists for community features.

**Response:**
```json
{
  "success": true,
  "playlists": [
    {
      "userId": 1,
      "userName": "John Doe",
      "songs": [
        {
          "id": 1,
          "title": "Song Title",
          "thumbnailUrl": "https://example.com/thumb.jpg"
        }
      ]
    }
  ]
}
```

## Song APIs

### 1. Get All Songs
**GET** `/api/song/all`

Returns paginated list of all songs.

**Query Parameters:**
- `page` (optional): Page number (default: 1)
- `limit` (optional): Items per page (default: 20)

**Response:**
```json
{
  "success": true,
  "songs": [
    {
      "id": 1,
      "title": "Song Title",
      "albumId": 1,
      "albumName": "Album Name",
      "thumbnailUrl": "https://example.com/thumb.jpg",
      "songUrl": "https://example.com/song.mp3",
      "playCount": 150,
      "year": 2023,
      "singers": ["Singer 1", "Singer 2"],
      "artists": ["Artist 1"],
      "musicDirectors": ["Director 1"]
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 10,
    "totalSongs": 200,
    "hasNext": true,
    "hasPrev": false
  }
}
```

### 2. Get Single Song
**GET** `/api/song/single/:id`

Returns detailed information about a specific song.

**Parameters:**
- `id` (path): Song ID

**Response:**
```json
{
  "success": true,
  "song": {
    "id": 1,
    "title": "Song Title",
    "albumId": 1,
    "albumName": "Album Name",
    "thumbnailUrl": "https://example.com/thumb.jpg",
    "songUrl": "https://example.com/song.mp3",
    "playCount": 150,
    "year": 2023,
    "singers": ["Singer 1", "Singer 2"],
    "artists": ["Artist 1"],
    "musicDirectors": ["Director 1"]
  }
}
```

### 3. Search Songs
**GET** `/api/song/search`

Search for songs with various filters.

**Query Parameters:**
- `q`: Search query (song title, singer, artist, etc.)
- `year` (optional): Filter by year
- `page` (optional): Page number
- `limit` (optional): Items per page

**Example:**
```
GET /api/song/search?q=love&year=2023&page=1&limit=10
```

**Response:**
```json
{
  "success": true,
  "results": [
    {
      "id": 1,
      "title": "Love Song",
      "albumName": "Album Name",
      "thumbnailUrl": "https://example.com/thumb.jpg",
      "year": 2023,
      "singers": ["Singer 1"]
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 5,
    "hasNext": true
  }
}
```

### 4. Get Top Played Songs
**GET** `/api/song/top-played`

Returns most played songs with shuffle option.

**Query Parameters:**
- `limit` (optional): Number of songs (default: 20)
- `shuffle` (optional): Shuffle results (true/false)

**Response:**
```json
{
  "success": true,
  "songs": [
    {
      "id": 1,
      "title": "Popular Song",
      "playCount": 1000,
      "albumName": "Hit Album",
      "thumbnailUrl": "https://example.com/thumb.jpg",
      "singers": ["Popular Singer"]
    }
  ]
}
```

### 5. Get Queue Songs
**GET** `/api/song/queue`

Returns optimized song data for queue functionality.

**Response:**
```json
{
  "success": true,
  "songs": [
    {
      "id": 1,
      "title": "Song Title",
      "songUrl": "https://example.com/song.mp3",
      "thumbnailUrl": "https://example.com/thumb.jpg"
    }
  ]
}
```

### 6. Get Songs by Year
**GET** `/api/song/queue/year/:year`

Returns songs from a specific year.

**Parameters:**
- `year` (path): Year (e.g., 2023)

**Response:**
```json
{
  "success": true,
  "year": 2023,
  "songs": [
    {
      "id": 1,
      "title": "2023 Hit",
      "thumbnailUrl": "https://example.com/thumb.jpg"
    }
  ]
}
```

### 7. Get Available Years
**GET** `/api/song/queue/years`

Returns list of years that have songs.

**Response:**
```json
{
  "success": true,
  "years": [2023, 2022, 2021, 2020]
}
```

### 8. Update Play Count
**POST** `/api/song/:id/play`

Increments play count for a song.

**Parameters:**
- `id` (path): Song ID

**Response:**
```json
{
  "success": true,
  "message": "Play count updated",
  "playCount": 151
}
```

### 9. Get User's Playlist Songs
**GET** `/api/song/playlist`

Returns songs in current user's playlist.

**Headers:**
```
Cookie: token=jwt_token_here
```

**Response:**
```json
{
  "success": true,
  "playlist": [
    {
      "id": 1,
      "title": "Playlist Song",
      "thumbnailUrl": "https://example.com/thumb.jpg",
      "songUrl": "https://example.com/song.mp3"
    }
  ]
}
```

## Album APIs

### 1. Get All Albums
**GET** `/api/song/album/all`

Returns all albums.

**Response:**
```json
{
  "success": true,
  "albums": [
    {
      "id": 1,
      "title": "Album Title",
      "year": 2023,
      "thumbnailUrl": "https://example.com/album-thumb.jpg",
      "songCount": 10,
      "artists": ["Artist 1"],
      "musicDirectors": ["Director 1"]
    }
  ]
}
```

### 2. Get Songs by Album
**GET** `/api/song/album/:id`

Returns all songs in a specific album.

**Parameters:**
- `id` (path): Album ID

**Response:**
```json
{
  "success": true,
  "album": {
    "id": 1,
    "title": "Album Title",
    "year": 2023,
    "thumbnailUrl": "https://example.com/album-thumb.jpg"
  },
  "songs": [
    {
      "id": 1,
      "title": "Song 1",
      "thumbnailUrl": "https://example.com/thumb.jpg",
      "songUrl": "https://example.com/song.mp3"
    }
  ]
}
```

### 3. Get Top Years
**GET** `/api/song/years/top`

Returns top 10 years based on song count.

**Response:**
```json
{
  "success": true,
  "years": [
    {
      "year": 2023,
      "songCount": 150,
      "albumCount": 20
    },
    {
      "year": 2022,
      "songCount": 120,
      "albumCount": 15
    }
  ]
}
```

### 4. Get Albums by Year
**GET** `/api/song/years/:year/albums`

Returns albums from a specific year with their songs.

**Parameters:**
- `year` (path): Year

**Response:**
```json
{
  "success": true,
  "year": 2023,
  "albums": [
    {
      "id": 1,
      "title": "2023 Album",
      "thumbnailUrl": "https://example.com/album-thumb.jpg",
      "songs": [
        {
          "id": 1,
          "title": "Song Title",
          "thumbnailUrl": "https://example.com/thumb.jpg"
        }
      ]
    }
  ]
}
```

## Home/Content APIs

### 1. Get Latest Albums (Smart)
**GET** `/api/home/albums/latest-smart`

Returns intelligently selected latest albums.

**Response:**
```json
{
  "success": true,
  "albums": [
    {
      "id": 1,
      "title": "Latest Album",
      "year": 2023,
      "thumbnailUrl": "https://example.com/album-thumb.jpg",
      "songCount": 8,
      "artists": ["Artist 1"],
      "isNew": true
    }
  ]
}
```

### 2. Get Latest Albums by Year
**GET** `/api/home/albums/latest`

Returns latest albums grouped by year.

**Response:**
```json
{
  "success": true,
  "albumsByYear": {
    "2023": [
      {
        "id": 1,
        "title": "2023 Album",
        "thumbnailUrl": "https://example.com/album-thumb.jpg"
      }
    ],
    "2022": [
      {
        "id": 2,
        "title": "2022 Album",
        "thumbnailUrl": "https://example.com/album-thumb.jpg"
      }
    ]
  }
}
```

### 3. Get Albums (Paginated)
**GET** `/api/home/albums`

Returns paginated albums.

**Query Parameters:**
- `page` (optional): Page number
- `limit` (optional): Items per page

**Response:**
```json
{
  "success": true,
  "albums": [
    {
      "id": 1,
      "title": "Album Title",
      "year": 2023,
      "thumbnailUrl": "https://example.com/album-thumb.jpg"
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 10,
    "hasNext": true
  }
}
```

### 4. Get Songs by Album ID
**GET** `/api/home/albums/:albumId/songs`

Returns songs for a specific album.

**Parameters:**
- `albumId` (path): Album ID

**Response:**
```json
{
  "success": true,
  "album": {
    "id": 1,
    "title": "Album Title",
    "year": 2023
  },
  "songs": [
    {
      "id": 1,
      "title": "Song Title",
      "thumbnailUrl": "https://example.com/thumb.jpg",
      "songUrl": "https://example.com/song.mp3"
    }
  ]
}
```

## Artist APIs

### 1. Get Top Artists
**GET** `/api/home/artists/top`

Returns top artists section.

**Response:**
```json
{
  "success": true,
  "artists": [
    {
      "id": 1,
      "name": "Artist Name",
      "albumCount": 5,
      "imageUrl": "https://example.com/artist.jpg"
    }
  ]
}
```

### 2. Get All Artists (Paginated)
**GET** `/api/home/artists`

Returns paginated list of artists.

**Query Parameters:**
- `page`, `limit`: Standard pagination

**Response:**
```json
{
  "success": true,
  "artists": [
    {
      "id": 1,
      "name": "Artist Name",
      "albumCount": 5
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 20
  }
}
```

### 3. Get Albums by Artist
**GET** `/api/home/artists/:artistId/albums`

Returns albums by a specific artist.

**Parameters:**
- `artistId` (path): Artist ID

**Response:**
```json
{
  "success": true,
  "artist": {
    "id": 1,
    "name": "Artist Name"
  },
  "albums": [
    {
      "id": 1,
      "title": "Album by Artist",
      "year": 2023,
      "thumbnailUrl": "https://example.com/album-thumb.jpg"
    }
  ]
}
```

## Singer APIs

### 1. Get Top Singers
**GET** `/api/home/singers/top`

Returns top singers section.

**Response:**
```json
{
  "success": true,
  "singers": [
    {
      "name": "Singer Name",
      "songCount": 25,
      "imageUrl": "https://example.com/singer.jpg"
    }
  ]
}
```

### 2. Get All Singers (Paginated)
**GET** `/api/home/singers`

Returns paginated list of singers.

**Response:**
```json
{
  "success": true,
  "singers": [
    {
      "name": "Singer Name",
      "songCount": 25
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 15
  }
}
```

### 3. Get Songs by Singer
**GET** `/api/home/singers/:singerName/songs`

Returns songs by a specific singer.

**Parameters:**
- `singerName` (path): Singer name (URL encoded)

**Response:**
```json
{
  "success": true,
  "singer": {
    "name": "Singer Name"
  },
  "songs": [
    {
      "id": 1,
      "title": "Song by Singer",
      "albumName": "Album Name",
      "thumbnailUrl": "https://example.com/thumb.jpg"
    }
  ]
}
```

## Music Director APIs

### 1. Get Top Music Directors
**GET** `/api/home/music-directors/top`

Returns top music directors section.

**Response:**
```json
{
  "success": true,
  "musicDirectors": [
    {
      "name": "Director Name",
      "albumCount": 10,
      "imageUrl": "https://example.com/director.jpg"
    }
  ]
}
```

### 2. Get All Music Directors (Paginated)
**GET** `/api/home/music-directors`

Returns paginated list of music directors.

**Response:**
```json
{
  "success": true,
  "musicDirectors": [
    {
      "name": "Director Name",
      "albumCount": 10
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 8
  }
}
```

### 3. Get Albums by Music Director
**GET** `/api/home/music-directors/:directorName/albums`

Returns albums by a specific music director.

**Parameters:**
- `directorName` (path): Director name (URL encoded)

**Response:**
```json
{
  "success": true,
  "musicDirector": {
    "name": "Director Name"
  },
  "albums": [
    {
      "id": 1,
      "title": "Album by Director",
      "year": 2023,
      "thumbnailUrl": "https://example.com/album-thumb.jpg"
    }
  ]
}
```

## Search APIs (Optimized)

### 1. Get Albums for Search
**GET** `/api/home/search/albums`

Returns minimal album data for search functionality.

**Response:**
```json
{
  "success": true,
  "albums": [
    {
      "id": 1,
      "title": "Album Title",
      "year": 2023
    }
  ]
}
```

### 2. Get Artists for Search
**GET** `/api/home/search/artists`

**Response:**
```json
{
  "success": true,
  "artists": [
    {
      "id": 1,
      "name": "Artist Name"
    }
  ]
}
```

### 3. Get Singers for Search
**GET** `/api/home/search/singers`

**Response:**
```json
{
  "success": true,
  "singers": [
    {
      "name": "Singer Name"
    }
  ]
}
```

### 4. Get Music Directors for Search
**GET** `/api/home/search/music-directors`

**Response:**
```json
{
  "success": true,
  "musicDirectors": [
    {
      "name": "Director Name"
    }
  ]
}
```

## User Interaction APIs

### 1. Track Play
**POST** `/api/interaction/track/play/:songId`

Tracks when a song starts playing.

**Parameters:**
- `songId` (path): Song ID

**Request Body:**
```json
{
  "timestamp": "2025-12-04T12:00:00Z",
  "position": 0
}
```

**Response:**
```json
{
  "success": true,
  "message": "Play tracked"
}
```

### 2. Track Completion
**POST** `/api/interaction/track/completion/:songId`

Tracks when a song is completed.

**Parameters:**
- `songId` (path): Song ID

**Request Body:**
```json
{
  "duration": 180,
  "timestamp": "2025-12-04T12:03:00Z"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Completion tracked"
}
```

### 3. Track Skip
**POST** `/api/interaction/track/skip/:songId`

Tracks when a song is skipped.

**Parameters:**
- `songId` (path): Song ID

**Request Body:**
```json
{
  "position": 45,
  "timestamp": "2025-12-04T12:00:45Z"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Skip tracked"
}
```

### 4. Track Search
**POST** `/api/interaction/track/search`

Tracks search queries (works without authentication).

**Request Body:**
```json
{
  "query": "love songs",
  "timestamp": "2025-12-04T12:00:00Z"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Search tracked"
}
```

### 5. Get Recommendations
**GET** `/api/interaction/recommendations`

Returns personalized song recommendations.

**Query Parameters:**
- `limit` (optional): Number of recommendations

**Response:**
```json
{
  "success": true,
  "recommendations": [
    {
      "id": 1,
      "title": "Recommended Song",
      "thumbnailUrl": "https://example.com/thumb.jpg",
      "score": 0.95,
      "reason": "Based on your listening history"
    }
  ]
}
```

### 6. Get Listening Stats
**GET** `/api/interaction/stats`

Returns user's listening statistics.

**Response:**
```json
{
  "success": true,
  "stats": {
    "totalPlays": 150,
    "totalListeningTime": 18000,
    "topGenres": ["Pop", "Rock"],
    "topArtists": ["Artist 1", "Artist 2"],
    "averageSessionDuration": 1200
  }
}
```

### 7. Get Trending Songs
**GET** `/api/interaction/trending`

Returns currently trending songs.

**Query Parameters:**
- `limit` (optional): Number of trending songs

**Response:**
```json
{
  "success": true,
  "trending": [
    {
      "id": 1,
      "title": "Trending Song",
      "thumbnailUrl": "https://example.com/thumb.jpg",
      "trendScore": 0.98,
      "playCount": 5000
    }
  ]
}
```

### 8. Get Queue Songs (Interaction)
**GET** `/api/interaction/queue`

Returns songs for queue based on user interactions.

**Response:**
```json
{
  "success": true,
  "queue": [
    {
      "id": 1,
      "title": "Queue Song",
      "thumbnailUrl": "https://example.com/thumb.jpg",
      "priority": 1
    }
  ]
}
```

## Admin APIs

*Note: These endpoints require admin role authentication.*

### 1. Create Album
**POST** `/api/song/album/new`

Creates a new album.

**Headers:**
```
Content-Type: multipart/form-data
```

**Form Data:**
```
title: Album Title
year: 2023
thumbnail: [file upload]
```

**Response:**
```json
{
  "success": true,
  "message": "Album created successfully",
  "album": {
    "id": 1,
    "title": "Album Title",
    "year": 2023,
    "thumbnailUrl": "https://example.com/album-thumb.jpg"
  }
}
```

### 2. Add Song
**POST** `/api/song/new`

Adds a new song to the platform.

**Headers:**
```
Content-Type: multipart/form-data
```

**Form Data:**
```
title: Song Title
albumId: 1
songFile: [audio file upload]
thumbnail: [image file upload - optional]
```

**Response:**
```json
{
  "success": true,
  "message": "Song added successfully",
  "song": {
    "id": 1,
    "title": "Song Title",
    "albumId": 1,
    "songUrl": "https://example.com/song.mp3",
    "thumbnailUrl": "https://example.com/thumb.jpg"
  }
}
```

### 3. Add Thumbnail to Song
**POST** `/api/song/:id/thumbnail`

Adds or updates thumbnail for an existing song.

**Parameters:**
- `id` (path): Song ID

**Headers:**
```
Content-Type: multipart/form-data
```

**Form Data:**
```
thumbnail: [image file upload]
```

**Response:**
```json
{
  "success": true,
  "message": "Thumbnail updated successfully",
  "thumbnailUrl": "https://example.com/new-thumb.jpg"
}
```

### 4. Add Singer to Song
**POST** `/api/song/:id/singer`

Associates a singer with a song.

**Parameters:**
- `id` (path): Song ID

**Request Body:**
```json
{
  "singerName": "Singer Name"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Singer added to song"
}
```

### 5. Add Artist to Album
**POST** `/api/song/album/:id/artist`

Associates an artist with an album.

**Parameters:**
- `id` (path): Album ID

**Request Body:**
```json
{
  "artistName": "Artist Name"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Artist added to album"
}
```

### 6. Add Music Director to Album
**POST** `/api/song/album/:id/musicdirector`

Associates a music director with an album.

**Parameters:**
- `id` (path): Album ID

**Request Body:**
```json
{
  "musicDirectorName": "Director Name"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Music director added to album"
}
```

### 7. Delete Song
**DELETE** `/api/song/:id`

Deletes a song from the platform.

**Parameters:**
- `id` (path): Song ID

**Response:**
```json
{
  "success": true,
  "message": "Song deleted successfully"
}
```

## Error Handling

All APIs follow a consistent error response format:

```json
{
  "success": false,
  "message": "Error description",
  "error": "Detailed error information (in development)"
}
```

### Common HTTP Status Codes

- `200` - Success
- `201` - Created successfully
- `400` - Bad request (validation errors)
- `401` - Unauthorized (invalid credentials/token)
- `403` - Forbidden (insufficient permissions)
- `404` - Not found
- `409` - Conflict (e.g., email already exists)
- `429` - Too many requests (rate limited)
- `500` - Internal server error

### Validation Errors

```json
{
  "success": false,
  "message": "Validation failed",
  "errors": [
    {
      "field": "email",
      "message": "Please provide a valid email address"
    },
    {
      "field": "password",
      "message": "Password must contain at least one number"
    }
  ]
}
```

## Rate Limiting

Authentication endpoints (`/login`, `/register`) are rate limited:
- 10 requests per 15 minutes per IP address
- Exceeding the limit returns HTTP 429

```json
{
  "success": false,
  "message": "Too many requests. Please try again later."
}
```

## File Upload Guidelines

### Supported Formats

**Audio Files:**
- MP3, WAV, AAC
- Max size: 50MB

**Image Files:**
- JPG, PNG, WebP
- Max size: 5MB
- Recommended dimensions: 500x500px (square)

### Upload Response

```json
{
  "success": true,
  "message": "File uploaded successfully",
  "fileUrl": "https://cloudinary.com/path/to/file",
  "publicId": "file_public_id"
}
```

## Pagination

Most list endpoints support pagination:

**Query Parameters:**
- `page`: Page number (default: 1)
- `limit`: Items per page (default: 20, max: 100)

**Response Format:**
```json
{
  "success": true,
  "data": [...],
  "pagination": {
    "currentPage": 1,
    "totalPages": 10,
    "totalItems": 200,
    "itemsPerPage": 20,
    "hasNext": true,
    "hasPrev": false
  }
}
```

## Environment Variables

Required environment variables:

```env
PORT=5000
DB_HOST=localhost
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DB_NAME=your_db_name
JWT_SECRET=your_jwt_secret
Cloud_Name=your_cloudinary_name
Cloud_Api=your_cloudinary_api_key
Cloud_Secret=your_cloudinary_api_secret
```

## Getting Started

1. Clone the repository
2. Install dependencies: `npm install`
3. Set up environment variables
4. Initialize database: `python backend/database/init_db.py`
5. Start development server: `npm run dev`
6. API will be available at `http://localhost:5000/api`

## Testing

Use tools like Postman, curl, or any HTTP client to test the APIs. Most endpoints require authentication, so start by registering/logging in to get the JWT cookie.

Example using curl:

```bash
# Register
curl -X POST http://localhost:5000/api/user/register \
  -H "Content-Type: application/json" \
  -d '{"name":"John Doe","email":"john@example.com","password":"SecurePass123"}' \
  -c cookies.txt

# Get profile (using saved cookies)
curl -X GET http://localhost:5000/api/user/me \
  -b cookies.txt
```

## Admin Dashboard APIs

*Note: All admin endpoints require authentication and admin role.*

### 1. Get Dashboard Statistics
**GET** `/api/admin/dashboard/stats`

Returns comprehensive platform statistics.

**Headers:**
```
Cookie: token=jwt_token_here
```

**Response:**
```json
{
  "success": true,
  "stats": {
    "users": {
      "total": 1500,
      "recent": 12
    },
    "songs": {
      "total": 8500,
      "recent": 25
    },
    "albums": {
      "total": 450
    },
    "artists": {
      "total": 200
    },
    "singers": {
      "total": 180
    },
    "musicDirectors": {
      "total": 75
    },
    "plays": {
      "total": 125000
    },
    "topSongsToday": [
      {
        "title": "Popular Song",
        "play_count": 1250,
        "album_title": "Hit Album"
      }
    ]
  }
}
```

### 2. Get User Analytics
**GET** `/api/admin/analytics/users`

Returns user registration and activity analytics.

**Query Parameters:**
- `period` (optional): Number of days (default: 7)

**Response:**
```json
{
  "success": true,
  "analytics": {
    "registrations": [
      {
        "date": "2025-12-04",
        "count": 15
      }
    ],
    "roleDistribution": [
      {
        "role": "user",
        "count": 1485
      },
      {
        "role": "admin", 
        "count": 15
      }
    ],
    "activeUsers": [
      {
        "name": "John Doe",
        "email": "john@example.com",
        "interactions": 45,
        "last_activity": "2025-12-04T12:00:00Z"
      }
    ]
  }
}
```

### 3. Get Content Analytics
**GET** `/api/admin/analytics/content`

Returns content performance analytics.

**Query Parameters:**
- `period` (optional): Number of days (default: 7)

**Response:**
```json
{
  "success": true,
  "analytics": {
    "mostPlayedSongs": [
      {
        "title": "Hit Song",
        "play_count": 5000,
        "album_title": "Popular Album",
        "singers": "Singer A, Singer B"
      }
    ],
    "albumPerformance": [
      {
        "title": "Best Album",
        "year": 2023,
        "song_count": 12,
        "total_plays": 25000
      }
    ],
    "contentUploads": [
      {
        "date": "2025-12-04",
        "song_count": 8
      }
    ]
  }
}
```

### 4. Get System Health
**GET** `/api/admin/system/health`

Returns system status and health metrics.

**Response:**
```json
{
  "success": true,
  "health": {
    "database": "healthy",
    "storage": {
      "estimated_audio_mb": 2500.75,
      "estimated_image_mb": 125.50
    },
    "issues": [
      {
        "type": "missing_thumbnail",
        "count": 15
      },
      {
        "type": "missing_audio",
        "count": 2
      }
    ],
    "timestamp": "2025-12-04T12:00:00Z"
  }
}
```

### 5. Get Activity Logs
**GET** `/api/admin/activity/logs`

Returns recent platform activity.

**Query Parameters:**
- `limit` (optional): Number of logs (default: 50, max: 100)

**Response:**
```json
{
  "success": true,
  "activities": [
    {
      "action": "play",
      "user_name": "John Doe",
      "song_title": "Song Title",
      "timestamp": "2025-12-04T12:00:00Z"
    },
    {
      "action": "registration",
      "user_name": "Jane Smith",
      "song_title": "New user registered",
      "timestamp": "2025-12-04T11:30:00Z"
    },
    {
      "action": "upload",
      "user_name": "Admin",
      "song_title": "New Song Added",
      "timestamp": "2025-12-04T11:00:00Z"
    }
  ]
}
```

### 6. Bulk Delete Songs
**DELETE** `/api/admin/songs/bulk`

Deletes multiple songs at once.

**Request Body:**
```json
{
  "songIds": [123, 456, 789]
}
```

**Response:**
```json
{
  "success": true,
  "message": "3 songs deleted successfully"
}
```

### 7. Update Song Metadata
**PUT** `/api/admin/songs/:songId/metadata`

Updates song metadata fields.

**Parameters:**
- `songId` (path): Song ID

**Request Body:**
```json
{
  "title": "Updated Song Title",
  "year": 2024,
  "playCount": 1500
}
```

**Response:**
```json
{
  "success": true,
  "message": "Song metadata updated successfully"
}
```

### 8. Toggle Featured Song
**PATCH** `/api/admin/songs/:songId/featured`

Toggles the featured status of a song.

**Parameters:**
- `songId` (path): Song ID

**Response:**
```json
{
  "success": true,
  "message": "Song featured successfully",
  "is_featured": true
}
```

## Admin Dashboard Features

The enhanced admin dashboard includes:

### **Dashboard Overview**
- Real-time platform statistics
- User growth metrics
- Content performance indicators
- Top performing songs
- Recent activity summary

### **Content Management**
- Enhanced album creation with validation
- Advanced song upload with metadata
- Bulk song operations (delete, update)
- Featured content management
- Thumbnail management system

### **Analytics & Reports**
- User registration trends
- Content upload analytics
- Most played songs analysis
- Album performance metrics
- Active user tracking

### **System Health**
- Database connection status
- Storage usage monitoring
- System issue detection
- Recent activity logs
- Error tracking

### **Advanced Features**
- Bulk content operations
- Featured content promotion
- Comprehensive search and filtering
- Real-time updates
- Mobile-responsive interface

---

For more information or support, please refer to the project documentation or contact the development team.