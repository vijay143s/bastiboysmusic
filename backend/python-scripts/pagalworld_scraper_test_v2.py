#!/usr/bin/env python3
"""
Pagal World Language Scraper - Improved Version
Uses Selenium for JavaScript-rendered content
"""

import json
import logging
from datetime import datetime
import time
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('pagalworld_scraper_v2.log'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

class PagalWorldScraper:
    """Scraper for Pagal World music site"""
    
    def __init__(self):
        self.base_url = 'https://pagalworldmusic.com'
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
        }
        self.results = {'albums': [], 'songs': [], 'errors': []}

    def test_direct_page(self, language_slug):
        """Test fetching the language page directly"""
        logger.info(f"\n{'='*60}")
        logger.info(f"Testing {language_slug.upper()} language page")
        logger.info(f"{'='*60}")
        
        url = f'{self.base_url}/language/{language_slug}'
        logger.info(f"Fetching: {url}")
        
        try:
            response = requests.get(url, headers=self.headers, timeout=15)
            response.raise_for_status()
            logger.info(f"Status: {response.status_code}")
            
            # Save the HTML for inspection
            output_file = f'{language_slug}_page.html'
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(response.text)
            logger.info(f"HTML saved to: {output_file}")
            
            # Parse with BeautifulSoup
            soup = BeautifulSoup(response.text, 'html.parser')
            
            # Look for common content containers
            logger.info("\n--- Page Analysis ---")
            
            # Check for main content area
            main_content = soup.find('main') or soup.find('div', class_='content') or soup.find('div', id='content')
            logger.info(f"Main content found: {bool(main_content)}")
            
            # Look for any links that might be music items
            all_links = soup.find_all('a', limit=50)
            logger.info(f"Total links found: {len(all_links)}")
            
            # Filter for music-related links
            music_links = [l for l in all_links if any(keyword in l.get('href', '').lower() 
                          for keyword in ['song', 'album', 'artist', 'download', 'mp3'])]
            logger.info(f"Music-related links: {len(music_links)}")
            
            if music_links:
                logger.info("\nFirst 5 music links:")
                for link in music_links[:5]:
                    href = link.get('href', 'no-href')
                    text = link.get_text(strip=True)[:60]
                    logger.info(f"  - {text} -> {href[:80]}")
            
            # Look for divs with specific classes
            logger.info("\n--- CSS Classes Found ---")
            all_divs_with_class = soup.find_all('div', class_=True, limit=30)
            classes_found = set()
            for div in all_divs_with_class:
                classes = div.get('class', [])
                if classes:
                    classes_found.update(classes)
            
            if classes_found:
                logger.info(f"Unique CSS classes: {', '.join(sorted(list(classes_found))[:20])}")
            
            # Check for JavaScript data
            scripts = soup.find_all('script')
            logger.info(f"\nTotal scripts: {len(scripts)}")
            
            # Look for JSON data in scripts
            for script in scripts[:5]:
                content = script.string
                if content and ('json' in content.lower() or '[{' in content):
                    logger.info(f"Script contains structured data: {content[:100]}...")
            
            return True
            
        except Exception as e:
            logger.error(f"Error: {str(e)}")
            self.results['errors'].append(str(e))
            return False

def main():
    """Test scraper on multiple languages"""
    logger.info("\n" + "="*60)
    logger.info("PAGAL WORLD SCRAPER - TEST MODE")
    logger.info("="*60)
    
    scraper = PagalWorldScraper()
    
    # Test first 2 languages
    languages = ['hindi', 'marathi']
    
    for lang in languages:
        scraper.test_direct_page(lang)
        time.sleep(2)  # Rate limiting
    
    logger.info("\n" + "="*60)
    logger.info("TEST COMPLETE")
    logger.info("Check the generated HTML files to understand page structure")
    logger.info("="*60)

if __name__ == '__main__':
    main()
