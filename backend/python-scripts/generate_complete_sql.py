#!/usr/bin/env python3
"""
Complete SQL Generator from Extended Scraper Data
Converts JSON to ready-to-execute SQL with proper relationships
"""

import json
import sys
from urllib.parse import urljoin

class CompleteSQLGenerator:
    def __init__(self, json_file):
        with open(json_file, 'r', encoding='utf-8') as f:
            self.data = json.load(f)
        
        self.base_url = "https://pagalworldmusic.com"
        self.albums = self.data['data']['albums']
        self.songs = self.data['data']['songs']
    
    def escape_sql(self, value):
        """Escape SQL string values"""
        if value is None:
            return "NULL"
        if isinstance(value, bool):
            return "1" if value else "0"
        if isinstance(value, (int, float)):
            return str(value)
        escaped = str(value).replace("'", "''")
        return f"'{escaped}'"
    
    def make_absolute_url(self, url):
        """Convert relative URL to absolute"""
        if not url:
            return None
        if url.startswith('http'):
            return url
        return urljoin(self.base_url, url)
    
    def generate_sql(self, output_file):
        """Generate complete SQL file"""
        
        sql_content = f"""-- Complete SQL Insert Statements
-- Generated from Pagal World Extended Scraper
-- Total Albums: {len(self.albums)}
-- Total Songs: {len(self.songs)}

-- ============================================================
-- EXECUTION INSTRUCTIONS:
-- ============================================================
-- 1. Backup your database
-- 2. Execute this entire script in your MySQL client
-- 3. Albums are inserted first (with AUTO_INCREMENT ID)
-- 4. Songs are linked using COALESCE with album titles
-- 5. All audio URLs are absolute (include domain)
-- ============================================================

SET FOREIGN_KEY_CHECKS=0;
START TRANSACTION;

-- ============================================================
-- ALBUMS INSERT STATEMENTS
-- ============================================================

"""
        
        # Add album inserts
        for album in self.albums:
            title = album.get('title', 'Unknown')
            description = album.get('description', '')
            image_url = album.get('image_url_high') or album.get('image_url')
            year = album.get('year')
            director = album.get('director')
            music_director = album.get('music_director')
            language = album.get('language', 'Unknown').lower()
            
            sql = f"""INSERT IGNORE INTO albums (
    title,
    description,
    thumbnail_url,
    year,
    director,
    music_director,
    language,
    created_at,
    updated_at
) VALUES (
    {self.escape_sql(title)},
    {self.escape_sql(description)},
    {self.escape_sql(image_url)},
    {self.escape_sql(year)},
    {self.escape_sql(director)},
    {self.escape_sql(music_director)},
    {self.escape_sql(language)},
    NOW(),
    NOW()
);

"""
            sql_content += sql
        
        sql_content += f"""-- Total albums: {len(self.albums)}

-- ============================================================
-- SONGS INSERT STATEMENTS (with album lookup using COALESCE)
-- ============================================================
-- Songs are linked to albums by title lookup
-- If album not found, defaults to album_id = 1
-- ============================================================

"""
        
        # Add song inserts
        for idx, song in enumerate(self.songs, 1):
            title = song.get('title', 'Unknown')
            album_name = song.get('album_name', 'Unknown')
            singer = song.get('artist_main') or song.get('singer', 'Unknown')
            image_url = song.get('image_url_high') or song.get('image_url')
            audio_url = self.make_absolute_url(song.get('audio_url'))
            description = song.get('description', '')
            
            # Create comment with album reference
            comment = f"-- Song {idx}: {title} (Album: {album_name})\n"
            
            sql = f"""{comment}INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    description,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = {self.escape_sql(album_name)} LIMIT 1), 1),
    {self.escape_sql(title)},
    {self.escape_sql(singer)},
    {self.escape_sql(image_url)},
    {self.escape_sql(audio_url)},
    {self.escape_sql(description)},
    NOW(),
    NOW()
);

"""
            sql_content += sql
        
        sql_content += f"""-- Total songs: {len(self.songs)}

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check albums inserted
SELECT 'Albums Inserted:' as check_label, COUNT(*) as count FROM albums WHERE created_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE);

-- Check songs inserted
SELECT 'Songs Inserted:' as check_label, COUNT(*) as count FROM songs WHERE created_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE);

-- Check song-album relationships
SELECT 
    'Album-Song Mapping:' as check_label,
    a.title,
    COUNT(s.id) as song_count
FROM albums a
LEFT JOIN songs s ON a.id = s.album_id
WHERE a.created_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
GROUP BY a.id, a.title
ORDER BY a.title;

-- Show all audio URLs for verification
SELECT 'Audio URLs Sample:' as check_label, title, SUBSTRING(audio_url, 1, 80) as audio_url
FROM songs
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
LIMIT 5;

COMMIT;
SET FOREIGN_KEY_CHECKS=1;

-- End of script
"""
        
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(sql_content)
        
        print(f"✅ SQL file generated: {output_file}")
        return output_file
    
    def generate_summary(self, output_file):
        """Generate summary document"""
        
        summary = f"""# Database Import Summary

Generated from: pagalworld_extended_results.json
Total Albums: {len(self.albums)}
Total Songs: {len(self.songs)}

## Albums to be Inserted

"""
        
        for album in self.albums:
            summary += f"\n### {album.get('title')}\n"
            summary += f"- **Language**: {album.get('language')}\n"
            summary += f"- **Description**: {album.get('description', 'N/A')[:100]}...\n"
            summary += f"- **Image**: {album.get('image_url_high', 'N/A')[:80]}\n"
            summary += f"- **Music Director**: {album.get('music_director', 'N/A')}\n"
            summary += f"- **Year**: {album.get('year', 'N/A')}\n"
        
        summary += f"\n\n## Sample Songs\n\n"
        
        for song in self.songs[:10]:
            summary += f"\n### {song.get('title')}\n"
            summary += f"- **Album**: {song.get('album_name')}\n"
            summary += f"- **Artist**: {song.get('artist_main', 'Unknown')}\n"
            summary += f"- **Duration**: {song.get('duration', 'N/A')}\n"
            summary += f"- **Label**: {song.get('label', 'N/A')}\n"
            summary += f"- **Audio URL**: {self.make_absolute_url(song.get('audio_url', ''))}\n"
        
        summary += f"\n\n... and {len(self.songs) - 10} more songs\n"
        
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(summary)
        
        print(f"✅ Summary generated: {output_file}")


def main():
    input_file = "pagalworld_extended_results.json"
    output_sql = "insert_complete_data.sql"
    output_summary = "INSERT_SUMMARY.md"
    
    print("="*70)
    print("COMPLETE SQL GENERATOR")
    print("="*70 + "\n")
    
    try:
        gen = CompleteSQLGenerator(input_file)
        
        print(f"📊 Data loaded:")
        print(f"   Albums: {len(gen.albums)}")
        print(f"   Songs: {len(gen.songs)}\n")
        
        # Generate SQL
        gen.generate_sql(output_sql)
        
        # Generate summary
        gen.generate_summary(output_summary)
        
        print("\n" + "="*70)
        print("✅ GENERATION COMPLETE")
        print("="*70)
        print(f"\n📋 Files created:")
        print(f"   1. {output_sql}")
        print(f"      └─ Ready-to-execute SQL with proper album linking")
        print(f"   2. {output_summary}")
        print(f"      └─ Summary of data to be imported")
        
        print(f"\n🚀 Next Steps:")
        print(f"   1. Backup your database")
        print(f"   2. Execute the SQL file:")
        print(f"      mysql -u root -p database_name < {output_sql}")
        print(f"   3. Verify the import with:")
        print(f"      SELECT COUNT(*) FROM albums;")
        print(f"      SELECT COUNT(*) FROM songs;")
        print("="*70 + "\n")
        
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
