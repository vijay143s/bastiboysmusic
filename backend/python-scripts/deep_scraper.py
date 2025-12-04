#!/usr/bin/env python3
"""
Pagal World Deep Scraper - Unified Complete Data Extraction
Scrapes language pages, then goes INTO each album/song to extract full details
"""

import requests
from bs4 import BeautifulSoup
import json
import time
from datetime import datetime
from urllib.parse import urljoin, urlparse
import re
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class PagalWorldDeepScraper:
    def __init__(self):
        self.base_url = "https://pagalworldmusic.com"
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
        }
        self.results = {
            'timestamp': datetime.now().isoformat(),
            'language': None,
            'total_items': 0,
            'total_errors': 0,
            'data': []  # Unified array of complete items
        }
        self.processed_ids = set()
    
    def scrape_language(self, language, pages=1):
        """Scrape language page and go deep into each item"""
        self.results['language'] = language
        language_url = f"{self.base_url}/language/{language}"
        
        print(f"\n{'='*70}")
        print(f"🎵 DEEP SCRAPING: {language.upper()}")
        print(f"{'='*70}\n")
        
        for page in range(1, pages + 1):
            print(f"📄 Page {page}...")
            url = f"{language_url}?page={page}" if page > 1 else language_url
            
            try:
                response = requests.get(url, self.headers, timeout=10)
                soup = BeautifulSoup(response.content, 'html.parser')
                
                # Find all track items
                track_divs = soup.find_all('div', class_='track')
                print(f"   Found {len(track_divs)} items\n")
                
                if not track_divs:
                    break
                
                for idx, track_div in enumerate(track_divs, 1):
                    try:
                        link = track_div.find('a', href=True)
                        if not link:
                            continue
                        
                        href = link.get('href', '')
                        item_url = urljoin(self.base_url, href)
                        
                        # Determine type and scrape details
                        if 'album' in href:
                            print(f"   [{idx}] ALBUM: ", end='')
                            item_data = self.scrape_album_deep(item_url, language)
                        elif 'track' in href:
                            print(f"   [{idx}] SONG: ", end='')
                            item_data = self.scrape_song_deep(item_url, language)
                        else:
                            continue
                        
                        if item_data:
                            item_id = item_data.get('id')
                            if item_id not in self.processed_ids:
                                self.processed_ids.add(item_id)
                                self.results['data'].append(item_data)
                                self.results['total_items'] += 1
                                print(f"✓ {item_data.get('title', 'Unknown')[:50]}")
                            else:
                                print(f"(duplicate)")
                        else:
                            print(f"✗ Failed to scrape")
                    
                    except Exception as e:
                        self.results['total_errors'] += 1
                        print(f"   Error: {str(e)[:40]}")
                
                time.sleep(1)
            
            except Exception as e:
                self.results['total_errors'] += 1
                print(f"   Page error: {e}")
                break
        
        return self.results
    
    def scrape_album_deep(self, album_url, language):
        """Go INTO album page and extract complete details"""
        try:
            response = requests.get(album_url, self.headers, timeout=10)
            soup = BeautifulSoup(response.content, 'html.parser')
            
            # Extract ID from URL
            match = re.search(r'/album/([a-zA-Z0-9_-]+)', album_url)
            album_id = match.group(1) if match else None
            
            if not album_id:
                return None
            
            # Get title
            title_elem = soup.find('h1') or soup.find('h2')
            title = title_elem.get_text(strip=True) if title_elem else 'Unknown'
            
            # Get image URL
            image_url = self.extract_image_url(soup)
            
            # Get metadata
            metadata = self.extract_album_metadata(soup)
            
            # Get description
            description = self.extract_description(soup)
            
            album_data = {
                'type': 'album',
                'id': album_id,
                'title': title,
                'url': album_url,
                'language': language,
                'image_url': image_url,
                'year': metadata.get('year'),
                'director': metadata.get('director'),
                'music_director': metadata.get('music_director'),
                'star_cast': metadata.get('star_cast'),
                'description': description,
                'source': 'album_page'
            }
            
            return album_data
        
        except Exception as e:
            logger.error(f"Album scrape error: {e}")
            return None
    
    def scrape_song_deep(self, song_url, language):
        """Go INTO song page and extract complete details"""
        try:
            response = requests.get(song_url, self.headers, timeout=10)
            soup = BeautifulSoup(response.content, 'html.parser')
            
            # Extract ID from URL
            match = re.search(r'/track/([a-zA-Z0-9_-]+)', song_url)
            song_id = match.group(1) if match else None
            
            if not song_id:
                return None
            
            # Get title
            title_elem = soup.find('h1') or soup.find('h2')
            title = title_elem.get_text(strip=True) if title_elem else 'Unknown'
            
            # Get image URL
            image_url = self.extract_image_url(soup)
            
            # Extract song details
            song_metadata = self.extract_song_metadata(soup)
            
            # Extract audio URL (proper full URL)
            audio_url = self.extract_audio_url(soup)
            
            # Extract album name from song page
            album_name = self.extract_album_name(soup)
            
            song_data = {
                'type': 'song',
                'id': song_id,
                'title': title,
                'url': song_url,
                'language': language,
                'image_url': image_url,
                'album_name': album_name,
                'singer': song_metadata.get('singer'),
                'artist': song_metadata.get('artist'),
                'music_composer': song_metadata.get('music_composer'),
                'label': song_metadata.get('label'),
                'duration': song_metadata.get('duration'),
                'year': song_metadata.get('year'),
                'audio_url': audio_url,
                'description': song_metadata.get('description'),
                'source': 'song_page'
            }
            
            return song_data
        
        except Exception as e:
            logger.error(f"Song scrape error: {e}")
            return None
    
    def extract_image_url(self, soup):
        """Extract actual image URL from page"""
        try:
            # Look for meta og:image first
            og_image = soup.find('meta', property='og:image')
            if og_image and og_image.get('content'):
                url = og_image.get('content')
                if 'downloads/cover' in url or url.endswith(('.jpg', '.png', '.webp')):
                    return url
            
            # Look for main image
            img = soup.find('img', class_=lambda x: x and 'image' in str(x).lower())
            if img:
                img_src = img.get('src', '') or img.get('data-src', '')
                if img_src and 'downloads/cover' in img_src:
                    if not img_src.startswith('http'):
                        return urljoin(self.base_url, img_src)
                    return img_src
            
            # Look for any image with .jpg extension
            all_imgs = soup.find_all('img')
            for img in all_imgs:
                img_src = img.get('src', '') or img.get('data-src', '')
                if img_src and ('downloads/cover' in img_src or img_src.endswith(('.jpg', '.png', '.webp'))):
                    if 'default' not in img_src.lower() and 'logo' not in img_src.lower():
                        if not img_src.startswith('http'):
                            return urljoin(self.base_url, img_src)
                        return img_src
            
            return None
        except:
            return None
    
    def extract_audio_url(self, soup):
        """Extract complete audio URL with domain"""
        try:
            # Find download link
            download_link = soup.find('a', href=re.compile(r'/download\.php'))
            if download_link:
                href = download_link.get('href', '')
                # Make it absolute URL
                if href.startswith('/'):
                    return urljoin(self.base_url, href)
                return href
            
            return None
        except:
            return None
    
    def extract_album_metadata(self, soup):
        """Extract album metadata (year, director, etc.)"""
        metadata = {
            'year': None,
            'director': None,
            'music_director': None,
            'star_cast': None
        }
        
        try:
            # Look for info sections
            info_text = soup.get_text()
            
            # Extract year
            year_match = re.search(r'\b(19|20)\d{2}\b', info_text)
            if year_match:
                metadata['year'] = int(year_match.group())
            
            # Look for specific sections
            sections = soup.find_all(['div', 'p', 'span'])
            for section in sections:
                text = section.get_text(strip=True)
                
                if 'Director' in text or 'director' in text:
                    metadata['director'] = text.split(':')[-1].strip()[:100]
                
                if 'Music Director' in text or 'music director' in text:
                    metadata['music_director'] = text.split(':')[-1].strip()[:100]
                
                if 'Star Cast' in text or 'star cast' in text:
                    metadata['star_cast'] = text.split(':')[-1].strip()[:200]
        
        except:
            pass
        
        return metadata
    
    def extract_song_metadata(self, soup):
        """Extract song metadata (singer, artist, duration, etc.)"""
        metadata = {
            'singer': None,
            'artist': None,
            'music_composer': None,
            'label': None,
            'duration': None,
            'year': None,
            'description': None
        }
        
        try:
            # Get page text for searching
            text = soup.get_text()
            
            # Look for duration (HH:MM format)
            duration_match = re.search(r'\b\d{1,2}:\d{2}\b', text)
            if duration_match:
                metadata['duration'] = duration_match.group()
            
            # Extract year
            year_match = re.search(r'\b(19|20)\d{2}\b', text)
            if year_match:
                metadata['year'] = int(year_match.group())
            
            # Look for metadata sections
            info_sections = soup.find_all(['div', 'p'])
            for section in info_sections:
                section_text = section.get_text(strip=True)
                
                # Look for Singer
                if 'Singer' in section_text or 'singer' in section_text:
                    parts = section_text.split(':')
                    if len(parts) > 1:
                        metadata['singer'] = parts[-1].strip()[:100]
                
                # Look for Artist
                if 'Artist' in section_text or 'artist' in section_text:
                    parts = section_text.split(':')
                    if len(parts) > 1:
                        metadata['artist'] = parts[-1].strip()[:100]
                
                # Look for Music Composer
                if 'Composer' in section_text or 'composer' in section_text:
                    parts = section_text.split(':')
                    if len(parts) > 1:
                        metadata['music_composer'] = parts[-1].strip()[:100]
                
                # Look for Label
                if 'Label' in section_text or 'label' in section_text:
                    parts = section_text.split(':')
                    if len(parts) > 1:
                        metadata['label'] = parts[-1].strip()[:100]
            
            # Get description
            desc_elem = soup.find('p', class_='description') or soup.find('div', class_='description')
            if desc_elem:
                metadata['description'] = desc_elem.get_text(strip=True)[:500]
        
        except:
            pass
        
        return metadata
    
    def extract_description(self, soup):
        """Extract general description"""
        try:
            desc = soup.find('p', class_='description')
            if desc:
                return desc.get_text(strip=True)[:500]
            
            # Look for any description
            desc = soup.find('meta', {'name': 'description'})
            if desc:
                return desc.get('content', '')[:500]
            
            return None
        except:
            return None
    
    def extract_album_name(self, soup):
        """Extract album name from song page"""
        try:
            # Look for album link on song page
            album_link = soup.find('a', href=re.compile(r'/album/'))
            if album_link:
                return album_link.get_text(strip=True)
            
            # Look in text
            text = soup.get_text()
            
            # Search for "From [AlbumName]" pattern
            match = re.search(r'From\s+([^-\n]+?)(?:\s*-|$)', text)
            if match:
                return match.group(1).strip()
            
            return None
        except:
            return None
    
    def save_results(self, filename=None):
        """Save results to JSON"""
        if not filename:
            lang = self.results['language'].lower()
            filename = f"pagalworld_deep_{lang}_results.json"
        
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(self.results, f, ensure_ascii=False, indent=2)
        
        print(f"\n✅ Results saved to: {filename}")
        return filename
    
    def print_summary(self):
        """Print summary"""
        print(f"\n{'='*70}")
        print(f"📊 DEEP SCRAPING SUMMARY")
        print(f"{'='*70}")
        print(f"Language: {self.results['language'].upper()}")
        print(f"Total Items: {self.results['total_items']}")
        print(f"Errors: {self.results['total_errors']}")
        print(f"Timestamp: {self.results['timestamp']}")
        print(f"{'='*70}\n")


def main():
    scraper = PagalWorldDeepScraper()
    
    # Scrape Hindi language, page 1 only
    scraper.scrape_language(language='hindi', pages=1)
    
    # Print summary
    scraper.print_summary()
    
    # Save results
    scraper.save_results()


if __name__ == "__main__":
    main()
