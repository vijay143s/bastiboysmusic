#!/usr/bin/env python3
"""
SQL Generator for Unified Data
Creates INSERT statements with proper album ID lookup using COALESCE
Handles albums and songs together with complete fields
"""

import json
import sys
from datetime import datetime

class UnifiedSQLGenerator:
    def __init__(self, json_file):
        with open(json_file, 'r', encoding='utf-8') as f:
            self.data = json.load(f)
    
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
    
    def generate_sql_file(self, output_file):
        """Generate SQL file with INSERT IGNORE statements"""
        
        sql_content = f"""-- Unified SQL Insert Statements
-- Generated on: {datetime.now().isoformat()}
-- Language: {self.data['language'].upper()}
-- Total Items: {self.data['total_items']} (Albums: {self.data['total_albums']}, Songs: {self.data['total_songs']})

-- ============================================================
-- EXECUTION INSTRUCTIONS:
-- ============================================================
-- 1. Backup your database first
-- 2. Execute this script in your MySQL client
-- 3. Albums will be inserted first (auto_increment ID)
-- 4. Songs will be linked to albums using COALESCE
-- 5. If album doesn't exist, will default to album_id = 1
-- ============================================================

SET FOREIGN_KEY_CHECKS=0;

-- ============================================================
-- ALBUMS INSERT
-- ============================================================
"""
        
        # Separate albums and songs
        albums = [item for item in self.data['data'] if item['type'] == 'album']
        songs = [item for item in self.data['data'] if item['type'] == 'song']
        
        # Insert albums
        for album in albums:
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
    {self.escape_sql(album.get('title'))},
    {self.escape_sql(album.get('description'))},
    {self.escape_sql(album.get('image_url_high') or album.get('image_url'))},
    {self.escape_sql(album.get('year'))},
    {self.escape_sql(album.get('director'))},
    {self.escape_sql(album.get('music_director'))},
    {self.escape_sql(album.get('language'))},
    NOW(),
    NOW()
);"""
            
            sql_content += f"\n{sql}\n"
        
        sql_content += f"\n-- Total albums inserted: {len(albums)}\n"
        
        sql_content += """
-- ============================================================
-- SONGS INSERT (with album lookup using COALESCE)
-- ============================================================
-- Album ID is looked up by title, defaults to 1 if not found
-- ============================================================
"""
        
        # Insert songs with album lookups
        for song in songs:
            album_name = song.get('album_name', 'Unknown')
            
            sql = f"""INSERT IGNORE INTO songs (
    album_id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    COALESCE((SELECT id FROM albums WHERE title = {self.escape_sql(album_name)} LIMIT 1), 1),
    {self.escape_sql(song.get('title'))},
    {self.escape_sql(song.get('singer'))},
    {self.escape_sql(song.get('image_url_high') or song.get('image_url'))},
    {self.escape_sql(song.get('audio_url'))},
    NOW(),
    NOW()
);"""
            
            sql_content += f"\n{sql}\n"
        
        sql_content += f"\n-- Total songs inserted: {len(songs)}\n"
        
        sql_content += """
-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================
"""
        
        sql_content += """
-- Check albums inserted
SELECT COUNT(*) as album_count FROM albums WHERE created_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE);

-- Check songs inserted
SELECT COUNT(*) as song_count FROM songs WHERE created_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE);

-- Check album-song relationships
SELECT 
    a.id,
    a.title as album,
    COUNT(s.id) as song_count
FROM albums a
LEFT JOIN songs s ON a.id = s.album_id
WHERE a.created_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
GROUP BY a.id, a.title
ORDER BY a.title;

SET FOREIGN_KEY_CHECKS=1;

-- End of script
"""
        
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(sql_content)
        
        print(f"\n✅ SQL file generated: {output_file}")
        return output_file
    
    def generate_summary_report(self, output_file):
        """Generate summary report with all fields"""
        
        report = f"""# Data Import Summary Report
Generated: {datetime.now().isoformat()}
Language: {self.data['language'].upper()}

## Overview
- **Total Items**: {self.data['total_items']}
- **Albums**: {self.data['total_albums']}
- **Songs**: {self.data['total_songs']}
- **Errors**: {self.data['total_errors']}

## Albums

"""
        
        albums = [item for item in self.data['data'] if item['type'] == 'album']
        for idx, album in enumerate(albums, 1):
            report += f"\n### {idx}. {album.get('title', 'Unknown')}\n"
            report += f"- **Type**: Album\n"
            report += f"- **Language**: {album.get('language')}\n"
            report += f"- **Image URL**: {album.get('image_url_high') or album.get('image_url') or 'N/A'}\n"
            report += f"- **Description**: {album.get('description', 'N/A')}\n"
            if album.get('year'):
                report += f"- **Year**: {album.get('year')}\n"
            if album.get('director'):
                report += f"- **Director**: {album.get('director')}\n"
            if album.get('music_director'):
                report += f"- **Music Director**: {album.get('music_director')}\n"
            report += f"- **Source URL**: {album.get('url')}\n"
        
        report += f"\n\n## Songs\n"
        
        songs = [item for item in self.data['data'] if item['type'] == 'song']
        for idx, song in enumerate(songs, 1):
            report += f"\n### {idx}. {song.get('title', 'Unknown')}\n"
            report += f"- **Type**: Song\n"
            report += f"- **Language**: {song.get('language')}\n"
            if song.get('album_name'):
                report += f"- **Album**: {song.get('album_name')}\n"
            if song.get('singer'):
                report += f"- **Singer**: {song.get('singer')}\n"
            if song.get('artist'):
                report += f"- **Artist**: {song.get('artist')}\n"
            if song.get('music_director'):
                report += f"- **Music Director**: {song.get('music_director')}\n"
            report += f"- **Image URL**: {song.get('image_url_high') or song.get('image_url') or 'N/A'}\n"
            report += f"- **Audio URL**: {song.get('audio_url') or 'N/A'}\n"
            if song.get('duration'):
                report += f"- **Duration**: {song.get('duration')}\n"
            if song.get('year'):
                report += f"- **Year**: {song.get('year')}\n"
            report += f"- **Source URL**: {song.get('url')}\n"
        
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(report)
        
        print(f"✅ Report generated: {output_file}")


def main():
    input_file = "pagalworld_hindi_unified.json"
    output_sql = "insert_unified_hindi.sql"
    output_report = "IMPORT_REPORT_HINDI.md"
    
    print("="*70)
    print("UNIFIED SQL GENERATOR")
    print("="*70)
    
    try:
        gen = UnifiedSQLGenerator(input_file)
        gen.generate_sql_file(output_sql)
        gen.generate_summary_report(output_report)
        
        print("\n" + "="*70)
        print("✅ GENERATION COMPLETE")
        print("="*70)
        print(f"\nGenerated files:")
        print(f"  1. {output_sql}")
        print(f"     └─ Ready to execute SQL script")
        print(f"  2. {output_report}")
        print(f"     └─ Complete data summary")
        print(f"\n📋 To execute:")
        print(f"  mysql -u root -p database_name < {output_sql}")
        print("="*70 + "\n")
        
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
