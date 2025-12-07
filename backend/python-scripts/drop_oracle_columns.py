import sys
sys.path.insert(0, '/Users/vijayramireddy/Documents/bastiboysmusic/backend/python-scripts')

from db_utils import get_db_connection
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def drop_oracle_columns():
    """Drop Oracle-related columns from albums and songs tables."""
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            
            # Drop columns one by one
            columns_to_drop = [
                ("albums", "oracle_thumbnail_url"),
                ("songs", "oracle_thumbnail_url"),
                ("songs", "oracle_audio_url"),
                ("songs", "oracle_audio_stream_url")
            ]
            
            for table, column in columns_to_drop:
                try:
                    logger.info(f"Dropping {table}.{column}...")
                    cursor.execute(f"ALTER TABLE {table} DROP COLUMN {column}")
                    logger.info(f"✓ Dropped {table}.{column}")
                except Exception as e:
                    if "Can't DROP" in str(e) or "doesn't exist" in str(e):
                        logger.warning(f"Column {table}.{column} doesn't exist, skipping")
                    else:
                        raise
            
            conn.commit()
            logger.info("All Oracle columns dropped successfully")
            
    except Exception as e:
        logger.error(f"Error dropping columns: {e}")
        raise

if __name__ == "__main__":
    drop_oracle_columns()
