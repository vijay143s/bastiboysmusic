import logging
import sys
from pathlib import Path
from db_utils import execute_sql_file, get_table_row_count

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def run_restore():
    sql_file = Path("backend/sql_updates/restore_backup.sql")
    if not sql_file.exists():
        logger.error(f"SQL file not found: {sql_file}")
        return

    logger.info("Starting database restore process...")
    if execute_sql_file(sql_file):
        logger.info("Restore script executed successfully.")
        
        # Verify counts
        tables = ['albums', 'songs', 'artists', 'music_directors', 'singers', 'user_playlists']
        print("\nPost-Restore Row Counts:")
        for table in tables:
            count = get_table_row_count(table)
            print(f"  {table}: {count}")
    else:
        logger.error("Restore script failed.")

if __name__ == "__main__":
    run_restore()
