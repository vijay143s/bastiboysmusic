"""
Script to remove duplicates from all tables in the database.
Keeps the oldest entry (lowest id) and removes newer duplicates based on:
- Songs: title, album_id
- Albums: title, year
- Artists: artist_name, album_id
- Singers: singer_name
- Music Directors: director_name, album_id
"""

import argparse
import logging
import sys
from pathlib import Path

from db_utils import get_db_connection
from dotenv import load_dotenv

SCRIPT_DIR = Path(__file__).resolve().parent
LOG_DIR = SCRIPT_DIR / 'logs'
LOG_DIR.mkdir(parents=True, exist_ok=True)
LOG_FILE = LOG_DIR / 'ingestion.log'

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(LOG_FILE, encoding='utf-8'),
        logging.StreamHandler(sys.stderr)
    ]
)
logger = logging.getLogger(__name__)

load_dotenv()


def find_duplicate_albums():
    """Find duplicate albums based on title and year."""
    with get_db_connection() as conn:
        cursor = conn.cursor(dictionary=True)
        
        query = """
        SELECT 
            id,
            title,
            year,
            created_at,
            COUNT(*) OVER (
                PARTITION BY 
                    title,
                    COALESCE(year, 0)
            ) as duplicate_count,
            ROW_NUMBER() OVER (
                PARTITION BY 
                    title,
                    COALESCE(year, 0)
                ORDER BY id ASC
            ) as row_num
        FROM albums
        ORDER BY title, id
        """
        
        cursor.execute(query)
        results = cursor.fetchall()
        cursor.close()
        
        duplicates_to_remove = [
            row for row in results 
            if row['duplicate_count'] > 1 and row['row_num'] > 1
        ]
        
        return duplicates_to_remove


def find_duplicate_songs():
    """Find duplicate songs based on title and album id."""
    with get_db_connection() as conn:
        cursor = conn.cursor(dictionary=True)
        
        query = """
        SELECT 
            s.id,
            s.title as song_title,
            s.album_id,
            a.title as album_title,
            s.created_at,
            COUNT(*) OVER (
                PARTITION BY 
                    s.title, 
                    s.album_id
            ) as duplicate_count,
            ROW_NUMBER() OVER (
                PARTITION BY 
                    s.title, 
                    s.album_id
                ORDER BY s.id ASC
            ) as row_num
        FROM songs s
        JOIN albums a ON s.album_id = a.id
        ORDER BY s.title, s.id
        """
        
        cursor.execute(query)
        results = cursor.fetchall()
        cursor.close()
        
        duplicates_to_remove = [
            row for row in results 
            if row['duplicate_count'] > 1 and row['row_num'] > 1
        ]
        
        return duplicates_to_remove


def find_duplicate_artists():
    """Find duplicate artists based on artist_name and album_id."""
    with get_db_connection() as conn:
        cursor = conn.cursor(dictionary=True)
        
        query = """
        SELECT 
            artist_id,
            artist_name,
            album_id,
            album_name,
            created_at,
            COUNT(*) OVER (
                PARTITION BY 
                    COALESCE(artist_name, ''),
                    album_id
            ) as duplicate_count,
            ROW_NUMBER() OVER (
                PARTITION BY 
                    COALESCE(artist_name, ''),
                    album_id
                ORDER BY artist_id ASC
            ) as row_num
        FROM artists
        ORDER BY artist_name, artist_id
        """
        
        cursor.execute(query)
        results = cursor.fetchall()
        cursor.close()
        
        duplicates_to_remove = [
            row for row in results 
            if row['duplicate_count'] > 1 and row['row_num'] > 1
        ]
        
        return duplicates_to_remove


def find_duplicate_singers():
    """Find duplicate singers based on singer_name."""
    with get_db_connection() as conn:
        cursor = conn.cursor(dictionary=True)
        
        query = """
        SELECT 
            singer_id,
            singer_name,
            COUNT(*) OVER (
                PARTITION BY singer_name
            ) as duplicate_count,
            ROW_NUMBER() OVER (
                PARTITION BY singer_name
                ORDER BY singer_id ASC
            ) as row_num
        FROM singers
        ORDER BY singer_name, singer_id
        """
        
        cursor.execute(query)
        results = cursor.fetchall()
        cursor.close()
        
        duplicates_to_remove = [
            row for row in results 
            if row['duplicate_count'] > 1 and row['row_num'] > 1
        ]
        
        return duplicates_to_remove


def find_duplicate_music_directors():
    """Find duplicate music directors based on director_name and album_id."""
    with get_db_connection() as conn:
        cursor = conn.cursor(dictionary=True)
        
        query = """
        SELECT 
            director_id,
            director_name,
            album_id,
            album_name,
            created_at,
            COUNT(*) OVER (
                PARTITION BY 
                    director_name,
                    album_id
            ) as duplicate_count,
            ROW_NUMBER() OVER (
                PARTITION BY 
                    director_name,
                    album_id
                ORDER BY director_id ASC
            ) as row_num
        FROM music_directors
        ORDER BY director_name, director_id
        """
        
        cursor.execute(query)
        results = cursor.fetchall()
        cursor.close()
        
        duplicates_to_remove = [
            row for row in results 
            if row['duplicate_count'] > 1 and row['row_num'] > 1
        ]
        
        return duplicates_to_remove


def remove_duplicates(table_name, id_column, duplicates_to_remove, dry_run=True):
    """Remove duplicates from any table."""
    if not duplicates_to_remove:
        logger.info(f"No {table_name} duplicates found to remove.")
        return 0
    
    if dry_run:
        logger.info(f"DRY RUN: Would remove {len(duplicates_to_remove)} duplicate {table_name}")
        for dup in duplicates_to_remove[:5]:  # Show first 5
            logger.info(f"  Would remove: {dup}")
        if len(duplicates_to_remove) > 5:
            logger.info(f"  ... and {len(duplicates_to_remove) - 5} more")
        return len(duplicates_to_remove)
    
    with get_db_connection() as conn:
        cursor = conn.cursor()
        
        # Get IDs to remove
        ids_to_remove = [dup[id_column] for dup in duplicates_to_remove]
        
        # Remove in batches of 1000
        batch_size = 1000
        total_removed = 0
        
        for i in range(0, len(ids_to_remove), batch_size):
            batch = ids_to_remove[i:i + batch_size]
            placeholders = ','.join(['%s'] * len(batch))
            query = f"DELETE FROM {table_name} WHERE {id_column} IN ({placeholders})"
            
            cursor.execute(query, batch)
            conn.commit()
            total_removed += cursor.rowcount
            logger.info(f"Removed batch {i//batch_size + 1}: {cursor.rowcount} {table_name} deleted")
        
        logger.info(f"Successfully removed {total_removed} duplicate {table_name}")
        cursor.close()
        return total_removed


def main(dry_run=False):
    mode_label = "DRY RUN MODE" if dry_run else "FULL REMOVAL MODE"
    logger.info(f"Starting duplicate workflow ({mode_label})...")
    
    # Find duplicates from all tables
    logger.info("\n" + "="*80)
    logger.info("FINDING DUPLICATES IN ALL TABLES")
    logger.info("="*80)
    
    logger.info("\n1. Finding duplicate albums...")
    dup_albums = find_duplicate_albums()
    logger.info(f"   Found {len(dup_albums)} duplicate albums to remove")
    
    logger.info("\n2. Finding duplicate songs...")
    dup_songs = find_duplicate_songs()
    logger.info(f"   Found {len(dup_songs)} duplicate songs to remove")
    
    logger.info("\n3. Finding duplicate artists...")
    dup_artists = find_duplicate_artists()
    logger.info(f"   Found {len(dup_artists)} duplicate artists to remove")
    
    logger.info("\n4. Finding duplicate singers...")
    dup_singers = find_duplicate_singers()
    logger.info(f"   Found {len(dup_singers)} duplicate singers to remove")
    
    logger.info("\n5. Finding duplicate music directors...")
    dup_directors = find_duplicate_music_directors()
    logger.info(f"   Found {len(dup_directors)} duplicate music directors to remove")
    
    # Calculate total
    total_duplicates = (len(dup_albums) + len(dup_songs) + len(dup_artists) + 
                       len(dup_singers) + len(dup_directors))
    
    if total_duplicates == 0:
        logger.info("\n✓ No duplicates found in any table. Database is clean!")
        logger.info("Analysis complete - no duplicate rows detected")
        return
    
    # Show summary
    logger.info(f"\n{'='*80}")
    logger.info(f"REMOVAL SUMMARY")
    logger.info(f"{'='*80}")
    logger.info(f"Albums:          {len(dup_albums)} duplicates")
    logger.info(f"Songs:           {len(dup_songs)} duplicates")
    logger.info(f"Artists:         {len(dup_artists)} duplicates")
    logger.info(f"Singers:         {len(dup_singers)} duplicates")
    logger.info(f"Music Directors: {len(dup_directors)} duplicates")
    logger.info(f"{'='*80}")
    logger.info(f"TOTAL:           {total_duplicates} duplicates across all tables")
    logger.info(f"Strategy: Keep oldest entry (lowest ID), remove newer duplicates")
    
    # Dry run preview
    logger.info(f"\n{'='*80}")
    logger.info("DRY RUN - Preview of what will be removed")
    logger.info(f"{'='*80}")
    
    if dup_albums:
        logger.info(f"\nAlbums to remove ({len(dup_albums)}):")
        remove_duplicates('albums', 'id', dup_albums, dry_run=True)
    
    if dup_songs:
        logger.info(f"\nSongs to remove ({len(dup_songs)}):")
        remove_duplicates('songs', 'id', dup_songs, dry_run=True)
    
    if dup_artists:
        logger.info(f"\nArtists to remove ({len(dup_artists)}):")
        remove_duplicates('artists', 'artist_id', dup_artists, dry_run=True)
    
    if dup_singers:
        logger.info(f"\nSingers to remove ({len(dup_singers)}):")
        remove_duplicates('singers', 'singer_id', dup_singers, dry_run=True)
    
    if dup_directors:
        logger.info(f"\nMusic Directors to remove ({len(dup_directors)}):")
        remove_duplicates('music_directors', 'director_id', dup_directors, dry_run=True)
    
    if dry_run:
        logger.info(f"\n{'='*80}")
        logger.info("*** DRY RUN COMPLETE - No records were removed ***")
        logger.info(f"Total duplicates found: {total_duplicates}")
        logger.info("Run without --dry-run flag to actually remove duplicates")
        logger.info(f"{'='*80}")
        logger.info("Analysis complete - review duplicate summary above")
        return
    
    logger.info("\nProceeding with duplicate removal...")
    logger.info("="*80)
    
    total_removed = 0
    
    # Remove in order: songs first (has FK to albums), then albums, then others
    if dup_songs:
        logger.info("\nRemoving duplicate songs...")
        total_removed += remove_duplicates('songs', 'id', dup_songs, dry_run=False)
    
    if dup_artists:
        logger.info("\nRemoving duplicate artists...")
        total_removed += remove_duplicates('artists', 'artist_id', dup_artists, dry_run=False)
    
    if dup_directors:
        logger.info("\nRemoving duplicate music directors...")
        total_removed += remove_duplicates('music_directors', 'director_id', dup_directors, dry_run=False)
    
    if dup_albums:
        logger.info("\nRemoving duplicate albums...")
        total_removed += remove_duplicates('albums', 'id', dup_albums, dry_run=False)
    
    if dup_singers:
        logger.info("\nRemoving duplicate singers...")
        total_removed += remove_duplicates('singers', 'singer_id', dup_singers, dry_run=False)
    
    logger.info(f"\n{'='*80}")
    logger.info(f"✓ Successfully removed {total_removed} duplicate records!")
    logger.info("Removal complete - database updated with changes")
    logger.info(f"{'='*80}")


def parse_args():
    parser = argparse.ArgumentParser(description='Remove duplicate records from database tables')
    parser.add_argument(
        '--dry-run',
        action='store_true',
        help='Preview duplicates without removing them'
    )
    return parser.parse_args()


if __name__ == '__main__':
    args = parse_args()
    main(dry_run=args.dry_run)
