#!/usr/bin/env python3
"""
Pagal World Language-based Scraper
Scrapes albums and songs by language category from pagalworldmusic.com
"""

import requests
import json
import time
from bs4 import BeautifulSoup
from datetime import datetime
from urllib.parse import urljoin, urlparse
import logging

# Configure logging
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('pagalworld_language_scraper.log'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

class PagalWorldLanguageScraper:
    def __init__(self):
        self.base_url = 'https://pagalworldmusic.com'
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
        }
        self.session = requests.Session()
        self.session.headers.update(self.headers)
        self.results = {
            'albums': [],
            'songs': [],
            'errors': []
        }

    def get_language_page(self, language_slug):
        """Get the language category page"""
        logger.info(f"Fetching language page: {language_slug}")
        
        url = f'{self.base_url}/language/{language_slug}'
        try:
            response = self.session.get(url, timeout=10)
            response.raise_for_status()
            logger.info(f"✓ Successfully fetched {url}")
            return response.text
        except Exception as e:
            error_msg = f"✗ Error fetching {url}: {str(e)}"
            logger.error(error_msg)
            self.results['errors'].append(error_msg)
            return None

    def parse_albums_from_page(self, html, language):
        """Parse albums from the language page"""
        logger.info(f"Parsing albums for language: {language}")
        
        soup = BeautifulSoup(html, 'html.parser')
        album_count = 0
        
        # Look for album containers
        album_containers = soup.find_all('div', class_=['album-item', 'movie-item', 'item-box', 'card'])
        logger.debug(f"Found {len(album_containers)} potential album containers")
        
        if not album_containers:
            # Try alternative selectors
            album_containers = soup.find_all('a', class_=['album-link', 'movie-link'])
            logger.debug(f"Trying alternative selectors, found {len(album_containers)} items")
        
        for container in album_containers:
            try:
                # Extract album details
                album_link = container.find('a') or container
                album_url = album_link.get('href', '')
                
                if not album_url:
                    continue
                
                # Make URL absolute
                if album_url.startswith('/'):
                    album_url = urljoin(self.base_url, album_url)
                
                album_title = album_link.get('title', '') or album_link.get_text(strip=True)
                
                if not album_title or not album_url:
                    continue
                
                # Extract image
                img = container.find('img')
                album_image = img.get('src', '') if img else ''
                
                album_data = {
                    'title': album_title,
                    'url': album_url,
                    'image': album_image,
                    'language': language,
                    'scrape_timestamp': datetime.now().isoformat()
                }
                
                self.results['albums'].append(album_data)
                album_count += 1
                logger.debug(f"  ✓ Found album: {album_title}")
                
            except Exception as e:
                logger.debug(f"  Error parsing album container: {str(e)}")
                continue
        
        logger.info(f"✓ Parsed {album_count} albums for language: {language}")
        return album_count

    def parse_songs_from_page(self, html, language):
        """Parse songs from the language page"""
        logger.info(f"Parsing songs for language: {language}")
        
        soup = BeautifulSoup(html, 'html.parser')
        song_count = 0
        
        # Look for song containers - try multiple selectors
        song_containers = soup.find_all('div', class_=['song-item', 'song-box', 'track-item'])
        logger.debug(f"Found {len(song_containers)} potential song containers")
        
        if not song_containers:
            # Try table rows
            song_containers = soup.find_all('tr', class_='song-row')
            logger.debug(f"Trying table rows, found {len(song_containers)} items")
        
        for container in song_containers:
            try:
                # Extract song details
                song_link = container.find('a')
                if not song_link:
                    continue
                
                song_url = song_link.get('href', '')
                song_title = song_link.get_text(strip=True)
                
                if not song_title or not song_url:
                    continue
                
                # Make URL absolute
                if song_url.startswith('/'):
                    song_url = urljoin(self.base_url, song_url)
                
                # Try to extract artist/singer
                singer = container.find('span', class_=['singer', 'artist'])
                singer_text = singer.get_text(strip=True) if singer else 'Unknown'
                
                song_data = {
                    'title': song_title,
                    'url': song_url,
                    'singer': singer_text,
                    'language': language,
                    'scrape_timestamp': datetime.now().isoformat()
                }
                
                self.results['songs'].append(song_data)
                song_count += 1
                logger.debug(f"  ✓ Found song: {song_title}")
                
            except Exception as e:
                logger.debug(f"  Error parsing song container: {str(e)}")
                continue
        
        logger.info(f"✓ Parsed {song_count} songs for language: {language}")
        return song_count

    def scrape_language(self, language_slug, language_name):
        """Scrape all albums and songs for a language"""
        logger.info(f"\n{'='*60}")
        logger.info(f"STARTING SCRAPE FOR: {language_name} ({language_slug})")
        logger.info(f"{'='*60}")
        
        html = self.get_language_page(language_slug)
        if not html:
            return False
        
        # Parse albums
        album_count = self.parse_albums_from_page(html, language_name)
        
        # Parse songs
        song_count = self.parse_songs_from_page(html, language_name)
        
        logger.info(f"\n✓ COMPLETED: Found {album_count} albums and {song_count} songs")
        return True

    def save_results(self, output_file='pagalworld_language_results.json'):
        """Save scraped results to JSON file"""
        logger.info(f"\nSaving results to {output_file}")
        
        output_data = {
            'timestamp': datetime.now().isoformat(),
            'total_albums': len(self.results['albums']),
            'total_songs': len(self.results['songs']),
            'total_errors': len(self.results['errors']),
            'data': self.results
        }
        
        try:
            with open(output_file, 'w', encoding='utf-8') as f:
                json.dump(output_data, f, indent=2, ensure_ascii=False)
            logger.info(f"✓ Results saved to {output_file}")
            return True
        except Exception as e:
            logger.error(f"✗ Error saving results: {str(e)}")
            return False

    def print_summary(self):
        """Print summary of scraping results"""
        logger.info(f"\n{'='*60}")
        logger.info("SCRAPING SUMMARY")
        logger.info(f"{'='*60}")
        logger.info(f"Total Albums Found: {len(self.results['albums'])}")
        logger.info(f"Total Songs Found: {len(self.results['songs'])}")
        logger.info(f"Total Errors: {len(self.results['errors'])}")
        
        if self.results['errors']:
            logger.info("\nErrors encountered:")
            for error in self.results['errors']:
                logger.error(f"  - {error}")
        
        if self.results['albums']:
            logger.info(f"\nSample Albums (first 3):")
            for album in self.results['albums'][:3]:
                logger.info(f"  - {album['title']} [{album['language']}]")
        
        if self.results['songs']:
            logger.info(f"\nSample Songs (first 3):")
            for song in self.results['songs'][:3]:
                logger.info(f"  - {song['title']} by {song['singer']} [{song['language']}]")

def main():
    """Main function to run the scraper"""
    logger.info("\n" + "="*60)
    logger.info("PAGAL WORLD LANGUAGE-BASED SCRAPER")
    logger.info("="*60 + "\n")
    
    scraper = PagalWorldLanguageScraper()
    
    # Languages to scrape
    languages = [
        ('hindi', 'Hindi'),
        ('marathi', 'Marathi'),
        ('tamil', 'Tamil'),
        ('telugu', 'Telugu'),
        ('kannada', 'Kannada'),
        ('punjabi', 'Punjabi')
    ]
    
    logger.info(f"Starting scrape for {len(languages)} languages\n")
    
    successful = 0
    for language_slug, language_name in languages:
        try:
            if scraper.scrape_language(language_slug, language_name):
                successful += 1
            time.sleep(2)  # Rate limiting
        except Exception as e:
            logger.error(f"✗ Error scraping {language_name}: {str(e)}")
    
    # Print summary and save results
    scraper.print_summary()
    scraper.save_results()
    
    logger.info(f"\n✓ Successfully scraped {successful}/{len(languages)} languages")
    logger.info("\nLog saved to: pagalworld_language_scraper.log")
    logger.info("Results saved to: pagalworld_language_results.json")

if __name__ == '__main__':
    main()
