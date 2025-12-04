#!/usr/bin/env python3
"""Extract all metadata from song page"""

import requests
from bs4 import BeautifulSoup
import re
import json

url = 'https://pagalworldmusic.com/track/VphajinY-tu-meri-main-tera'
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'}

response = requests.get(url, headers=headers, timeout=15)
soup = BeautifulSoup(response.text, 'html.parser')

song_data = {}

print("="*80)
print("EXTRACTING SONG METADATA")
print("="*80 + "\n")

# Method 1: Look for structured text patterns
print("METHOD 1: Text Pattern Extraction\n")

page_text = soup.get_text(separator=' | ', strip=True)

# Extract specific fields using regex
patterns = {
    'track_name': r'Track Name\s*\|\s*([^|]+)',
    'artist': r'Artist\s*\|\s*([^|]+)',
    'album': r'Album Name\s*\|\s*([^|]+)',
    'release_date': r'Release\s*\|\s*([^|]+)',
    'duration': r'Duration\s*\|\s*([^|]+)',
    'year': r'Year\s*\|\s*([^|]+)',
    'language': r'Language\s*\|\s*([^|]+)',
    'music_composer': r'Music\s*\|\s*([^|]+)',
    'label': r'Label\s*\|\s*([^|]+)',
}

for field, pattern in patterns.items():
    match = re.search(pattern, page_text)
    if match:
        value = match.group(1).strip()
        song_data[field] = value
        print(f"  {field}: {value}")

# Method 2: Extract artists list
print("\nMETHOD 2: Artists Extraction\n")
artists_section = re.search(r'Artists\s*\|\s*([^|]+)', page_text)
if artists_section:
    artists_text = artists_section.group(1)
    artists = [a.strip() for a in artists_text.split(',')]
    song_data['artists'] = artists
    print(f"  Found {len(artists)} artists:")
    for artist in artists[:5]:
        print(f"    - {artist}")

# Method 3: Download links
print("\nMETHOD 3: Download Links Extraction\n")
downloads = []
for a in soup.find_all('a'):
    text = a.get_text(strip=True)
    href = a.get('href', '')
    
    if 'download' in text.lower() and 'kbps' in text.lower():
        quality_match = re.search(r'(\d+)\s*kbps', text, re.IGNORECASE)
        quality = quality_match.group(1) + 'kbps' if quality_match else 'unknown'
        
        size_match = re.search(r'\((.*?)\)', text)
        size = size_match.group(1) if size_match else 'unknown'
        
        download_data = {
            'quality': quality,
            'size': size,
            'url': href
        }
        downloads.append(download_data)
        
        print(f"  Quality: {quality} | Size: {size}")
        print(f"  URL: {href[:100]}...\n")

song_data['downloads'] = downloads

# Method 4: Audio element
print("METHOD 4: Audio Tag\n")
audio = soup.find('audio')
if audio:
    source = audio.find('source')
    if source:
        audio_src = source.get('src', '')
        song_data['audio_src'] = audio_src
        print(f"  Found audio src: {audio_src}")
else:
    print("  No audio tag found")

# Method 5: Player information
print("\nMETHOD 5: Player Element\n")
player = soup.find('div', class_='player')
if player:
    print(f"  Player found: {player.get_text(strip=True)[:100]}")

# Method 6: Image/Artwork
print("\nMETHOD 6: Images\n")
for img in soup.find_all('img'):
    src = img.get('src', '')
    alt = img.get('alt', '')
    if src and ('song' in src.lower() or 'track' in src.lower() or 'album' in alt.lower()):
        print(f"  Image: {src[:100]}")
        song_data['image_url'] = src

# Summary
print("\n" + "="*80)
print("FINAL EXTRACTED DATA")
print("="*80)
print(json.dumps(song_data, indent=2))

# Save to file
with open('song_metadata_extracted.json', 'w', encoding='utf-8') as f:
    json.dump(song_data, f, indent=2, ensure_ascii=False)
print("\nSaved to song_metadata_extracted.json")
