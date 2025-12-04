#!/usr/bin/env python3
"""
Migration Script: Add stream_url for existing Pagal World songs

This script:
1. Checks if stream_url column exists, creates if needed
2. Finds all songs with pagalworldmusic.com URLs that don't have stream_url
3. Generates proper stream URLs for them
4. Updates the database

Usage:
    python migrate_stream_urls.py
"""

import sys
from pathlib import Path
from urllib.parse import quote

try:
    from db_utils import get_db_connection
except ImportError:
    print("Error: db_utils.py not found in current directory")
    sys.exit(1)

def migrate_stream_urls():
    """Migrate existing Pagal World URLs to use stream_url"""
    
    print("=" * 70)
    print("MIGRATION: Add stream_url for Pagal World songs")
    print("=" * 70)
    
    connection = get_db_connection()
    cursor = connection.cursor()
    
    try:
        # Step 1: Check if column exists, create if needed
        print("\n1️⃣  Checking stream_url column...")
        cursor.execute("""
            SELECT COLUMN_NAME 
            FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'songs' AND COLUMN_NAME = 'stream_url'
        """)
        
        if not cursor.fetchone():
            print("   ℹ️  stream_url column not found, creating...")
            cursor.execute("""
                ALTER TABLE songs 
                ADD COLUMN stream_url VARCHAR(500) AFTER audio_url
            """)
            connection.commit()
            print("   ✅ Column created")
        else:
            print("   ✅ Column already exists")
        
        # Step 2: Find songs with pagalworldmusic.com URLs and no stream_url
        print("\n2️⃣  Finding Pagal World songs without stream_url...")
        cursor.execute("""
            SELECT id, audio_url 
            FROM songs 
            WHERE audio_url LIKE '%pagalworldmusic.com%' 
            AND (stream_url IS NULL OR stream_url = '')
        """)
        
        songs = cursor.fetchall()
        print(f"   Found {len(songs)} songs to migrate")
        
        if len(songs) == 0:
            print("   ✅ No migrations needed")
            return
        
        # Step 3: Update stream_url for each song
        print("\n3️⃣  Updating stream_url for Pagal World songs...")
        updated = 0
        failed = 0
        
        for song_id, audio_url in songs:
            try:
                # Generate stream URL
                stream_url = f"/api/audio/stream?url={quote(audio_url, safe='')}"
                
                # Update database
                cursor.execute(
                    "UPDATE songs SET stream_url = %s WHERE id = %s",
                    (stream_url, song_id)
                )
                updated += 1
                
                if updated % 10 == 0:
                    print(f"   Progress: {updated}/{len(songs)}")
                    connection.commit()
                    
            except Exception as e:
                print(f"   ❌ Error updating song {song_id}: {e}")
                failed += 1
        
        # Final commit
        connection.commit()
        
        print(f"\n{'='*70}")
        print(f"✅ MIGRATION COMPLETE")
        print(f"{'='*70}")
        print(f"  Updated: {updated} songs")
        print(f"  Failed: {failed} songs")
        print(f"{'='*70}\n")
        
    except Exception as e:
        print(f"\n❌ Migration failed: {e}")
        connection.rollback()
        sys.exit(1)
    finally:
        cursor.close()
        connection.close()

if __name__ == "__main__":
    migrate_stream_urls()
