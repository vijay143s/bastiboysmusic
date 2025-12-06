# Homepage Sections - Implementation Summary

## Backend Changes

### 1. Repository Functions Added

#### Album Repository (`albumRepository.js`)
- **`getLatestAlbums(year, limit)`** - Fetches albums from a specific year (default 2025)
- **`getAlbumsPaginated(page, limit)`** - Fetches albums with pagination support

#### Artist Repository (`artistRepository.js`)
- **`getTopArtists(limit)`** - Fetches top artists by album count
- **`getArtistsPaginated(page, limit)`** - Fetches artists with pagination support

#### Singer Repository (`singerRepository.js`)
- **`getTopSingers(limit)`** - Fetches top singers
- **`getSingersPaginated(page, limit)`** - Fetches singers with pagination support

#### Music Director Repository (`musicDirectorRepository.js`)
- **`getTopMusicDirectors(limit)`** - Fetches top music directors by album count
- **`getMusicDirectorsPaginated(page, limit)`** - Fetches music directors with pagination support

### 2. New Controller: `homeControllers.js`
Handles all homepage section requests:
- `getLatestAlbumsByYear` - Route: `/api/home/albums/latest`
- `getAllAlbumsPaginated` - Route: `/api/home/albums`
- `getTopArtistsSection` - Route: `/api/home/artists/top`
- `getAllArtistsPaginated` - Route: `/api/home/artists`
- `getTopSingersSection` - Route: `/api/home/singers/top`
- `getAllSingersPaginated` - Route: `/api/home/singers`
- `getTopMusicDirectorsSection` - Route: `/api/home/music-directors/top`
- `getAllMusicDirectorsPaginated` - Route: `/api/home/music-directors`

### 3. New Routes: `homeRoutes.js`
RESTful API endpoints for all homepage sections with query parameter support for pagination:
```
GET /api/home/albums/latest?year=2025&limit=10
GET /api/home/albums?page=1&limit=12
GET /api/home/artists/top?limit=10
GET /api/home/artists?page=1&limit=12
GET /api/home/singers/top?limit=10
GET /api/home/singers?page=1&limit=12
GET /api/home/music-directors/top?limit=10
GET /api/home/music-directors?page=1&limit=12
```

### 4. Updated `index.js`
- Registered new `homeRoutes` with `/api/home` prefix

---

## Frontend Changes

### 1. New Component: `HorizontalScroll.jsx`
Reusable component for horizontal scrolling sections:
- Props: `title`, `items`, `renderItem`, `onMoreClick`, `loading`
- Features:
  - Responsive horizontal scroll with smooth overflow
  - Loading skeleton animation
  - "More" button to navigate to full pages
  - Empty state handling

### 2. Updated Home Page (`Home.jsx`)
Enhanced with new sections:
- **Featured Albums** - Shows all featured albums (existing)
- **Latest Albums (2025)** - Horizontal scroll of latest albums with year filter
- **Top Artists** - Horizontal scroll showing top artists by album count
- **Top Singers** - Horizontal scroll showing top singers
- **Top Music Directors** - Horizontal scroll showing top music directors

Each section includes custom cards with circular avatars showing initials.

### 3. New Pages with Pagination

#### Albums Page (`Albums.jsx`)
- Displays all albums in a 2-4 column grid
- Pagination support with Previous/Next buttons
- Shows pagination info (current page, total pages)

#### Artists Page (`Artists.jsx`)
- Displays all artists in a grid with circular avatar cards
- Shows artist name and album count
- Pagination support

#### Singers Page (`Singers.jsx`)
- Displays all singers in a grid with circular avatar cards
- Pagination support
- Shows initials in circular badges

#### Music Directors Page (`MusicDirectors.jsx`)
- Displays all music directors in a grid with circular avatar cards
- Shows director name and album count
- Pagination support

### 4. Updated App.jsx
- Added imports for new pages
- Registered new routes:
  - `/albums`
  - `/artists`
  - `/singers`
  - `/music-directors`

---

## API Response Format

### Latest Albums Response
```json
{
  "message": "Latest albums retrieved successfully",
  "data": [
    {
      "id": 1,
      "title": "Album Title",
      "description": "Description",
      "thumbnail": { "id": "...", "url": "..." },
      "year": 2025,
      "director": "...",
      "musicDirector": "...",
      "starCast": "...",
      "_id": "1"
    }
  ],
  "count": 10
}
```

### Top Artists Response
```json
{
  "message": "Top artists retrieved successfully",
  "data": [
    {
      "artistId": 1,
      "artistName": "Artist Name",
      "albumCount": 5
    }
  ],
  "count": 10
}
```

### Paginated Response
```json
{
  "message": "Albums retrieved successfully",
  "data": [...],
  "pagination": {
    "page": 1,
    "limit": 12,
    "total": 48,
    "pages": 4
  }
}
```

---

## Features Implemented

✅ RESTful API naming conventions  
✅ Database queries optimized with GROUP BY and indexing  
✅ Pagination support on all list endpoints  
✅ Responsive grid layouts for all pages  
✅ Horizontal scroll components for homepage  
✅ Circular avatar cards with user initials  
✅ Loading states and skeletons  
✅ Empty state handling  
✅ Error handling on all endpoints  
✅ Query parameter validation  
✅ Year-based album filtering  
✅ Top items sorting by count  

---

## Usage Examples

### Homepage Horizontal Sections
```jsx
<HorizontalScroll
  title="Latest Albums (2025)"
  items={latestAlbums}
  loading={loading}
  renderItem={(album) => <AlbumCard album={album} />}
  onMoreClick={() => navigate("/albums")}
/>
```

### Fetching Data
```javascript
// Get latest albums from 2025
const response = await axios.get("/api/home/albums/latest?year=2025&limit=10");

// Get artists page 2 with 12 per page
const response = await axios.get("/api/home/artists?page=2&limit=12");
```

---

## Database Schema Notes

The implementation leverages existing tables:
- `albums` - For album data and filtering by year
- `artists` - For artist information with album associations
- `singers` - For singer data
- `music_directors` - For music director information

All queries use efficient GROUP BY clauses and existing indexes for optimal performance.

---

## Next Steps (Optional Enhancements)

- Add search functionality to pagination pages
- Add filtering by year/release date
- Add sorting options (alphabetical, most popular, etc.)
- Add related items (songs by artist, albums by director, etc.)
- Add infinite scroll as alternative to pagination
- Cache popular sections for better performance
