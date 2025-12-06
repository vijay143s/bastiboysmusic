# Single Page Scraper Guide

The Pagalworld scraper now supports scraping **any single page** using the `--mode single` option.

## 🎯 Key Features

✅ **Incremental Mode** - No deletion of existing data
✅ **Smart Duplicate Detection** - Checks database before scraping
✅ **Album Existence Check** - Skips albums that already exist
✅ **Song Existence Check** - Skips songs that already exist
✅ **Parallel Fetching** - Fast scraping with concurrent requests
✅ **Automatic Type Detection** - Identifies album/track/listing pages
✅ **SQL Generation** - Creates INSERT statements with `INSERT IGNORE`

## How Duplicate Prevention Works

### 1. Album Check
Before scraping an album, the scraper:
- Fetches list of existing album titles from database
- Compares the target album against existing albums
- **Skips** the entire album if it already exists
- Logs: `⏭️  Album 'Name' already exists in database. Skipping.`

### 2. Song Check
For each song being added:
- Looks up the album ID in database
- Checks if song with same title exists in that album
- **Skips** the song if it already exists
- Logs: `⏭️  Skipped X existing songs (already in database)`

### 3. Database Level Protection
The generated SQL uses `INSERT IGNORE`:
- If a duplicate slips through, MySQL ignores it
- No errors, no overwrites
- Preserves existing data

## Supported Page Types

### 1. Album Pages
Scrape a complete album with all its songs:
```bash
python pagalworld_incremental_scraper.py --mode single --url "https://pagalworldmusic.com/album/vdPUsmveOwE_/yodha" --sql-output sql_output --execute-sql
```

### 2. Track Pages
Scrape a single song/track:
```bash
python pagalworld_incremental_scraper.py --mode single --url "https://pagalworldmusic.com/track/xxxxx/song-name" --sql-output sql_output --execute-sql
```

### 3. Language Listing Pages
Scrape all items from a specific page of a language listing:
```bash
# Scrape page 5 of Hindi songs
python pagalworld_incremental_scraper.py --mode single --url "https://pagalworldmusic.com/language/hindi/page/5" --sql-output sql_output --execute-sql

# Scrape first page of Punjabi songs
python pagalworld_incremental_scraper.py --mode single --url "https://pagalworldmusic.com/language/punjabi" --sql-output sql_output --execute-sql
```

## Command Options

- `--mode single` - Required: Set scraping mode to single page
- `--url "URL"` - Required: The full URL of the page to scrape
- `--sql-output DIRECTORY` - Optional: Directory for SQL output files (default: sql_output)
- `--execute-sql` - Optional: Automatically execute the generated SQL to insert data into database

## What Gets Scraped

### For Album Pages:
- Album metadata (title, image, language)
- All songs in the album
- Each song's details (title, singer, audio URL, image)

### For Track Pages:
- Single song details
- Creates a placeholder "Unknown Album" if needed

### For Language Listing Pages:
- All albums and songs displayed on that page
- Full details for each item (fetched in parallel for speed)
- Automatically detects the language from the URL

## Examples

```bash
# Just generate SQL files without executing
python pagalworld_incremental_scraper.py --mode single --url "https://pagalworldmusic.com/album/vdPUsmveOwE_/yodha" --sql-output sql_output

# Scrape and insert into database
python pagalworld_incremental_scraper.py --mode single --url "https://pagalworldmusic.com/album/vdPUsmveOwE_/yodha" --sql-output sql_output --execute-sql

# Scrape a specific page from a language
python pagalworld_incremental_scraper.py --mode single --url "https://pagalworldmusic.com/language/tamil/page/3" --execute-sql
```

## Features

✅ Parallel fetching for faster scraping
✅ Automatic page type detection
✅ Language auto-detection from URL
✅ Database integration ready
✅ SQL generation for manual review
✅ Duplicate prevention
✅ Error handling and logging

## Output

The scraper will:
1. Detect the page type automatically
2. Scrape all content from that page
3. Generate SQL files in the output directory
4. Optionally execute SQL to insert data
5. Update song thumbnails from album data

Check the logs in `logs/pagalworld_scraper.log` for detailed information.
