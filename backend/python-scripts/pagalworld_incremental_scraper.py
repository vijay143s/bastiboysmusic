#!/usr/bin/env python3
"""
Pagal World Incremental Scraper with Full Modes
Supports: Full Load, Incremental Load, Single Page, and Language-wise Scraping

Usage:
    # Full load (DELETE language data then reload)
    python pagalworld_incremental_scraper.py --mode full --language hindi --pages 1 --sql-output sql_output --execute-sql
    python pagalworld_incremental_scraper.py --mode full --language hindi --all-pages --sql-output sql_output --execute-sql
    # Incremental load (only new items)
    python pagalworld_incremental_scraper.py --mode incremental --language hindi --pages 1 --sql-output sql_output --execute-sql

    # Scrape single language page
    python pagalworld_incremental_scraper.py --mode single --url "https://pagalworldmusic.com/language/hindi" --sql-output sql_output --execute-sql

    # Full load multiple languages
    python pagalworld_incremental_scraper.py --mode full --languages "hindi,punjabi,tamil,telugu" --sql-output sql_output --execute-sql
"""

import os
import sys
import json
import html
import logging
import argparse
import requests
from bs4 import BeautifulSoup
from pathlib import Path
from datetime import datetime
from typing import Optional, Dict, List, Any, Set
from concurrent.futures import ThreadPoolExecutor, as_completed
from urllib.parse import urljoin, urlparse, quote
from contextlib import contextmanager

# Import database utilities
try:
    from db_utils import (
        get_db_connection,
        execute_sql_files_batch,
        get_table_row_count,
        test_connection,
        get_max_created_at,
        check_album_exists,
        get_existing_album_titles,
        check_song_exists,
        get_album_id_by_title,
        get_existing_songs_map
    )
except ImportError as e:
    print(f"Error importing db_utils: {e}")
    print("Make sure db_utils.py is in the same directory")
    sys.exit(1)

# Setup logging
LOG_DIR = Path('logs')
LOG_DIR.mkdir(exist_ok=True)

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(LOG_DIR / 'pagalworld_scraper.log', encoding='utf-8'),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)

# Force UTF-8 output on Windows
if sys.platform == 'win32':
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

# Constants
DEFAULT_TIMEOUT = 30
DEFAULT_WORKERS = 5
BASE_URL = "https://pagalworldmusic.com"

LANGUAGES = {
    'hindi': 'Hindi',
    'punjabi': 'Punjabi',
    'tamil': 'Tamil',
    'telugu': 'Telugu',
    'marathi': 'Marathi',
    'bengali': 'Bengali'
}


def create_session() -> requests.Session:
    """Create requests session with retry logic and increased pool size"""
    from requests.adapters import HTTPAdapter
    from urllib3.util.retry import Retry
    
    session = requests.Session()
    session.headers.update({
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
    })
    
    # Increase connection pool size to handle parallel requests
    adapter = HTTPAdapter(
        pool_connections=50,  # Number of connection pools to cache
        pool_maxsize=50,      # Maximum number of connections in pool
        max_retries=Retry(
            total=3,
            backoff_factor=0.3,
            status_forcelist=[500, 502, 503, 504]
        )
    )
    session.mount('http://', adapter)
    session.mount('https://', adapter)
    
    return session


def clean_album_name(album_name: str) -> str:
    """Clean album name by removing common suffixes and extracting actual album name"""
    if not album_name:
        return album_name
    
    # List of suffixes to remove (case-insensitive)
    suffixes_to_remove = [
        ' Original Motion Picture Soundtrack',
        ' Original Soundtrack',
        ' Motion Picture Soundtrack',
        ' Soundtrack',
        ' OST'
    ]
    
    cleaned = album_name.strip()
    
    # Remove suffixes (case-insensitive)
    for suffix in suffixes_to_remove:
        # Check if it ends with the suffix (case-insensitive)
        if cleaned.lower().endswith(suffix.lower()):
            cleaned = cleaned[:len(cleaned)-len(suffix)].strip()
            break  # Only remove one suffix
    
    # Handle "From {Album}" pattern - extract album name after "From"
    # Example: "Akeli Laila From Baaghi 4" -> "Baaghi 4"
    if ' From ' in cleaned:
        parts = cleaned.split(' From ')
        if len(parts) >= 2:
            # Last part after "From" is usually the album name
            cleaned = parts[-1].strip()
    
    return cleaned


def clean_song_title(song_title: str, album_name: str = None) -> str:
    """Clean song title by removing 'From {Album}' suffix"""
    if not song_title:
        return song_title
    
    cleaned = song_title
    
    # Remove "From {Album}" part
    if ' From ' in cleaned:
        parts = cleaned.split(' From ')
        # First part is the actual song title
        cleaned = parts[0].strip()
    
    # Remove common suffixes
    suffixes = [
        'Original Motion Picture Soundtrack',
        'Original Soundtrack',
        'Motion Picture Soundtrack',
        'Soundtrack',
        'OST'
    ]
    
    for suffix in suffixes:
        if cleaned.endswith(suffix):
            cleaned = cleaned[:-len(suffix)].strip()
    
    return cleaned


def update_song_thumbnails_from_albums():
    """Update songs thumbnail_url from albums using album_id join"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        logger.info("🎨 Updating song thumbnails from album thumbnails...")
        
        # Update query
        update_query = """
        UPDATE songs s
        INNER JOIN albums a ON s.album_id = a.id
        SET s.thumbnail_url = a.thumbnail_url
        WHERE s.thumbnail_url IS NULL OR s.thumbnail_url = '';
        """
        
        cursor.execute(update_query)
        conn.commit()
        
        updated_count = cursor.rowcount
        logger.info(f"✅ Updated {updated_count} songs with album thumbnails")
        
        cursor.close()
        conn.close()
        
        return True
    except Exception as e:
        logger.error(f"❌ Error updating song thumbnails: {e}")
        return False


def fetch_album_details_parallel(scraper, albums: List[Dict], workers: int = DEFAULT_WORKERS) -> List[Dict]:
    """Fetch multiple album details in parallel"""
    all_details = []
    total = len(albums)
    completed = 0
    
    # Increase workers for I/O bound album fetching
    actual_workers = min(workers * 2, total, 20)
    
    logger.info(f"🔄 Fetching {total} album details with {actual_workers} parallel workers...")
    
    def fetch_with_index(album_data):
        return scraper.fetch_album_details(album_data['url']), album_data
    
    with ThreadPoolExecutor(max_workers=actual_workers) as executor:
        future_to_album = {executor.submit(fetch_with_index, album): album for album in albums}
        
        for future in as_completed(future_to_album):
            completed += 1
            album = future_to_album[future]
            
            try:
                details, album_info = future.result()
                details['url'] = album_info['url']  # Preserve original URL
                # Don't overwrite cleaned title from fetch_album_details
                # details['title'] is already set and cleaned in fetch_album_details
                all_details.append(details)
                
                if completed % 5 == 0 or completed == total:
                    logger.info(f"   [OK] ({completed}/{total}) Fetched album details")
            except Exception as e:
                logger.error(f"   [ERROR] ({completed}/{total}) Error fetching album {album.get('url')}: {e}")
    
    return all_details


def fetch_song_details_parallel(scraper, songs: List[Dict], workers: int = DEFAULT_WORKERS) -> List[Dict]:
    """Fetch multiple song details in parallel"""
    all_songs = []
    total = len(songs)
    completed = 0
    
    # More workers for song fetching
    actual_workers = min(workers * 3, total, 30)
    
    logger.info(f"🎵 Fetching {total} song details with {actual_workers} parallel workers...")
    
    def fetch_with_index(song_data):
        return scraper.fetch_song_details(song_data['url']), song_data
    
    with ThreadPoolExecutor(max_workers=actual_workers) as executor:
        future_to_song = {executor.submit(fetch_with_index, song): song for song in songs}
        
        for future in as_completed(future_to_song):
            completed += 1
            song = future_to_song[future]
            
            try:
                details, song_info = future.result()
                details['url'] = song_info['url']  # Preserve original URL
                all_songs.append(details)
                
                if completed % 10 == 0 or completed == total:
                    logger.info(f"   [OK] ({completed}/{total}) Fetched song details")
            except Exception as e:
                logger.error(f"   [ERROR] ({completed}/{total}) Error fetching song {song.get('url')}: {e}")
    
    return all_songs


class PagalWorldSQLDataCollector:
    """Collect and deduplicate scraper data for SQL generation"""
    
    def __init__(self, incremental_mode: bool = False, existing_songs_cache: Dict[str, Set[str]] = None):
        self.albums = {}  # {title: album_data}
        self.songs = []  # [{album_name, title, singer, ...}]
        self.singers: Set[str] = set()
        self.artists: Set[str] = set()
        self.music_directors: Set[str] = set()
        self.incremental_mode = incremental_mode
        self.skipped_songs_count = 0
        # Cache of existing songs: {album_title: set(song_titles)}
        self.existing_songs_cache = existing_songs_cache or {}
    
    def add_album(self, title: str, data: Dict[str, Any]):
        """Add or update album"""
        if title not in self.albums:
            self.albums[title] = {
                'title': title,
                'language': data.get('language', 'hindi'),
                'description': data.get('description', ''),
                'image_url': data.get('image_url'),
                'year': data.get('year'),
                'director': data.get('director', ''),
                'music_director': data.get('music_director', ''),
                'star_cast': data.get('star_cast', ''),
                'created_at': datetime.now().isoformat()
            }
            return True
        return False
    
    def add_song(self, album_name: str, song_data: Dict[str, Any]):
        """Add song - with duplicate check in incremental mode using cache"""
        song_title = song_data.get('title', '')
        
        # In incremental mode, check if song already exists using cache
        if self.incremental_mode and song_title and album_name in self.existing_songs_cache:
            if song_title in self.existing_songs_cache[album_name]:
                self.skipped_songs_count += 1
                return False
        
        # Get album thumbnail as fallback for song thumbnail
        album_thumbnail = self.albums.get(album_name, {}).get('image_url')
        
        song = {
            'album_name': album_name,
            'title': song_data.get('title', ''),
            'singer': song_data.get('singer', ''),
            'artist': song_data.get('artist', ''),
            'image_url': song_data.get('image_url') or album_thumbnail,
            'audio_url': song_data.get('audio_url'),
            'duration': song_data.get('duration'),
            'created_at': datetime.now().isoformat()
        }
        self.songs.append(song)
        
        # Collect metadata
        if song.get('singer'):
            self.singers.add(song['singer'])
        if song.get('artist'):
            self.artists.add(song['artist'])
        if self.albums.get(album_name, {}).get('music_director'):
            self.music_directors.add(self.albums[album_name]['music_director'])
    
    def _escape_sql(self, value: Any) -> str:
        """Escape SQL string and decode HTML entities"""
        if value is None:
            return 'NULL'
        if isinstance(value, bool):
            return '1' if value else '0'
        if isinstance(value, (int, float)):
            return str(value)
        # Decode HTML entities first (e.g., &amp; -> &)
        decoded = html.unescape(str(value))
        # Then escape SQL special characters
        escaped = decoded.replace("'", "''")
        return f"'{escaped}'"
    
    def _make_absolute_url(self, url: Optional[str]) -> Optional[str]:
        """Convert relative URLs to absolute URLs"""
        if not url:
            return None
        if url.startswith('http'):
            return url
        if url.startswith('/'):
            return f"{BASE_URL}{url}"
        return url
    
    def _generate_stream_url(self, audio_url: Optional[str]) -> Optional[str]:
        """
        Generate stream URL ONLY for pagalworldmusic.com URLs
        For other domains (sentunes.online, etc), return None (use audio_url directly)
        """
        if not audio_url:
            return None
        
        # Make URL absolute first
        absolute_url = self._make_absolute_url(audio_url)
        if not absolute_url:
            return None
        
        # ONLY generate proxy stream URL for pagalworldmusic.com
        if "pagalworldmusic.com" in absolute_url:
            return f"/api/audio/stream?url={quote(absolute_url, safe='')}"
        
        # For other domains (sentunes.online, etc), return None 
        # This will use audio_url directly in the database
        return None
    
    def generate_sql_files(self, output_dir: Path):
        """Generate SQL INSERT files"""
        output_dir.mkdir(parents=True, exist_ok=True)
        
        self._generate_albums_sql(output_dir / 'albums.sql')
        self._generate_songs_sql(output_dir / 'songs.sql')
        self._generate_singers_sql(output_dir / 'singers.sql')
        self._generate_artists_sql(output_dir / 'artists.sql')
        self._generate_music_directors_sql(output_dir / 'music_directors.sql')
        
        logger.info(f"\n{'='*70}")
        logger.info(f"[OK] SQL FILES GENERATED")
        logger.info(f"{'='*70}")
        logger.info(f"  Albums: {len(self.albums)}")
        logger.info(f"  Songs: {len(self.songs)}")
        logger.info(f"  Singers: {len(self.singers)}")
        logger.info(f"  Artists: {len(self.artists)}")
        logger.info(f"  Music Directors: {len(self.music_directors)}")
        logger.info(f"  Output Directory: {output_dir.resolve()}")
        logger.info(f"{'='*70}\n")
    
    def generate_sql_files_with_delete(self, output_dir: Path, language: str):
        """Generate SQL with DELETE statements for specific language"""
        output_dir.mkdir(parents=True, exist_ok=True)
        
        # Generate DELETE files for this language
        self._generate_delete_statements(output_dir / '00_delete_language.sql', language)
        
        # Then generate INSERT files
        self._generate_albums_sql(output_dir / 'albums.sql')
        self._generate_songs_sql(output_dir / 'songs.sql')
        self._generate_singers_sql(output_dir / 'singers.sql')
        self._generate_artists_sql(output_dir / 'artists.sql')
        self._generate_music_directors_sql(output_dir / 'music_directors.sql')
        
        logger.info(f"\n{'='*70}")
        logger.info(f"[OK] SQL FILES GENERATED (WITH DELETE)")
        logger.info(f"{'='*70}")
        logger.info(f"  Language: {language.upper()}")
        logger.info(f"  Delete: Existing {language} albums and songs")
        logger.info(f"  Albums: {len(self.albums)}")
        logger.info(f"  Songs: {len(self.songs)}")
        logger.info(f"  Singers: {len(self.singers)}")
        logger.info(f"  Artists: {len(self.artists)}")
        logger.info(f"  Music Directors: {len(self.music_directors)}")
        logger.info(f"  Output Directory: {output_dir.resolve()}")
        logger.info(f"{'='*70}\n")
    
    def _generate_delete_statements(self, output_path: Path, language: str):
        """Generate DELETE statements for specific language"""
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- DELETE statements for language-specific full reload\n")
            f.write(f"-- Deleting all {language.upper()} language data\n\n")
            
            f.write("START TRANSACTION;\n\n")
            
            # Delete songs from albums of this language
            f.write("-- Delete songs from this language's albums\n")
            f.write("DELETE FROM songs\n")
            f.write("WHERE album_id IN (\n")
            f.write(f"  SELECT id FROM albums WHERE language = {self._escape_sql(language)}\n")
            f.write(");\n\n")
            
            # Delete albums of this language
            f.write(f"-- Delete albums with language = {language}\n")
            f.write("DELETE FROM albums\n")
            f.write(f"WHERE language = {self._escape_sql(language)};\n\n")
            
            f.write("COMMIT;\n\n")
            f.write("-- All data for language deleted. New data will be inserted next.\n")
    
    def _generate_albums_sql(self, output_path: Path):
        """Generate albums INSERT statements"""
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- Albums INSERT statements\n")
            f.write("-- Generated from Pagal World scraper\n\n")
            
            albums_list = sorted(self.albums.items())
            batch_size = 100
            
            for i in range(0, len(albums_list), batch_size):
                batch = albums_list[i:i+batch_size]
                if not batch:
                    continue
                
                f.write("INSERT IGNORE INTO albums (\n")
                f.write("    title, language, description, thumbnail_url, year,\n")
                f.write("    director, music_director, star_cast, created_at, updated_at\n")
                f.write(") VALUES\n")
                
                for idx, (title, album_data) in enumerate(batch):
                    comma = "," if idx < len(batch) - 1 else ";"
                    f.write("(\n")
                    f.write(f"    {self._escape_sql(album_data['title'])},\n")
                    f.write(f"    {self._escape_sql(album_data['language'])},\n")
                    f.write(f"    {self._escape_sql(album_data['description'][:500])},\n")
                    f.write(f"    {self._escape_sql(self._make_absolute_url(album_data['image_url']))},\n")
                    f.write(f"    {self._escape_sql(album_data['year'])},\n")
                    f.write(f"    {self._escape_sql(album_data['director'])},\n")
                    f.write(f"    {self._escape_sql(album_data['music_director'])},\n")
                    f.write(f"    {self._escape_sql(album_data['star_cast'])},\n")
                    f.write(f"    NOW(),\n")
                    f.write(f"    NOW()\n")
                    f.write(f"){comma}\n")
                
                f.write("\n")
    
    def _generate_songs_sql(self, output_path: Path):
        """Generate songs INSERT statements"""
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- Songs INSERT statements\n")
            f.write("-- Uses COALESCE to link to album_id by title\n")
            f.write("-- Includes pre-generated stream_url for instant playback\n\n")
            
            batch_size = 50
            
            for i in range(0, len(self.songs), batch_size):
                batch = self.songs[i:i+batch_size]
                if not batch:
                    continue
                
                f.write("INSERT IGNORE INTO songs (\n")
                f.write("    album_id, title, singer, thumbnail_url, audio_url, stream_url, created_at, updated_at\n")
                f.write(") VALUES\n")
                
                for idx, song in enumerate(batch):
                    comma = "," if idx < len(batch) - 1 else ";"
                    audio_url = self._make_absolute_url(song['audio_url'])
                    stream_url = self._generate_stream_url(song['audio_url']) if audio_url else None
                    f.write("(\n")
                    f.write(f"    COALESCE((SELECT id FROM albums WHERE title = {self._escape_sql(song['album_name'])} LIMIT 1), 1),\n")
                    f.write(f"    {self._escape_sql(song['title'])},\n")
                    f.write(f"    {self._escape_sql(song['singer'])},\n")
                    f.write(f"    {self._escape_sql(self._make_absolute_url(song['image_url']))},\n")
                    f.write(f"    {self._escape_sql(audio_url)},\n")
                    f.write(f"    {self._escape_sql(stream_url)},\n")
                    f.write(f"    NOW(),\n")
                    f.write(f"    NOW()\n")
                    f.write(f"){comma}\n")
                
                f.write("\n")
    
    def _generate_singers_sql(self, output_path: Path):
        """Generate singers INSERT statements"""
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- Singers INSERT statements\n\n")
            
            singers_list = sorted(list(self.singers))
            batch_size = 100
            
            for i in range(0, len(singers_list), batch_size):
                batch = singers_list[i:i+batch_size]
                if not batch:
                    continue
                
                f.write("INSERT IGNORE INTO singers (singer_name) VALUES\n")
                
                for idx, singer in enumerate(batch):
                    comma = "," if idx < len(batch) - 1 else ";"
                    f.write(f"({self._escape_sql(singer)}){comma}\n")
                
                f.write("\n")
    
    def _generate_artists_sql(self, output_path: Path):
        """Generate artists INSERT statements"""
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- Artists INSERT statements\n\n")
            
            artists_list = sorted(list(self.artists))
            batch_size = 100
            
            for i in range(0, len(artists_list), batch_size):
                batch = artists_list[i:i+batch_size]
                if not batch:
                    continue
                
                f.write("INSERT IGNORE INTO artists (artist_name) VALUES\n")
                
                for idx, artist in enumerate(batch):
                    comma = "," if idx < len(batch) - 1 else ";"
                    f.write(f"({self._escape_sql(artist)}){comma}\n")
                
                f.write("\n")
    
    def _generate_music_directors_sql(self, output_path: Path):
        """Generate music_directors INSERT statements"""
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- Music Directors INSERT statements\n\n")
            
            directors_list = sorted(list(self.music_directors))
            batch_size = 100
            
            for i in range(0, len(directors_list), batch_size):
                batch = directors_list[i:i+batch_size]
                if not batch:
                    continue
                
                f.write("INSERT IGNORE INTO music_directors (director_name) VALUES\n")
                
                for idx, director in enumerate(batch):
                    comma = "," if idx < len(batch) - 1 else ";"
                    f.write(f"({self._escape_sql(director)}){comma}\n")
                
                f.write("\n")


class PagalWorldIncrementalScraper:
    """Main scraper with incremental support"""
    
    def __init__(self, timeout: int = DEFAULT_TIMEOUT, workers: int = DEFAULT_WORKERS):
        self.timeout = timeout
        self.workers = workers
        self.session = create_session()
    
    def scrape_language_page(self, soup_or_language, pages: int = 1, url: str = None, all_pages: bool = False) -> List[Dict[str, Any]]:
        """Scrape language page for albums and songs
        
        Args:
            soup_or_language: Either BeautifulSoup object (for single page) or language string (for multi-page)
            pages: Number of pages to scrape (when language string provided)
            url: Original URL (when BeautifulSoup provided, to extract language)
            all_pages: Whether to scrape all pages
        """
        # Single page mode - soup object provided
        if isinstance(soup_or_language, BeautifulSoup):
            soup = soup_or_language
            language = 'hindi'  # default
            
            # Try to extract language from URL
            if url:
                logger.info(f"   Parsing single page: {url}")
                for lang_key in LANGUAGES.keys():
                    if lang_key in url.lower():
                        language = lang_key
                        break
            
            all_items = []
            
            # Find all track divs
            track_divs = soup.find_all('div', class_='track')
            logger.info(f"   Found {len(track_divs)} track divs on page")
            
            for track_div in track_divs:
                link = track_div.find('a', href=True)
                if not link:
                    continue
                
                href = link.get('href', '')
                if 'album' not in href.lower() and 'track' not in href.lower():
                    continue
                
                # Parse basic info from track-box
                track_box = track_div.find('div', class_='track-box')
                if track_box:
                    track_info = track_box.find('div', class_='track-info')
                    if not track_info:
                        continue
                    
                    title_div = track_info.find('div', class_='track-title')
                    title = title_div.get_text(strip=True) if title_div else 'Unknown'
                    
                    # Extract artist from second small-text div
                    artist = ''
                    small_texts = track_info.find_all('div', class_='small-text')
                    if len(small_texts) >= 1:
                        artist = small_texts[0].get_text(strip=True)
                    
                    img = track_box.find('img')
                    image_url = img.get('data-src', '') or img.get('src', '') if img else None
                    
                    item_type = 'album' if 'album' in href.lower() else 'song'
                    
                    all_items.append({
                        'type': item_type,
                        'title': title,
                        'url': urljoin(BASE_URL, href),
                        'image_url': image_url,
                        'language': language,
                        'artist': artist
                    })
            
            logger.info(f"   Extracted {len(all_items)} items (albums/tracks)")
            return all_items
        
        # Multi-page mode - language string provided
        language = soup_or_language
        all_items = []
        page = 1
        
        while True:
            # URL structure: /language/hindi (page 1), /language/hindi/2, /language/hindi/3, etc.
            if page == 1:
                url = f"{BASE_URL}/language/{language}"
            else:
                url = f"{BASE_URL}/language/{language}/{page}"
            
            logger.info(f"[PAGE] Scraping {language.upper()} page {page}: {url}")
            
            try:
                response = self.session.get(url, timeout=self.timeout)
                response.raise_for_status()
                
                soup = BeautifulSoup(response.content, 'html.parser')
                
                # Find all track divs
                track_divs = soup.find_all('div', class_='track')
                logger.info(f"   Found {len(track_divs)} items")
                
                if not track_divs:
                    logger.info(f"   No items found on page {page}, stopping")
                    break
                
                for track_div in track_divs:
                    link = track_div.find('a', href=True)
                    if not link:
                        continue
                    
                    href = link.get('href', '')
                    if 'album' not in href.lower() and 'track' not in href.lower():
                        continue
                    
                    # Parse basic info from track-box
                    track_box = track_div.find('div', class_='track-box')
                    if track_box:
                        track_info = track_box.find('div', class_='track-info')
                        if not track_info:
                            continue
                        
                        title_div = track_info.find('div', class_='track-title')
                        title = title_div.get_text(strip=True) if title_div else 'Unknown'
                        
                        # Extract artist from second small-text div
                        artist = ''
                        small_texts = track_info.find_all('div', class_='small-text')
                        if len(small_texts) >= 1:
                            artist = small_texts[0].get_text(strip=True)
                        
                        img = track_box.find('img')
                        image_url = img.get('data-src', '') or img.get('src', '') if img else None
                        
                        item_type = 'album' if 'album' in href.lower() else 'song'
                        
                        all_items.append({
                            'type': item_type,
                            'title': title,
                            'url': urljoin(BASE_URL, href),
                            'image_url': image_url,
                            'language': language,
                            'artist': artist
                        })
                
                import time
                time.sleep(1)  # Be respectful
                
                # Check if we should continue
                if not all_pages and page >= pages:
                    break
                
                page += 1
            
            except Exception as e:
                logger.error(f"Error scraping page {page}: {e}")
                break
        
        return all_items
    
    def fetch_album_details(self, album_url: str) -> Dict[str, Any]:
        """Fetch full album details from album page"""
        try:
            response = self.session.get(album_url, timeout=self.timeout)
            response.raise_for_status()
            soup = BeautifulSoup(response.content, 'html.parser')
            
            # Extract album details
            details = {
                'title': '',
                'description': '',
                'image_url': None,
                'year': None,
                'director': None,
                'music_director': None,
                'star_cast': None,
                'language': 'hindi',
                'songs': []
            }
            
            # Extract title from URL slug (e.g., /album/Lq685j4sOf4_/son-of-sardaar-2 -> Son Of Sardaar 2)
            url_parts = album_url.rstrip('/').split('/')
            if len(url_parts) >= 2:
                slug = url_parts[-1]
                # Convert slug to title case (son-of-sardaar-2 -> Son Of Sardaar 2)
                title_from_slug = slug.replace('-', ' ').title()
                # Clean the album name (remove "Original Motion Picture Soundtrack", etc.)
                details['title'] = clean_album_name(title_from_slug)
            
            # Fallback: Get title from h1 if slug extraction fails
            if not details['title']:
                title_h1 = soup.find('h1')
                if title_h1:
                    raw_title = title_h1.get_text(strip=True)
                    details['title'] = clean_album_name(raw_title)
            
            # Get image from first track - check multiple sources
            # Priority: actual src > data-src, skip default.webp
            first_img = soup.find('img', class_='track-image')
            if not first_img:
                first_img = soup.find('img', class_='image')
            
            if first_img:
                img_url = first_img.get('src') or first_img.get('data-src')
                # Skip default placeholder images
                if img_url and 'default.webp' not in img_url:
                    details['image_url'] = img_url
                elif first_img.get('data-src') and 'default.webp' not in first_img.get('data-src', ''):
                    details['image_url'] = first_img.get('data-src')
            
            # If still no image, try to get from JSON-LD schema
            if not details['image_url']:
                json_ld_scripts = soup.find_all('script', type='application/ld+json')
                for script in json_ld_scripts:
                    try:
                        data = json.loads(script.string)
                        if data.get('@type') == 'MusicRecording' and data.get('image'):
                            img_url = data['image']
                            if 'default.webp' not in img_url:
                                details['image_url'] = img_url
                                break
                    except:
                        pass
            
            # Parse JSON-LD schema for metadata
            json_ld_scripts = soup.find_all('script', type='application/ld+json')
            for script in json_ld_scripts:
                try:
                    data = json.loads(script.string)
                    if data.get('@type') == 'MusicRecording':
                        # Extract year from datePublished
                        if 'datePublished' in data:
                            try:
                                details['year'] = int(data['datePublished'][:4])
                            except:
                                pass
                        # Extract artist as music_director
                        if 'byArtist' in data and isinstance(data['byArtist'], dict):
                            artist_name = data['byArtist'].get('name', '')
                            if artist_name and not details['music_director']:
                                details['music_director'] = artist_name
                        break
                except:
                    pass
            
            # Extract language from breadcrumb
            breadcrumb = soup.find('ol', class_='breadcrumb')
            if breadcrumb:
                language_link = breadcrumb.find('a', href=lambda x: x and '/language/' in x)
                if language_link:
                    lang_name = language_link.find('span', itemprop='name')
                    if lang_name:
                        lang_text = lang_name.get_text(strip=True).replace(' Music', '').lower()
                        details['language'] = lang_text
            
            # Find all songs in album
            track_divs = soup.find_all('div', class_='track')
            for track_div in track_divs:
                song_link = track_div.find('a', href=True)
                if song_link and 'track' in song_link.get('href', ''):
                    track_info = track_div.find('div', class_='track-info')
                    if track_info:
                        title_div = track_info.find('div', class_='track-title')
                        raw_song_title = title_div.get_text(strip=True) if title_div else 'Unknown'
                        # Clean song title
                        song_title = clean_song_title(raw_song_title, details.get('title'))
                        
                        # Extract artist from byArtist attribute or small-text
                        artist = ''
                        small_texts = track_info.find_all('div', class_='small-text')
                        if len(small_texts) >= 1:
                            artist = small_texts[0].get_text(strip=True)
                        
                        details['songs'].append({
                            'title': song_title,
                            'url': urljoin(BASE_URL, song_link.get('href', '')),
                            'artist': artist
                        })
            
            import time
            time.sleep(0.5)
            return details
        
        except Exception as e:
            logger.error(f"Error fetching album {album_url}: {e}")
            return {'title': '', 'songs': []}
    
    def fetch_song_details(self, song_url: str) -> Dict[str, Any]:
        """Fetch full song details from song page - simple structure"""
        try:
            response = self.session.get(song_url, timeout=self.timeout)
            response.raise_for_status()
            soup = BeautifulSoup(response.content, 'html.parser')
            
            details = {
                'title': '',
                'singer': '',
                'artist': '',
                'album_name': '',
                'album_url': '',
                'year': None,
                'music_director': '',
                'label': '',
                'duration': '',
                'release_date': '',
                'language': 'hindi',
                'image_url': None,
                'audio_url': None
            }
            
            # Extract album info from breadcrumb first
            breadcrumb = soup.find('ol', class_='breadcrumb')
            if breadcrumb:
                # Find album link in breadcrumb (before the song link)
                album_link = breadcrumb.find('a', href=lambda x: x and '/album/' in x)
                if album_link:
                    details['album_url'] = urljoin(BASE_URL, album_link.get('href', ''))
                    album_span = album_link.find('span', itemprop='name')
                    if album_span:
                        raw_album_name = album_span.get_text(strip=True).replace(' Album', '').strip()
                        details['album_name'] = clean_album_name(raw_album_name)
            
            # Get image
            img = soup.find('img', class_='trackimg')
            if not img:
                img = soup.find('img', class_='track-image')
            if img:
                details['image_url'] = img.get('src') or img.get('data-src')
            
            # Get audio URL - prioritize 320kbps (high MB)
            audio_links = soup.find_all('a', href=lambda x: x and '/download.php' in x)
            if audio_links:
                # Try to find 320kbps first
                high_quality = None
                for link in audio_links:
                    href = link.get('href', '')
                    link_text = link.get_text(strip=True).lower()
                    if '320' in link_text or 'high' in href:
                        high_quality = href
                        break
                
                audio_url = high_quality or audio_links[0].get('href', '')
                if audio_url.startswith('/'):
                    details['audio_url'] = urljoin(BASE_URL, audio_url)
                else:
                    details['audio_url'] = audio_url
            
            # Parse metadata table
            table = soup.find('table')
            if table:
                rows = table.find_all('tr')
                for row in rows:
                    th = row.find('th')
                    td = row.find('td')
                    if th and td:
                        label = th.get_text(strip=True).lower()
                        value = td.get_text(strip=True)
                        
                        if label == 'track name':
                            raw_title = value
                            details['title'] = clean_song_title(raw_title, details.get('album_name'))
                        elif label == 'artist':
                            details['singer'] = value
                            details['artist'] = value
                        elif label == 'album name':
                            # Clean album name from table (fallback if breadcrumb didn't work)
                            if not details['album_name']:
                                details['album_name'] = clean_album_name(value)
                        elif label == 'release':
                            details['release_date'] = value
                            # Extract year from release date
                            try:
                                details['year'] = int(value[:4])
                            except:
                                pass
                        elif label == 'duration':
                            details['duration'] = value
                        elif label == 'artists':
                            # Multiple artists, use first as singer
                            if not details['singer']:
                                details['singer'] = value.split(',')[0].strip()
                        elif label == 'music':
                            details['music_director'] = value
                        elif label == 'label':
                            details['label'] = value
                        elif label == 'year':
                            try:
                                details['year'] = int(value)
                            except:
                                pass
                        elif label == 'language':
                            details['language'] = value.lower()
            
            import time
            time.sleep(0.5)
            return details
        
        except Exception as e:
            logger.error(f"Error fetching song {song_url}: {e}")
            return {}


def run_full_load(language: str, pages: int, sql_output: Path, execute_sql: bool, all_pages: bool = False):
    """Run full load for language - DELETE language data once, then scrape and execute page by page"""
    logger.info("="*70)
    logger.info(f"[FULL LOAD] {language.upper()}")
    logger.info(f"   [DELETE] Will DELETE all {language.upper()} data before reloading")
    if all_pages:
        logger.info(f"   [PAGES] Scraping ALL pages - EXECUTING PAGE BY PAGE")
    else:
        logger.info(f"   [PAGES] Scraping {pages} page(s) - EXECUTING PAGE BY PAGE")
    logger.info("="*70)
    
    scraper = PagalWorldIncrementalScraper()
    
    # DELETE language data ONCE at the beginning (before processing any pages)
    if execute_sql:
        logger.info(f"\n🗑️  [DELETE] Deleting existing {language} data from database...")
        delete_collector = PagalWorldSQLDataCollector()
        delete_collector.generate_sql_files_with_delete(sql_output, language)
        delete_file = sql_output / '00_delete_language.sql'
        if delete_file.exists():
            results = execute_sql_files_batch([delete_file])
            if results['success'] > 0:
                logger.info(f"✅ Successfully deleted existing {language} data")
            else:
                logger.error(f"❌ Failed to delete existing {language} data: {results.get('errors')}")
                return
    
    # Process pages one by one
    current_page = 1
    total_albums_processed = 0
    total_songs_processed = 0
    
    while True:
        # Build URL for current page
        if current_page == 1:
            page_url = f"{BASE_URL}/language/{language}"
        else:
            page_url = f"{BASE_URL}/language/{language}/{current_page}"
        
        logger.info(f"\n{'='*70}")
        logger.info(f"📄 PAGE {current_page}: {page_url}")
        logger.info(f"{'='*70}")
        
        try:
            # Fetch page content
            response = scraper.session.get(page_url, timeout=scraper.timeout)
            response.raise_for_status()
            soup = BeautifulSoup(response.content, 'html.parser')
            
            # Find all track divs on this page
            track_divs = soup.find_all('div', class_='track')
            logger.info(f"   Found {len(track_divs)} items on page {current_page}")
            
            if not track_divs:
                logger.info(f"   No items found on page {current_page}, stopping pagination")
                break
            
            # Create collector for this page only
            page_collector = PagalWorldSQLDataCollector()
            
            # Scrape items from current page
            items = scraper.scrape_language_page(soup, url=page_url)
            logger.info(f"   Extracted {len(items)} items from page {current_page}")
            
            if not items:
                logger.info(f"   No valid items on page {current_page}, stopping")
                break
            
            # Separate albums and standalone tracks
            albums = [i for i in items if i['type'] == 'album']
            standalone_tracks = [i for i in items if i['type'] == 'song']
            
            logger.info(f"   📀 Albums: {len(albums)}, 🎵 Standalone Tracks: {len(standalone_tracks)}")
            
            # Fetch all album details in parallel for this page
            album_details_list = fetch_album_details_parallel(scraper, albums, workers=DEFAULT_WORKERS)
            
            # Collect all songs from albums for parallel fetching
            all_songs_to_fetch = []
            for i, album_detail in enumerate(album_details_list):
                album = albums[i]
                # Use album title from details (extracted from URL slug)
                album_title = album_detail.get('title', album['title'])
                
                page_collector.add_album(album_title, {
                    'language': language,
                    'description': album_detail.get('description', ''),
                    'image_url': album_detail.get('image_url') or album.get('image_url'),
                    'year': album_detail.get('year'),
                    'director': album_detail.get('director'),
                    'music_director': album_detail.get('music_director'),
                    'star_cast': album_detail.get('star_cast')
                })
                
                # Collect songs from this album for parallel fetch
                for song in album_detail.get('songs', []):
                    all_songs_to_fetch.append({
                        'url': song['url'],
                        'album_title': album_title,
                        'song_title': song['title']
                    })
            
            logger.info(f"   🎵 Found {len(all_songs_to_fetch)} songs from albums")
            
            # Fetch all song details from albums in parallel
            if all_songs_to_fetch:
                song_details_list = fetch_song_details_parallel(scraper, all_songs_to_fetch, workers=DEFAULT_WORKERS)
                
                # Add fetched songs to collector
                for i, song_detail in enumerate(song_details_list):
                    song_info = all_songs_to_fetch[i]
                    page_collector.add_song(song_info['album_title'], {
                        'title': song_detail.get('title', song_info['song_title']),
                        'singer': song_detail.get('singer', ''),
                        'image_url': song_detail.get('image_url'),
                        'audio_url': song_detail.get('audio_url')
                    })
            
            # Process standalone tracks (singles)
            if standalone_tracks:
                logger.info(f"   🎵 Processing {len(standalone_tracks)} standalone tracks...")
                
                # Fetch standalone track details first to get album info
                standalone_songs_to_fetch = [{
                    'url': track['url'],
                    'album_title': None,  # Will be determined from track page
                    'song_title': track['title']
                } for track in standalone_tracks]
                
                standalone_details_list = fetch_song_details_parallel(scraper, standalone_songs_to_fetch, workers=DEFAULT_WORKERS)
                
                # Group tracks by their actual album and create albums
                album_tracks = {}  # album_name -> list of tracks
                
                for i, song_detail in enumerate(standalone_details_list):
                    track_info = standalone_tracks[i]
                    album_name = song_detail.get('album_name', 'Singles')
                    
                    # Use cleaned album name or fallback to Singles
                    if not album_name or album_name.strip() == '':
                        album_name = 'Singles'
                    
                    if album_name not in album_tracks:
                        album_tracks[album_name] = {
                            'tracks': [],
                            'year': song_detail.get('year'),
                            'music_director': song_detail.get('music_director'),
                            'image_url': song_detail.get('image_url'),
                            'language': song_detail.get('language', language)
                        }
                    
                    album_tracks[album_name]['tracks'].append({
                        'title': song_detail.get('title', track_info['title']),
                        'singer': song_detail.get('singer', track_info.get('artist', '')),
                        'image_url': song_detail.get('image_url', track_info.get('image_url')),
                        'audio_url': song_detail.get('audio_url')
                    })
                    
                    # Update album metadata if not set
                    if not album_tracks[album_name]['year'] and song_detail.get('year'):
                        album_tracks[album_name]['year'] = song_detail.get('year')
                    if not album_tracks[album_name]['music_director'] and song_detail.get('music_director'):
                        album_tracks[album_name]['music_director'] = song_detail.get('music_director')
                    if not album_tracks[album_name]['image_url'] and song_detail.get('image_url'):
                        album_tracks[album_name]['image_url'] = song_detail.get('image_url')
                
                # Create albums and add tracks
                logger.info(f"   📀 Creating {len(album_tracks)} albums from standalone tracks...")
                for album_name, album_data in album_tracks.items():
                    # Add album if not already exists
                    if album_name not in page_collector.albums:
                        page_collector.add_album(album_name, {
                            'language': album_data['language'],
                            'description': f'{len(album_data["tracks"])} tracks',
                            'image_url': album_data['image_url'],
                            'year': album_data['year'],
                            'music_director': album_data['music_director']
                        })
                    
                    # Add all tracks to this album
                    for track in album_data['tracks']:
                        page_collector.add_song(album_name, track)
            
            # Generate SQL for this page (no DELETE - already done at start)
            logger.info(f"   📊 Generating SQL for page {current_page}...")
            page_collector.generate_sql_files(sql_output)
            
            page_albums = len(page_collector.albums)
            page_songs = len(page_collector.songs)
            total_albums_processed += page_albums
            total_songs_processed += page_songs
            
            logger.info(f"   ✅ Page {current_page}: {page_albums} albums, {page_songs} songs")
            
            # Execute SQL for this page if requested
            if execute_sql:
                logger.info(f"   💾 Executing SQL for page {current_page}...")
                # Get all SQL files in the output directory (exclude delete file)
                sql_files = sorted([
                    sql_output / 'albums.sql',
                    sql_output / 'songs.sql',
                    sql_output / 'singers.sql',
                    sql_output / 'artists.sql',
                    sql_output / 'music_directors.sql'
                ])
                sql_files = [f for f in sql_files if f.exists()]
                
                results = execute_sql_files_batch(sql_files)
                if results['success'] > 0:
                    logger.info(f"   ✅ Page {current_page} data executed successfully")
                else:
                    logger.error(f"   ❌ Page {current_page} execution failed: {results.get('errors')}")
                
                if results['errors']:
                    logger.error(f"   Errors on page {current_page}: {results['errors']}")
            
            # Check if we should continue to next page
            if not all_pages and current_page >= pages:
                logger.info(f"\n   ⏹️  Reached requested page limit ({pages})")
                break
            
            # Small delay between pages
            import time
            time.sleep(1)
            current_page += 1
            
        except Exception as e:
            logger.error(f"   ❌ Error processing page {current_page}: {e}")
            break
    
    logger.info("\n" + "="*70)
    logger.info(f"[OK] FULL LOAD COMPLETE - Processed {current_page} page(s)")
    logger.info(f"   Total: {total_albums_processed} albums, {total_songs_processed} songs")
    logger.info("="*70 + "\n")
    logger.info("\n" + "="*70)
    logger.info(f"[OK] FULL LOAD COMPLETE - Processed {current_page} page(s)")
    logger.info(f"   Total: {total_albums_processed} albums, {total_songs_processed} songs")
    logger.info("="*70 + "\n")


def run_incremental_load(language: str, pages: int, sql_output: Path, execute_sql: bool, all_pages: bool = False):
    """Run incremental load for language"""
    logger.info("="*70)
    logger.info(f"📈 INCREMENTAL LOAD: {language.upper()}")
    if all_pages:
        logger.info(f"   📄 Scraping ALL pages (pagination)")
    else:
        logger.info(f"   📄 Scraping {pages} page(s)")
    logger.info("="*70)
    
    # Get existing albums
    existing_titles = get_existing_album_titles(language)
    logger.info(f"\n📊 Found {len(existing_titles)} existing albums for {language}")
    
    # Load existing songs cache for duplicate checking
    logger.info("📊 Loading existing songs from database...")
    existing_songs_cache = get_existing_songs_map()
    
    scraper = PagalWorldIncrementalScraper()
    collector = PagalWorldSQLDataCollector(incremental_mode=True, existing_songs_cache=existing_songs_cache)
    
    # Scrape language pages
    logger.info(f"\n📥 Scraping {language} ({'all pages' if all_pages else f'{pages} pages'}) for new items...")
    items = scraper.scrape_language_page(language, pages, all_pages=all_pages)
    
    # Filter new items
    new_items = [i for i in items if i['title'] not in existing_titles]
    logger.info(f"Found {len(new_items)} new items (out of {len(items)} total)\n")
    
    if not new_items:
        logger.info("No new items to scrape!")
        return
    
    # Process new albums
    new_albums = [i for i in new_items if i['type'] == 'album']
    logger.info(f"📀 Processing {len(new_albums)} new albums...")
    
    # Fetch all new album details in parallel
    album_details_list = fetch_album_details_parallel(scraper, new_albums, workers=DEFAULT_WORKERS)
    
    # Collect all songs for parallel fetching
    all_songs_to_fetch = []
    for i, album_detail in enumerate(album_details_list):
        album = new_albums[i]
        collector.add_album(album['title'], {
            'language': language,
            'description': album_detail.get('description', ''),
            'image_url': album_detail.get('image_url') or album.get('image_url'),
            'year': album_detail.get('year'),
            'director': album_detail.get('director'),
            'music_director': album_detail.get('music_director'),
            'star_cast': album_detail.get('star_cast')
        })
        
        # Collect songs for parallel fetch
        for song in album_detail.get('songs', []):
            all_songs_to_fetch.append({
                'url': song['url'],
                'album_title': album['title'],
                'song_title': song['title']
            })
    
    logger.info(f"🎵 Found {len(all_songs_to_fetch)} songs to process")
    
    # Fetch all song details in parallel
    if all_songs_to_fetch:
        song_details_list = fetch_song_details_parallel(scraper, all_songs_to_fetch, workers=DEFAULT_WORKERS)
        
        # Add fetched songs to collector
        for i, song_detail in enumerate(song_details_list):
            song_info = all_songs_to_fetch[i]
            collector.add_song(song_info['album_title'], {
                'title': song_detail.get('title', song_info['song_title']),
                'singer': song_detail.get('singer', ''),
                'image_url': song_detail.get('image_url'),
                'audio_url': song_detail.get('audio_url')
            })
    
    # Generate SQL
    logger.info(f"\n📊 Generating SQL...")
    collector.generate_sql_files(sql_output)
    
    # Execute SQL if requested
    if execute_sql:
        logger.info(f"\n💾 Executing SQL...")
        # Get all SQL files in the output directory
        sql_files = sorted([
            sql_output / 'albums.sql',
            sql_output / 'songs.sql',
            sql_output / 'singers.sql',
            sql_output / 'artists.sql',
            sql_output / 'music_directors.sql'
        ])
        sql_files = [f for f in sql_files if f.exists()]
        
        results = execute_sql_files_batch(sql_files)
        logger.info(f"Execution result: {'[OK] Success' if results['success'] > 0 else '[FAIL] Failed'}")
        if results['errors']:
            logger.error(f"Errors: {results['errors']}")
        
        # Update song thumbnails from album thumbnails
        update_song_thumbnails_from_albums()
    
    logger.info("\n" + "="*70)
    logger.info("[OK] INCREMENTAL LOAD COMPLETE")
    logger.info("="*70 + "\n")


def run_single_page(url: str, sql_output: Path, execute_sql: bool):
    """Run scraping for single page - incremental mode (no delete)"""
    logger.info("="*70)
    logger.info(f"🔍 SINGLE PAGE SCRAPING (INCREMENTAL)")
    logger.info(f"URL: {url}")
    logger.info("="*70)
    
    scraper = PagalWorldIncrementalScraper()
    
    # Load existing data ONCE at the beginning
    existing_albums = set()
    existing_songs_cache = {}
    
    if execute_sql:
        try:
            logger.info("📊 Loading existing data from database...")
            existing_albums = get_existing_album_titles()
            existing_songs_cache = get_existing_songs_map()
            logger.info(f"✅ Loaded {len(existing_albums)} albums and {sum(len(songs) for songs in existing_songs_cache.values())} songs")
        except Exception as e:
            logger.warning(f"Could not fetch existing data: {e}")
    
    # Create collector with cache
    collector = PagalWorldSQLDataCollector(incremental_mode=True, existing_songs_cache=existing_songs_cache)
    
    try:
        response = scraper.session.get(url, timeout=scraper.timeout)
        response.raise_for_status()
        soup = BeautifulSoup(response.content, 'html.parser')
        
        # Detect page type: album, track, or language listing
        if '/language/' in url or '/page/' in url:
            logger.info("📋 Detected: Language listing page")
            
            # Scrape all albums/songs from this single page
            items = scraper.scrape_language_page(soup, url=url)  # Pass soup and url as keyword arg
            
            # Extract language from URL if possible
            language = 'hindi'
            for lang_key in LANGUAGES.keys():
                if lang_key in url.lower():
                    language = lang_key
                    break
            
            logger.info(f"✅ Found {len(items)} items on page")
            
            # Separate albums and songs
            albums = [item for item in items if item['type'] == 'album']
            songs = [item for item in items if item['type'] == 'song']
            
            logger.info(f"📀 Albums: {len(albums)}, 🎵 Songs: {len(songs)}")
            
            # Filter out existing albums
            if existing_albums:
                albums_before = len(albums)
                albums = [a for a in albums if a['title'] not in existing_albums]
                skipped = albums_before - len(albums)
                if skipped > 0:
                    logger.info(f"⏭️  Skipped {skipped} existing albums")
            
            # Fetch album details in parallel
            if albums:
                album_details_list = fetch_album_details_parallel(scraper, albums, workers=DEFAULT_WORKERS)
                
                for album_detail in album_details_list:
                    album_title = album_detail.get('title', 'Unknown')
                    if album_title and album_title != '':
                        collector.add_album(album_title, {
                            'language': language,
                            'description': album_detail.get('description', ''),
                            'image_url': album_detail.get('image_url'),
                            'year': album_detail.get('year')
                        })
                        
                        # Fetch songs from this album
                        songs_in_album = album_detail.get('songs', [])
                        if songs_in_album:
                            song_details_list = fetch_song_details_parallel(scraper, songs_in_album, workers=DEFAULT_WORKERS)
                            
                            # Update album metadata from first song if not available
                            if song_details_list and (not album_detail.get('year') or not album_detail.get('music_director')):
                                first_song = song_details_list[0]
                                if not album_detail.get('year') and first_song.get('year'):
                                    collector.albums[album_title]['year'] = first_song.get('year')
                                if not album_detail.get('music_director') and first_song.get('music_director'):
                                    collector.albums[album_title]['music_director'] = first_song.get('music_director')
                                    collector.music_directors.add(first_song.get('music_director'))
                            
                            for song_detail in song_details_list:
                                collector.add_song(album_title, {
                                    'title': song_detail.get('title', ''),
                                    'singer': song_detail.get('singer', ''),
                                    'artist': song_detail.get('artist', ''),
                                    'image_url': song_detail.get('image_url'),
                                    'audio_url': song_detail.get('audio_url'),
                                    'duration': song_detail.get('duration', '')
                                })
            
            # Fetch standalone songs in parallel
            if songs:
                song_details_list = fetch_song_details_parallel(scraper, songs, workers=DEFAULT_WORKERS)
                
                for i, song_detail in enumerate(song_details_list):
                    song_info = songs[i]
                    album_name = 'Singles'
                    
                    # Create singles album if not exists
                    if 'Singles' not in collector.albums:
                        collector.add_album('Singles', {
                            'language': language,
                            'description': 'Single tracks collection',
                            'image_url': song_detail.get('image_url')
                        })
                    
                    collector.add_song(album_name, {
                        'title': song_detail.get('title', song_info.get('title', 'Unknown')),
                        'singer': song_detail.get('singer', ''),
                        'artist': song_detail.get('artist', ''),
                        'image_url': song_detail.get('image_url'),
                        'audio_url': song_detail.get('audio_url'),
                        'duration': song_detail.get('duration', '')
                    })
        
        elif '/album/' in url:
            logger.info("📀 Detected: Album page")
            
            # Fetch album details first (includes title from URL slug)
            album_details = scraper.fetch_album_details(url)
            album_title = album_details.get('title', 'Unknown Album')
            
            # Check if album already exists
            if album_title in existing_albums:
                logger.info(f"⏭️  Album '{album_title}' already exists in database. Skipping.")
                logger.info("\n" + "="*70)
                logger.info("[OK] SINGLE PAGE SCRAPING COMPLETE (No new data)")
                logger.info("="*70 + "\n")
                return
            
            collector.add_album(album_title, {
                'language': album_details.get('language', 'hindi'),
                'description': album_details.get('description', ''),
                'image_url': album_details.get('image_url'),
                'year': album_details.get('year'),
                'director': album_details.get('director'),
                'music_director': album_details.get('music_director'),
                'star_cast': album_details.get('star_cast')
            })
            
            # Fetch all songs in parallel
            songs_to_fetch = [{
                'url': song['url'],
                'album_title': album_title,
                'song_title': song['title']
            } for song in album_details.get('songs', [])]
            
            if songs_to_fetch:
                song_details_list = fetch_song_details_parallel(scraper, songs_to_fetch, workers=DEFAULT_WORKERS)
                
                # Update album metadata from first song if not available
                if song_details_list:
                    first_song = song_details_list[0]
                    if album_title in collector.albums:
                        if not collector.albums[album_title].get('year') and first_song.get('year'):
                            collector.albums[album_title]['year'] = first_song.get('year')
                        if not collector.albums[album_title].get('music_director') and first_song.get('music_director'):
                            collector.albums[album_title]['music_director'] = first_song.get('music_director')
                            collector.music_directors.add(first_song.get('music_director'))
                
                for i, song_detail in enumerate(song_details_list):
                    song_info = songs_to_fetch[i]
                    collector.add_song(song_info['album_title'], {
                        'title': song_detail.get('title', song_info['song_title']),
                        'singer': song_detail.get('singer', ''),
                        'artist': song_detail.get('artist', ''),
                        'image_url': song_detail.get('image_url'),
                        'audio_url': song_detail.get('audio_url'),
                        'duration': song_detail.get('duration', '')
                    })
        
        elif '/track/' in url:
            logger.info("🎵 Detected: Song page")
            song_details = scraper.fetch_song_details(url)
            
            # Create placeholder album
            collector.add_album('Unknown Album', {
                'language': 'hindi',
                'description': '',
                'image_url': song_details.get('image_url')
            })
            
            collector.add_song('Unknown Album', {
                'title': song_details.get('title', 'Unknown Song'),
                'singer': song_details.get('singer', ''),
                'artist': song_details.get('artist', ''),
                'image_url': song_details.get('image_url'),
                'audio_url': song_details.get('audio_url'),
                'duration': song_details.get('duration', '')
            })
        
        else:
            logger.error("Could not detect page type (album or track)")
            return
        
        # Generate SQL
        logger.info(f"\n📊 Generating SQL...")
        collector.generate_sql_files(sql_output)
        
        # Show skip statistics
        if collector.skipped_songs_count > 0:
            logger.info(f"⏭️  Skipped {collector.skipped_songs_count} existing songs (already in database)")
        
        # Execute SQL if requested
        if execute_sql:
            logger.info(f"\n💾 Executing SQL...")
            # Get all SQL files in the output directory
            sql_files = sorted([
                sql_output / 'albums.sql',
                sql_output / 'songs.sql',
                sql_output / 'singers.sql',
                sql_output / 'artists.sql',
                sql_output / 'music_directors.sql'
            ])
            sql_files = [f for f in sql_files if f.exists()]
            
            results = execute_sql_files_batch(sql_files)
            logger.info(f"Execution result: {'[OK] Success' if results['success'] > 0 else '[FAIL] Failed'}")
            if results['errors']:
                logger.error(f"Errors: {results['errors']}")
            
            # Update song thumbnails from album thumbnails
            update_song_thumbnails_from_albums()
        
        logger.info("\n" + "="*70)
        logger.info("[OK] SINGLE PAGE SCRAPING COMPLETE")
        logger.info("="*70 + "\n")
    
    except Exception as e:
        logger.error(f"Error scraping page: {e}")


def main():
    parser = argparse.ArgumentParser(
        description='Pagal World Incremental Scraper',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Full load (delete language data + reload)
  python pagalworld_incremental_scraper.py --mode full --language hindi --pages 1 --sql-output sql_output --execute-sql
  
  # Incremental load (add new items only)
  python pagalworld_incremental_scraper.py --mode incremental --language hindi --pages 1 --sql-output sql_output --execute-sql
  
  # Single album page
  python pagalworld_incremental_scraper.py --mode single --url "https://pagalworldmusic.com/album/vdPUsmveOwE_/yodha" --sql-output sql_output --execute-sql
  
  # Single track page
  python pagalworld_incremental_scraper.py --mode single --url "https://pagalworldmusic.com/track/..." --sql-output sql_output --execute-sql
  
  # Single language listing page
  python pagalworld_incremental_scraper.py --mode single --url "https://pagalworldmusic.com/language/hindi/page/5" --sql-output sql_output --execute-sql
  
  # Full load multiple languages
  python pagalworld_incremental_scraper.py --mode full --languages "hindi,punjabi,tamil" --pages 1 --sql-output sql_output --execute-sql
        """
    )
    
    parser.add_argument('--mode', choices=['full', 'incremental', 'single'],
                       required=True, help='Scraping mode')
    parser.add_argument('--language', default='hindi',
                       help='Language to scrape (default: hindi)')
    parser.add_argument('--languages', help='Comma-separated languages')
    parser.add_argument('--pages', type=int, default=1,
                       help='Number of pages to scrape (default: 1)')
    parser.add_argument('--all-pages', action='store_true',
                       help='Scrape all available pages (ignores --pages argument)')
    parser.add_argument('--url', help='URL for single page mode (album, track, or language listing page)')
    parser.add_argument('--sql-output', type=Path, default=Path('sql_output'),
                       help='Output directory for SQL files')
    parser.add_argument('--execute-sql', action='store_true',
                       help='Execute generated SQL files')
    
    args = parser.parse_args()
    
    # Test connection
    if args.execute_sql:
        logger.info("Testing database connection...")
        if not test_connection():
            logger.error("Database connection failed!")
            sys.exit(1)
        logger.info("[OK] Database connection OK\n")
    
    # Run appropriate mode
    if args.mode == 'full':
        languages = args.languages.split(',') if args.languages else [args.language]
        for lang in languages:
            run_full_load(lang.strip(), args.pages, args.sql_output, args.execute_sql, all_pages=args.all_pages)
    
    elif args.mode == 'incremental':
        languages = args.languages.split(',') if args.languages else [args.language]
        for lang in languages:
            run_incremental_load(lang.strip(), args.pages, args.sql_output, args.execute_sql, all_pages=args.all_pages)
    
    elif args.mode == 'single':
        if not args.url:
            logger.error("--url required for single mode")
            sys.exit(1)
        run_single_page(args.url, args.sql_output, args.execute_sql)


if __name__ == '__main__':
    main()

