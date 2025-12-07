import logging
from db_utils import get_db_connection

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def list_tables():
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("SHOW TABLES")
            tables = cursor.fetchall()
            print("\nDatabase Tables:")
            for table in tables:
                print(f"- {table[0]}")
    except Exception as e:
        logger.error(f"Error listing tables: {e}")

if __name__ == "__main__":
    list_tables()
