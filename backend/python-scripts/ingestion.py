#!/usr/bin/env python3
"""
Unified Album & Song Ingestion Script
Combines article scraping, song extraction, data cleanup, and database insertion.

Usage:
    # Full load (truncate and reload all data)
    python ingestion.py --mode full --sql-output sql_output --execute-sql --truncate

    # Incremental load (only new articles)
    python ingestion.py --mode incremental --sql-output sql_output --execute-sql

    # Scrape specific tags
    python ingestion.py --mode full --tags "1,a,b,c" --sql-output sql_output --execute-sql

    # Dry run (generate SQL but don't execute)
    python ingestion.py --mode full --sql-output sql_output
"""

from __future__ import annotations

import argparse
import csv
import json
import os
import re
import sys
import logging
import difflib
from datetime import datetime
from pathlib import Path
from typing import Any, Optional, Dict, List
from concurrent.futures import ThreadPoolExecutor, as_completed

import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry
from bs4 import BeautifulSoup
import gzip
import zlib

try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass

from db_utils import (
    get_db_connection,
    execute_sql_files_with_truncate,
    get_table_row_count,
    test_connection
)

# Constants
DEFAULT_URL = "https://sensongsmp3.live/telugump3s21/"
DEFAULT_TIMEOUT = int(os.getenv('DEFAULT_TIMEOUT', 30))
DEFAULT_WORKERS = int(os.getenv('WORKERS', 5))
DEFAULT_BATCH_SIZE = int(os.getenv('BATCH_SIZE', 10))
DEFAULT_ACCEPT_ENCODING = "identity"

# Artist Normalization Map
ARTIST_NORMALIZATION_MAP = {
    "a.r.rahman": "A. R. Rahman",
    "a r rahman": "A. R. Rahman",
    "ar rahman": "A. R. Rahman",
    "anup rubens": "Anup Rubens",
    "nup rubense": "Anup Rubens",
    "anup rubense": "Anup Rubens",
    "devi sri prasad": "Devi Sri Prasad",
    "dsp": "Devi Sri Prasad",
    "s.s. thaman": "S. Thaman",
    "ss thaman": "S. Thaman",
    "thaman s": "S. Thaman",
    "manisharma": "Mani Sharma",
    "mani sharma": "Mani Sharma",
    "m.m. keeravani": "M. M. Keeravani",
    "mm starts": "M. M. Keeravani",
    "m m keeravani": "M. M. Keeravani",
}

# Setup logging
LOG_LEVEL = os.getenv('LOG_LEVEL', 'INFO')
LOG_FILE = os.getenv('LOG_FILE', 'logs/ingestion.log')

os.makedirs('logs', exist_ok=True)

# Configure handlers with UTF-8 encoding to support Unicode characters
file_handler = logging.FileHandler(LOG_FILE, encoding='utf-8')
stream_handler = logging.StreamHandler(sys.stderr)

# Try to set UTF-8 encoding for console on Windows
try:
    import codecs
    sys.stderr = codecs.getwriter('utf-8')(sys.stderr.buffer, errors='replace')
except Exception:
    # If UTF-8 setup fails, continue with ASCII-safe logging
    pass

logging.basicConfig(
    level=getattr(logging, LOG_LEVEL),
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[file_handler, stream_handler]
)
logger = logging.getLogger(__name__)


# ============================================================================
# DATA CLEANUP FUNCTIONS
# ============================================================================

def clean_string(value: str) -> str:
    """Remove unwanted characters like leading/trailing dashes and extra spaces."""
    if not value:
        return ''
    
    # Remove leading/trailing dashes and spaces
    cleaned = value.strip().strip('-').strip()
    
    
    return cleaned


    return cleaned


def get_existing_names_from_db() -> set:
    """Fetch all existing artist/singer/director names from the database for dynamic matching."""
    names = set()
    try:
        from db_utils import get_db_connection
        # We need to handle ImportError if db_utils isn't available (e.g. running in isolation)
    except ImportError:
        logger.warning("Could not import get_db_connection. Dynamic normalization disabled.")
        return names

    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            
            # Fetch from multiple tables
            queries = [
                "SELECT DISTINCT singer_name FROM singers",
                "SELECT DISTINCT artist_name FROM artists",
                "SELECT DISTINCT director_name FROM music_directors"
            ]
            
            for q in queries:
                try:
                    cursor.execute(q)
                    results = cursor.fetchall()
                    for row in results:
                        if row[0]:
                            names.add(row[0])
                except Exception as e:
                    logger.warning(f"Error fetching existing names with query '{q}': {e}")
                    
            cursor.close()
            logger.info(f"Loaded {len(names)} unique names from database for dynamic normalization.")
            return names
    except Exception as e:
        logger.error(f"Error connecting to DB for existing names: {e}")
        return names


def normalize_name(name: str, known_names: set = None) -> str:
    """
    Normalize artist/director names using:
    1. Static map (primary)
    2. Dynamic fuzzy matching against known_names (secondary)
    """
    if not name:
        return ''
    
    cleaned = clean_string(name)
    lower_name = cleaned.lower()
    
    # 1. Static Mapping
    if lower_name in ARTIST_NORMALIZATION_MAP:
        return ARTIST_NORMALIZATION_MAP[lower_name]
    
    # 2. Dynamic Fuzzy Matching
    if known_names:
        # If exact match exists, return it (handles case sensitivity)
        # We need to check case-insensitive match against known_names
        # But known_names is a set of original strings. 
        # Let's verify if 'cleaned' is already in known_names perfectly
        if cleaned in known_names:
            return cleaned
            
        # Fuzzy match
        # cutoff=0.9 requires very high similarity (e.g. "Anup Rubens" vs "nup Rubens" is > 0.9)
        matches = difflib.get_close_matches(cleaned, known_names, n=1, cutoff=0.9)
        if matches:
            logger.info(f"Dynamic Normalization: '{cleaned}' -> '{matches[0]}'")
            return matches[0]
        
    return cleaned


def clean_year(year_str: str) -> Optional[int]:
    """Extract and clean year from string."""
    if not year_str:
        return None
    
    # Extract first 4-digit year
    year_match = re.search(r'\b(\d{4})\b', year_str)
    if year_match:
        try:
            year = int(year_match.group(1))
            # Validate year range
            if 1900 <= year <= 2100:
                return year
        except ValueError:
            pass
    
    return None


def split_names(names_str: str, known_names: set = None) -> List[str]:
    """Split comma-separated names and clean each."""
    if not names_str:
        return []
    
    # Split by comma and clean each name
    names = [normalize_name(name, known_names) for name in names_str.split(',')]
    
    # Filter out empty names
    return [name for name in names if name]


# ============================================================================
# HTTP & SCRAPING FUNCTIONS
# ============================================================================

def create_session() -> requests.Session:
    """Create a requests session with connection pooling and retry logic."""
    session = requests.Session()
    
    # Configure retry strategy
    retry_strategy = Retry(
        total=3,
        backoff_factor=0.5,
        status_forcelist=[429, 500, 502, 503, 504],
        allowed_methods=["HEAD", "GET", "OPTIONS"]
    )
    
    # Mount adapter with connection pooling
    adapter = HTTPAdapter(
        max_retries=retry_strategy,
        pool_connections=20,
        pool_maxsize=20,
        pool_block=False
    )
    session.mount("http://", adapter)
    session.mount("https://", adapter)
    
    return session


def build_headers(target_url: str, accept_encoding: str) -> dict[str, str]:
    """Generate desktop-browser like headers."""
    from urllib.parse import urlparse
    
    parsed = urlparse(target_url)
    origin = f"{parsed.scheme}://{parsed.netloc}"
    return {
        "User-Agent": (
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
            "AppleWebKit/537.36 (KHTML, like Gecko) "
            "Chrome/130.0.0.0 Safari/537.36"
        ),
        "Accept": "text/html,application/json;q=0.9,*/*;q=0.8",
        "Accept-Language": "en-US,en;q=0.9",
        "Accept-Encoding": accept_encoding or DEFAULT_ACCEPT_ENCODING,
        "Connection": "keep-alive",
        "Referer": origin,
        "Origin": origin,
        "Cache-Control": "no-cache",
        "Pragma": "no-cache",
    }


def _maybe_decompress(resp: requests.Response) -> bytes | None:
    """Decompress response body if needed."""
    encoding = resp.headers.get("Content-Encoding", "").lower()
    body = resp.content
    if not body:
        return body
    if "br" in encoding:
        try:
            import brotlicffi as brotli
        except ImportError:
            try:
                import brotli
            except ImportError:
                return None
        try:
            return brotli.decompress(body)
        except Exception:
            return None
    if "gzip" in encoding:
        try:
            return gzip.decompress(body)
        except Exception:
            return None
    if "deflate" in encoding:
        try:
            return zlib.decompress(body)
        except Exception:
            return None
    return body


def get_page_numbers(soup: BeautifulSoup) -> list[int]:
    """Extract all page numbers from pagination."""
    page_numbers = []
    page_links = soup.find_all('a', class_='page-numbers')
    
    for link in page_links:
        href = link.get('href', '')
        if 'page/' in href:
            try:
                page_num = int(href.split('page/')[-1].rstrip('/'))
                page_numbers.append(page_num)
            except (ValueError, IndexError):
                continue
    
    return sorted(set(page_numbers))


def extract_articles_from_page(soup: BeautifulSoup) -> list[dict[str, str]]:
    """Extract all articles with href and image src from content-thumbnail elements."""
    articles = []
    thumbnails = soup.find_all('div', class_='content-thumbnail')
    
    for thumbnail in thumbnails:
        link = thumbnail.find('a', href=True)
        img = thumbnail.find('img')
        
        if link and img:
            href = link.get('href', '')
            img_src = img.get('src', '')
            
            if href and img_src:
                articles.append({
                    'href': href,
                    'image_src': img_src,
                    'title': link.get('title', '')
                })
    
    return articles


def scrape_tag_page(tag_name: str, page: int = 1, timeout: int = DEFAULT_TIMEOUT, session: requests.Session = None) -> tuple[list[dict], list[int]]:
    """Scrape a single tag page and return articles and available page numbers."""
    url = f"https://sensongsmp3.live/tag/{tag_name}/page/{page}/" if page > 1 else f"https://sensongsmp3.live/tag/{tag_name}/"
    
    headers = build_headers(url, DEFAULT_ACCEPT_ENCODING)
    
    # Use provided session or create new one
    if session is None:
        session = requests
    
    try:
        resp = session.get(url, headers=headers, timeout=timeout)
        resp.raise_for_status()
        
        decoded = _maybe_decompress(resp)
        if decoded is None:
            return [], []
        
        html_text = decoded.decode(resp.encoding or "utf-8", errors="replace")
        soup = BeautifulSoup(html_text, "html.parser")
        
        articles = extract_articles_from_page(soup)
        page_numbers = get_page_numbers(soup)
        
        return articles, page_numbers
    
    except Exception as e:
        logger.error(f"Error scraping {url}: {e}")
        return [], []


def scrape_all_tag_pages(tag_name: str, timeout: int = DEFAULT_TIMEOUT) -> list[dict]:
    """Scrape all pages for a given tag and return all articles."""
    all_articles = []
    page_numbers = [1]
    current_page = 1
    visited_pages = set()
    
    # Create session for this tag to reuse connections
    session = create_session()
    
    while current_page not in visited_pages:
        visited_pages.add(current_page)
        logger.info(f"Scraping tag '{tag_name}' page {current_page}...")
        
        articles, available_pages = scrape_tag_page(tag_name, current_page, timeout, session)
        all_articles.extend(articles)
        
        if not available_pages:
            break
        
        next_pages = [p for p in available_pages if p not in visited_pages and p > current_page]
        if next_pages:
            current_page = min(next_pages)
        else:
            break
    
    return all_articles


def scrape_all_tag_pages_parallel(tags: list[str], timeout: int = DEFAULT_TIMEOUT, workers: int = DEFAULT_WORKERS) -> list[dict]:
    """Scrape multiple tags in parallel with optimized resource usage."""
    all_articles = []
    completed = 0
    total = len(tags)
    
    # Use more workers for better parallelism
    actual_workers = min(workers * 2, total, 20)  # Cap at 20 to avoid overwhelming
    
    logger.info(f"Scraping {total} tags with {actual_workers} parallel workers...")
    
    with ThreadPoolExecutor(max_workers=actual_workers) as executor:
        future_to_tag = {executor.submit(scrape_all_tag_pages, tag, timeout): tag for tag in tags}
        
        for future in as_completed(future_to_tag):
            tag = future_to_tag[future]
            completed += 1
            try:
                articles = future.result()
                all_articles.extend(articles)
                logger.info(f"[OK] ({completed}/{total}) Completed tag '{tag}': {len(articles)} articles")
            except Exception as e:
                logger.error(f"[ERROR] ({completed}/{total}) Error scraping tag '{tag}': {e}")
    
    return all_articles


def extract_album_year_from_title(title: str) -> tuple[str, str]:
    """Extract album name and year from title like 'Permalink to: Album Name (2024)'."""
    album_name = ''
    year = ''
    
    if title.startswith('Permalink to: '):
        title = title[len('Permalink to: '):]
    
    year_match = re.search(r'\((\d{4})\)$', title)
    if year_match:
        year = year_match.group(1)
        album_name = title[:year_match.start()].strip()
    else:
        album_name = title
    
    return album_name, year


def extract_album_details(soup: BeautifulSoup) -> dict[str, str]:
    """Extract album details like Album Name, Star Cast, Music Director, etc."""
    details = {}
    
    try:
        content = soup.find('div', class_='entry-content entry-content-single')
        if not content:
            return details
        
        paragraphs = content.find_all('p')
        
        for para in paragraphs:
            para_html = str(para)
            
            if '<br/>' in para_html or '<br>' in para_html:
                para_html = para_html.replace('<br/>', '\n').replace('<br>', '\n')
                temp_soup = BeautifulSoup(para_html, 'html.parser')
                para_text = temp_soup.get_text()
                
                for line in para_text.split('\n'):
                    line = line.strip()
                    if ':' in line:
                        try:
                            key_part, value_part = line.split(':', 1)
                            key_part = key_part.strip().lower()
                            value_part = clean_string(value_part)
                            
                            if 'album' in key_part and 'language' not in key_part:
                                details['album_name'] = value_part
                            elif 'star cast' in key_part or 'cast' in key_part:
                                details['star_cast'] = value_part
                            elif 'music by' in key_part or 'music' in key_part:
                                details['music_director'] = value_part
                            elif 'directer' in key_part or 'director' in key_part:
                                details['director'] = value_part
                            elif any(kw in key_part for kw in ['year', 'release', 'released', 'date']):
                                details['year'] = value_part
                            elif 'quality' in key_part:
                                details['audio_quality'] = value_part
                        except:
                            continue
            else:
                para_text = para.get_text('\n')
                
                for line in para_text.split('\n'):
                    line = line.strip()
                    
                    if not line or ':' not in line:
                        continue
                    
                    try:
                        key_part, value_part = line.split(':', 1)
                        key_part = key_part.strip().lower()
                        value_part = clean_string(value_part)
                        
                        if any(keyword in key_part for keyword in ['album title', 'album name', 'movie title', 'movie name', 'film', 'movie']):
                            details['album_name'] = value_part
                        elif any(keyword in key_part for keyword in ['cast', 'star cast', 'cast crew', 'stars', 'hero', 'heroine']):
                            details['star_cast'] = value_part
                        elif any(keyword in key_part for keyword in ['music director', 'music by', 'music', 'composer']):
                            details['music_director'] = value_part
                        elif any(keyword in key_part for keyword in ['director', 'directer', 'directed by']):
                            details['director'] = value_part
                        elif any(keyword in key_part for keyword in ['year', 'release', 'released', 'date']):
                            details['year'] = value_part
                        elif any(keyword in key_part for keyword in ['quality', 'audio quality']):
                            details['audio_quality'] = value_part
                    except (ValueError, IndexError):
                        continue
        
        return details
    
    except Exception as e:
        logger.error(f"Error extracting album details: {e}")
        return details


def extract_songs_from_article(soup: BeautifulSoup) -> list[dict[str, str]]:
    """Extract songs with their download links."""
    songs = []
    
    try:
        content = soup.find('div', class_='entry-content entry-content-single')
        if not content:
            return songs
        
        tables = content.find_all('table')
        if tables:
            for table in tables:
                rows = table.find_all('tr')
                for row in rows:
                    cells = row.find_all('td')
                    if len(cells) >= 2:
                        song_number = cells[0].get_text().strip()
                        
                        song_cell = cells[1]
                        song_text = song_cell.get_text('\n').strip()
                        
                        song_parts = [part.strip() for part in song_text.split('\n') if part.strip()]
                        
                        if song_parts:
                            song_title = clean_string(song_parts[0])
                            singers = clean_string(song_parts[1]) if len(song_parts) > 1 else ''
                            
                            links = song_cell.find_all('a', href=True) + row.find_all('a', href=True)
                            
                            song_links = []
                            for link in links:
                                href = link.get('href', '')
                                if href and ('download' in href.lower() or 'mp3' in href.lower() or href.startswith('http')):
                                    song_links.append({
                                        'url': href,
                                        'quality': 'Standard',
                                        'has_hq': 'HQ' in href or 'hq' in href
                                    })
                            
                            if not song_links:
                                song_links.append({
                                    'url': '',
                                    'quality': 'Unknown',
                                    'has_hq': False
                                })
                            
                            song_data = {
                                'title': song_title,
                                'singers': singers,
                                'links': song_links
                            }
                            songs.append(song_data)
        
        if not songs:
            paragraphs = content.find_all('p')
            current_song = None
            
            for para in paragraphs:
                text = para.get_text().strip()
                
                if any(text.startswith(f'{i:02d}.') for i in range(1, 100)):
                    song_full_title = text.split('Download')[0].strip()
                    
                    for i in range(1, 100):
                        prefix = f'{i:02d}. '
                        if song_full_title.startswith(prefix):
                            song_full_title = song_full_title[len(prefix):].strip()
                            break
                    
                    song_name = song_full_title
                    singers = ''
                    
                    if '–' in song_full_title:
                        parts = song_full_title.split('–', 1)
                        song_name = clean_string(parts[0])
                        singers = clean_string(parts[1])
                    elif '-' in song_full_title:
                        parts = song_full_title.split('-', 1)
                        song_name = clean_string(parts[0])
                        singers = clean_string(parts[1])
                    
                    current_song = {
                        'title': song_name,
                        'singers': singers,
                        'links': []
                    }
                    songs.append(current_song)
                
                links = para.find_all('a', href=True)
                for link in links:
                    href = link.get('href', '')
                    
                    if not href:
                        continue
                    
                    link_text = link.get_text().strip()
                    para_text = para.get_text()
                    has_hq_in_url = 'HQ' in href or 'hq' in href
                    
                    quality = "Unknown"
                    
                    if "320 Kbps" in para_text:
                        link_index = para_text.find(link_text)
                        quality_320_index = para_text.find("320 Kbps")
                        
                        if link_index < quality_320_index:
                            quality = "320 Kbps"
                    elif "128 Kbps" in para_text:
                        link_index = para_text.find(link_text)
                        quality_128_index = para_text.find("128 Kbps")
                        
                        if link_index < quality_128_index:
                            quality = "128 Kbps"
                    
                    if current_song:
                        current_song['links'].append({
                            'url': href,
                            'quality': quality,
                            'has_hq': has_hq_in_url
                        })
        
        processed_songs = []
        for song in songs:
            if not song['links']:
                if song.get('title'):
                    song['links'] = [{'url': '', 'quality': 'Unknown', 'has_hq': False}]
                    song['audio_quality'] = 'Standard'
                    processed_songs.append(song)
                continue
            
            if len(song['links']) == 1:
                link = song['links'][0]
                song['audio_quality'] = 'Original' if link['has_hq'] else 'Standard'
                song['links'] = [link]
            else:
                hq_links = [link for link in song['links'] if link['has_hq']]
                
                if hq_links:
                    song['links'] = hq_links
                    song['audio_quality'] = 'Original'
                else:
                    has_320 = any(link['quality'] == '320 Kbps' for link in song['links'])
                    
                    if has_320:
                        song['links'] = [link for link in song['links'] if link['quality'] == '320 Kbps']
                        song['audio_quality'] = 'Original'
                    else:
                        song['audio_quality'] = 'Standard'
            
            processed_songs.append(song)
        
        return processed_songs
    
    except Exception as e:
        logger.error(f"Error extracting songs: {e}")
        return songs


def scrape_article_details(article_url: str, timeout: int = DEFAULT_TIMEOUT, session: requests.Session = None) -> dict[str, Any]:
    """Scrape a single article page to extract album details and songs."""
    headers = build_headers(article_url, DEFAULT_ACCEPT_ENCODING)
    
    # Use provided session or create new one
    if session is None:
        session = requests
    
    try:
        resp = session.get(article_url, headers=headers, timeout=timeout)
        resp.raise_for_status()
        
        decoded = _maybe_decompress(resp)
        if decoded is None:
            return {'error': 'Failed to decompress response'}
        
        html_text = decoded.decode(resp.encoding or "utf-8", errors="replace")
        soup = BeautifulSoup(html_text, "html.parser")
        
        album_details = extract_album_details(soup)
        
        thumbnail_url = ''
        img_tag = soup.find('img', class_='wp-image')
        if not img_tag:
            img_tag = soup.find('img', class_='aligncenter')
        if not img_tag:
            content = soup.find('div', class_='entry-content entry-content-single')
            if content:
                img_tag = content.find('img')
        
        if img_tag and img_tag.get('src'):
            thumbnail_url = img_tag.get('src', '')
        
        songs = extract_songs_from_article(soup)
        
        return {
            'url': article_url,
            'album_details': album_details,
            'thumbnail_url': thumbnail_url,
            'songs': songs
        }
    
    except Exception as e:
        logger.error(f"Error scraping article {article_url}: {e}")
        return {'error': str(e), 'url': article_url}


def scrape_articles_batch_with_metadata(article_data_list: list[dict], timeout: int = DEFAULT_TIMEOUT, workers: int = DEFAULT_WORKERS) -> list[dict]:
    """Scrape multiple articles in parallel with metadata and session pooling."""
    all_results = []
    total = len(article_data_list)
    completed = 0
    
    # Increase workers for article scraping (more I/O bound)
    actual_workers = min(workers * 3, total, 30)  # Cap at 30 for article scraping
    
    # Create session pool for workers
    sessions = [create_session() for _ in range(actual_workers)]
    session_index = 0
    
    def scrape_with_session(article_data):
        nonlocal session_index
        session = sessions[session_index % len(sessions)]
        session_index += 1
        return scrape_article_details(article_data['href'], timeout, session), article_data
    
    logger.info(f"Scraping {total} articles with {actual_workers} parallel workers...")
    
    with ThreadPoolExecutor(max_workers=actual_workers) as executor:
        future_to_data = {executor.submit(scrape_with_session, article): article for article in article_data_list}
        
        for future in as_completed(future_to_data):
            completed += 1
            article_data = future_to_data[future]
            url = article_data['href']
            
            try:
                result, article_info = future.result()
                
                if 'error' not in result:
                    title_album, title_year = extract_album_year_from_title(article_info['title'])
                    
                    album_details = result.get('album_details', {})
                    if title_album:
                        album_details['album_name'] = title_album
                    if title_year:
                        album_details['year'] = title_year
                    
                    result['album_details'] = album_details
                    result['thumbnail_url'] = article_info.get('image_src', '')
                    
                    all_results.append(result)
                    songs_count = len(result.get('songs', []))
                    
                    # Log progress every 10 articles or on completion
                    if completed % 10 == 0 or completed == total:
                        logger.info(f"[OK] Progress: {completed}/{total} articles processed ({len(all_results)} successful)")
                else:
                    if completed % 50 == 0:  # Log errors less frequently
                        logger.error(f"[ERROR] [{completed}/{total}] Error: {result['error']}")
            except Exception as e:
                if completed % 50 == 0:  # Log exceptions less frequently
                    logger.error(f"[ERROR] [{completed}/{total}] Exception: {e}")
    
    logger.info(f"[OK] Completed: {len(all_results)}/{total} articles scraped successfully")
    return all_results


def generate_tag_list(characters: str = "1abcdefghijklmnopqrstuvwxyz") -> list[str]:
    """Generate list of tags from character list."""
    return [f"telugu-{char}" for char in characters]


# ============================================================================
# SQL GENERATION WITH CLEANUP
# ============================================================================

class SQLDataCollector:
    """Collect and deduplicate data for SQL INSERT statements with data cleanup."""
    
    def __init__(self):
        self.albums = {}
        self.songs = []
        self.artists = set()
        self.singers = set()
        self.music_directors = set()
        # Track latest album year for each artist for thumbnail selection
        self.artist_album_years = {}
        
        # Load known names for dynamic normalization
        self.known_names = get_existing_names_from_db()
    
    def add_article_data(self, article_data: dict):
        """Add article data to the collector with data cleanup."""
        album_details = article_data.get('album_details', {})
        thumbnail_url = article_data.get('thumbnail_url', '')
        songs = article_data.get('songs', [])
        
        album_name = clean_string(album_details.get('album_name', ''))
        if not album_name:
            return
        
        # Clean and parse year
        year_str = album_details.get('year', '').strip()
        year_int = clean_year(year_str)
        
        # Add album (deduplicate by album_name)
        if album_name not in self.albums:
            self.albums[album_name] = {
                'title': album_name,
                'year': year_int,
                'director': normalize_name(album_details.get('director', ''), self.known_names),
                'music_director': normalize_name(album_details.get('music_director', ''), self.known_names),
                'star_cast': normalize_name(album_details.get('star_cast', ''), self.known_names),
                'thumbnail_url': thumbnail_url
            }
        
        # Add artists from star_cast
        star_cast = album_details.get('star_cast', '').strip()
        if star_cast:
            artists = split_names(star_cast, self.known_names)
            for artist in artists:
                self.artists.add((artist, album_name))
                
                # Track latest year for artist thumbnail
                if year_int:
                    if artist not in self.artist_album_years:
                        self.artist_album_years[artist] = (year_int, album_name, thumbnail_url)
                    else:
                        existing_year, _, _ = self.artist_album_years[artist]
                        if year_int > existing_year:
                            self.artist_album_years[artist] = (year_int, album_name, thumbnail_url)
        
        # Add music director
        music_director = album_details.get('music_director', '').strip()
        if music_director:
            directors = split_names(music_director, self.known_names)
            for director in directors:
                self.music_directors.add((director, album_name))
        
        # Add songs and singers
        for song in songs:
            song_title = clean_string(song.get('title', ''))
            if not song_title:
                continue
            
            singers = clean_string(song.get('singers', ''))
            
            links = song.get('links', [])
            audio_url = links[0].get('url', '') if links else ''
            
            self.songs.append({
                'album_name': album_name,
                'title': song_title,
                'singer': singers,
                'thumbnail_url': thumbnail_url,
                'audio_url': audio_url
            })
            
            # Add singers
            if singers:
                singer_list = split_names(singers, self.known_names)
                for singer in singer_list:
                    self.singers.add(singer)
    
    def generate_sql_files(self, output_dir: Path | str):
        """Generate separate SQL files for each table."""
        if isinstance(output_dir, str):
            output_dir = Path(output_dir)
        
        output_dir.mkdir(parents=True, exist_ok=True)
        
        self._generate_albums_sql(output_dir / 'albums.sql')
        self._generate_songs_sql(output_dir / 'songs.sql')
        self._generate_artists_sql(output_dir / 'artists.sql')
        self._generate_singers_sql(output_dir / 'singers.sql')
        self._generate_music_directors_sql(output_dir / 'music_directors.sql')
        
        logger.info(f"\n{'='*70}")
        logger.info(f"✓ SQL FILES GENERATED")
        logger.info(f"{'='*70}")
        logger.info(f"  Albums: {len(self.albums)}")
        logger.info(f"  Songs: {len(self.songs)}")
        logger.info(f"  Artists: {len(self.artists)}")
        logger.info(f"  Singers: {len(self.singers)}")
        logger.info(f"  Music Directors: {len(self.music_directors)}")
        logger.info(f"  Output Directory: {output_dir.resolve()}")
        logger.info(f"{'='*70}\n")
    
    def _escape_sql_string(self, value: str) -> str:
        """Escape string for SQL INSERT."""
        if not value:
            return 'NULL'
        escaped = value.replace("'", "''")
        return f"'{escaped}'"
    
    def _generate_albums_sql(self, output_path: Path):
        """Generate SQL INSERT statements for albums table."""
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- Albums INSERT statements\n")
            f.write("-- Generated from scraping data with data cleanup\n\n")
            
            albums_list = sorted(self.albums.items())
            batch_size = 1000
            
            for i in range(0, len(albums_list), batch_size):
                batch = albums_list[i:i+batch_size]
                if not batch:
                    continue
                
                f.write("INSERT IGNORE INTO albums (title, year, director, music_director, star_cast, thumbnail_url) VALUES\n")
                
                values = []
                for album_name, album_data in batch:
                    title = self._escape_sql_string(album_data['title'])
                    year = album_data['year'] if album_data['year'] else 'NULL'
                    director = self._escape_sql_string(album_data['director'])
                    music_director = self._escape_sql_string(album_data['music_director'])
                    star_cast = self._escape_sql_string(album_data['star_cast'])
                    thumbnail_url = self._escape_sql_string(album_data['thumbnail_url'])
                    values.append(f"({title}, {year}, {director}, {music_director}, {star_cast}, {thumbnail_url})")
                
                f.write(",\n".join(values))
                f.write(";\n\n")
    
    def _generate_songs_sql(self, output_path: Path):
        """Generate SQL INSERT statements for songs table."""
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- Songs INSERT statements\n")
            f.write("-- Generated from scraping data with data cleanup\n\n")
            
            batch_size = 500
            
            for i in range(0, len(self.songs), batch_size):
                batch = self.songs[i:i+batch_size]
                if not batch:
                    continue
                
                f.write("INSERT IGNORE INTO songs (album_id, title, singer, thumbnail_url, audio_url) VALUES\n")
                
                values = []
                for song_data in batch:
                    album_name = self._escape_sql_string(song_data['album_name'])
                    title = self._escape_sql_string(song_data['title'])
                    singer = self._escape_sql_string(song_data['singer'])
                    thumbnail_url = self._escape_sql_string(song_data['thumbnail_url'])
                    audio_url = self._escape_sql_string(song_data['audio_url'])
                    values.append(f"(COALESCE((SELECT id FROM albums WHERE title = {album_name} LIMIT 1), 1), {title}, {singer}, {thumbnail_url}, {audio_url})")
                
                f.write(",\n".join(values))
                f.write(";\n\n")
    
    def _generate_artists_sql(self, output_path: Path):
        """Generate SQL INSERT statements for artists table."""
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- Artists INSERT statements\n")
            f.write("-- Generated from scraping data with data cleanup\n\n")
            
            artists_list = sorted(self.artists)
            batch_size = 500
            
            for i in range(0, len(artists_list), batch_size):
                batch = artists_list[i:i+batch_size]
                if not batch:
                    continue
                
                f.write("INSERT IGNORE INTO artists (artist_name, album_id, album_name) VALUES\n")
                
                values = []
                for artist_name, album_name in batch:
                    artist = self._escape_sql_string(artist_name)
                    album = self._escape_sql_string(album_name)
                    values.append(f"({artist}, COALESCE((SELECT id FROM albums WHERE title = {album} LIMIT 1), 1), {album})")
                
                f.write(",\n".join(values))
                f.write(";\n\n")
    
    def _generate_singers_sql(self, output_path: Path):
        """Generate SQL INSERT statements for singers table."""
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- Singers INSERT statements\n")
            f.write("-- Generated from scraping data with data cleanup\n\n")
            
            singers_list = sorted(self.singers)
            batch_size = 1000
            
            for i in range(0, len(singers_list), batch_size):
                batch = singers_list[i:i+batch_size]
                if not batch:
                    continue
                
                f.write("INSERT IGNORE INTO singers (singer_name) VALUES\n")
                
                values = []
                for singer_name in batch:
                    singer = self._escape_sql_string(singer_name)
                    values.append(f"({singer})")
                
                f.write(",\n".join(values))
                f.write(";\n\n")
    
    def _generate_music_directors_sql(self, output_path: Path):
        """Generate SQL INSERT statements for music_directors table."""
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("-- Music Directors INSERT statements\n")
            f.write("-- Generated from scraping data with data cleanup\n\n")
            
            directors_list = sorted(self.music_directors)
            batch_size = 500
            
            for i in range(0, len(directors_list), batch_size):
                batch = directors_list[i:i+batch_size]
                if not batch:
                    continue
                
                f.write("INSERT IGNORE INTO music_directors (director_name, album_id, album_name) VALUES\n")
                
                values = []
                for director_name, album_name in batch:
                    director = self._escape_sql_string(director_name)
                    album = self._escape_sql_string(album_name)
                    values.append(f"({director}, COALESCE((SELECT id FROM albums WHERE title = {album} LIMIT 1), 1), {album})")
                
                f.write(",\n".join(values))
                f.write(";\n\n")


# ============================================================================
# MAIN INGESTION LOGIC
# ============================================================================

def run_full_load(tags: Optional[list[str]], sql_output: Path, execute_sql: bool, truncate: bool, workers: int, batch_size: int, timeout: int):
    """Run full load - scrape all tags and generate SQL."""
    logger.info("="*70)
    logger.info("STARTING FULL LOAD")
    logger.info("="*70)
    
    # Use all tags if not specified
    if not tags:
        tags = generate_tag_list()
    
    logger.info(f"Scraping {len(tags)} tags...")
    
    # Scrape all articles
    all_articles = scrape_all_tag_pages_parallel(tags, timeout=timeout, workers=workers)
    
    logger.info(f"Found {len(all_articles)} articles to scrape")
    
    # Optimize batch size for better parallelism
    # Use larger batches to reduce overhead
    optimized_batch_size = max(batch_size * 5, 50)  # At least 50 articles per batch
    total_batches = (len(all_articles) + optimized_batch_size - 1) // optimized_batch_size
    
    logger.info(f"Processing in {total_batches} batches of ~{optimized_batch_size} articles each")
    
    # Scrape article details in optimized batches
    all_article_data = []
    for batch_num in range(total_batches):
        batch_start = batch_num * optimized_batch_size
        batch_end = min(batch_start + optimized_batch_size, len(all_articles))
        batch_data = all_articles[batch_start:batch_end]
        
        logger.info(f"\n{'='*70}")
        logger.info(f"Processing batch {batch_num + 1}/{total_batches} ({len(batch_data)} articles)")
        logger.info(f"{'='*70}")
        
        batch_results = scrape_articles_batch_with_metadata(batch_data, timeout=timeout, workers=workers)
        all_article_data.extend(batch_results)
        
        logger.info(f"Batch {batch_num + 1} complete: {len(batch_results)} articles scraped")
    
    # Generate SQL
    logger.info("Generating SQL files...")
    sql_collector = SQLDataCollector()
    
    for article in all_article_data:
        sql_collector.add_article_data(article)
    
    sql_collector.generate_sql_files(sql_output)
    
    # Execute SQL if requested
    if execute_sql:
        logger.info("Executing SQL files...")
        results = execute_sql_files_with_truncate(sql_output, truncate=truncate)
        
        if results['truncated']:
            logger.info("[OK] Tables truncated")
        
        logger.info(f"[OK] SQL execution completed: {results['success']} succeeded, {results['failed']} failed")
        
        if results['errors']:
            logger.error(f"Errors: {results['errors']}")
        
        # Show row counts
        logger.info("\nFinal row counts:")
        for table in ['albums', 'songs', 'artists', 'singers', 'music_directors']:
            count = get_table_row_count(table)
            logger.info(f"  {table}: {count}")
    
    logger.info("="*70)
    logger.info("FULL LOAD COMPLETED")
    logger.info("="*70)


def run_incremental_load(sql_output: Path, execute_sql: bool, workers: int, batch_size: int, timeout: int):
    """Run incremental load - only new articles (not implemented in this version)."""
    logger.info("="*70)
    logger.info("INCREMENTAL LOAD")
    logger.info("="*70)
    logger.warning("Incremental load not fully implemented - running full load instead")
    run_full_load(None, sql_output, execute_sql, False, workers, batch_size, timeout)


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Unified Album & Song Ingestion Script",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Full load with truncate and SQL execution
  python ingestion.py --mode full --sql-output sql_output --execute-sql --truncate
  
  # Full load for specific tags
  python ingestion.py --mode full --tags "1,a,b" --sql-output sql_output --execute-sql
  
  # Incremental load
  python ingestion.py --mode incremental --sql-output sql_output --execute-sql
  
  # Dry run (generate SQL only)
  python ingestion.py --mode full --sql-output sql_output
        """
    )
    
    parser.add_argument(
        "--mode",
        choices=["full", "incremental"],
        required=True,
        help="Ingestion mode: full (reload all) or incremental (only new)"
    )
    
    parser.add_argument(
        "--sql-output",
        type=Path,
        required=True,
        help="Directory to save SQL INSERT files"
    )
    
    parser.add_argument(
        "--execute-sql",
        action="store_true",
        help="Execute generated SQL files"
    )
    
    parser.add_argument(
        "--truncate",
        action="store_true",
        help="Truncate all tables before inserting (only with --execute-sql)"
    )
    
    parser.add_argument(
        "--tags",
        type=str,
        help="Comma-separated tags to scrape (e.g., '1,a,b,c'). If not specified, all tags will be scraped."
    )
    
    parser.add_argument(
        "--workers",
        type=int,
        default=DEFAULT_WORKERS,
        help=f"Number of parallel workers (default: {DEFAULT_WORKERS})"
    )
    
    parser.add_argument(
        "--batch-size",
        type=int,
        default=DEFAULT_BATCH_SIZE,
        help=f"Batch size for processing (default: {DEFAULT_BATCH_SIZE})"
    )
    
    parser.add_argument(
        "--timeout",
        type=int,
        default=DEFAULT_TIMEOUT,
        help=f"Request timeout in seconds (default: {DEFAULT_TIMEOUT})"
    )
    
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv or sys.argv[1:])
    
    # Test DB connection if execute_sql is requested
    if args.execute_sql:
        logger.info("Testing database connection...")
        if not test_connection():
            logger.error("[ERROR] Database connection failed! Check your .env configuration.")
            return 1
        logger.info("[OK] Database connection successful")
    
    # Parse tags if provided
    tags = None
    if args.tags:
        chars = [c.strip() for c in args.tags.split(',')]
        tags = generate_tag_list(characters=''.join(chars))
    
    # Run appropriate mode
    if args.mode == "full":
        run_full_load(
            tags=tags,
            sql_output=args.sql_output,
            execute_sql=args.execute_sql,
            truncate=args.truncate,
            workers=args.workers,
            batch_size=args.batch_size,
            timeout=args.timeout
        )
    else:  # incremental
        run_incremental_load(
            sql_output=args.sql_output,
            execute_sql=args.execute_sql,
            workers=args.workers,
            batch_size=args.batch_size,
            timeout=args.timeout
        )
    
    return 0


if __name__ == "__main__":
    sys.exit(main())
