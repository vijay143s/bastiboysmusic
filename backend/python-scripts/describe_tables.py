import logging
import sys
from db_utils import get_db_connection

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def describe_table(table_name):
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            cursor.execute(f"DESCRIBE {table_name}")
            columns = cursor.fetchall()
            print(f"\nSchema for {table_name}:")
            # Print column name and type
            for col in columns:
                print(f"{col[0]} {col[1]}")
    except Exception as e:
        logger.error(f"Error describing table {table_name}: {e}")

if __name__ == "__main__":
    tables = ['songs', 'songs_backup', 'albums', 'albums_backup']
    for table in tables:
        describe_table(table)
