import logging
import sys
sys.path.insert(0, '/Users/vijayramireddy/Documents/bastiboysmusic/backend/python-scripts')

from db_utils import get_db_connection

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

def build_name_map(names_list):
    """
    Build a fuzzy matching map for names.
    Key: normalized (lowercase, no spaces/dots), Value: canonical name
    """
    name_map = {}
    for name in names_list:
        if not name:
            continue
        # Normalize key
        key = name.lower().replace('.', '').replace(' ', '').replace('-', '')
        name_map[key] = name
    return name_map

def normalize_key(name):
    """Normalize a name to a lookup key."""
    if not name:
        return ''
    return name.lower().replace('.', '').replace(' ', '').replace('-', '')

def normalize_songs_singers():
    """
    Normalize songs.singer column using singers table as source of truth.
    """
    logger.info("Normalizing songs.singer using singers table...")
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            
            # Get all canonical singer names
            cursor.execute("SELECT singer_name FROM singers")
            singers = [row[0] for row in cursor.fetchall()]
            singer_map = build_name_map(singers)
            
            logger.info(f"Loaded {len(singers)} canonical singer names")
            
            # Get all songs with singers
            cursor.execute("SELECT id, singer FROM songs WHERE singer IS NOT NULL AND singer != ''")
            songs = cursor.fetchall()
            
            updated = 0
            for song_id, singer_str in songs:
                # Split by comma
                names = [n.strip() for n in singer_str.replace(' & ', ',').replace(' and ', ',').split(',')]
                
                new_names = []
                changed = False
                
                for name in names:
                    if not name:
                        continue
                    
                    # Look up canonical name
                    key = normalize_key(name)
                    canonical = singer_map.get(key, name)
                    
                    if canonical != name:
                        changed = True
                    
                    new_names.append(canonical)
                
                if changed and new_names:
                    new_str = ", ".join(new_names)
                    cursor.execute("UPDATE songs SET singer = %s WHERE id = %s", (new_str, song_id))
                    updated += 1
            
            conn.commit()
            logger.info(f"Updated {updated} songs with normalized singers")
            
    except Exception as e:
        logger.error(f"Error normalizing songs.singer: {e}")
        raise

def normalize_albums_star_cast():
    """
    Normalize albums.star_cast column using artists table as source of truth.
    """
    logger.info("Normalizing albums.star_cast using artists table...")
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            
            # Get all canonical artist names
            cursor.execute("SELECT DISTINCT artist_name FROM artists WHERE artist_name IS NOT NULL")
            artists = [row[0] for row in cursor.fetchall()]
            artist_map = build_name_map(artists)
            
            logger.info(f"Loaded {len(artists)} canonical artist names")
            
            # Get all albums with star_cast
            cursor.execute("SELECT id, star_cast FROM albums WHERE star_cast IS NOT NULL AND star_cast != ''")
            albums = cursor.fetchall()
            
            updated = 0
            for album_id, cast_str in albums:
                # Split by comma
                names = [n.strip() for n in cast_str.replace(' & ', ',').replace(' and ', ',').split(',')]
                
                new_names = []
                changed = False
                
                for name in names:
                    if not name:
                        continue
                    
                    # Look up canonical name
                    key = normalize_key(name)
                    canonical = artist_map.get(key, name)
                    
                    if canonical != name:
                        changed = True
                    
                    new_names.append(canonical)
                
                if changed and new_names:
                    new_str = ", ".join(new_names)
                    cursor.execute("UPDATE albums SET star_cast = %s WHERE id = %s", (new_str, album_id))
                    updated += 1
            
            conn.commit()
            logger.info(f"Updated {updated} albums with normalized star_cast")
            
    except Exception as e:
        logger.error(f"Error normalizing albums.star_cast: {e}")
        raise

def normalize_albums_music_director():
    """
    Normalize albums.music_director column using music_directors table as source of truth.
    """
    logger.info("Normalizing albums.music_director using music_directors table...")
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            
            # Get all canonical music director names
            cursor.execute("SELECT DISTINCT director_name FROM music_directors WHERE director_name IS NOT NULL")
            directors = [row[0] for row in cursor.fetchall()]
            director_map = build_name_map(directors)
            
            logger.info(f"Loaded {len(directors)} canonical music director names")
            
            # Get all albums with music_director
            cursor.execute("SELECT id, music_director FROM albums WHERE music_director IS NOT NULL AND music_director != ''")
            albums = cursor.fetchall()
            
            updated = 0
            for album_id, director_str in albums:
                # Split by comma
                names = [n.strip() for n in director_str.replace(' & ', ',').replace(' and ', ',').split(',')]
                
                new_names = []
                changed = False
                
                for name in names:
                    if not name:
                        continue
                    
                    # Look up canonical name
                    key = normalize_key(name)
                    canonical = director_map.get(key, name)
                    
                    if canonical != name:
                        changed = True
                    
                    new_names.append(canonical)
                
                if changed and new_names:
                    new_str = ", ".join(new_names)
                    cursor.execute("UPDATE albums SET music_director = %s WHERE id = %s", (new_str, album_id))
                    updated += 1
            
            conn.commit()
            logger.info(f"Updated {updated} albums with normalized music_director")
            
    except Exception as e:
        logger.error(f"Error normalizing albums.music_director: {e}")
        raise

if __name__ == "__main__":
    normalize_songs_singers()
    normalize_albums_star_cast()
    normalize_albums_music_director()
    logger.info("✓ All cross-table normalization complete")
