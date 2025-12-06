# Pagal World Language Scraper - Implementation Guide

## Overview
Created a web scraper to extract albums and songs by language from pagalworldmusic.com

## Files Created

### 1. Local Test Scrapers
- `pagalworld_language_scraper_working.py` - Main working scraper
  - Scrapes 8+ languages (Hindi, Marathi, Tamil, Telugu, Kannada, Punjabi, Gujarati, Bengali)
  - Extracts albums with metadata (title, URL, image, song count)
  - Logs detailed progress to `pagalworld_language_scraper.log`
  - Saves results to `pagalworld_language_results.json`

### 2. Test Scripts
- `pagalworld_scraper_test_v2.py` - Page structure analyzer
- `test_language_scraper.py` - Quick test runner

## How It Works

### Page Structure
The Pagal World language pages use:
- HTML with server-rendered content
- Album links in format: `/album/{id}/{slug}`
- Structure: `<div class="track">` > `<a class="track-link">` > album data

### Scraping Logic
1. Fetches language page (e.g., `/language/hindi`)
2. Finds all `.track` containers
3. Extracts album details:
   - **Title**: From the track title
   - **URL**: `/album/{id}/{slug}` format
   - **Image**: From `<img src>`
   - **Song Count**: From "Total songs = X" text
   - **Language**: Captured from request parameter

### Data Structure
```json
{
  "albums": [
    {
      "type": "album",
      "title": "Album Name",
      "url": "https://pagalworldmusic.com/album/...",
      "slug": "album-id",
      "language": "Hindi",
      "image": "https://c.saavncdn.com/...",
      "song_count": 10,
      "scrape_timestamp": "2025-12-04T18:52:46.241..."
    }
  ],
  "songs": [],
  "errors": []
}
```

## Running the Scraper Locally

```bash
cd backend/python-scripts
python pagalworld_language_scraper_working.py
```

This generates:
- `pagalworld_language_scraper.log` - Detailed logs
- `pagalworld_language_results.json` - Results data

## Log Output Example

```
======================================================================
PAGAL WORLD LANGUAGE-BASED SCRAPER
======================================================================

Starting scrape for 8 languages

======================================================================
SCRAPING: Hindi (hindi)
======================================================================
URL: https://pagalworldmusic.com/language/hindi

[Status: 200]
Found 20 track containers

  [Album: Dhurandhar]
  [Album: De De Pyaar De 2 Deluxe Album]
  ...

======================================================================
SUMMARY for Hindi
  Albums found: 20
  Songs found: 0
======================================================================
```

## Next Steps for UI Integration

1. **Create Backend Route**
   - Endpoint: `POST /api/scraper/language`
   - Body: `{ language: 'hindi', limit: 50 }`
   - Returns: Albums + songs for that language

2. **Create React Component**
   - Language selector dropdown
   - Progress indicator during scrape
   - Results table with albums
   - Option to import to database

3. **Database Integration**
   - Store language metadata
   - Link albums to language
   - Track scrape history

## Features Included

✅ Multi-language support
✅ Detailed logging with timestamps
✅ Error handling and reporting
✅ Rate limiting (2 sec between requests)
✅ JSON output format
✅ Image URL capture
✅ Song count extraction
✅ UTF-8 encoding support

## Known Issues

- Unicode characters in logs cause Windows encoding warnings (cosmetic only)
- Page loads content dynamically, so full song list might not be visible
- Some albums may not have images

## Improvements for Next Release

- [ ] Implement pagination for large result sets
- [ ] Add song-level scraping from album pages
- [ ] Cache results to reduce API calls
- [ ] Add filtering by release date
- [ ] Implement Selenium for JavaScript-loaded content
- [ ] Add database persistence
- [ ] Create UI dashboard for scraper management
