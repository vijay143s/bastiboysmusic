import logging
import difflib
from db_utils import get_db_connection

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def find_variations(table_name, column_name):
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            cursor.execute(f"SELECT DISTINCT {column_name} FROM {table_name} WHERE {column_name} IS NOT NULL AND {column_name} != ''")
            names = [row[0] for row in cursor.fetchall()]
            
            logger.info(f"Analyzing {len(names)} unique names in {table_name}...")
            
            # Simple clustering
            # We'll normalize by removing punctuation and lowercasing, then group
            canonical_map = {} # normalized -> canonical (first one found or most frequent)
            
            # To pick the 'best' canonical, we might want frequency, but for now let's just see conflicts
            
            normalized_groups = {}
            
            for name in names:
                norm = name.lower().replace('.', '').replace(' ', '').replace('-', '')
                if norm not in normalized_groups:
                    normalized_groups[norm] = []
                normalized_groups[norm].append(name)
            
            potential_merges = 0
            print(f"\n--- Potential Duplicates in {table_name} ---")
            for norm, group in normalized_groups.items():
                if len(group) > 1:
                    print(f"Group: {group}")
                    potential_merges += 1
            
            if potential_merges == 0:
                print("No obvious punctuation/case-sensitivity duplicates found.")

    except Exception as e:
        logger.error(f"Error finding variations in {table_name}: {e}")

if __name__ == "__main__":
    find_variations('singers', 'singer_name')
    find_variations('artists', 'artist_name')
    find_variations('music_directors', 'director_name')
