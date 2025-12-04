#!/usr/bin/env python3
"""Analyze song page structure to find audio download links"""

import requests
from bs4 import BeautifulSoup
import json
import re

url = 'https://pagalworldmusic.com/track/VphajinY-tu-meri-main-tera'
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'}

try:
    print("Fetching page...")
    response = requests.get(url, headers=headers, timeout=15)
    soup = BeautifulSoup(response.text, 'html.parser')
    
    print(f"Status: {response.status_code}")
    print(f"Page length: {len(response.text)} bytes\n")
    
    print("="*80)
    print("ANALYZING PAGE STRUCTURE")
    print("="*80)
    
    # Look for all links with download/mp3
    print("\n1. DOWNLOAD LINKS AND BUTTONS:\n")
    download_found = False
    for elem in soup.find_all(['a', 'button', 'div'], limit=100):
        text = elem.get_text(strip=True)
        href = elem.get('href', '')
        onclick = elem.get('onclick', '')
        classes = ' '.join(elem.get('class', []))
        data_attrs = {k: v for k, v in elem.attrs.items() if k.startswith('data-')}
        
        if any(x in text.lower() for x in ['download', 'play', 'mp3', 'listen', '320', '192', '128', 'audio']):
            download_found = True
            print(f"Element: <{elem.name} class='{classes}'>")
            print(f"  Text: {text[:100]}")
            if href:
                print(f"  href: {href[:150]}")
            if onclick:
                print(f"  onclick: {onclick[:150]}")
            if data_attrs:
                print(f"  data attrs: {data_attrs}")
            print()
    
    if not download_found:
        print("  No download elements found in initial scan\n")
    
    # Look for all form inputs and hidden fields
    print("\n2. FORM INPUTS AND HIDDEN FIELDS:\n")
    for input_elem in soup.find_all('input', limit=30):
        input_type = input_elem.get('type', '')
        name = input_elem.get('name', '')
        value = input_elem.get('value', '')
        if value:
            print(f"  <input type='{input_type}' name='{name}' value='{value[:80]}'")
    
    # Look for script tags with JSON data
    print("\n3. SCRIPT TAGS WITH DATA:\n")
    for script in soup.find_all('script', limit=20):
        content = script.string
        if content and ('download' in content.lower() or 'mp3' in content.lower() or 'url' in content.lower()):
            print(f"  Script found with relevant data (length: {len(content)})")
            # Try to find URLs
            urls = re.findall(r'https?://[^\s"\'><]+', content)
            if urls:
                print(f"    URLs found: {len(urls)}")
                for url_match in urls[:5]:
                    print(f"      - {url_match[:100]}")
            print()
    
    # Look for all elements with specific classes
    print("\n4. KEY ELEMENTS BY CLASS:\n")
    for target_class in ['download', 'player', 'audio', 'song', 'track', 'play-btn', 'download-btn', 'quality']:
        elems = soup.find_all(class_=target_class)
        if elems:
            print(f"  Found {len(elems)} elements with class '{target_class}'")
            for elem in elems[:2]:
                print(f"    - {elem.name}: {elem.get_text(strip=True)[:80]}")
    
    # Look for meta tags with media info
    print("\n5. META TAGS:\n")
    for meta in soup.find_all('meta'):
        name = meta.get('name', '') or meta.get('property', '')
        content = meta.get('content', '')
        if 'image' in name.lower() or 'url' in name.lower() or 'description' in name.lower():
            print(f"  {name}: {content[:100]}")
    
    # Full page text
    print("\n6. FULL PAGE TEXT (first 3000 chars):\n")
    text = soup.get_text(separator='\n', strip=True)
    print(text[:3000])
    
    # Save raw HTML for inspection
    with open('song_page_raw.html', 'w', encoding='utf-8') as f:
        f.write(response.text)
    print("\n\nRaw HTML saved to song_page_raw.html")
    
except Exception as e:
    print(f"Error: {e}")
    import traceback
    traceback.print_exc()
