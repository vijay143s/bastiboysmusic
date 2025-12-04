#!/usr/bin/env python3
"""Debug script to check what's on album pages"""

import requests
from bs4 import BeautifulSoup

BASE_URL = "https://pagalworldmusic.com"

# Fetch a sample album page
album_url = "https://pagalworldmusic.com/album/De-De-Pyaar-De-2-Deluxe-Album-4578106"

session = requests.Session()
session.headers.update({'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'})

response = session.get(album_url, timeout=30)
soup = BeautifulSoup(response.content, 'html.parser')

print(f"URL: {album_url}\n")
print("="*70)

# Print all text content
text_content = soup.get_text()
print("Page text (first 2000 chars):")
print(text_content[:2000])

print("\n" + "="*70)
print("Looking for common metadata patterns...\n")

# Find all elements with text that might contain metadata
for elem in soup.find_all(['div', 'p', 'span']):
    text = elem.get_text(strip=True)
    if any(keyword in text.lower() for keyword in ['year', 'director', 'music', 'singer', 'cast', 'actor', '20']):
        print(f"[{elem.name}] {text[:100]}")

print("\n" + "="*70)
print("All divs with class names:")
for div in soup.find_all('div'):
    if div.get('class'):
        print(f"  {div.get('class')}")
