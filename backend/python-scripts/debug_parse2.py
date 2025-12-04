import requests
from bs4 import BeautifulSoup
import re
from urllib.parse import urljoin

url = 'https://pagalworldmusic.com/language/hindi'
headers = {'User-Agent': 'Mozilla/5.0'}

response = requests.get(url, headers=headers, timeout=10)
soup = BeautifulSoup(response.content, 'html.parser')

track_divs = soup.find_all('div', class_='track')
print(f'Found {len(track_divs)} track divs\n')

for idx, track_div in enumerate(track_divs[:3], 1):
    print(f'=== TRACK {idx} ===')
    
    link = track_div.find('a', href=True)
    if link:
        href = link.get('href')
        print(f'Link href: {href}')
        
        # Extract ID
        match = re.search(r'/(album|track)/([a-zA-Z0-9_-]+)', href)
        if match:
            item_id = match.group(2)
            print(f'ID: {item_id}')
        else:
            print('ID: NOT FOUND')
        
        # Get track-box
        track_box = track_div.find('div', class_='track-box')
        if track_box:
            print('track-box: FOUND')
            
            # Get title
            title_elem = track_box.find('h2') or track_box.find('a')
            if title_elem:
                title = title_elem.get_text(strip=True)
                print(f'Title: {title}')
            else:
                # Try track-title
                title_div = track_box.find('div', class_='track-title')
                if title_div:
                    title = title_div.get_text(strip=True)
                    print(f'Title (from track-title): {title}')
                else:
                    print('Title: NOT FOUND')
            
            # Get image
            img = track_box.find('img')
            if img:
                img_src = img.get('src') or img.get('data-src')
                print(f'Image: {img_src[:50]}')
        else:
            print('track-box: NOT FOUND')
    else:
        print('Link: NOT FOUND')
    
    print()
