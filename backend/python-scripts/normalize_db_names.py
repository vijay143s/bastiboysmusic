import logging
import re
from db_utils import get_db_connection

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Canonical Mapping
PREFERRED_NAMES = {
    "ar rahman": "A. R. Rahman",
    "a r rahman": "A. R. Rahman",
    "a.r. rahman": "A. R. Rahman",
    "a.r.rahman": "A. R. Rahman",
    "anirudh ravichander": "Anirudh Ravichander",
    "devi sri prasad": "Devi Sri Prasad",
    "dsp": "Devi Sri Prasad",
    "mani sharma": "Mani Sharma",
    "manisharma": "Mani Sharma",
    "mm keeravani": "M. M. Keeravani",
    "m.mv keeravani": "M. M. Keeravani",
    "m m keeravani": "M. M. Keeravani",
    "m.m. keeravani": "M. M. Keeravani",
    "s thaman": "S. Thaman",
    "ss thaman": "S. Thaman",
    "s.s. thaman": "S. Thaman",
    "thaman s": "S. Thaman",
    "thaman": "S. Thaman",
    "ilayaraja": "Ilaiyaraaja",
    "ilaiyaraaja": "Ilaiyaraaja",
    "k chakravarthy": "K. Chakravarthy",
    "k. chakravarthy": "K. Chakravarthy",
    "ghantasala": "Ghantasala",
    "sp balasubrahmanyam": "S. P. Balasubrahmanyam",
    "s.p. balasubrahmanyam": "S. P. Balasubrahmanyam",
    "s. p. balasubrahmanyam": "S. P. Balasubrahmanyam",
    "spb": "S. P. Balasubrahmanyam",
    "ks chithra": "K. S. Chithra",
    "k.s. chithra": "K. S. Chithra",
    "chitra": "K. S. Chithra",
    "janaki": "S. Janaki",
    "s janaki": "S. Janaki",
    "s. janaki": "S. Janaki",
    "yesudas": "K. J. Yesudas",
    "k.j. yesudas": "K. J. Yesudas",
    "kj yesudas": "K. J. Yesudas",
    "harris jayaraj": "Harris Jayaraj",
    "yuvan shankar raja": "Yuvan Shankar Raja",
}

def get_canonical_name(name):
    """
    Get the canonical name for a given name string.
    1. Check explicit map.
    2. Else return as is (but could apply simple formatting like Title Case).
    """
    if not name:
        return name
    
    clean = name.strip()
    lower = clean.lower().replace('.', '').replace('  ', ' ').strip()
    
    # Check map keys (which should be lowercased keys of preference)
    # But for PREFERRED_NAMES, I used exact keys above. Let's make a lookup map.
    
    # Create lookup on fly or once
    lookup = {k.replace('.', '').replace('  ', ' '): v for k, v in PREFERRED_NAMES.items()}
    
    if lower in lookup:
        return lookup[lower]
    
    # Fallback: if we didn't have an explicit map, returns original 
    # (Checking effectively if punctuation was the only diff)
    return clean

def normalize_simple_table(table_name, column_name, id_column):
    """
    Normalize names in a simple id-name table (artists, music_directors).
    Strategy: 
    1. Fetch all rows.
    2. Group by normalized key.
    3. Determine best name for key.
    4. Update all rows in group to best name.
    """
    logger.info(f"Normalizing {table_name}...")
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            cursor.execute(f"SELECT {id_column}, {column_name} FROM {table_name}")
            rows = cursor.fetchall()
            
            # Group rows
            groups = {}
            for row in rows:
                id_val, name = row
                if not name: continue
                
                # Normalization key: lowercase, no dots, no spaces
                key = name.lower().replace('.', '').replace(' ', '').replace('-', '')
                if key not in groups:
                    groups[key] = []
                groups[key].append({'id': id_val, 'name': name})
            
            updates = 0
            for key, group in groups.items():
                if not group: continue
                
                # Determine canonical name
                # 1. Check if any matches PREFERRED_NAMES
                canonical = None
                
                # Check explicit map first using key
                # We need to act smart. PREFERRED_NAMES keys are looser.
                # Let's check if any name in the group matches a preferred entry
                
                for item in group:
                    mapped = get_canonical_name(item['name'])
                    if mapped != item['name']: # found a mapping
                        canonical = mapped
                        break
                
                if not canonical:
                    # Heuristic: Pick the longest name that looks "nicest" (most caps?)
                    # Sort by length descending, then by uppercase count
                    group.sort(key=lambda x: (len(x['name']), sum(1 for c in x['name'] if c.isupper())), reverse=True)
                    canonical = group[0]['name']
                
                # Update all in group to canonical
                for item in group:
                    if item['name'] != canonical:
                        logger.info(f"Updating {table_name} ID {item['id']}: '{item['name']}' -> '{canonical}'")
                        cursor.execute(f"UPDATE {table_name} SET {column_name} = %s WHERE {id_column} = %s", (canonical, item['id']))
                        updates += 1
            
            conn.commit()
            logger.info(f"Updated {updates} records in {table_name}")

    except Exception as e:
        logger.error(f"Error normalizing {table_name}: {e}")

def normalize_singers_table():
    """
    Special handling for singers table.
    We should DELETE duplicates.
    1. Group by key.
    2. Keep one (canonical), delete others.
    3. If canonical name collision occurs with ANOTHER group (e.g. Thaman -> S. Thaman, but S. Thaman exists),
       we must delete the colliding row instead of updating it.
    """
    logger.info("Normalizing singers...")
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            
            # Fetch all first to build a robust map
            cursor.execute("SELECT singer_id, singer_name FROM singers")
            rows = cursor.fetchall()
            
            # 1. Existing Names Map (Name -> ID) to check for collisions
            existing_names = {row[1]: row[0] for row in rows}
            
            groups = {}
            for row in rows:
                sid, name = row
                # Normalized key
                key = name.lower().replace('.', '').replace(' ', '').replace('-', '')
                if key not in groups:
                    groups[key] = []
                groups[key].append({'id': sid, 'name': name})
            
            deleted = 0
            updated_count = 0
            
            for key, group in groups.items():
                # Sort group to find best candidate within this group
                group.sort(key=lambda x: (len(x['name']), sum(1 for c in x['name'] if c.isupper())), reverse=True)
                
                # Determine the desired canonical name for this group
                # We take the best in group, then normalize it via preferred map
                best_in_group = group[0]['name']
                canonical = get_canonical_name(best_in_group)
                
                # Now, for EACH item in the group, we want it to be 'canonical'.
                # But 'canonical' might already exist in the DB (as a different ID).
                
                # We need to resolve each item
                for item in group:
                    current_name = item['name']
                    current_id = item['id']
                    
                    if current_name == canonical:
                        continue # Already correct
                    
                    # We want to change current_name -> canonical
                    # Check if canonical already exists (in the DB snapshot or real-time?)
                    # Real-time check is safer or try/except
                    
                    try:
                        cursor.execute("UPDATE singers SET singer_name = %s WHERE singer_id = %s", (canonical, current_id))
                        updated_count += 1
                        # Update our local map if needed, but we don't strictly need to if we rely on DB constraints
                        # But wait, if we update, we might hit duplicate error if needed.
                        
                    except Exception as err:
                        # Check for duplicate entry error (1062)
                        if "1062" in str(err) or "Duplicate entry" in str(err):
                            logger.info(f"Duplicate collision: '{current_name}' -> '{canonical}'. Deleting ID {current_id} instead.")
                            cursor.execute("DELETE FROM singers WHERE singer_id = %s", (current_id,))
                            deleted += 1
                        else:
                            logger.error(f"Error updating singer {current_id}: {err}")

            conn.commit()
            logger.info(f"Singers normalization: {updated_count} renamed, {deleted} duplicates deleted")
            
    except Exception as e:
        logger.error(f"Error normalizing singers: {e}")

def normalize_songs_singers():
    """
    Parse 'singer' column in songs table, normalize each name, rebuild string.
    """
    logger.info("Normalizing songs.singer column...")
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT id, singer FROM songs WHERE singer IS NOT NULL AND singer != ''")
            rows = cursor.fetchall()
            
            updated = 0
            for row in rows:
                sid, singer_str = row
                
                # Split
                names = [n.strip() for n in singer_str.replace(' & ', ',').split(',')]
                
                new_names = []
                changed = False
                
                for name in names:
                    if not name: continue
                    # We need a robust 'get_canonical' that can handle the raw name
                    # We can use the same logic: check preferred, else heuristic?
                    # Since we don't have the whole table context here, we rely on preferred map + simple cleanup
                    
                    # Re-use the PREFERRED lookup for exact matches
                    mapped = get_canonical_name(name)
                    if mapped != name:
                        changed = True
                    new_names.append(mapped)
                
                if changed:
                    new_str = ", ".join(new_names)
                    if new_str != singer_str:
                         cursor.execute("UPDATE songs SET singer = %s WHERE id = %s", (new_str, sid))
                         updated += 1
            
            conn.commit()
            logger.info(f"Updated {updated} songs with normalized singers")

    except Exception as e:
        logger.error(f"Error normalizing songs: {e}")

def normalize_albums_table():
    """
    Normalize 'music_director', 'director', and 'star_cast' in albums table.
    These are likely comma-separated strings.
    """
    logger.info("Normalizing albums table columns...")
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT id, music_director, director, star_cast FROM albums")
            rows = cursor.fetchall()
            
            updated = 0
            for row in rows:
                aid, md, d, cast = row
                
                new_md = normalize_comma_separated(md)
                new_d = normalize_comma_separated(d)
                new_cast = normalize_comma_separated(cast)
                
                if new_md != md or new_d != d or new_cast != cast:
                    cursor.execute(
                        "UPDATE albums SET music_director = %s, director = %s, star_cast = %s WHERE id = %s",
                        (new_md, new_d, new_cast, aid)
                    )
                    updated += 1
            
            conn.commit()
            logger.info(f"Updated {updated} albums with normalized names")

    except Exception as e:
        logger.error(f"Error normalizing albums: {e}")

def normalize_comma_separated(text):
    """
    Helper to normalize a comma-separated string of names.
    """
    if not text:
        return text
    
    # Handle common separators
    parts = [n.strip() for n in text.replace(' & ', ',').replace(' and ', ',').split(',')]
    
    new_parts = []
    for part in parts:
        if not part: continue
        canonical = get_canonical_name(part)
        new_parts.append(canonical)
    
    return ", ".join(new_parts)

if __name__ == "__main__":
    normalize_simple_table('artists', 'artist_name', 'artist_id')
    normalize_simple_table('music_directors', 'director_name', 'director_id')
    normalize_singers_table()
    normalize_songs_singers()
    normalize_albums_table()
