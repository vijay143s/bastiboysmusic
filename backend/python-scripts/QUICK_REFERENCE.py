#!/usr/bin/env python3
"""
QUICK REFERENCE - Unified Language Scraper & SQL Import
One-page quick start guide
"""

QUICK_START = """
╔════════════════════════════════════════════════════════════════════════════╗
║           UNIFIED LANGUAGE SCRAPER - QUICK REFERENCE (v1.0)               ║
╚════════════════════════════════════════════════════════════════════════════╝

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 THREE-STEP WORKFLOW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

STEP 1: SCRAPE (Generate JSON)
  └─ python scraper_unified.py
     Output: pagalworld_hindi_unified.json (20 items: 5 albums + 15 songs)

STEP 2: GENERATE SQL (Create SQL file)
  └─ python generate_sql_unified.py
     Output: insert_unified_hindi.sql (ready to execute)

STEP 3: IMPORT TO DATABASE (Execute SQL)
  └─ mysql -u root -p your_db < insert_unified_hindi.sql
     Result: Data inserted with auto-linked album IDs

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 DATA FIELDS (Unified Structure)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

COMMON (All Items)
  ├─ type: "album" | "song"
  ├─ id: unique_id
  ├─ title: Name
  ├─ url: Full URL
  ├─ language: "hindi"
  ├─ image_url: Thumbnail (might be null)
  ├─ image_url_high: ✅ REAL artwork (no placeholders)
  ├─ description: Metadata
  └─ source: "language_page_unified"

ALBUMS (Only in albums)
  ├─ year: 2025
  ├─ director: Name
  ├─ music_director: Composer
  └─ [More fields as available]

SONGS (Only in songs)
  ├─ singer: Vocalist
  ├─ artist: Artist
  ├─ album_name: Album title
  ├─ audio_url: ✅ Download link
  ├─ duration: "03:52"
  ├─ year: 2025
  ├─ music_director: Composer
  └─ [More fields as available]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✨ KEY FEATURES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Real Image URLs        - No placeholders (/default.webp)
✅ Audio URLs Extracted   - Download links included
✅ Unified Data           - Albums & songs in one structure
✅ All Fields Captured    - 15+ fields per item
✅ Smart Album Linking    - COALESCE auto-lookup
✅ Zero Configuration     - Works as-is
✅ 100% Success Rate      - No errors on Hindi page 1

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📈 HINDI PAGE 1 RESULTS (Sample)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total Items: 20
├─ Albums: 5 ✅
│  ├─ Dhurandhar
│  ├─ De De Pyaar De 2 Deluxe Album
│  ├─ Ek Deewane Ki Deewaniyat
│  ├─ Tere Ishk Mein
│  └─ 120 Bahadur Original Motion Picture Soundtrack
│
└─ Songs: 15 ✅
   ├─ Tu Meri Main Tera Main Tera Tu Meri Title Track
   ├─ Chal Musafir From Gustaakh Ishq
   ├─ Hey Penne
   ├─ Ishq Jalakar Karvaan From Dhurandhar
   ├─ [... 10 more songs]
   └─ Chikiri Chikiri From Peddi Hindi

Image URLs: 20/20 ✅ (Real .jpg files)
Audio URLs: 15/15 ✅ (Download links)
Errors: 0

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔄 SQL STRUCTURE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ALBUMS INSERT (5 statements)
  ├─ Uses INSERT IGNORE (won't error on duplicates)
  ├─ Fields: title, description, thumbnail_url, year, director, music_director, language
  └─ Auto-increment ID assigned by MySQL

SONGS INSERT (15 statements)
  ├─ Uses COALESCE for smart album lookup:
  │  └─ COALESCE((SELECT id FROM albums WHERE title = 'Album Name'), 1)
  ├─ Fields: album_id, title, singer, thumbnail_url, audio_url
  └─ If album not found, defaults to album_id = 1

VERIFICATION QUERIES
  ├─ Check album count
  ├─ Check song count
  └─ Check album-song relationships

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💻 EXECUTION COMMANDS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# 1. SCRAPE
cd backend/python-scripts
python scraper_unified.py

# 2. GENERATE SQL
python generate_sql_unified.py

# 3. BACKUP (Important!)
mysqldump -u root -p your_db > backup_$(date +%Y%m%d).sql

# 4. IMPORT
mysql -u root -p your_db < insert_unified_hindi.sql

# 5. VERIFY
mysql -u root -p your_db -e "
  SELECT COUNT(*) as albums FROM albums WHERE language='hindi';
  SELECT COUNT(*) as songs FROM songs WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 HOUR);
"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 OUTPUT FILES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

pagalworld_hindi_unified.json
  ├─ Type: JSON
  ├─ Size: ~50 KB
  ├─ Contents: 20 items (5 albums + 15 songs)
  └─ Fields: All metadata, URLs, dates, etc.

insert_unified_hindi.sql
  ├─ Type: SQL
  ├─ Size: ~20 KB
  ├─ Contents: 20 INSERT statements + verification
  └─ Ready: Yes (can execute directly)

IMPORT_REPORT_HINDI.md
  ├─ Type: Markdown
  ├─ Contents: Complete data summary
  └─ Use: Review before import

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚨 IMPORTANT NOTES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. BACKUP FIRST
   ├─ Always backup before running SQL
   └─ USE: mysqldump

2. ALBUM IDs ARE AUTO-INCREMENT
   ├─ Don't need to know them beforehand
   ├─ COALESCE handles lookup
   └─ Defaults to album_id=1 if not found

3. IMAGE URLs ARE REAL
   ├─ Format: https://pagalworldmusic.com/downloads/cover/XXXX/XXXX.jpg
   ├─ No more: https://pagalworldmusic.com/default.webp
   └─ Verified: 100% JPG/PNG files

4. AUDIO URLs ARE RELATIVE
   ├─ Format: /download.php?title=...
   ├─ Prefix: https://pagalworldmusic.com
   └─ Full: https://pagalworldmusic.com/download.php?title=...

5. RATE LIMITING INCLUDED
   ├─ 0.5-1 second delays between requests
   ├─ Respectful scraping
   └─ No server blocking

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔧 CUSTOMIZATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CHANGE LANGUAGE:
  Edit scraper_unified.py main():
  └─ scraper.scrape_language(language='punjabi', pages=1)

ADD MORE PAGES:
  └─ scraper.scrape_language(language='hindi', pages=3)

MODIFY SQL TEMPLATE:
  Edit generate_sql_unified.py:
  └─ Modify INSERT statement fields

BATCH SCRAPE:
  for lang in hindi punjabi tamil telugu; do
    python -c "
from scraper_unified import UnifiedLanguageScraper
s = UnifiedLanguageScraper()
s.scrape_language('$lang')
s.save_results()
    "
  done

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ STATUS & NEXT STEPS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ COMPLETED:
  ├─ Language-wise scraping
  ├─ Image URL extraction (real artwork)
  ├─ Audio URL extraction
  ├─ Unified data structure
  ├─ SQL generation with COALESCE
  ├─ Pagination support
  └─ Error handling

📋 NEXT STEPS:
  1. Review pagalworld_hindi_unified.json
  2. Check IMPORT_REPORT_HINDI.md
  3. Backup database
  4. Execute insert_unified_hindi.sql
  5. Verify data in database
  6. (Optional) Add singer/artist relationships

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

For detailed documentation, see: UNIFIED_SCRAPER_COMPLETE_GUIDE.md

Version: 1.0 | Status: ✅ Production Ready | Last Updated: 2025-12-04
"""

if __name__ == "__main__":
    print(QUICK_START)
