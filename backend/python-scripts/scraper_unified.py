#!/usr/bin/env python3
"""
Unified Language Scraper with Complete Fields
Merges albums and songs into one dataset with all fields
Image URLs from extended scraper logic
"""

import requests
from bs4 import BeautifulSoup
import json
import time
from datetime import datetime
from urllib.parse import urljoin, urlparse
import re

class UnifiedLanguageScraper:
    def __init__(self):
        self.base_url = "https://pagalworldmusic.com"
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
        }
        self.results = {
            'timestamp': datetime.now().isoformat(),
            'language': None,
            'total_pages_scraped': 0,
            'total_albums': 0,
            'total_songs': 0,
            'total_items': 0,
            'total_errors': 0,
            'data': []  # Single unified list with all fields
        }
        self.processed_ids = set()
    
    def scrape_language(self, language, pages=1):
        """Scrape songs/albums for a specific language with complete fields"""
        self.results['language'] = language
        language_url = f"{self.base_url}/language/{language}"
        
        print(f"\n🎵 Starting Unified Language Scraper")
        print(f"   Language: {language.upper()}")
        print(f"   URL: {language_url}")
        print(f"   Pages: {pages}")
        
        for page in range(1, pages + 1):
            print(f"\n📄 Scraping Page {page}...")
            
            url = f"{language_url}?page={page}" if page > 1 else language_url
            
            try:
                response = requests.get(url, headers=self.headers, timeout=10)
                response.raise_for_status()
                soup = BeautifulSoup(response.content, 'html.parser')
                
                # Get all track divs
                track_divs = soup.find_all('div', class_='track')
                print(f"   Found {len(track_divs)} items on page {page}")
                
                if not track_divs:
                    print(f"   ⚠️ No items found. Stopping pagination.")
                    break
                
                # Process each item
                for idx, track_div in enumerate(track_divs, 1):
                    try:
                        link = track_div.find('a', href=True)
                        if not link:
                            continue
                        
                        href = link.get('href', '')
                        
                        # Get track-box element
                        track_box = track_div.find('div', class_='track-box')
                        if not track_box:
                            track_box = track_div
                        
                        # Determine type (album or song)
                        is_album = 'album' in href.lower()
                        item_type = 'album' if is_album else 'song'
                        
                        # Parse complete item with all fields
                        item_data = self.parse_complete_item(
                            track_box, href, language, item_type
                        )
                        
                        if not item_data:
                            continue
                        
                        # Check for duplicates
                        item_id = item_data.get('id')
                        if item_id in self.processed_ids:
                            continue
                        
                        self.processed_ids.add(item_id)
                        
                        # Add to results
                        self.results['data'].append(item_data)
                        self.results['total_items'] += 1
                        
                        if is_album:
                            self.results['total_albums'] += 1
                            print(f"     ✓ ALBUM [{idx}] {item_data.get('title', 'Unknown')[:40]}")
                        else:
                            self.results['total_songs'] += 1
                            print(f"     ✓ SONG  [{idx}] {item_data.get('title', 'Unknown')[:40]}")
                    
                    except Exception as e:
                        self.results['total_errors'] += 1
                        print(f"     ✗ Error processing item {idx}: {str(e)[:50]}")
                
                self.results['total_pages_scraped'] = page
                time.sleep(1)  # Rate limiting
            
            except Exception as e:
                self.results['total_errors'] += 1
                print(f"   ✗ Error scraping page {page}: {str(e)}")
                break
        
        return self.results
    
    def parse_complete_item(self, track_box, href, language, item_type):
        """Parse item with complete fields (unified)"""
        try:
            # Basic fields
            title_div = track_box.find('div', class_='track-title')
            title = title_div.get_text(strip=True) if title_div else 'Unknown'
            
            if not title:
                return None
            
            item_id = self.extract_id_from_url(href)
            if not item_id:
                return None
            
            # Get image URL (actual artwork, not placeholder)
            image_url = self.extract_image_url(track_box)
            
            # Get description/metadata
            description = self.extract_description(track_box)
            
            # Build unified item data
            item_data = {
                'type': item_type,
                'id': item_id,
                'title': title,
                'url': urljoin(self.base_url, href),
                'language': language,
                'image_url': image_url,
                'description': description,
                'source': 'language_page_unified'
            }
            
            # For songs, fetch page details
            if item_type == 'song':
                page_details = self.fetch_song_page_details(item_data['url'])
                if page_details:
                    item_data.update(page_details)
            else:
                # For albums, fetch page details
                page_details = self.fetch_album_page_details(item_data['url'])
                if page_details:
                    item_data.update(page_details)
            
            return item_data
        
        except Exception as e:
            print(f"      Error parsing item: {str(e)[:50]}")
            return None
    
    def extract_image_url(self, element):
        """Extract actual image URL (not placeholder)"""
        try:
            img = element.find('img')
            if not img:
                return None
            
            # Try data-src first (lazy loaded), then src
            img_url = img.get('data-src', '') or img.get('src', '')
            
            if not img_url or img_url == '/default.webp':
                return None
            
            # Make absolute URL
            if img_url.startswith('/'):
                img_url = urljoin(self.base_url, img_url)
            
            return img_url if img_url and 'default' not in img_url.lower() else None
        except:
            return None
    
    def extract_description(self, element):
        """Extract description/metadata from element"""
        try:
            descriptions = []
            
            # Get small-text divs
            small_texts = element.find_all('div', class_='small-text')
            for text_div in small_texts[:3]:  # First 3 items
                text = text_div.get_text(strip=True)
                if text:
                    descriptions.append(text)
            
            return ' | '.join(descriptions) if descriptions else ''
        except:
            return ''
    
    def extract_id_from_url(self, url):
        """Extract unique ID from URL"""
        try:
            match = re.search(r'/(album|track)/([a-zA-Z0-9_-]+)', url)
            if match:
                return match.group(2)
            return None
        except:
            return None
    
    def fetch_album_page_details(self, album_url):
        """Fetch complete album details from page"""
        try:
            response = requests.get(album_url, headers=self.headers, timeout=10)
            soup = BeautifulSoup(response.content, 'html.parser')
            
            details = {}
            page_text = soup.get_text(separator=' | ', strip=True)
            
            # Extract year
            year_match = re.search(r'\b(19|20)\d{2}\b', page_text)
            if year_match:
                details['year'] = int(year_match.group())
            
            # Try to extract image from page (high quality)
            img_tags = soup.find_all('img')
            for img in img_tags:
                for img_url in [img.get('data-src', ''), img.get('src', '')]:
                    if img_url and any(ext in img_url.lower() for ext in ['.jpg', '.png', '.webp']):
                        if 'logo' not in img_url.lower() and 'default' not in img_url.lower():
                            if not img_url.startswith('http'):
                                img_url = urljoin(self.base_url, img_url)
                            details['image_url_high'] = img_url
                            break
                if details.get('image_url_high'):
                    break
            
            # Extract metadata
            if 'Director' in page_text:
                director_match = re.search(r'Director[:\s|]*([^|,\n]+)', page_text)
                if director_match:
                    details['director'] = director_match.group(1).strip()
            
            if 'Music' in page_text:
                music_match = re.search(r'Music[:\s|]*([^|,\n]+)', page_text)
                if music_match:
                    details['music_director'] = music_match.group(1).strip()
            
            time.sleep(0.5)  # Rate limiting
            return details
        except:
            return {}
    
    def fetch_song_page_details(self, song_url):
        """Fetch complete song details from page"""
        try:
            response = requests.get(song_url, headers=self.headers, timeout=10)
            soup = BeautifulSoup(response.content, 'html.parser')
            
            details = {}
            page_text = soup.get_text(separator=' | ', strip=True)
            
            # Extract metadata
            patterns = {
                'singer': r'Singer[:\s|]*([^|,\n]+)',
                'artist': r'Artist[:\s|]*([^|,\n]+)',
                'album_name': r'Album[:\s|]*([^|,\n]+)',
                'music_director': r'Music[:\s|]*([^|,\n]+)',
                'duration': r'Duration[:\s|]*([^|,\n]+)',
                'year': r'Year[:\s|]*([^|,\n]+)',
            }
            
            for field, pattern in patterns.items():
                match = re.search(pattern, page_text)
                if match:
                    details[field] = match.group(1).strip()
            
            # If album_name not found, try to extract from breadcrumb or title
            if not details.get('album_name'):
                # Look for album link in page
                album_link = soup.find('a', href=re.compile(r'/album/'))
                if album_link:
                    details['album_name'] = album_link.get_text(strip=True)
                else:
                    # Try from page content or set to Unknown
                    details['album_name'] = 'Unknown'
            
            # Extract audio URL (critical!)
            download_links = soup.find_all('a', href=re.compile(r'/download\.php'))
            if download_links:
                for link in download_links:
                    href = link.get('href', '')
                    if href and 'download' in href:
                        details['audio_url'] = href
                        break
            
            # Extract high quality image
            img_tags = soup.find_all('img')
            for img in img_tags:
                for img_url in [img.get('data-src', ''), img.get('src', '')]:
                    if img_url and any(ext in img_url.lower() for ext in ['.jpg', '.png', '.webp']):
                        if 'logo' not in img_url.lower() and 'default' not in img_url.lower():
                            if not img_url.startswith('http'):
                                img_url = urljoin(self.base_url, img_url)
                            details['image_url_high'] = img_url
                            break
                if details.get('image_url_high'):
                    break
            
            time.sleep(0.5)  # Rate limiting
            return details
        except:
            return {}
    
    def save_results(self, filename=None):
        """Save unified results to JSON"""
        if not filename:
            lang = self.results['language'].lower()
            filename = f"pagalworld_{lang}_unified.json"
        
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(self.results, f, ensure_ascii=False, indent=2)
        
        print(f"\n✅ Results saved to: {filename}")
        return filename
    
    def print_summary(self):
        """Print scraping summary"""
        summary = self.results
        print("\n" + "="*70)
        print("📊 UNIFIED SCRAPING SUMMARY")
        print("="*70)
        print(f"Language: {summary['language'].upper()}")
        print(f"Pages Scraped: {summary['total_pages_scraped']}")
        print(f"Total Albums: {summary['total_albums']}")
        print(f"Total Songs: {summary['total_songs']}")
        print(f"Total Items: {summary['total_items']}")
        print(f"Errors: {summary['total_errors']}")
        print(f"Timestamp: {summary['timestamp']}")
        print("="*70 + "\n")


def main():
    """Main execution"""
    scraper = UnifiedLanguageScraper()
    
    # Scrape Hindi language, page 1 only
    scraper.scrape_language(language='hindi', pages=1)
    
    # Print summary
    scraper.print_summary()
    
    # Save results
    scraper.save_results()


if __name__ == "__main__":
    main()
