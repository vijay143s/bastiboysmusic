#!/usr/bin/env python3
"""
Pagal World Language-wise Scraper with Pagination Support
Scrapes songs/albums by language and handles multiple pages
"""

import requests
from bs4 import BeautifulSoup
import json
import time
from datetime import datetime
from urllib.parse import urljoin, urlparse
import re

class PagalWorldLanguageScraper:
    def __init__(self):
        self.base_url = "https://pagalworldmusic.com"
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        }
        self.results = {
            'timestamp': datetime.now().isoformat(),
            'language': None,
            'total_pages_scraped': 0,
            'total_albums': 0,
            'total_songs': 0,
            'total_errors': 0,
            'data': {
                'albums': [],
                'songs': []
            }
        }
        self.processed_ids = set()
    
    def scrape_language(self, language, pages=1, item_type=None):
        """
        Scrape songs/albums for a specific language
        
        Args:
            language: Language name (e.g., 'hindi', 'punjabi', 'tamil', 'telugu')
            pages: Number of pages to scrape (default: 1)
            item_type: 'songs', 'albums', or None (both)
        """
        self.results['language'] = language
        language_url = f"{self.base_url}/language/{language}"
        
        print(f"\n🎵 Starting Language Scraper")
        print(f"   Language: {language.upper()}")
        print(f"   URL: {language_url}")
        print(f"   Pages: {pages}")
        print(f"   Item Type: {item_type or 'All (Albums + Songs)'}")
        
        for page in range(1, pages + 1):
            print(f"\n📄 Scraping Page {page}...")
            
            # Add page parameter if page > 1
            url = f"{language_url}?page={page}" if page > 1 else language_url
            
            try:
                response = requests.get(url, headers=self.headers, timeout=10)
                response.raise_for_status()
                
                soup = BeautifulSoup(response.content, 'html.parser')
                
                # Get all track divs (parent of track-box)
                track_divs = soup.find_all('div', class_='track')
                print(f"   Found {len(track_divs)} items on page {page}")
                
                if not track_divs:
                    print(f"   ⚠️  No items found. Stopping pagination.")
                    break
                
                # Process each item
                for idx, track_div in enumerate(track_divs, 1):
                    try:
                        # The link is the parent of track-box
                        link = track_div.find('a', href=True)
                        if not link:
                            continue
                        
                        href = link.get('href', '')
                        
                        # Skip if not album or track
                        if 'album' not in href.lower() and 'track' not in href.lower():
                            continue
                        
                        # Parse the track-box inside the link
                        track_box = track_div.find('div', class_='track-box')
                        if not track_box:
                            track_box = track_div
                        
                        item_data = self.parse_item(track_box, href, language)
                        
                        if not item_data:
                            continue
                        
                        # Skip if already processed
                        item_id = item_data.get('id')
                        if item_id in self.processed_ids:
                            continue
                        
                        self.processed_ids.add(item_id)
                        
                        # Classify and store
                        if 'album' in href.lower():
                            if item_type != 'songs':
                                self.results['data']['albums'].append(item_data)
                                self.results['total_albums'] += 1
                                print(f"     ✓ ALBUM [{idx}] {item_data.get('title', 'Unknown')[:40]}")
                        elif 'track' in href.lower():
                            if item_type != 'albums':
                                self.results['data']['songs'].append(item_data)
                                self.results['total_songs'] += 1
                                print(f"     ✓ SONG  [{idx}] {item_data.get('title', 'Unknown')[:40]}")
                    
                    except Exception as e:
                        self.results['total_errors'] += 1
                        print(f"     ✗ Error processing item {idx}: {str(e)[:50]}")
                
                self.results['total_pages_scraped'] = page
                time.sleep(1)  # Be respectful to the server
            
            except Exception as e:
                self.results['total_errors'] += 1
                print(f"   ✗ Error scraping page {page}: {str(e)}")
                break
        
        return self.results
    
    def parse_item(self, item, href, language):
        """Parse individual song/album item"""
        try:
            # Get title - try multiple sources
            title = None
            
            # Try track-title div
            title_elem = item.find('div', class_='track-title')
            if title_elem:
                title = title_elem.get_text(strip=True)
            
            # Fallback to h2
            if not title:
                title_elem = item.find('h2')
                if title_elem:
                    title = title_elem.get_text(strip=True)
            
            # Fallback to first a tag
            if not title:
                title_elem = item.find('a')
                if title_elem:
                    title = title_elem.get_text(strip=True)
            
            if not title:
                return None
            
            # Extract ID from URL
            item_id = self.extract_id_from_url(href)
            if not item_id:
                return None
            
            # Get image
            img = item.find('img')
            image_url = None
            if img:
                img_src = img.get('src', '') or img.get('data-src', '')
                if img_src and img_src != '/default.webp':
                    image_url = urljoin(self.base_url, img_src) if not img_src.startswith('http') else img_src
            
            # Get description/artist info
            description = ""
            desc_elem = item.find('p')
            if desc_elem:
                description = desc_elem.get_text(strip=True)
            else:
                # Try small-text divs
                small_texts = item.find_all('div', class_='small-text')
                if small_texts:
                    description = ' | '.join([t.get_text(strip=True) for t in small_texts[:2]])
            
            # Build item data
            item_data = {
                'type': 'album' if 'album' in href else 'song',
                'id': item_id,
                'title': title,
                'url': urljoin(self.base_url, href),
                'image_url': image_url,
                'language': language,
                'description': description,
                'source': 'language_page'
            }
            
            return item_data
        
        except Exception as e:
            print(f"      Error parsing item: {str(e)[:50]}")
            return None
    
    def extract_id_from_url(self, url):
        """Extract unique ID from URL"""
        try:
            # For album: /album/XXXXX/name
            # For track: /track/XXXXX-name
            match = re.search(r'/(album|track)/([a-zA-Z0-9_-]+)', url)
            if match:
                return match.group(2)
            return None
        except:
            return None
    
    def fetch_full_details(self):
        """Fetch full details for each item (optional, can be heavy)"""
        print(f"\n📥 Fetching full details...")
        
        # For albums
        for idx, album in enumerate(self.results['data']['albums'], 1):
            try:
                details = self.scrape_album_details(album['url'])
                album.update(details)
                print(f"   ✓ Album {idx}: {album['title'][:40]}")
            except Exception as e:
                print(f"   ✗ Album {idx} error: {str(e)[:40]}")
        
        # For songs
        for idx, song in enumerate(self.results['data']['songs'], 1):
            try:
                details = self.scrape_song_details(song['url'])
                song.update(details)
                print(f"   ✓ Song {idx}: {song['title'][:40]}")
            except Exception as e:
                print(f"   ✗ Song {idx} error: {str(e)[:40]}")
    
    def scrape_album_details(self, album_url):
        """Scrape full album details"""
        try:
            response = requests.get(album_url, headers=self.headers, timeout=10)
            soup = BeautifulSoup(response.content, 'html.parser')
            
            details = {
                'year': None,
                'director': None,
                'music_director': None,
                'star_cast': None,
            }
            
            # Extract metadata from page
            info_section = soup.find('div', class_='album-info') or soup.find('div', class_='info')
            if info_section:
                text = info_section.get_text()
                
                # Try to extract year
                year_match = re.search(r'\b(19|20)\d{2}\b', text)
                if year_match:
                    details['year'] = int(year_match.group())
            
            time.sleep(0.5)
            return details
        except:
            return {}
    
    def scrape_song_details(self, song_url):
        """Scrape full song details"""
        try:
            response = requests.get(song_url, headers=self.headers, timeout=10)
            soup = BeautifulSoup(response.content, 'html.parser')
            
            details = {
                'singer': None,
                'artist': None,
                'audio_url': None,
                'duration': None,
            }
            
            # Extract audio URL
            audio_link = soup.find('a', href=re.compile(r'/download\.php'))
            if audio_link:
                details['audio_url'] = audio_link.get('href')
            
            time.sleep(0.5)
            return details
        except:
            return {}
    
    def save_results(self, filename=None):
        """Save results to JSON file"""
        if not filename:
            lang = self.results['language'].lower()
            filename = f"pagalworld_{lang}_results.json"
        
        filepath = filename
        
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(self.results, f, ensure_ascii=False, indent=2)
        
        print(f"\n✅ Results saved to: {filepath}")
        return filepath
    
    def print_summary(self):
        """Print scraping summary"""
        summary = self.results
        print("\n" + "="*60)
        print("📊 SCRAPING SUMMARY")
        print("="*60)
        print(f"Language: {summary['language'].upper()}")
        print(f"Pages Scraped: {summary['total_pages_scraped']}")
        print(f"Total Albums: {summary['total_albums']}")
        print(f"Total Songs: {summary['total_songs']}")
        print(f"Total Items: {summary['total_albums'] + summary['total_songs']}")
        print(f"Errors: {summary['total_errors']}")
        print(f"Timestamp: {summary['timestamp']}")
        print("="*60 + "\n")


def main():
    """Main execution"""
    scraper = PagalWorldLanguageScraper()
    
    # Scrape Hindi language, page 1 only
    scraper.scrape_language(
        language='hindi',
        pages=1,
        item_type=None  # None = both albums and songs
    )
    
    # Print summary
    scraper.print_summary()
    
    # Save results
    scraper.save_results()


if __name__ == "__main__":
    main()
