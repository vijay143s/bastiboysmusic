#!/usr/bin/env python3
"""
Pagal World Incremental Scraper with Full Modes
Supports: Full Load, Incremental Load, Single Page, and Language-wise Scraping

Usage:
    # Full load (DELETE language data then reload)
    python pagalworld_incremental_scraper.py --mode full --language hindi --pages 1 --sql-output sql_output --execute-sql

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
        get_existing_album_titles
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
    """Create requests session with retry logic"""
    session = requests.Session()
    session.headers.update({
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
    })
    return session


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
                details['title'] = album_info['title']  # Use scraped title
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
    
    def __init__(self, incremental_mode: bool = False):
        self.albums = {}  # {title: album_data}
        self.songs = []  # [{album_name, title, singer, ...}]
        self.singers: Set[str] = set()
        self.artists: Set[str] = set()
        self.music_directors: Set[str] = set()
        self.incremental_mode = incremental_mode
    
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
        """Add song"""
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
        """Escape SQL string"""
        if value is None:
            return 'NULL'
        if isinstance(value, bool):
            return '1' if value else '0'
        if isinstance(value, (int, float)):
            return str(value)
        escaped = str(value).replace("'", "''")
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
    
    def scrape_language_page(self, language: str, pages: int = 1, all_pages: bool = False) -> List[Dict[str, Any]]:
        """Scrape language page for albums and songs"""
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
                        title_div = track_box.find('div', class_='track-title')
                        title = title_div.get_text(strip=True) if title_div else 'Unknown'
                        
                        img = track_box.find('img')
                        image_url = img.get('data-src', '') if img else None
                        
                        item_type = 'album' if 'album' in href.lower() else 'song'
                        
                        all_items.append({
                            'type': item_type,
                            'title': title,
                            'url': urljoin(BASE_URL, href),
                            'image_url': image_url,
                            'language': language
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
                'songs': []
            }
            
            # Get title
            title_div = soup.find('h1', class_='entry-title')
            if title_div:
                details['title'] = title_div.get_text(strip=True)
            
            # Get image
            img = soup.find('img', class_='track-image')
            if img and img.get('data-src'):
                details['image_url'] = img.get('data-src')
            
            # Pagal World doesn't store year, director, etc. at album level
            # These fields are typically empty on the site
            # Just extract songs which are the main content
            
            # Find all songs in album
            track_divs = soup.find_all('div', class_='track')
            for track_div in track_divs:
                song_link = track_div.find('a', href=True)
                if song_link and 'track' in song_link.get('href', ''):
                    title_div = track_div.find('div', class_='track-title')
                    song_title = title_div.get_text(strip=True) if title_div else 'Unknown'
                    
                    details['songs'].append({
                        'title': song_title,
                        'url': urljoin(BASE_URL, song_link.get('href', ''))
                    })
            
            import time
            time.sleep(0.5)
            return details
        
        except Exception as e:
            logger.error(f"Error fetching album {album_url}: {e}")
            return {'title': '', 'songs': []}
    
    def fetch_song_details(self, song_url: str) -> Dict[str, Any]:
        """Fetch full song details from song page"""
        try:
            response = self.session.get(song_url, timeout=self.timeout)
            response.raise_for_status()
            soup = BeautifulSoup(response.content, 'html.parser')
            
            details = {
                'title': '',
                'singer': '',
                'image_url': None,
                'audio_url': None
            }
            
            # Get title
            title_div = soup.find('h1')
            if title_div:
                details['title'] = title_div.get_text(strip=True)
            
            # Get image
            img = soup.find('img', class_='track-image')
            if img and img.get('data-src'):
                details['image_url'] = img.get('data-src')
            
            # Get audio URL
            audio_links = soup.find_all('a', href=lambda x: x and '/download.php' in x)
            if audio_links:
                audio_url = audio_links[0].get('href', '')
                if audio_url.startswith('/'):
                    details['audio_url'] = urljoin(BASE_URL, audio_url)
                else:
                    details['audio_url'] = audio_url
            
            import time
            time.sleep(0.5)
            return details
        
        except Exception as e:
            logger.error(f"Error fetching song {song_url}: {e}")
            return {}


def run_full_load(language: str, pages: int, sql_output: Path, execute_sql: bool, all_pages: bool = False):
    """Run full load for language (DELETE only this language's data, then reload)"""
    logger.info("="*70)
    logger.info(f"[FULL LOAD] {language.upper()}")
    logger.info(f"   [DELETE] Will DELETE all {language.upper()} data before reloading")
    if all_pages:
        logger.info(f"   [PAGES] Scraping ALL pages (pagination)")
    else:
        logger.info(f"   [PAGES] Scraping {pages} page(s)")
    logger.info("="*70)
    
    scraper = PagalWorldIncrementalScraper()
    collector = PagalWorldSQLDataCollector()
    
    # Scrape language pages
    logger.info(f"\n[SCRAPING] {language} ({'all pages' if all_pages else f'{pages} pages'})...")
    items = scraper.scrape_language_page(language, pages, all_pages=all_pages)
    logger.info(f"Found {len(items)} items total\n")
    
    # Process albums
    albums = [i for i in items if i['type'] == 'album']
    logger.info(f"📀 Processing {len(albums)} albums...")
    
    # Fetch all album details in parallel
    album_details_list = fetch_album_details_parallel(scraper, albums, workers=DEFAULT_WORKERS)
    
    # Collect all songs for parallel fetching
    all_songs_to_fetch = []
    for i, album_detail in enumerate(album_details_list):
        album = albums[i]
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
    
    # Generate SQL with DELETE statements for this language
    logger.info(f"\n📊 Generating SQL with DELETE for {language}...")
    collector.generate_sql_files_with_delete(sql_output, language)
    
    # Execute SQL if requested
    if execute_sql:
        logger.info(f"\n💾 Executing SQL...")
        # Get all SQL files in the output directory
        sql_files = sorted([
            sql_output / '00_delete_language.sql',
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
    logger.info("[OK] FULL LOAD COMPLETE")
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
    
    scraper = PagalWorldIncrementalScraper()
    collector = PagalWorldSQLDataCollector(incremental_mode=True)
    
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
    """Run scraping for single page"""
    logger.info("="*70)
    logger.info(f"🔍 SINGLE PAGE SCRAPING")
    logger.info(f"URL: {url}")
    logger.info("="*70)
    
    scraper = PagalWorldIncrementalScraper()
    collector = PagalWorldSQLDataCollector()
    
    try:
        response = scraper.session.get(url, timeout=scraper.timeout)
        response.raise_for_status()
        soup = BeautifulSoup(response.content, 'html.parser')
        
        # Detect if it's album or song page
        if '/album/' in url:
            logger.info("📀 Detected: Album page")
            album_title = soup.find('h1')
            if album_title:
                album_title = album_title.get_text(strip=True)
            else:
                album_title = "Unknown Album"
            
            album_details = scraper.fetch_album_details(url)
            collector.add_album(album_title, {
                'language': 'hindi',  # Default
                'description': album_details.get('description', ''),
                'image_url': album_details.get('image_url'),
                'year': album_details.get('year')
            })
            
            # Fetch all songs in parallel
            songs_to_fetch = [{
                'url': song['url'],
                'album_title': album_title,
                'song_title': song['title']
            } for song in album_details.get('songs', [])]
            
            if songs_to_fetch:
                song_details_list = fetch_song_details_parallel(scraper, songs_to_fetch, workers=DEFAULT_WORKERS)
                
                for i, song_detail in enumerate(song_details_list):
                    song_info = songs_to_fetch[i]
                    collector.add_song(song_info['album_title'], {
                        'title': song_detail.get('title', song_info['song_title']),
                        'singer': song_detail.get('singer', ''),
                        'image_url': song_detail.get('image_url'),
                        'audio_url': song_detail.get('audio_url')
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
                'image_url': song_details.get('image_url'),
                'audio_url': song_details.get('audio_url')
            })
        
        else:
            logger.error("Could not detect page type (album or track)")
            return
        
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
  
  # Single page
  python pagalworld_incremental_scraper.py --mode single --url "https://pagalworldmusic.com/album/..." --sql-output sql_output --execute-sql
  
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
    parser.add_argument('--url', help='URL for single page mode')
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

