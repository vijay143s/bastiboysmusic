#!/usr/bin/env python3
"""
PagalNew Scraper
Scrapes pagalnew.com and saves data to SQL files.
Compatible with existing bastiboysmusic database schema.
"""

import os
import sys
import json
import logging
import argparse
import requests
import re
from bs4 import BeautifulSoup
from pathlib import Path
from datetime import datetime
from typing import Optional, Dict, List, Any, Set
from concurrent.futures import ThreadPoolExecutor, as_completed
from urllib.parse import urljoin, quote

# Import database utilities
try:
    from db_utils import (
        get_db_connection,
        execute_sql_files_batch,
        get_existing_album_titles,
        check_album_exists
    )
except ImportError as e:
    print(f"Error importing db_utils: {e}")
    sys.exit(1)

# Setup logging
LOG_DIR = Path('logs')
LOG_DIR.mkdir(exist_ok=True)

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(LOG_DIR / 'pagalnew_scraper.log', encoding='utf-8'),
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
BASE_URL = "https://pagalnew.com"

class PagalNewSQLDataCollector:
    """Collect and deduplicate scraper data for SQL generation"""
    
    def __init__(self):
        self.albums = {}  # {title: album_data}
        self.songs = []  # [{album_name, title, singer, ...}]
        self.singers: Set[str] = set()
        
        # Store artist/director associations: list of {name, album_title}
        self.artists_data = [] 
        self.music_directors_data = []
    
    def add_album(self, title: str, data: Dict[str, Any]):
        """Add or update album"""
        if not title:
            return False
            
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
            
            # Add music directors from album metadata
            md = data.get('music_director', '')
            if md:
                # Split by common separators if needed, but schema seems to allow full string or normalized rows.
                # Given schema has 'director_name' and 'album_id', it implies normalized, but many entries might be "A, B".
                # Let's try to split comma-separated names for better normalization if possible, 
                # or just insert the whole string if that's the convention.
                # "Shashwat Sachdev, Charanjit Ahuja" -> split
                directors = [d.strip() for d in re.split(r',|&', md) if d.strip()]
                for d_name in directors:
                    self.music_directors_data.append({'name': d_name, 'album_title': title})
            
            return True
        else:
            curr = self.albums[title]
            if not curr.get('year') and data.get('year'):
                curr['year'] = data['year']
            if not curr.get('music_director') and data.get('music_director'):
                curr['music_director'] = data['music_director']
        return False
    
    def add_song(self, album_name: str, song_data: Dict[str, Any]):
        """Add song"""
        # Get album thumbnail as fallback
        album_thumbnail = self.albums.get(album_name, {}).get('image_url')
        
        song = {
            'album_name': album_name,
            'title': song_data.get('title', ''),
            'singer': song_data.get('singer', ''),
            'artist': song_data.get('artist', ''),
            'image_url': song_data.get('image_url') or album_thumbnail,
            'audio_url': song_data.get('audio_url'),
            'duration': song_data.get('duration'),
            'lyrics': song_data.get('lyrics', ''),
            'language': self.albums.get(album_name, {}).get('language', 'hindi'),
            'created_at': datetime.now().isoformat()
        }
        self.songs.append(song)
        
        # Collect singers -> table `singers` (only singer_name)
        if song.get('singer'):
            for s in re.split(r',|&', song['singer']):
                self.singers.add(s.strip())
        
        # Collect artists -> table `artists` (artist_name, album_id)
        if song.get('artist'):
            for a in re.split(r',|&', song['artist']):
                a_name = a.strip()
                if a_name:
                    self.artists_data.append({'name': a_name, 'album_title': album_name})
        
        # Also add song-level composer to music_directors if present
        composer = song_data.get('music_composer')
        if composer:
             for c in re.split(r',|&', composer):
                 c_name = c.strip()
                 if c_name:
                     self.music_directors_data.append({'name': c_name, 'album_title': album_name})

    def _escape_sql(self, value: Any) -> str:
        """Escape SQL string"""
        if value is None:
            return 'NULL'
        if isinstance(value, bool):
            return '1' if value else '0'
        if isinstance(value, (int, float)):
            return str(value)
        escaped = str(value).replace("'", "''").replace('\\', '\\\\')
        return f"'{escaped}'"
    
    def _make_absolute_url(self, url: Optional[str]) -> Optional[str]:
        if not url: return None
        if url.startswith('http'): return url
        if url.startswith('/'): return f"{BASE_URL}{url}"
        return url

    def generate_sql_files(self, output_dir: Path):
        """Generate SQL INSERT files"""
        output_dir.mkdir(parents=True, exist_ok=True)
        
        self._generate_albums_sql(output_dir / 'albums.sql')
        self._generate_songs_sql(output_dir / 'songs.sql')
        self._generate_metadata_sql(output_dir / 'metadata.sql')
        
        logger.info(f"Generated SQL files in {output_dir}")
        logger.info(f"  Albums: {len(self.albums)}")
        logger.info(f"  Songs: {len(self.songs)}")

    def _generate_albums_sql(self, output_path: Path):
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- Albums INSERT statements\n\n")
            for title, data in self.albums.items():
                f.write("INSERT IGNORE INTO albums (title, language, description, thumbnail_url, year, director, music_director, star_cast, created_at, updated_at) VALUES (\n")
                f.write(f"    {self._escape_sql(data['title'])},\n")
                f.write(f"    {self._escape_sql(data['language'])},\n")
                f.write(f"    {self._escape_sql(data['description'][:500])},\n")
                f.write(f"    {self._escape_sql(self._make_absolute_url(data['image_url']))},\n")
                f.write(f"    {self._escape_sql(data['year'])},\n")
                f.write(f"    {self._escape_sql(data['director'])},\n")
                f.write(f"    {self._escape_sql(data['music_director'])},\n")
                f.write(f"    {self._escape_sql(data['star_cast'])},\n")
                f.write("    NOW(), NOW());\n")

    def _generate_songs_sql(self, output_path: Path):
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- Songs INSERT statements\n\n")
            for song in self.songs:
                audio = self._make_absolute_url(song['audio_url'])
                # Mapping lyrics to description field
                description = song.get('lyrics', '')
                f.write("INSERT IGNORE INTO songs (album_id, title, singer, description, language, thumbnail_url, audio_url, created_at, updated_at) VALUES (\n")
                f.write(f"    (SELECT id FROM albums WHERE title = {self._escape_sql(song['album_name'])} LIMIT 1),\n")
                f.write(f"    {self._escape_sql(song['title'])},\n")
                f.write(f"    {self._escape_sql(song['singer'])},\n")
                f.write(f"    {self._escape_sql(description)},\n")
                f.write(f"    {self._escape_sql(song['language'])},\n")
                f.write(f"    {self._escape_sql(self._make_absolute_url(song['image_url']))},\n")
                f.write(f"    {self._escape_sql(audio)},\n")
                f.write("    NOW(), NOW());\n")

    def print_debug_info(self):
        """Print collected data for verification"""
        print("\n" + "="*80)
        print("DEBUG: COLLECTED DATA REVIEW")
        print("="*80)
        
        print(f"\n--- ALBUMS ({len(self.albums)}) ---")
        for title, data in self.albums.items():
            print(json.dumps(data, indent=2, default=str))

        print(f"\n--- SONGS ({len(self.songs)}) ---")
        for song in self.songs:
            print(json.dumps(song, indent=2, default=str))

        print(f"\n--- SINGERS ({len(self.singers)}) ---")
        print(list(self.singers))

        print(f"\n--- ARTISTS ({len(self.artists_data)}) ---")
        for item in self.artists_data:
            print(f"Name: {item['name']} | Album: {item['album_title']}")

        print(f"\n--- MUSIC DIRECTORS ({len(self.music_directors_data)}) ---")
        for item in self.music_directors_data:
            print(f"Name: {item['name']} | Album: {item['album_title']}")
        
        print("="*80 + "\n")

    def _generate_metadata_sql(self, output_path: Path):
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- Metadata INSERT statements\n\n")
            
            # Singers (simple list)
            for s in self.singers:
                if s:
                    f.write(f"INSERT IGNORE INTO singers (singer_name) VALUES ({self._escape_sql(s)});\n")
            
            # Artists (linked to albums)
            # Table: artist_id, artist_name, album_id, album_name, ...
            seen_artists = set()
            for item in self.artists_data:
                key = (item['name'], item['album_title'])
                if key not in seen_artists:
                    seen_artists.add(key)
                    f.write("INSERT IGNORE INTO artists (artist_name, album_name, album_id, created_at, updated_at) VALUES (\n")
                    f.write(f"    {self._escape_sql(item['name'])},\n")
                    f.write(f"    {self._escape_sql(item['album_title'])},\n")
                    f.write(f"    (SELECT id FROM albums WHERE title = {self._escape_sql(item['album_title'])} LIMIT 1),\n")
                    f.write("    NOW(), NOW());\n")

    def _generate_music_directors_sql(self, output_path: Path):
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- Music Directors INSERT statements\n\n")
            seen_directors = set()
            for item in self.music_directors_data:
                key = (item['name'], item['album_title'])
                if key not in seen_directors:
                    seen_directors.add(key)
                    f.write("INSERT IGNORE INTO music_directors (director_name, album_name, album_id, created_at, updated_at) VALUES (\n")
                    f.write(f"    {self._escape_sql(item['name'])},\n")
                    f.write(f"    {self._escape_sql(item['album_title'])},\n")
                    f.write(f"    (SELECT id FROM albums WHERE title = {self._escape_sql(item['album_title'])} LIMIT 1),\n")
                    f.write("    NOW(), NOW());\n")

class PagalNewScraper:
    def __init__(self):
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
        })
    
    def scrape_category(self, url: str, max_pages: Optional[int] = None) -> List[Dict]:
        """Scrape a category page for album links with pagination"""
        all_albums = []
        current_page = 1
        current_url = url
        
        # Base category URL without page number
        # e.g. https://pagalnew.com/category/bollywood-mp3-songs
        # If input is .../bollywood-mp3-songs/1, strip it?
        # Actually, let's just rely on the next page links found in HTML
        
        while True:
            logger.info(f"Scraping category page {current_page}: {current_url}")
            try:
                resp = self.session.get(current_url)
                resp.raise_for_status()
                soup = BeautifulSoup(resp.content, 'html.parser')
                
                # Extract albums from current page
                page_albums = []
                links = soup.find_all('a', href=True)
                for link in links:
                    href = link['href']
                    if '/album/' in href and not href.endswith('.zip'): 
                        title = link.get_text(strip=True)
                        if not title: continue
                        
                        page_albums.append({
                            'url': urljoin(BASE_URL, href),
                            'title': title
                        })
                
                # De-duplicate current page albums
                seen = set()
                unique_page_albums = []
                for a in page_albums:
                    if a['url'] not in seen:
                        seen.add(a['url'])
                        unique_page_albums.append(a)
                
                if not unique_page_albums:
                    logger.info("No albums found on this page. Stopping.")
                    break
                    
                all_albums.extend(unique_page_albums)
                logger.info(f"  Found {len(unique_page_albums)} albums on page {current_page}")
                
                # Check for stop condition
                if max_pages and current_page >= max_pages:
                    logger.info(f"Reached max pages ({max_pages}). Stopping.")
                    break
                
                # Find next page link
                # The pagination HTML: <div class="pagination">... <a class='currentactive'>1</a> <a href='.../2'>2 </a> ... </div>
                # We need to find the link for 'current_page + 1'
                
                next_page_num = current_page + 1
                next_page_link = None
                
                pagination_div = soup.find('div', class_='pagination')
                if pagination_div:
                    # Look for a link exactly matching the next page number
                    # Text might be "2 " or "2"
                    for a in pagination_div.find_all('a', href=True):
                        # Clean text to just numbers
                        try:
                            txt = a.get_text(strip=True)
                            if txt.isdigit() and int(txt) == next_page_num:
                                next_page_link = a['href']
                                break
                        except ValueError:
                            continue
                            
                    # If not found by number, check for '>>' or 'Next' if we want to be robust,
                    # but the output shows numbers are explicit.
                
                if next_page_link:
                    current_url = urljoin(BASE_URL, next_page_link)
                    current_page += 1
                else:
                    logger.info("No next page link found. Stopping.")
                    break

            except Exception as e:
                logger.error(f"Error scraping page {current_page}: {e}")
                break
        
        # Global de-duplication
        seen = set()
        final_albums = []
        for a in all_albums:
            if a['url'] not in seen:
                seen.add(a['url'])
                final_albums.append(a)
                
        logger.info(f"Total unique albums found across {current_page} pages: {len(final_albums)}")
        return final_albums

    def fetch_album_details(self, album_url: str) -> Dict[str, Any]:
        """Scrape album page to get metadata and list of song page URLs"""
        try:
            resp = self.session.get(album_url)
            resp.raise_for_status()
            soup = BeautifulSoup(resp.content, 'html.parser')
            
            details = {
                'title': '',
                'song_page_urls': [], 
                'image_url': None,
                'music_director': '',
                'director': '', # Added field
                'star_cast': '', # Added field
                'year': None,
                'language': 'hindi', # Default
                'description': ''
            }
            
            # 1. Title
            # <h1 class="col-lg-12 ... main_page_category_div up">Title...</h1>
            h1 = soup.find('h1', class_='main_page_category_div')
            if h1:
                details['title'] = h1.get_text(strip=True).replace(' Mp3 Songs Download Pagalnew', '').replace(' Mp3 Songs', '').strip()
            
            if not details['title']:
                # Fallback to h2 or URL slug
                h2 = soup.find('h2')
                if h2:
                    details['title'] = h2.get_text(strip=True).replace(' Mp3 Songs', '').strip()
                else:
                    slug = album_url.split('/')[-1].split('.')[0].replace('-', ' ')
                    details['title'] = slug.title()

            # 2. Image
            # Look for img with class b-lazy or album-image
            img = soup.find('img', class_='b-lazy')
            if not img:
                 div = soup.find('div', class_='album-image')
                 if div: img = div.find('img')
            
            if img:
                details['image_url'] = img.get('data-src') or img.get('src')
            
            # Additional fallback to main_page_middle if not found
            if not details['image_url']:
                 middle = soup.find('div', id='main_page_middle')
                 if middle:
                     img_tag = middle.find('img')
                     if img_tag:
                         details['image_url'] = img_tag.get('data-src') or img_tag.get('src')


            if not details['image_url']:
                og_img = soup.find('meta', property='og:image')
                if og_img:
                    details['image_url'] = og_img['content']

            # Make image absolute
            if details['image_url'] and not details['image_url'].startswith('http'):
                 details['image_url'] = urljoin(BASE_URL, details['image_url'])

            # 3. Metadata (Year, Artists, Starcast, Composed by)
            # The HTML shows strict structure: <b> Label: </b> Value <hr...>
            # We can iterate over <b> tags in main_page_middle
            middle = soup.find('div', id='main_page_middle')
            if middle:
                for b in middle.find_all('b'):
                    label = b.get_text(strip=True).lower()
                    # Value is the text node immediately following the <b> tag
                    # sometimes separated by spaces or newlines
                    value = b.next_sibling
                    if value:
                        value_str = str(value).strip()
                        
                        if 'year' in label:
                            try:
                                details['year'] = int(re.search(r'\d{4}', value_str).group())
                            except:
                                pass
                        elif 'composed by' in label or 'music' in label:
                            details['music_director'] = value_str.strip('- ').strip()
                        elif 'starcast' in label:
                            details['star_cast'] = value_str.strip('- ').strip()
                        elif 'artists' in label:
                            # Could store as description or extra field
                            details['description'] = f"Artists: {value_str.strip('- ').strip()}"

            # Fallback for year from title
            if not details['year']:
                year_match = re.search(r'\((\d{4})\)', details['title']) or re.search(r'20\d{2}', details['title'])
                if year_match:
                    details['year'] = int(year_match.group(1) if len(year_match.groups()) > 0 else year_match.group())
                else:
                    details['year'] = datetime.now().year

            # 4. Song Page URLs
            song_divs = soup.find_all('div', class_='main_page_category_music')
            
            for div in song_divs:
                # Get link
                link = div.find_parent('a') or div.find('a', href=True)
                if link and link.get('href'):
                    href = link.get('href')
                    if '/songs/' in href or '/song/' in href:
                        abs_url = urljoin(BASE_URL, href)
                        details['song_page_urls'].append(abs_url)
            
            details['song_page_urls'] = list(set(details['song_page_urls']))

            return details
            
        except Exception as e:
            logger.error(f"Error scraping album {album_url}: {e}")
            return None

    def fetch_song_details(self, song_url: str) -> Dict[str, Any]:
        """Scrape song page to get audio URL and metadata"""
        try:
            resp = self.session.get(song_url)
            resp.raise_for_status()
            soup = BeautifulSoup(resp.content, 'html.parser')
            
            song_data = {
                'title': 'Unknown Song',
                'audio_url': None,
                'image_url': None,
                'singer': '',
                'artist': '',
                'music_composer': '',
                'star_cast': '',
                'lyrics': ''
            }
            
            # Title
            h1 = soup.find('h1', class_='main_page_category_div') or soup.find('h2', class_='main_page_category_div')
            if h1:
                raw_title = h1.get_text(strip=True).replace(' Mp3 Song Download', '').strip()
                # User request: split with - and strip
                if '-' in raw_title:
                    raw_title = raw_title.split('-')[0].strip()
                
                # Cleanup " Song" suffix if present (e.g. "Phurr Song")
                # Checking if it ends with " Song" case insensitive
                if raw_title.lower().endswith(' song'):
                    raw_title = raw_title[:-5].strip()
                    
                song_data['title'] = raw_title
            
            # Audio URL
            # ... (existing logic) ...
            links = soup.find_all('a', href=True)
            candidate_urls = []
            for link in links:
                href = link['href']
                text = link.get_text(strip=True).lower()
                if 'download' in href or '.mp3' in href:
                    candidate_urls.append(urljoin(BASE_URL, href))
            
            # Prioritize 320
            for url in candidate_urls:
                if '320' in url:
                    song_data['audio_url'] = url
                    break
            
            if not song_data['audio_url'] and candidate_urls:
                song_data['audio_url'] = candidate_urls[0]

            # Metadata from description paragraph
            # Format: "Download X Mp3 audio in 320Kbps from Y, Sung by A, Composed by B, Starring C, Lyrics penned by D"
            p = soup.find('p', align='center')
            if p:
                text = p.get_text(strip=True)
                
                # Extract Singer
                match_singer = re.search(r'Sung by\s+(.*?)(?:Composed by|Starring|Lyrics penned by|$)', text, re.IGNORECASE)
                if match_singer:
                    song_data['singer'] = match_singer.group(1).split(',')[0].strip().rstrip(',')  # First singer as main
                    song_data['artist'] = match_singer.group(1).strip().rstrip(',') # All singers
                
                # Extract Composer
                match_composer = re.search(r'Composed by\s+(.*?)(?:Starring|Lyrics penned by|$)', text, re.IGNORECASE)
                if match_composer:
                    song_data['music_composer'] = match_composer.group(1).strip().rstrip(',')

                # Extract Star Cast
                match_star = re.search(r'Starring\s+(.*?)(?:Lyrics penned by|$)', text, re.IGNORECASE)
                if match_star:
                    song_data['star_cast'] = match_star.group(1).strip().rstrip(',')
                    
                # Extract Lyrics
                match_lyrics = re.search(r'Lyrics penned by\s+(.*?)$', text, re.IGNORECASE)
                if match_lyrics:
                    song_data['lyrics'] = match_lyrics.group(1).strip().rstrip(',')

            return song_data
            
        except Exception as e:
            logger.error(f"Error scraping song {song_url}: {e}")
            return None

def run_scraper(url: str, mode: str, sql_output: Path, execute_sql: bool, max_pages: Optional[int] = None):
    scraper = PagalNewScraper()
    collector = PagalNewSQLDataCollector()
    
    albums_to_process = []
    
    if mode == 'single' and '/category/' in url:
        albums_to_process = scraper.scrape_category(url, max_pages=max_pages)
    elif mode == 'single' and '/album/' in url:
        albums_to_process = [{'url': url, 'title': 'Unknown'}]
    else:
        logger.error(f"Unsupported URL or mode: {url} ({mode})")
        return
    
    # ... (rest of function remains structurally same, just re-indent if needed, but here we just need to pass the list)

    logger.info(f"Processing {len(albums_to_process)} albums...")
    
    # Process albums
    with ThreadPoolExecutor(max_workers=DEFAULT_WORKERS) as executor:
        # 1. Fetch Album Details
        future_to_album = {
            executor.submit(scraper.fetch_album_details, a['url']): a 
            for a in albums_to_process
        }
        
        for future in as_completed(future_to_album):
            a_data = future_to_album[future]
            try:
                album_details = future.result()
                if album_details:
                    collector.add_album(album_details['title'], album_details)
                    
                    song_urls = album_details.get('song_page_urls', [])
                    logger.info(f"  Album '{album_details['title']}' has {len(song_urls)} songs. Fetching...")
                    
                    # Log full details for verification
                    logger.info(f"Details for {album_details['title']}:\n{json.dumps(album_details, indent=2, default=str)}")

                    # 2. Fetch Songs for this album
                    for s_url in song_urls:
                        s_details = scraper.fetch_song_details(s_url)
                        if s_details and s_details['audio_url']:
                             # Use album image if song image missing
                             if not s_details.get('image_url'):
                                 s_details['image_url'] = album_details.get('image_url')
                             
                             logger.info(f"  > Fetched Song: {s_details['title']}\n{json.dumps(s_details, indent=4, default=str)}")
                             
                             collector.add_song(album_details['title'], s_details)
                    
                    logger.info(f"  Parsed {album_details['title']} complete.")
            
            except Exception as e:
                logger.error(f"Failed to process album {a_data['url']}: {e}")

    # Debug Printing
    collector.print_debug_info()

    # Output SQL
    collector.generate_sql_files(sql_output)
    
    # Execute SQL
    if execute_sql:
        logger.info("Executing SQL...")
        files = [
            sql_output / 'metadata.sql',
            sql_output / 'albums.sql',
            sql_output / 'songs.sql'
        ]
        res = execute_sql_files_batch([f for f in files if f.exists()])
        logger.info(f"DB Update Result: {res}")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='PagalNew Scraper')
    parser.add_argument('--mode', choices=['single', 'full'], required=True)
    parser.add_argument('--url', help='URL to scrape (for single mode)')
    parser.add_argument('--sql-output', type=Path, default=Path('sql_pagalnew'))
    parser.add_argument('--execute-sql', action='store_true')
    parser.add_argument('--max-pages', type=int, default=None, help='Max pages to scrape for category (default: all)')
    
    args = parser.parse_args()
    
    if args.mode == 'single' and not args.url:
        print("Error: --url is required for single mode")
        sys.exit(1)
        
    run_scraper(args.url, args.mode, args.sql_output, args.execute_sql, args.max_pages)
