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
DEFAULT_URL = "https://sensongsmp3.live/"
DEFAULT_TIMEOUT = int(os.getenv('DEFAULT_TIMEOUT', 30))
DEFAULT_WORKERS = int(os.getenv('WORKERS', 5))
DEFAULT_BATCH_SIZE = int(os.getenv('BATCH_SIZE', 10))
DEFAULT_ACCEPT_ENCODING = "identity"

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
    
    # Replace multiple spaces with single space
    cleaned = re.sub(r'\s+', ' ', cleaned)
    
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


def split_names(names_str: str) -> List[str]:
    """Split comma-separated names and clean each."""
    if not names_str:
        return []
    
    # Split by comma and clean each name
    names = [clean_string(name) for name in names_str.split(',')]
    
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
                
                # Check for patterns: "01." or "1-" or "1 -" 
                song_pattern_found = False
                song_full_title = ""
                
                # Pattern 1: "01. Song Name" or "1. Song Name"
                if any(text.startswith(f'{i:02d}.') for i in range(1, 100)):
                    song_pattern_found = True
                    song_full_title = text.split('Download')[0].strip()
                    
                    for i in range(1, 100):
                        prefix = f'{i:02d}. '
                        if song_full_title.startswith(prefix):
                            song_full_title = song_full_title[len(prefix):].strip()
                            break
                
                # Pattern 2: "1- Song Name" or "1 - Song Name"
                elif any(text.startswith(f'{i}-') or text.startswith(f'{i} -') for i in range(1, 100)):
                    song_pattern_found = True
                    # Remove leading number and dash/hyphen
                    for i in range(1, 100):
                        if text.startswith(f'{i}-'):
                            song_full_title = text[len(f'{i}-'):].strip()
                            break
                        elif text.startswith(f'{i} -'):
                            song_full_title = text[len(f'{i} -'):].strip()
                            break
                    
                    # Remove "Download" if present
                    if 'Download' in song_full_title:
                        song_full_title = song_full_title.split('Download')[0].strip()
                
                if song_pattern_found and song_full_title:
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
                
                # Check for "Singers:-" pattern in the paragraph to extract singers
                if current_song and 'Singers' in text and ':' in text:
                    lines = text.split('\n')
                    for line in lines:
                        if 'Singers' in line and ':' in line:
                            singer_part = line.split(':', 1)[1].strip()
                            if singer_part and not current_song['singers']:
                                current_song['singers'] = clean_string(singer_part)
                
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
    
    def __init__(self, incremental_mode: bool = False):
        self.albums = {}
        self.songs = []
        self.artists = set()
        self.singers = set()
        self.music_directors = set()
        self.incremental_mode = incremental_mode
        # Track latest album year for each artist for thumbnail selection
        self.artist_album_years = {}
    
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
                'director': clean_string(album_details.get('director', '')),
                'music_director': clean_string(album_details.get('music_director', '')),
                'star_cast': clean_string(album_details.get('star_cast', '')),
                'thumbnail_url': thumbnail_url
            }
        
        # Add artists from star_cast
        star_cast = album_details.get('star_cast', '').strip()
        if star_cast:
            artists = split_names(star_cast)
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
            directors = split_names(music_director)
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
                singer_list = split_names(singers)
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


def extract_date_published_from_article(soup: BeautifulSoup) -> Optional[datetime]:
    """Extract dateModified from JSON-LD script tag in article page."""
    try:
        scripts = soup.find_all('script', type='application/ld+json')
        for script in scripts:
            try:
                data = json.loads(script.string)
                if isinstance(data, dict):
                    # Check if data has @graph structure
                    graph_items = data.get('@graph', [data])
                    
                    for item in graph_items:
                        if not isinstance(item, dict):
                            continue
                        
                        # Look for WebPage type which contains dateModified/datePublished
                        if item.get('@type') in ['WebPage', 'Article', 'NewsArticle']:
                            # Prefer dateModified over datePublished for incremental updates
                            date_str = item.get('dateModified') or item.get('datePublished')
                            
                            if date_str:
                                # Parse ISO format: "2025-11-27T03:51:05+00:00"
                                # Handle both +00:00 and Z timezone formats
                                if date_str.endswith('Z'):
                                    date_str = date_str[:-1] + '+00:00'
                                return datetime.fromisoformat(date_str)
            except (json.JSONDecodeError, ValueError) as e:
                continue
    except Exception as e:
        logger.error(f"Error extracting date modified: {e}")
    return None


def extract_year_from_article_html(soup: BeautifulSoup) -> Optional[int]:
    """Extract year from article HTML (title or album metadata)."""
    try:
        # Try to extract from title
        title_tag = soup.find('h1', class_='entry-title')
        if title_tag:
            title_text = title_tag.get_text()
            # Look for 4-digit year
            year_match = re.search(r'\b(19|20)\d{2}\b', title_text)
            if year_match:
                return int(year_match.group())
        
        # Try to extract from album details
        album_details = extract_album_details(soup)
        if album_details.get('year'):
            year = clean_year(album_details['year'])
            if year:
                return year
    except Exception as e:
        logger.error(f"Error extracting year: {e}")
    return None


def scrape_page_articles(page_url: str, timeout: int = DEFAULT_TIMEOUT) -> list[dict]:
    """Scrape article list from a paginated page (homepage or /page/N/)."""
    try:
        session = create_session()
        headers = build_headers(page_url, "gzip, deflate")
        resp = session.get(page_url, headers=headers, timeout=timeout)
        resp.raise_for_status()
        
        soup = BeautifulSoup(resp.content, 'html.parser')
        articles = extract_articles_from_page(soup)
        
        # Extract year from each article
        for article in articles:
            # Try to extract year from title
            title = article.get('title', '')
            year_match = re.search(r'\b(19|20)\d{2}\b', title)
            if year_match:
                article['year'] = int(year_match.group())
            else:
                article['year'] = None
        
        return articles
    except Exception as e:
        logger.error(f"Error scraping page {page_url}: {e}")
        return []


def scrape_incremental_articles(
    base_url: str,
    min_timestamp: Optional[datetime],
    timeout: int = DEFAULT_TIMEOUT,
    max_pages: int = 50,
    logger: Optional[logging.Logger] = None
) -> list[dict]:
    """
    Scrape articles from homepage and paginated pages.
    Returns ALL articles found - filtering by dateModified will happen later during scraping.
    Stops after max_pages or when no more articles found.
    """
    if logger is None:
        logger = logging.getLogger(__name__)
    
    all_articles = []
    page_num = 1
    
    logger.info(f"Scraping articles from {base_url}")
    if min_timestamp:
        logger.info(f"Will filter articles with dateModified > {min_timestamp}")
    
    while page_num <= max_pages:
        if page_num == 1:
            page_url = base_url.rstrip('/')
        else:
            page_url = f"{base_url.rstrip('/')}/page/{page_num}/"
        
        logger.info(f"Scraping page {page_num}: {page_url}")
        articles = scrape_page_articles(page_url, timeout)
        
        if not articles:
            logger.warning(f"No articles found on page {page_num}, stopping")
            break
        
        all_articles.extend(articles)
        logger.info(f"Page {page_num}: Found {len(articles)} articles")
        
        page_num += 1
    
    logger.info(f"Auto-discovery complete: {len(all_articles)} articles found (will filter by dateModified during scraping)")
    return all_articles


def scrape_article_with_date(article_url: str, timeout: int = DEFAULT_TIMEOUT, min_timestamp: Optional[datetime] = None) -> dict[str, Any]:
    """Scrape article details including dateModified. Returns None if article is older than min_timestamp."""
    try:
        session = create_session()
        headers = build_headers(article_url, "gzip, deflate")
        resp = session.get(article_url, headers=headers, timeout=timeout)
        resp.raise_for_status()
        soup = BeautifulSoup(resp.content, 'html.parser')
        
        # First extract dateModified to check if we should process this article
        date_modified = extract_date_published_from_article(soup)
        
        # Filter by timestamp if provided
        if min_timestamp and date_modified:
            # Ensure both are timezone-aware for comparison
            if date_modified.tzinfo is None:
                from datetime import timezone
                date_modified = date_modified.replace(tzinfo=timezone.utc)
            if min_timestamp.tzinfo is None:
                from datetime import timezone
                min_timestamp = min_timestamp.replace(tzinfo=timezone.utc)
            
            if date_modified <= min_timestamp:
                # Skip old articles
                logger.debug(f"Skipping {article_url}: dateModified {date_modified} <= {min_timestamp}")
                return None
            else:
                logger.debug(f"Processing {article_url}: dateModified {date_modified} > {min_timestamp}")
        elif min_timestamp and not date_modified:
            # If no dateModified found, log warning and skip to be safe
            logger.warning(f"No dateModified found for {article_url}, skipping to avoid duplicates")
            return None
        
        # Now extract full article details
        article_data = extract_album_details(soup)
        
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
            'album_details': article_data,
            'thumbnail_url': thumbnail_url,
            'songs': songs,
            'date_published': date_modified
        }
    except Exception as e:
        logger.error(f"Error scraping article {article_url}: {e}")
        return {'error': str(e), 'url': article_url}


def run_single_article(
    article_url: str,
    sql_output: Path = Path('sql_output'),
    execute_sql: bool = False,
    timeout: int = DEFAULT_TIMEOUT
):
    """
    Scrape a single article and insert into database.
    Checks for duplicates before inserting.
    Does not filter by date - always processes the article.
    """
    logger.info("="*70)
    logger.info("SINGLE ARTICLE SCRAPING")
    logger.info("="*70)
    logger.info(f"Article URL: {article_url}")
    
    # Scrape the article without date filtering
    logger.info("Scraping article...")
    article_result = scrape_article_details(article_url, timeout=timeout)
    
    if not article_result or 'error' in article_result:
        logger.error(f"Failed to scrape article: {article_result.get('error', 'Unknown error')}")
        return
    
    # Extract data
    album_details = article_result.get('album_details', {})
    album_name = album_details.get('album_name', '')
    
    # If album_name not found in details, try to extract from page title
    if not album_name:
        try:
            session = create_session()
            headers = build_headers(article_url, "gzip, deflate")
            resp = session.get(article_url, headers=headers, timeout=timeout)
            resp.raise_for_status()
            soup = BeautifulSoup(resp.content, 'html.parser')
            
            # Try to get from h1.entry-title
            title_tag = soup.find('h1', class_='entry-title')
            if title_tag:
                title_text = title_tag.get_text().strip()
                # Remove year in parentheses if present: "Album Name (2015)" -> "Album Name"
                import re
                album_name = re.sub(r'\s*\(\d{4}\)\s*$', '', title_text).strip()
                if album_name:
                    album_details['album_name'] = album_name
                    article_result['album_details'] = album_details
                    logger.info(f"Extracted album name from title: {album_name}")
        except Exception as e:
            logger.warning(f"Could not extract album name from title: {e}")
    
    if not album_name:
        album_name = album_details.get('album_name', 'Unknown')
    
    songs = article_result.get('songs', [])
    
    logger.info(f"Album: {album_name}")
    logger.info(f"Songs found: {len(songs)}")
    
    # Create collector and add data
    collector = SQLDataCollector(incremental_mode=True)
    collector.add_article_data(article_result)
    
    # Generate SQL files
    sql_output.mkdir(parents=True, exist_ok=True)
    logger.info(f"Generating SQL files in: {sql_output}")
    
    collector.generate_sql_files(sql_output)
    
    logger.info(f"Generated SQL for:")
    logger.info(f"  - Albums: {len(collector.albums)}")
    logger.info(f"  - Songs: {len(collector.songs)}")
    logger.info(f"  - Artists: {len(collector.artists)}")
    logger.info(f"  - Singers: {len(collector.singers)}")
    logger.info(f"  - Music Directors: {len(collector.music_directors)}")
    
    # Execute SQL if requested
    if execute_sql:
        logger.info("="*70)
        logger.info("EXECUTING SQL")
        logger.info("="*70)
        
        from db_utils import execute_sql_files_batch
        
        sql_files = [
            sql_output / 'albums.sql',
            sql_output / 'songs.sql',
            sql_output / 'artists.sql',
            sql_output / 'singers.sql',
            sql_output / 'music_directors.sql'
        ]
        
        # Filter to existing files
        existing_files = [f for f in sql_files if f.exists()]
        
        if existing_files:
            try:
                execute_sql_files_batch(existing_files)
                logger.info("SQL execution completed successfully!")
                logger.info("Note: INSERT IGNORE used - duplicates were skipped automatically")
            except Exception as e:
                logger.error(f"SQL execution failed: {e}")
        else:
            logger.warning("No SQL files found to execute")
    
    logger.info("="*70)
    logger.info("SINGLE ARTICLE SCRAPING COMPLETED")
    logger.info("="*70)


def run_year_load(
    start_year: int,
    sql_output: Path = Path('sql_output'),
    execute_sql: bool = False,
    workers: int = DEFAULT_WORKERS,
    batch_size: int = 10,
    timeout: int = DEFAULT_TIMEOUT
):
    """
    Scrape all articles from all tags starting from a specific year to current year.
    Only inserts albums that don't already exist in the database.
    """
    from datetime import datetime
    current_year = datetime.now().year
    
    logger.info("="*70)
    logger.info(f"YEAR-BASED LOAD: {start_year} to {current_year}")
    logger.info("="*70)
    
    # Get existing album titles from database for the year range
    existing_albums = set()
    try:
        from db_utils import get_db_connection
        with get_db_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT title FROM albums WHERE year >= %s AND year <= %s", (start_year, current_year))
            existing_albums = {row[0] for row in cursor.fetchall()}
            cursor.close()
        logger.info(f"Found {len(existing_albums)} existing albums from {start_year} to {current_year}")
    except Exception as e:
        logger.warning(f"Could not get existing albums: {e}")
    
    # Generate all tags
    tags = generate_tag_list()
    logger.info(f"Scraping {len(tags)} tags to find albums from {start_year} to {current_year}...")
    
    # Scrape all articles from all tags
    all_articles = scrape_all_tag_pages_parallel(tags, timeout=timeout, workers=workers)
    logger.info(f"Found {len(all_articles)} total articles from all tags")
    
    # Process articles in batches to extract year information
    logger.info(f"Filtering articles by year range {start_year}-{current_year}...")
    year_articles = []
    
    # Process in smaller batches to show progress
    batch_size_check = 100
    total_batches = (len(all_articles) + batch_size_check - 1) // batch_size_check
    
    for batch_num in range(total_batches):
        batch_start = batch_num * batch_size_check
        batch_end = min(batch_start + batch_size_check, len(all_articles))
        batch_data = all_articles[batch_start:batch_end]
        
        logger.info(f"Checking batch {batch_num + 1}/{total_batches}...")
        
        # Scrape each article to get year
        batch_results = scrape_articles_batch_with_metadata(batch_data, timeout=timeout, workers=workers)
        
        for article in batch_results:
            album_details = article.get('album_details', {})
            album_name = album_details.get('album_name', '')
            year_str = album_details.get('year', '').strip()
            article_year = clean_year(year_str)
            
            # Extract album name from title if not in details
            if not album_name:
                try:
                    url = article.get('url', '')
                    if url:
                        session = create_session()
                        headers = build_headers(url, "gzip, deflate")
                        resp = session.get(url, headers=headers, timeout=timeout)
                        soup = BeautifulSoup(resp.content, 'html.parser')
                        title_tag = soup.find('h1', class_='entry-title')
                        if title_tag:
                            title_text = title_tag.get_text().strip()
                            import re
                            album_name = re.sub(r'\s*\(\d{4}\)\s*$', '', title_text).strip()
                            if album_name:
                                album_details['album_name'] = album_name
                except:
                    pass
            
            # Filter by year range and check if not already exists
            if article_year and article_year >= start_year and article_year <= current_year and album_name and album_name not in existing_albums:
                year_articles.append(article)
                logger.info(f"  ✓ Found: {album_name} ({article_year})")
    
    logger.info(f"\nFound {len(year_articles)} new articles from {start_year} to {current_year}")
    
    if not year_articles:
        logger.info("No new articles to process!")
        return
    
    # Generate SQL
    logger.info("Generating SQL files...")
    sql_collector = SQLDataCollector(incremental_mode=True)
    
    for article in year_articles:
        sql_collector.add_article_data(article)
    
    sql_collector.generate_sql_files(sql_output)
    
    logger.info(f"Generated SQL for:")
    logger.info(f"  - Albums: {len(sql_collector.albums)}")
    logger.info(f"  - Songs: {len(sql_collector.songs)}")
    logger.info(f"  - Artists: {len(sql_collector.artists)}")
    logger.info(f"  - Singers: {len(sql_collector.singers)}")
    logger.info(f"  - Music Directors: {len(sql_collector.music_directors)}")
    
    # Execute SQL if requested
    if execute_sql:
        logger.info("="*70)
        logger.info("EXECUTING SQL")
        logger.info("="*70)
        
        from db_utils import execute_sql_files_batch
        
        sql_files = [
            sql_output / 'albums.sql',
            sql_output / 'songs.sql',
            sql_output / 'artists.sql',
            sql_output / 'singers.sql',
            sql_output / 'music_directors.sql'
        ]
        
        existing_files = [f for f in sql_files if f.exists()]
        
        if existing_files:
            try:
                execute_sql_files_batch(existing_files)
                logger.info("SQL execution completed successfully!")
                logger.info("Note: INSERT IGNORE used - duplicates were skipped automatically")
            except Exception as e:
                logger.error(f"SQL execution failed: {e}")
        else:
            logger.warning("No SQL files found to execute")
    
    logger.info("="*70)
    logger.info(f"YEAR RANGE {start_year}-{current_year} LOAD COMPLETED")
    logger.info("="*70)


def run_incremental_load(
    articles_csv: Optional[Path] = None,
    sql_output: Path = Path('sql_output'),
    auto_discover: bool = False,
    base_url: str = "https://sensongsmp3.live/",
    max_pages: int = 50,
    execute_sql: bool = False,
    workers: int = DEFAULT_WORKERS,
    batch_size: int = 10,
    timeout: int = DEFAULT_TIMEOUT
):
    """
    Run incremental load - only new articles based on max created_at timestamp.
    Can auto-discover articles from website or read from CSV.
    """
    logger.info("="*70)
    logger.info("INCREMENTAL LOAD STARTED")
    logger.info("="*70)
    
    # Step 1: Get max timestamp from database
    max_timestamp = None
    
    try:
        from db_utils import get_max_created_at
        max_timestamp = get_max_created_at('albums')
        if max_timestamp:
            logger.info(f"Max timestamp found: {max_timestamp}")
            logger.info(f"Will only process articles with dateModified > {max_timestamp}")
        else:
            logger.info("No existing records found in database")
    except Exception as e:
        logger.warning(f"Could not get max timestamp: {e}")
    
    # Step 2: Get articles (auto-discover or from CSV)
    article_data_list = []
    
    if auto_discover:
        logger.info("Auto-discovering articles from website...")
        article_data_list = scrape_incremental_articles(base_url, max_timestamp, timeout, max_pages, logger)
        logger.info(f"Discovered {len(article_data_list)} articles")
        
        # Save articles CSV
        articles_csv_path = sql_output / 'discovered_articles.csv'
        try:
            import csv as csv_module
            with open(articles_csv_path, 'w', newline='', encoding='utf-8') as f:
                writer = csv_module.DictWriter(f, fieldnames=['href', 'image_src', 'title', 'year'])
                writer.writeheader()
                writer.writerows(article_data_list)
            logger.info(f"Saved discovered articles to: {articles_csv_path}")
        except Exception as e:
            logger.warning(f"Could not save articles CSV: {e}")
    elif articles_csv and articles_csv.exists():
        logger.info(f"Reading articles from CSV: {articles_csv}")
        try:
            with open(articles_csv, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                for row in reader:
                    if 'href' in row:
                        article_data_list.append({
                            'href': row['href'],
                            'image_src': row.get('image_src', ''),
                            'title': row.get('title', ''),
                            'year': int(row['year']) if row.get('year') and str(row['year']).isdigit() else None
                        })
            logger.info(f"Found {len(article_data_list)} articles in CSV")
        except Exception as e:
            logger.error(f"Error reading CSV: {e}")
            return
    else:
        logger.error("No article source provided (CSV or auto-discover)")
        return
    
    if not article_data_list:
        logger.warning("No articles to process")
        return
    
    # Step 3: Scrape articles with dateModified filtering
    logger.info(f"Scraping {len(article_data_list)} articles with {workers} workers...")
    logger.info(f"Filtering: Only articles with dateModified > {max_timestamp if max_timestamp else 'N/A'}")
    all_scraped_data = []
    skipped_count = 0
    error_count = 0
    no_date_count = 0
    first_article_logged = False
    
    with ThreadPoolExecutor(max_workers=workers) as executor:
        future_to_article = {
            executor.submit(scrape_article_with_date, article['href'], timeout, max_timestamp): article
            for article in article_data_list
        }
        
        completed = 0
        for future in as_completed(future_to_article):
            completed += 1
            article = future_to_article[future]
            try:
                result = future.result()
                if result is None:
                    # Article was filtered out (too old or no date)
                    skipped_count += 1
                elif result.get('error'):
                    error_count += 1
                    logger.error(f"Error scraping {article['href']}: {result['error']}")
                else:
                    all_scraped_data.append(result)
                    # Log first successful article to verify date extraction
                    if not first_article_logged:
                        date_pub = result.get('date_published')
                        logger.info(f"First article processed: {article['href']}")
                        logger.info(f"  dateModified: {date_pub}")
                        logger.info(f"  Max timestamp: {max_timestamp}")
                        logger.info(f"  Should process: {date_pub > max_timestamp if (date_pub and max_timestamp) else 'N/A'}")
                        first_article_logged = True
                
                # Log progress every 10 articles
                if completed % 10 == 0:
                    logger.info(f"Progress: {completed}/{len(article_data_list)} - New: {len(all_scraped_data)}, Skipped: {skipped_count}, Errors: {error_count}")
            except Exception as e:
                error_count += 1
                logger.error(f"Exception scraping {article['href']}: {e}")
    
    logger.info(f"Scraping complete: {len(all_scraped_data)} new articles, {skipped_count} skipped, {error_count} errors")
    
    # Save songs CSV
    if all_scraped_data:
        songs_csv_path = sql_output / 'scraped_songs.csv'
        try:
            import csv as csv_module
            with open(songs_csv_path, 'w', newline='', encoding='utf-8') as f:
                writer = csv_module.writer(f)
                writer.writerow(['Album', 'Song Title', 'Singers', 'Audio URL', 'Date Published'])
                for article in all_scraped_data:
                    album_name = article.get('album_details', {}).get('album_name', '')
                    date_pub = article.get('date_published', '')
                    for song in article.get('songs', []):
                        audio_url = song.get('links', [{}])[0].get('url', '') if song.get('links') else ''
                        writer.writerow([
                            album_name,
                            song.get('title', ''),
                            song.get('singers', ''),
                            audio_url,
                            date_pub
                        ])
            logger.info(f"Saved songs CSV to: {songs_csv_path}")
        except Exception as e:
            logger.warning(f"Could not save songs CSV: {e}")
    
    # Step 4: Generate SQL files (incremental mode - no TRUNCATE)
    logger.info("Generating incremental SQL files...")
    sql_collector = SQLDataCollector(incremental_mode=True)
    
    for article in all_scraped_data:
        article_data = {
            'album_details': article.get('album_details', {}),
            'thumbnail_url': article.get('thumbnail_url', ''),
            'songs': article.get('songs', []),
            'date_published': article.get('date_published')
        }
        sql_collector.add_article_data(article_data)
    
    logger.info(f"Albums found: {len(sql_collector.albums)}")
    logger.info(f"Songs found: {len(sql_collector.songs)}")
    
    sql_collector.generate_sql_files(sql_output)
    logger.info(f"SQL files generated in: {sql_output}")
    
    # Step 5: Execute SQL files (if requested)
    if execute_sql:
        try:
            from db_utils import execute_sql_files_batch
            sql_files = [
                sql_output / 'albums.sql',
                sql_output / 'songs.sql',
                sql_output / 'artists.sql',
                sql_output / 'singers.sql',
                sql_output / 'music_directors.sql'
            ]
            results = execute_sql_files_batch(sql_files)
            logger.info(f"SQL execution: {results['success']} succeeded, {results['failed']} failed")
        except Exception as e:
            logger.error(f"SQL execution error: {e}")
    
    logger.info("="*70)
    logger.info("INCREMENTAL LOAD COMPLETED")
    logger.info("="*70)


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
  
  # Single article scraping
  python ingestion.py --mode single --article-url "https://sensongsmp3.live/..." --sql-output sql_output --execute-sql
  
  # Year-based load (scrape all tags for specific year, insert only new albums)
  python ingestion.py --mode year --year 1995 --sql-output sql_output --execute-sql
  
  # Dry run (generate SQL only)
  python ingestion.py --mode full --sql-output sql_output
        """
    )
    
    parser.add_argument(
        "--mode",
        choices=["full", "incremental", "single", "year"],
        required=True,
        help="Ingestion mode: full (reload all), incremental (only new), single (one article), or year (specific year)"
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
        "--auto-discover-articles",
        action="store_true",
        help="Automatically discover new articles from homepage (incremental mode only)"
    )
    
    parser.add_argument(
        "--base-url",
        type=str,
        default="https://sensongsmp3.live/",
        help="Base URL for article discovery (default: https://sensongsmp3.live/)"
    )
    
    parser.add_argument(
        "--max-pages",
        type=int,
        default=50,
        help="Maximum pages to scrape during auto-discovery (default: 50)"
    )
    
    parser.add_argument(
        "--articles-csv",
        type=Path,
        help="CSV file with article URLs for incremental mode (alternative to auto-discover)"
    )
    
    parser.add_argument(
        "--article-url",
        type=str,
        help="Single article URL to scrape (for --mode single)"
    )
    
    parser.add_argument(
        "--year",
        type=int,
        help="Start year to scrape from (for --mode year, e.g., 1995 will scrape 1995 to current year)"
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
    elif args.mode == "single":
        if not args.article_url:
            logger.error("--article-url is required for single mode")
            return 1
        run_single_article(
            article_url=args.article_url,
            sql_output=args.sql_output,
            execute_sql=args.execute_sql,
            timeout=args.timeout
        )
    elif args.mode == "year":
        if not args.year:
            logger.error("--year is required for year mode")
            return 1
        run_year_load(
            start_year=args.year,
            sql_output=args.sql_output,
            execute_sql=args.execute_sql,
            workers=args.workers,
            batch_size=args.batch_size,
            timeout=args.timeout
        )
    else:  # incremental
        run_incremental_load(
            articles_csv=args.articles_csv if hasattr(args, 'articles_csv') else None,
            sql_output=args.sql_output,
            auto_discover=args.auto_discover_articles if hasattr(args, 'auto_discover_articles') else False,
            base_url=args.base_url if hasattr(args, 'base_url') else "https://sensongsmp3.live/",
            max_pages=args.max_pages if hasattr(args, 'max_pages') else 50,
            execute_sql=args.execute_sql,
            workers=args.workers,
            batch_size=args.batch_size,
            timeout=args.timeout
        )
    
    return 0


if __name__ == "__main__":
    sys.exit(main())
