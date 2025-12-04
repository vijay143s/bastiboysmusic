#!/usr/bin/env python3
"""
Advanced SQL Generator with Smart Album-Song Mapping
Intelligently maps songs to albums based on title similarity
"""

import json
import sys
from datetime import datetime
import re
from difflib import SequenceMatcher

class AdvancedSQLGenerator:
    def __init__(self, json_file):
        with open(json_file, 'r', encoding='utf-8') as f:
            self.data = json.load(f)
        
        self.sql_statements = []
        self.album_mapping = {}  # Map scraper album to database insert order
        self.song_to_album = {}  # Map song title to album title
    
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
    
    def similarity(self, a, b):
        """Calculate similarity between two strings"""
        return SequenceMatcher(None, a.lower(), b.lower()).ratio()
    
    def map_songs_to_albums(self):
        """Intelligently map songs to albums based on similarity"""
        print("\n🔗 Mapping songs to albums...")
        
        albums = self.data['data']['albums']
        songs = self.data['data']['songs']
        
        for song in songs:
            song_title = song.get('title', '')
            best_album = None
            best_score = 0.0
            
            # Find best matching album
            for album in albums:
                album_title = album.get('title', '')
                
                # Check if album title is mentioned in song
                if album_title.lower() in song_title.lower():
                    score = 0.9  # High confidence
                elif any(word in song_title.lower() for word in album_title.lower().split()):
                    score = 0.7  # Medium confidence
                else:
                    score = self.similarity(album_title, song_title)
                
                if score > best_score:
                    best_score = score
                    best_album = album
            
            if best_album and best_score > 0.3:
                self.song_to_album[song_title] = best_album['title']
                print(f"  ✓ {song_title[:40]} → {best_album['title'][:40]} (score: {best_score:.2f})")
            else:
                self.song_to_album[song_title] = albums[0]['title']  # Default to first album
                print(f"  ? {song_title[:40]} → {albums[0]['title']} (default)")
    
    def generate_complete_sql(self, output_file):
        """Generate complete SQL with proper mapping"""
        
        sql_content = f"""-- Generated SQL Insert Statements (Advanced)
-- Generated on: {datetime.now().isoformat()}
-- Language: {self.data['language'].upper()}
-- Total Albums: {len(self.data['data']['albums'])}
-- Total Songs: {len(self.data['data']['songs'])}

-- ============================================================
-- EXECUTION STEPS:
-- ============================================================
-- 1. Backup your database before running this script
-- 2. Run this script in a transaction (BEGIN; ... COMMIT;)
-- 3. Verify counts after execution
-- 4. Manually add singer, artist, and music_director data
-- ============================================================

SET FOREIGN_KEY_CHECKS=0;
START TRANSACTION;

-- ============================================================
-- ALBUMS INSERT
-- ============================================================
"""
        
        # Build album insert statements
        albums = self.data['data']['albums']
        album_id_map = {}  # Map album title to insert order
        
        for idx, album in enumerate(albums, 1):
            album_id_map[album['title']] = idx
            
            title = album.get('title', 'Unknown')
            description = album.get('description', '')
            image_url = album.get('image_url')
            language = album.get('language', 'hindi')
            
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
    {self.escape_sql(image_url)},
    {self.escape_sql(language)},
    NOW(),
    NOW()
);"""
            
            sql_content += f"\n-- Album {idx}\n{sql}\n"
        
        sql_content += f"\n-- Total albums: {len(albums)}\n"
        
        sql_content += """
-- ============================================================
-- SONGS INSERT
-- ============================================================
"""
        
        # Build song insert statements with proper album mapping
        songs = self.data['data']['songs']
        
        for idx, song in enumerate(songs, 1):
            song_title = song.get('title', 'Unknown')
            
            # Get mapped album
            mapped_album = self.song_to_album.get(song_title, albums[0]['title'])
            album_id = album_id_map.get(mapped_album, 1)
            
            description = song.get('description', '')
            image_url = song.get('image_url')
            audio_url = song.get('audio_url')
            
            # Get artist info from description if available
            artist_info = ""
            if description and '|' in description:
                parts = description.split('|')
                artist_info = parts[0].strip()
            
            sql = f"""INSERT INTO songs (
    album_id,
    title,
    description,
    thumbnail_url,
    audio_url,
    created_at,
    updated_at
) VALUES (
    {album_id},  -- Album: {mapped_album}
    {self.escape_sql(song_title)},
    {self.escape_sql(description)},
    {self.escape_sql(image_url)},
    {self.escape_sql(audio_url)},
    NOW(),
    NOW()
);"""
            
            sql_content += f"\n-- Song {idx}\n{sql}\n"
        
        sql_content += f"\n-- Total songs: {len(songs)}\n"
        
        sql_content += """
-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================
"""
        
        sql_content += """
-- Verify albums inserted
SELECT COUNT(*) as album_count FROM albums WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 MINUTE);

-- Verify songs inserted
SELECT COUNT(*) as song_count FROM songs WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 MINUTE);

-- Verify song-album relationships
SELECT 
    a.title as album,
    COUNT(s.id) as song_count
FROM albums a
LEFT JOIN songs s ON a.id = s.album_id
WHERE a.created_at >= DATE_SUB(NOW(), INTERVAL 1 MINUTE)
GROUP BY a.id, a.title
ORDER BY a.title;

COMMIT;
SET FOREIGN_KEY_CHECKS=1;

-- End of script
"""
        
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(sql_content)
        
        print(f"\n✅ Advanced SQL file generated: {output_file}")
        return output_file
    
    def generate_album_song_mapping(self, output_file):
        """Generate a reference document showing album-song mapping"""
        
        doc = f"""# Album-Song Mapping Reference
Generated: {datetime.now().isoformat()}
Language: {self.data['language'].upper()}

## Overview
Total Albums: {len(self.data['data']['albums'])}
Total Songs: {len(self.data['data']['songs'])}

## Mapping Details

"""
        
        albums = self.data['data']['albums']
        
        for idx, album in enumerate(albums, 1):
            doc += f"\n### Album {idx}: {album['title']}\n"
            doc += f"- **Language**: {album['language']}\n"
            doc += f"- **Description**: {album.get('description', 'N/A')}\n"
            doc += f"- **Image URL**: {album.get('image_url') or 'N/A'}\n"
            doc += f"- **URL**: {album.get('url')}\n"
            
            # Find songs for this album
            mapped_songs = [s for s in self.data['data']['songs'] 
                          if self.song_to_album.get(s.get('title', '')) == album['title']]
            
            doc += f"- **Songs Count**: {len(mapped_songs)}\n"
            doc += "\n**Songs:**\n"
            
            for s_idx, song in enumerate(mapped_songs, 1):
                doc += f"  {s_idx}. {song.get('title', 'Unknown')}\n"
                if song.get('description'):
                    doc += f"     - {song['description']}\n"
        
        doc += """

## Unmatched Songs
Songs that couldn't be mapped to specific albums (assigned to first album):

"""
        
        first_album = albums[0]['title']
        unmatched = [s for s in self.data['data']['songs'] 
                    if self.song_to_album.get(s.get('title', '')) == first_album 
                    and s.get('title', '') not in [ss.get('title', '') for ss in self.data['data']['songs']
                                                     if self.song_to_album.get(ss.get('title', '')) == first_album
                                                     and ss in self.data['data']['songs'][:len(self.data['data']['songs'])//2]]]
        
        doc += f"Total: {len(unmatched)}\n"
        
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(doc)
        
        print(f"✅ Mapping reference generated: {output_file}")


def main():
    input_file = "pagalworld_hindi_results.json"
    output_sql = "insert_hindi_data_advanced.sql"
    output_mapping = "ALBUM_SONG_MAPPING.md"
    
    print("="*70)
    print("ADVANCED SQL GENERATOR FOR SCRAPER DATA")
    print("="*70)
    
    try:
        # Initialize generator
        gen = AdvancedSQLGenerator(input_file)
        
        # Map songs to albums
        gen.map_songs_to_albums()
        
        # Generate SQL
        gen.generate_complete_sql(output_sql)
        
        # Generate mapping reference
        gen.generate_album_song_mapping(output_mapping)
        
        print("\n" + "="*70)
        print("✅ GENERATION COMPLETE")
        print("="*70)
        print(f"\nGenerated files:")
        print(f"  1. {output_sql} - Ready to execute SQL script")
        print(f"  2. {output_mapping} - Album-song mapping reference")
        print("\n📋 Next Steps:")
        print("  1. Backup your database")
        print("  2. Run insert_hindi_data_advanced.sql in your database client")
        print("  3. Verify the data with the provided SQL queries")
        print("  4. Add singer, artist, and music_director relationships manually")
        print("="*70 + "\n")
        
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
