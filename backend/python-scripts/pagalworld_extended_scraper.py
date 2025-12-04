#!/usr/bin/env python3
"""
Pagal World Language Scraper - Extended Version
Captures maximum fields including song audio URLs and album details
"""

import requests
import json
import time
import logging
from datetime import datetime
from bs4 import BeautifulSoup
from urllib.parse import urljoin, urlparse
import re

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('pagalworld_extended_scraper.log'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

class PagalWorldExtendedScraper:
    """Extended scraper with maximum field extraction"""
    
    def __init__(self):
        self.base_url = 'https://pagalworldmusic.com'
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
        }
        self.results = {'albums': [], 'songs': [], 'errors': []}

    def scrape_language_page(self, language_slug, language_name):
        """Scrape a language category page"""
        logger.info(f"\n{'='*70}")
        logger.info(f"SCRAPING: {language_name} ({language_slug})")
        logger.info(f"{'='*70}")
        
        url = f'{self.base_url}/language/{language_slug}'
        logger.info(f"URL: {url}\n")
        
        try:
            response = requests.get(url, headers=self.headers, timeout=15)
            response.raise_for_status()
            logger.info(f"Status: {response.status_code}")
            
            soup = BeautifulSoup(response.text, 'html.parser')
            
            # Find all track items (albums)
            track_boxes = soup.find_all('div', class_='track-box')
            logger.info(f"Found {len(track_boxes)} track containers\n")
            
            album_count = 0
            song_count = 0
            
            for track_box in track_boxes:
                try:
                    # Get the parent track link
                    track_link = track_box.find_parent('a', class_='track-link')
                    if not track_link:
                        continue
                    
                    href = track_link.get('href', '')
                    if not href:
                        continue
                    
                    title = track_link.get('title', '')
                    if not title:
                        title_elem = track_box.find('div', class_='track-title')
                        if title_elem:
                            title = title_elem.get_text(strip=True)
                    
                    if not title or not href:
                        continue
                    
                    # Check if this is an album link
                    if '/album/' in href:
                        album_data = self.scrape_album_details(href, title, language_name, track_box)
                        if album_data:
                            self.results['albums'].append(album_data)
                            album_count += 1
                            logger.info(f"  [Album] {title[:40]}")
                    
                    elif '/song/' in href or '/track/' in href:
                        song_data = self.scrape_song_details(href, title, language_name, track_box)
                        if song_data:
                            self.results['songs'].append(song_data)
                            song_count += 1
                            logger.info(f"  [Song] {title[:40]}")
                
                except Exception as e:
                    logger.debug(f"  Error parsing item: {str(e)}")
                    continue
            
            logger.info(f"\n{'='*70}")
            logger.info(f"SUMMARY for {language_name}")
            logger.info(f"  Albums found: {album_count}")
            logger.info(f"  Songs found: {song_count}")
            logger.info(f"{'='*70}\n")
            
            return album_count, song_count
            
        except Exception as e:
            error_msg = f"Error scraping {language_name}: {str(e)}"
            logger.error(error_msg)
            self.results['errors'].append(error_msg)
            return 0, 0

    def scrape_album_details(self, album_href, title, language_name, track_box):
        """Scrape detailed information about an album"""
        try:
            album_url = urljoin(self.base_url, album_href)
            
            # Get image from track-box
            img = track_box.find('img')
            image_url = img.get('src', '') if img else ''
            if image_url and image_url.startswith('/'):
                image_url = urljoin(self.base_url, image_url)
            
            # Get song count from text
            info_text = track_box.get_text()
            song_count = None
            if 'Total songs' in info_text:
                try:
                    songs_part = info_text.split('Total songs')[1].split('=')[1].strip()
                    song_count = int(songs_part.split()[0])
                except:
                    pass
            
            # Extract album ID from URL
            album_id = album_href.split('/')[2] if len(album_href.split('/')) > 2 else ''
            
            # Try to scrape album page for more details
            album_details = self.fetch_album_page_details(album_url)
            
            album_data = {
                'type': 'album',
                'title': title,
                'url': album_url,
                'album_id': album_id,
                'slug': album_href.split('/')[-1],
                'language': language_name,
                'image_url': album_details.get('image_url_high') if album_details and album_details.get('image_url_high') else (image_url if image_url else None),
                'image_url_high': album_details.get('image_url_high') if album_details else None,
                'song_count': song_count,
                'year': album_details.get('year') if album_details else None,
                'director': album_details.get('director') if album_details else None,
                'music_director': album_details.get('music_director') if album_details else None,
                'star_cast': album_details.get('star_cast') if album_details else None,
                'description': album_details.get('description') if album_details else None,
                'total_songs': album_details.get('total_songs') if album_details else song_count,
                'scrape_timestamp': datetime.now().isoformat()
            }
            
            return album_data
            
        except Exception as e:
            logger.debug(f"Error scraping album details: {str(e)}")
            return None

    def fetch_album_page_details(self, album_url):
        """Fetch additional details from album page"""
        try:
            logger.debug(f"Fetching album page: {album_url}")
            response = requests.get(album_url, headers=self.headers, timeout=10)
            response.raise_for_status()
            
            soup = BeautifulSoup(response.text, 'html.parser')
            page_text = soup.get_text(separator=' | ', strip=True)
            
            details = {}
            
            # Extract metadata using regex patterns from page text
            metadata_patterns = {
                'album_name': r'Album Name\s*\|\s*([^|]+)',
                'release_date': r'Release\s*\|\s*([^|]+)',
                'year': r'Year\s*\|\s*([^|]+)',
                'label': r'Label\s*\|\s*([^|]+)',
            }
            
            for field, pattern in metadata_patterns.items():
                match = re.search(pattern, page_text)
                if match:
                    value = match.group(1).strip()
                    details[field] = value
            
            # Extract director if present
            director_patterns = [
                r'Director[:\s]+([^,|\n]+)',
                r'[Dd]irector[:\s]+([^,|]+)',
            ]
            for pattern in director_patterns:
                director_match = re.search(pattern, page_text)
                if director_match:
                    details['director'] = director_match.group(1).strip()
                    break
            
            # Extract music director
            music_patterns = [
                r'Music[:\s|]*([^,|\n]+)',
                r'Music Director[:\s|]*([^,|\n]+)',
            ]
            for pattern in music_patterns:
                music_match = re.search(pattern, page_text)
                if music_match:
                    music_text = music_match.group(1).strip()
                    if music_text and 'Label' not in music_text:
                        details['music_director'] = music_text
                        break
            
            # Extract star cast
            cast_match = re.search(r'Star Cast[:\s|]*([^|]+)', page_text)
            if cast_match:
                details['star_cast'] = cast_match.group(1).strip()
            
            # Count total songs on page
            song_elements = soup.find_all('div', class_=['song-item', 'track-item'])
            if song_elements:
                details['total_songs'] = len(song_elements)
            
            # Look for high-quality image
            img_tags = soup.find_all('img')
            for img in img_tags:
                src = img.get('src', '')
                data_src = img.get('data-src', '')
                
                # Check both src and data-src for actual image files (jpg, png, webp)
                for img_url in [data_src, src]:
                    if img_url and any(ext in img_url.lower() for ext in ['.jpg', '.png', '.webp']):
                        # Exclude logos and defaults
                        if 'logo' not in img_url.lower() and 'default' not in img_url.lower():
                            if img_url.startswith('/'):
                                img_url = urljoin(self.base_url, img_url)
                            details['image_url_high'] = img_url
                            logger.debug(f"Album image found: {img_url[:80]}")
                            break
                if details.get('image_url_high'):
                    break
            
            # Extract meta description
            meta_desc = soup.find('meta', attrs={'name': 'description'})
            if meta_desc:
                details['description'] = meta_desc.get('content', '')
            
            logger.debug(f"Extracted album details: {len(details)} fields")
            return details if details else None
            
        except Exception as e:
            logger.debug(f"Could not fetch album page details: {str(e)}")
            return None

    def scrape_song_details(self, song_href, title, language_name, track_box):
        """Scrape detailed information about a song"""
        try:
            song_url = urljoin(self.base_url, song_href)
            
            # Get artist/singer info from track-box
            artist_elem = track_box.find('span', class_='artist')
            artist = artist_elem.get_text(strip=True) if artist_elem else 'Unknown'
            
            # Image will be fetched from song page (more reliable)
            image_url = None
            
            # Extract song ID from URL
            song_id = song_href.split('/')[2] if len(song_href.split('/')) > 2 else ''
            
            # Try to fetch song page for audio URL and complete details
            song_details = self.fetch_song_page_details(song_url)
            
            song_data = {
                'type': 'song',
                'title': title,
                'url': song_url,
                'song_id': song_id,
                'slug': song_href.split('/')[-1],
                'language': language_name,
                
                # Basic info from track-box
                'artist': artist,
                'singer': artist,
                'image_url': image_url if image_url else None,
                
                # Detailed info from song page
                'artist_main': song_details.get('artist_main') if song_details else None,
                'all_artists': song_details.get('all_artists') if song_details else None,
                'artists': song_details.get('artists') if song_details else None,
                'album_name': song_details.get('album_name') if song_details else None,
                'music_composer': song_details.get('music_composer') if song_details else None,
                'label': song_details.get('label') if song_details else None,
                
                # Audio URLs (CRITICAL!)
                'audio_url': song_details.get('audio_url') if song_details else None,
                'audio_quality': song_details.get('audio_quality') if song_details else None,
                'audio_size': song_details.get('audio_size') if song_details else None,
                'audio_urls_all': song_details.get('audio_urls_all') if song_details else None,
                'audio_src_direct': song_details.get('audio_src_direct') if song_details else None,
                
                # Metadata
                'duration': song_details.get('duration') if song_details else None,
                'release_date': song_details.get('release_date') if song_details else None,
                'year': song_details.get('year') if song_details else None,
                'description': song_details.get('description') if song_details else None,
                'image_url_high': song_details.get('image_url_high') if song_details else None,
                'track_name': song_details.get('track_name') if song_details else title,
                
                'scrape_timestamp': datetime.now().isoformat()
            }
            
            return song_data
            
        except Exception as e:
            logger.debug(f"Error scraping song details: {str(e)}")
            return None

    def fetch_song_page_details(self, song_url):
        """Fetch audio URL and other details from song page"""
        try:
            logger.debug(f"Fetching song page: {song_url}")
            response = requests.get(song_url, headers=self.headers, timeout=10)
            response.raise_for_status()
            
            soup = BeautifulSoup(response.text, 'html.parser')
            page_text = soup.get_text(separator=' | ', strip=True)
            
            details = {}
            
            # Extract metadata using regex patterns from page text
            metadata_patterns = {
                'track_name': r'Track Name\s*\|\s*([^|]+)',
                'artist_main': r'Artist\s*\|\s*([^|]+)',
                'album_name': r'Album Name\s*\|\s*([^|]+)',
                'release_date': r'Release\s*\|\s*([^|]+)',
                'duration': r'Duration\s*\|\s*([^|]+)',
                'year': r'Year\s*\|\s*([^|]+)',
                'label': r'Label\s*\|\s*([^|]+)',
            }
            
            for field, pattern in metadata_patterns.items():
                match = re.search(pattern, page_text)
                if match:
                    value = match.group(1).strip()
                    details[field] = value
            
            # Extract multiple artists
            artists_section = re.search(r'Artists\s*\|\s*([^|]+)', page_text)
            if artists_section:
                artists_text = artists_section.group(1)
                artists = [a.strip() for a in artists_text.split(',') if a.strip()]
                details['artists'] = artists
                details['all_artists'] = ', '.join(artists)
            
            # Extract music composer
            music_section = re.search(r'Music\s*\|\s*([^|]+)', page_text)
            if music_section:
                details['music_composer'] = music_section.group(1).strip()
            
            # Look for download links (audio_url is CRITICAL!)
            download_links = soup.find_all('a')
            audio_urls = {}
            for link in download_links:
                text = link.get_text(strip=True)
                href = link.get('href', '')
                
                if 'download' in text.lower() and 'kbps' in text.lower():
                    quality_match = re.search(r'(\d+)\s*kbps', text, re.IGNORECASE)
                    if quality_match:
                        quality = quality_match.group(1) + 'kbps'
                        size_match = re.search(r'\((.*?)\)', text)
                        size = size_match.group(1) if size_match else None
                        
                        audio_urls[quality] = {
                            'url': href,
                            'size': size
                        }
                        
                        # Set 320kbps as primary, or highest available
                        if quality == '320kbps' or details.get('audio_url') is None:
                            details['audio_url'] = href
                            details['audio_quality'] = quality
                            details['audio_size'] = size
            
            # Also check for audio element direct source
            audio_elem = soup.find('audio')
            if audio_elem:
                source_elem = audio_elem.find('source')
                if source_elem:
                    src = source_elem.get('src', '')
                    if src and details.get('audio_url') is None:
                        details['audio_src_direct'] = src
                        if not details.get('audio_url'):
                            details['audio_url'] = src
                            details['audio_quality'] = 'stream'
            
            # Store all available qualities
            details['audio_urls_all'] = audio_urls
            
            # Extract metadata
            meta_desc = soup.find('meta', attrs={'name': 'description'})
            if meta_desc:
                details['description'] = meta_desc.get('content', '')
            
            # Try to find high-quality image
            img_tags = soup.find_all('img')
            for img in img_tags:
                src = img.get('src', '')
                data_src = img.get('data-src', '')
                
                # Check both src and data-src for actual image files
                for img_url in [data_src, src]:
                    if img_url and any(ext in img_url.lower() for ext in ['.jpg', '.png', '.webp']):
                        # Exclude logos and defaults
                        if 'logo' not in img_url.lower() and 'default' not in img_url.lower():
                            if img_url.startswith('/'):
                                img_url = urljoin(self.base_url, img_url)
                            details['image_url_high'] = img_url
                            logger.debug(f"Found actual image: {img_url[:80]}")
                            break
                if details.get('image_url_high'):
                    break
            
            # If no image found in img tags, try meta tags
            if not details.get('image_url_high'):
                meta_img = soup.find('meta', attrs={'property': 'og:image'})
                if meta_img:
                    img_url = meta_img.get('content', '')
                    if img_url and 'logo' not in img_url.lower() and '.jpg' in img_url.lower():
                        details['image_url'] = img_url
                        logger.debug(f"Using meta og:image: {img_url[:80]}")
            
            logger.debug(f"Extracted song details: {len(details)} fields, audio_url found: {bool(details.get('audio_url'))}")
            return details if details else None
            
        except Exception as e:
            logger.debug(f"Could not fetch song page details: {str(e)}")
            return None

    def save_results(self, output_file='pagalworld_extended_results.json'):
        """Save results to JSON"""
        logger.info(f"\nSaving results to {output_file}...")
        
        output_data = {
            'timestamp': datetime.now().isoformat(),
            'summary': {
                'total_albums': len(self.results['albums']),
                'total_songs': len(self.results['songs']),
                'total_errors': len(self.results['errors']),
                'fields_per_album': 13,
                'fields_per_song': 12
            },
            'data': self.results
        }
        
        try:
            with open(output_file, 'w', encoding='utf-8') as f:
                json.dump(output_data, f, indent=2, ensure_ascii=False)
            logger.info(f"Results saved to {output_file}")
            return True
        except Exception as e:
            logger.error(f"Error saving results: {str(e)}")
            return False

    def print_summary(self):
        """Print final summary"""
        logger.info(f"\n{'='*70}")
        logger.info("FINAL SUMMARY - EXTENDED FIELDS")
        logger.info(f"{'='*70}")
        logger.info(f"Total Albums Found: {len(self.results['albums'])}")
        logger.info(f"Total Songs Found: {len(self.results['songs'])}")
        logger.info(f"Total Errors: {len(self.results['errors'])}")
        
        if self.results['albums']:
            logger.info(f"\nAlbum Fields Captured (per album):")
            album = self.results['albums'][0]
            for i, (key, value) in enumerate(album.items(), 1):
                if value is not None:
                    logger.info(f"  {i}. {key}: {str(value)[:60]}")
        
        if self.results['songs']:
            logger.info(f"\nSong Fields Captured (per song):")
            song = self.results['songs'][0]
            for i, (key, value) in enumerate(song.items(), 1):
                if value is not None:
                    logger.info(f"  {i}. {key}: {str(value)[:60]}")
        
        logger.info(f"{'='*70}\n")

def main():
    """Main execution"""
    logger.info("\n" + "="*70)
    logger.info("PAGAL WORLD EXTENDED SCRAPER - MAXIMUM FIELDS")
    logger.info("="*70 + "\n")
    
    scraper = PagalWorldExtendedScraper()
    
    # Languages to scrape
    languages = [
        ('hindi', 'Hindi'),
        ('marathi', 'Marathi'),
        ('tamil', 'Tamil'),
        ('telugu', 'Telugu'),
    ]
    
    logger.info(f"Starting scrape for {len(languages)} languages\n")
    
    total_albums = 0
    total_songs = 0
    
    for language_slug, language_name in languages:
        try:
            albums, songs = scraper.scrape_language_page(language_slug, language_name)
            total_albums += albums
            total_songs += songs
            time.sleep(2)  # Rate limiting
        except Exception as e:
            logger.error(f"Error scraping {language_name}: {str(e)}")
    
    # Save and print results
    scraper.save_results()
    scraper.print_summary()
    
    logger.info(f"Log file: pagalworld_extended_scraper.log")
    logger.info(f"Results file: pagalworld_extended_results.json")

if __name__ == '__main__':
    main()
