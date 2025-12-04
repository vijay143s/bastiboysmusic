import requests
from bs4 import BeautifulSoup
import re
from urllib.parse import urljoin

url = 'https://pagalworldmusic.com/language/hindi'
headers = {'User-Agent': 'Mozilla/5.0'}

response = requests.get(url, headers=headers, timeout=10)
soup = BeautifulSoup(response.content, 'html.parser')

items = soup.find_all('div', class_='track-box')
print(f'Found {len(items)} track-boxes\n')

for idx, item in enumerate(items[:3], 1):
    print(f'=== ITEM {idx} ===')
    
    # Find all links
    links = item.find_all('a', href=True)
    print(f'Links found: {len(links)}')
    
    for link in links:
        href = link.get('href')
        print(f'  href: {href}')
        
        # Check if album or track
        if 'album' in href.lower():
            print(f'  -> IS ALBUM')
        elif 'track' in href.lower():
            print(f'  -> IS TRACK')
        else:
            print(f'  -> OTHER')
    
    # Get title
    title_elem = item.find('h2') or item.find('a')
    if title_elem:
        print(f'Title: {title_elem.get_text(strip=True)[:50]}')
    
    # Get image
    img = item.find('img')
    if img:
        img_src = img.get('src', '') or img.get('data-src', '')
        print(f'Image: {img_src[:50]}')
    
    print()
