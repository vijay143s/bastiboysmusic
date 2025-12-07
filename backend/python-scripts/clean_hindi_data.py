import os
import mysql.connector
from dotenv import load_dotenv

# Load environment variables
load_dotenv(os.path.join(os.path.dirname(__file__), '.env'))

def get_db_connection():
    return mysql.connector.connect(
        host=os.getenv('MYSQL_HOST'),
        user=os.getenv('MYSQL_USER'),
        password=os.getenv('MYSQL_PASSWORD'),
        database=os.getenv('MYSQL_DATABASE'),
        port=int(os.getenv('MYSQL_PORT', 3306))
    )

def clean_hindi_data():
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        print("Starting cleanup of Hindi data...")

        # 1. Get Album IDs for Hindi albums
        cursor.execute("SELECT id FROM albums WHERE language = 'hindi' OR language = 'Hindi'")
        album_ids = [row[0] for row in cursor.fetchall()]

        if not album_ids:
            print("No Hindi albums found.")
            return

        print(f"Found {len(album_ids)} Hindi albums.")
        
        album_ids_str = ', '.join(map(str, album_ids))

        # 2. Delete Songs linked to these albums
        print("Deleting songs...")
        cursor.execute(f"DELETE FROM songs WHERE album_id IN ({album_ids_str})")
        print(f"Deleted {cursor.rowcount} songs.")
        
        # 3. Delete Artists linked to these albums
        print("Deleting artists...")
        cursor.execute(f"DELETE FROM artists WHERE album_id IN ({album_ids_str})")
        print(f"Deleted {cursor.rowcount} artists.")

        # 4. Delete Music Directors linked to these albums
        print("Deleting music directors...")
        cursor.execute(f"DELETE FROM music_directors WHERE album_id IN ({album_ids_str})")
        print(f"Deleted {cursor.rowcount} music directors.")

        # 5. Delete Albums
        print("Deleting albums...")
        cursor.execute(f"DELETE FROM albums WHERE id IN ({album_ids_str})")
        print(f"Deleted {cursor.rowcount} albums.")

        conn.commit()
        print("Cleanup complete.")

    except Exception as e:
        print(f"Error: {e}")
        conn.rollback()
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    clean_hindi_data()
