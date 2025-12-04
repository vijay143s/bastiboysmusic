#!/usr/bin/env python3
"""
Pagal World Language Scraper - Working Version
Scrapes albums and songs by language category
"""

import requests
import json
import time
import logging
from datetime import datetime
from bs4 import BeautifulSoup
from urllib.parse import urljoin

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('pagalworld_language_scraper.log'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

class PagalWorldLanguageScraper:
    """Scrapes Pagal World by language category"""
    
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
            logger.info(f"✓ Status: {response.status_code}")
            
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
                        # Try to get from track-title
                        title_elem = track_box.find('div', class_='track-title')
                        if title_elem:
                            title = title_elem.get_text(strip=True)
                    
                    if not title or not href:
                        continue
                    
                    # Check if this is an album link
                    if '/album/' in href:
                        # It's an album
                        album_data = {
                            'type': 'album',
                            'title': title,
                            'url': urljoin(self.base_url, href),
                            'slug': href.split('/')[-1],
                            'language': language_name,
                            'scrape_timestamp': datetime.now().isoformat()
                        }
                        
                        # Try to get image
                        img = track_box.find('img')
                        if img:
                            album_data['image'] = img.get('src', '')
                        
                        # Try to get song count
                        info_text = track_box.get_text()
                        if 'Total songs' in info_text:
                            try:
                                songs_part = info_text.split('Total songs')[1].split('=')[1].strip()
                                album_data['song_count'] = int(songs_part.split()[0])
                            except:
                                pass
                        
                        self.results['albums'].append(album_data)
                        album_count += 1
                        logger.info(f"  ✓ Album: {title[:50]}")
                    
                    elif '/song/' in href or '/track/' in href:
                        # It's a song
                        song_data = {
                            'type': 'song',
                            'title': title,
                            'url': urljoin(self.base_url, href),
                            'slug': href.split('/')[-1],
                            'language': language_name,
                            'scrape_timestamp': datetime.now().isoformat()
                        }
                        
                        # Try to get image
                        img = track_box.find('img')
                        if img:
                            song_data['image'] = img.get('src', '')
                        
                        # Try to get artist/singer info
                        artist_elem = track_box.find('span', class_='artist')
                        if artist_elem:
                            song_data['artist'] = artist_elem.get_text(strip=True)
                        
                        self.results['songs'].append(song_data)
                        song_count += 1
                        logger.info(f"  ✓ Song: {title[:50]}")
                
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

    def save_results(self, output_file='pagalworld_language_results.json'):
        """Save results to JSON"""
        logger.info(f"\nSaving results to {output_file}...")
        
        output_data = {
            'timestamp': datetime.now().isoformat(),
            'summary': {
                'total_albums': len(self.results['albums']),
                'total_songs': len(self.results['songs']),
                'total_errors': len(self.results['errors'])
            },
            'data': self.results
        }
        
        try:
            with open(output_file, 'w', encoding='utf-8') as f:
                json.dump(output_data, f, indent=2, ensure_ascii=False)
            logger.info(f"✓ Results saved to {output_file}")
            return True
        except Exception as e:
            logger.error(f"Error saving results: {str(e)}")
            return False

    def print_summary(self):
        """Print final summary"""
        logger.info(f"\n{'='*70}")
        logger.info("FINAL SUMMARY")
        logger.info(f"{'='*70}")
        logger.info(f"Total Albums Found: {len(self.results['albums'])}")
        logger.info(f"Total Songs Found: {len(self.results['songs'])}")
        logger.info(f"Total Errors: {len(self.results['errors'])}")
        
        if self.results['albums']:
            logger.info(f"\nSample Albums (first 3):")
            for album in self.results['albums'][:3]:
                logger.info(f"  - {album['title']} [{album['language']}]")
        
        if self.results['songs']:
            logger.info(f"\nSample Songs (first 3):")
            for song in self.results['songs'][:3]:
                artist = song.get('artist', 'Unknown')
                logger.info(f"  - {song['title']} by {artist} [{song['language']}]")
        
        logger.info(f"{'='*70}\n")

def main():
    """Main execution"""
    logger.info("\n" + "="*70)
    logger.info("PAGAL WORLD LANGUAGE-BASED SCRAPER")
    logger.info("="*70 + "\n")
    
    scraper = PagalWorldLanguageScraper()
    
    # Languages to scrape
    languages = [
        ('hindi', 'Hindi'),
        ('marathi', 'Marathi'),
        ('tamil', 'Tamil'),
        ('telugu', 'Telugu'),
        ('kannada', 'Kannada'),
        ('punjabi', 'Punjabi'),
        ('gujarati', 'Gujarati'),
        ('bengali', 'Bengali')
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
    
    logger.info(f"\nLog file: pagalworld_language_scraper.log")
    logger.info(f"Results file: pagalworld_language_results.json")

if __name__ == '__main__':
    main()
