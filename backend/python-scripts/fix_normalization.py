import logging
import sys
import re
sys.path.insert(0, '/Users/vijayramireddy/Documents/bastiboysmusic/backend/python-scripts')

from db_utils import get_db_connection

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

def split_combined_singers():
    """
    Split combined singer names (e.g., "Udit Narayan & Kousalya") into individual singers.
    """
    logger.info("Splitting combined singer names...")
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            
            # Get all singers with & or 'and' in their names
            cursor.execute("SELECT singer_id, singer_name FROM singers WHERE singer_name LIKE '%&%' OR singer_name LIKE '% and %'")
            combined_singers = cursor.fetchall()
            
            logger.info(f"Found {len(combined_singers)} combined singer entries")
            
            added = 0
            deleted = 0
            
            for singer_id, singer_name in combined_singers:
                # Split by & or 'and'
                parts = re.split(r'\s+&\s+|\s+and\s+', singer_name, flags=re.IGNORECASE)
                parts = [p.strip() for p in parts if p.strip()]
                
                if len(parts) > 1:
                    logger.info(f"Splitting '{singer_name}' into: {parts}")
                    
                    # Insert individual singers (IGNORE duplicates)
                    for part in parts:
                        try:
                            cursor.execute("INSERT IGNORE INTO singers (singer_name) VALUES (%s)", (part,))
                            if cursor.rowcount > 0:
                                added += 1
                        except Exception as e:
                            logger.warning(f"Could not insert '{part}': {e}")
                    
                    # Delete the combined entry
                    cursor.execute("DELETE FROM singers WHERE singer_id = %s", (singer_id,))
                    deleted += 1
            
            conn.commit()
            logger.info(f"Split complete: {added} individual singers added, {deleted} combined entries removed")
            
    except Exception as e:
        logger.error(f"Error splitting singers: {e}")
        raise

def restore_album_relationships():
    """
    Restore album_id relationships for artists and music_directors from albums table.
    This fixes the issue where duplicate removal may have broken relationships.
    """
    logger.info("Restoring album relationships for artists and music_directors...")
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            
            # For artists: update album_id based on album_name
            logger.info("Fixing artists table...")
            cursor.execute("""
                UPDATE artists a
                INNER JOIN albums alb ON a.album_name = alb.title
                SET a.album_id = alb.id
                WHERE a.album_id != alb.id OR a.album_id IS NULL
            """)
            artists_updated = cursor.rowcount
            
            # For music_directors: update album_id based on album_name
            logger.info("Fixing music_directors table...")
            cursor.execute("""
                UPDATE music_directors md
                INNER JOIN albums alb ON md.album_name = alb.title
                SET md.album_id = alb.id
                WHERE md.album_id != alb.id OR md.album_id IS NULL
            """)
            directors_updated = cursor.rowcount
            
            conn.commit()
            logger.info(f"Restored relationships: {artists_updated} artists, {directors_updated} music_directors")
            
    except Exception as e:
        logger.error(f"Error restoring relationships: {e}")
        raise

if __name__ == "__main__":
    split_combined_singers()
    restore_album_relationships()
    logger.info("✓ All fixes complete")
