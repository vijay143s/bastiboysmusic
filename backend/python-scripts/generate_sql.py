#!/usr/bin/env python3
"""
Generate SQL Insert Statements from Scraper JSON Output
Creates INSERT statements for albums, songs, singers, artists, and music_directors tables
"""

import json
import sys
from datetime import datetime
import re

class SQLGenerator:
    def __init__(self, json_file):
        with open(json_file, 'r', encoding='utf-8') as f:
            self.data = json.load(f)
        
        self.sql_statements = []
        self.album_ids = {}  # Map title to inserted ID
        self.singer_ids = {}  # Map singer name to inserted ID
        self.artist_ids = {}  # Map artist name to inserted ID
        self.director_ids = {}  # Map director name to inserted ID
    
    def escape_sql(self, value):
        """Escape SQL string values"""
        if value is None:
            return "NULL"
        if isinstance(value, bool):
            return "1" if value else "0"
        if isinstance(value, (int, float)):
            return str(value)
        # Escape single quotes
        escaped = str(value).replace("'", "''")
        return f"'{escaped}'"
    
    def generate_album_inserts(self):
        """Generate INSERT statements for albums"""
        print("\n📀 Generating ALBUM inserts...")
        
        for album in self.data['data']['albums']:
            title = album.get('title', 'Unknown')
            description = album.get('description', '')
            image_url = album.get('image_url')
            language = album.get('language', 'hindi')
            
            # Create unique thumbnail_url from image
            thumbnail_url = image_url if image_url else None
            
            sql = f"""INSERT INTO albums (
    title,
    description,
    thumbnail_url,
    language,
    created_at,
    updated_at
) VALUES (
    {self.escape_sql(title)},
    {self.escape_sql(description)},
    {self.escape_sql(thumbnail_url)},
    {self.escape_sql(language)},
    NOW(),
    NOW()
);"""
            
            self.sql_statements.append(('album', sql, title))
            print(f"  ✓ {title[:50]}")
        
        return len(self.data['data']['albums'])
    
    def generate_song_inserts(self):
        """Generate INSERT statements for songs"""
        print("\n🎵 Generating SONG inserts...")
        
        # Build albums map (simplified - in real scenario, query from DB)
        # For now, we'll use a reference comment
        
        for song in self.data['data']['songs']:
            title = song.get('title', 'Unknown')
            description = song.get('description', '')
            image_url = song.get('image_url')
            audio_url = song.get('audio_url')
            
            sql = f"""-- Song: {title}
INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    1,  -- TODO: Replace with actual album_id after albums are inserted
    {self.escape_sql(title)},
    {self.escape_sql(description)},
    {self.escape_sql(image_url)},
    {self.escape_sql(audio_url)},
    NOW(),
    NOW()
);"""
            
            self.sql_statements.append(('song', sql, title))
            print(f"  ✓ {title[:50]}")
        
        return len(self.data['data']['songs'])
    
    def generate_complete_sql_file(self, output_file):
        """Generate complete SQL file with all statements"""
        
        sql_content = f"""-- Generated SQL Insert Statements
-- Generated on: {datetime.now().isoformat()}
-- Language: {self.data['language'].upper()}
-- Total Albums: {len(self.data['data']['albums'])}
-- Total Songs: {len(self.data['data']['songs'])}

-- ============================================================
-- IMPORTANT NOTES:
-- ============================================================
-- 1. This script assumes the database schema is already created
-- 2. Insert albums FIRST (before songs)
-- 3. Update song INSERT statements with correct album_id values
-- 4. This is generated from language page scraping (may lack full details)
-- 5. You may need to manually add singer, artist, and music_director data
-- ============================================================

SET FOREIGN_KEY_CHECKS=0;

-- ============================================================
-- ALBUMS INSERT
-- ============================================================
"""
        
        # Add album inserts
        album_count = 0
        for item_type, sql, title in self.sql_statements:
            if item_type == 'album':
                sql_content += f"\n{sql}\n"
                album_count += 1
        
        sql_content += f"\n-- Total albums inserted: {album_count}\n"
        
        sql_content += """
-- ============================================================
-- SONGS INSERT
-- ============================================================
-- NOTE: You need to query album IDs from the albums table
-- and replace the placeholder album_id values below
-- Example query: SELECT id, title FROM albums;
-- ============================================================
"""
        
        # Add song inserts
        song_count = 0
        for item_type, sql, title in self.sql_statements:
            if item_type == 'song':
                sql_content += f"\n{sql}\n"
                song_count += 1
        
        sql_content += f"\n-- Total songs inserted: {song_count}\n"
        
        sql_content += """
-- ============================================================
-- OPTIONAL: Singer, Artist, Music Director inserts
-- ============================================================
-- These require mapping from song metadata
-- Uncomment and modify as needed based on your requirements
-- ============================================================

SET FOREIGN_KEY_CHECKS=1;

-- End of generated script
"""
        
        # Write to file
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(sql_content)
        
        print(f"\n✅ SQL file generated: {output_file}")
        return output_file
    
    def generate_import_guide(self, output_file):
        """Generate a guide for importing the data"""
        
        guide = f"""# SQL Import Guide

## Generated: {datetime.now().isoformat()}
## Language: {self.data['language'].upper()}

### Summary
- **Albums**: {len(self.data['data']['albums'])}
- **Songs**: {len(self.data['data']['songs'])}
- **Total Items**: {len(self.data['data']['albums']) + len(self.data['data']['songs'])}

### Steps to Import

#### 1. Prepare the Database
```sql
-- Ensure database and tables exist
USE your_database_name;

-- Disable foreign key checks temporarily
SET FOREIGN_KEY_CHECKS=0;
```

#### 2. Insert Albums First
Run the album INSERT statements from the generated SQL file.
Example:
```sql
INSERT INTO albums (title, description, thumbnail_url, language, created_at, updated_at)
VALUES (...);
```

**After inserting albums, verify the insertion:**
```sql
SELECT id, title FROM albums ORDER BY created_at DESC LIMIT 5;
```

#### 3. Map Album IDs to Songs
Once albums are inserted, you need to get the album IDs:
```sql
-- Get all inserted albums with their IDs
SELECT id, title FROM albums 
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 HOUR);
```

#### 4. Update Song Inserts with Album IDs
Replace the placeholder `1` in song INSERT statements with actual album IDs.

**Example mapping:**
"""
        
        # Add album mappings
        for idx, album in enumerate(self.data['data']['albums'], 1):
            guide += f"\n- Album ID {idx}: {album['title']}"
        
        guide += """

#### 5. Insert Songs
Execute all song INSERT statements with correct album_id values.

#### 6. Verify Import
```sql
-- Check total songs inserted
SELECT COUNT(*) as total_songs FROM songs;

-- Check album songs relationship
SELECT a.title, COUNT(s.id) as song_count
FROM albums a
LEFT JOIN songs s ON a.id = s.album_id
GROUP BY a.id, a.title
ORDER BY a.title;
```

#### 7. Re-enable Foreign Key Checks
```sql
SET FOREIGN_KEY_CHECKS=1;
```

### Album Details

"""
        
        for album in self.data['data']['albums']:
            guide += f"\n#### {album['title']}\n"
            guide += f"- **Language**: {album['language']}\n"
            guide += f"- **ID**: {album['id']}\n"
            if album.get('description'):
                guide += f"- **Description**: {album['description'][:100]}\n"
            if album.get('image_url'):
                guide += f"- **Image**: {album['image_url']}\n"
        
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(guide)
        
        print(f"✅ Import guide generated: {output_file}")
        return output_file


def main():
    input_file = "pagalworld_hindi_results.json"
    output_sql = "insert_hindi_data.sql"
    output_guide = "IMPORT_GUIDE_HINDI.md"
    
    print("="*60)
    print("SQL GENERATOR FOR SCRAPER DATA")
    print("="*60)
    
    try:
        # Initialize generator
        gen = SQLGenerator(input_file)
        
        # Generate inserts
        album_count = gen.generate_album_inserts()
        song_count = gen.generate_song_inserts()
        
        # Generate SQL file
        gen.generate_complete_sql_file(output_sql)
        
        # Generate import guide
        gen.generate_import_guide(output_guide)
        
        print("\n" + "="*60)
        print("✅ GENERATION COMPLETE")
        print("="*60)
        print(f"Albums: {album_count}")
        print(f"Songs: {song_count}")
        print(f"\nGenerated files:")
        print(f"  - {output_sql}")
        print(f"  - {output_guide}")
        print("="*60 + "\n")
        
    except Exception as e:
        print(f"\n❌ Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
