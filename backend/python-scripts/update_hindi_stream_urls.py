#!/usr/bin/env python3
"""
Update stream_url for existing Hindi songs with Pagal World URLs

This script:
1. Finds all Hindi songs with pagalworldmusic.com URLs
2. Generates proper stream URLs with URL encoding
3. Updates the database

Usage:
    python update_hindi_stream_urls.py
"""

import sys
from pathlib import Path
from urllib.parse import quote

try:
    from db_utils import get_db_connection
except ImportError:
    print("Error: db_utils.py not found in current directory")
    sys.exit(1)

def update_hindi_stream_urls():
    """Update stream URLs for existing Hindi Pagal World songs"""
    
    print("=" * 70)
    print("UPDATE: Hindi Songs Stream URLs")
    print("=" * 70)
    
    with get_db_connection() as connection:
        cursor = connection.cursor()
        
        try:
            # Step 1: Find Hindi songs with pagalworldmusic.com URLs that need updating
            print("\n1️⃣  Finding Hindi songs with Pagal World URLs...")
            cursor.execute("""
                SELECT s.id, s.audio_url, a.title as album_title, s.title as song_title
                FROM songs s
                INNER JOIN albums a ON s.album_id = a.id
                WHERE a.language = 'hindi'
                  AND s.audio_url LIKE '%pagalworldmusic.com%'
                  AND (s.stream_url IS NULL OR s.stream_url = '')
                ORDER BY a.year DESC, s.created_at DESC
            """)
            
            songs = cursor.fetchall()
            print(f"   Found {len(songs)} songs to update")
            
            if len(songs) == 0:
                print("   ✅ No songs need updating")
                return
            
            # Step 2: Generate and update stream URLs
            print("\n2️⃣  Generating stream URLs and updating database...")
            updated = 0
            failed = 0
            
            for song_id, audio_url, album_title, song_title in songs:
                try:
                    # Generate stream URL with proper URL encoding
                    stream_url = f"/api/audio/stream?url={quote(audio_url, safe='')}"
                    
                    # Update database
                    cursor.execute(
                        "UPDATE songs SET stream_url = %s WHERE id = %s",
                        (stream_url, song_id)
                    )
                    
                    updated += 1
                    
                    if updated % 10 == 0:
                        print(f"   Progress: {updated}/{len(songs)} [{album_title} - {song_title}]")
                        connection.commit()
                        
                except Exception as e:
                    print(f"   ❌ Error updating song {song_id}: {e}")
                    failed += 1
            
            # Final commit
            connection.commit()
            
            # Step 3: Verify the updates
            print("\n3️⃣  Verifying updates...")
            cursor.execute("""
                SELECT COUNT(*) as total
                FROM songs s
                INNER JOIN albums a ON s.album_id = a.id
                WHERE a.language = 'hindi'
                  AND s.audio_url LIKE '%pagalworldmusic.com%'
                  AND s.stream_url LIKE '/api/audio/stream?url=%'
            """)
            
            verify_count = cursor.fetchone()[0]
            
            print(f"\n{'='*70}")
            print(f"✅ UPDATE COMPLETE")
            print(f"{'='*70}")
            print(f"  Updated: {updated} songs")
            print(f"  Failed: {failed} songs")
            print(f"  Verified: {verify_count} songs with stream_url")
            print(f"{'='*70}\n")
            
            # Step 4: Show sample of updated songs
            print("📋 Sample of updated songs:")
            cursor.execute("""
                SELECT 
                  s.id,
                  s.title,
                  SUBSTRING(s.audio_url, 1, 50) as audio_url_preview,
                  SUBSTRING(s.stream_url, 1, 60) as stream_url_preview,
                  a.title as album_title
                FROM songs s
                INNER JOIN albums a ON s.album_id = a.id
                WHERE a.language = 'hindi'
                  AND s.stream_url LIKE '/api/audio/stream?url=%'
                LIMIT 5
            """)
            
            samples = cursor.fetchall()
            for song_id, title, audio_prev, stream_prev, album in samples:
                print(f"\n  ID: {song_id}")
                print(f"  Song: {title}")
                print(f"  Album: {album}")
                print(f"  Audio URL: {audio_prev}...")
                print(f"  Stream URL: {stream_prev}...")
            
        except Exception as e:
            print(f"\n❌ Update failed: {e}")
            connection.rollback()
            sys.exit(1)
        finally:
            cursor.close()

if __name__ == "__main__":
    update_hindi_stream_urls()
