import requests
from bs4 import BeautifulSoup

url = 'https://pagalworldmusic.com/language/hindi'
headers = {'User-Agent': 'Mozilla/5.0'}

try:
    response = requests.get(url, headers=headers, timeout=10)
    soup = BeautifulSoup(response.content, 'html.parser')
    
    print('=== SEARCHING FOR ITEMS ===')
    
    # Try track-box
    items = soup.find_all('div', class_='track-box')
    print(f'track-box found: {len(items)}')
    
    # Try album-item or song-item
    items = soup.find_all('div', class_='album-item')
    print(f'album-item found: {len(items)}')
    
    items = soup.find_all('div', class_='song-item')
    print(f'song-item found: {len(items)}')
    
    # Check for all divs with classes
    all_divs = soup.find_all('div', class_=True)
    class_patterns = {}
    for div in all_divs[:100]:
        classes = str(div.get('class'))
        if classes not in class_patterns:
            class_patterns[classes] = 0
        class_patterns[classes] += 1
    
    print(f'\nTop 10 div classes:')
    for cls, count in sorted(class_patterns.items(), key=lambda x: x[1], reverse=True)[:10]:
        print(f'  {cls}: {count}')
    
    # Find any links
    links = soup.find_all('a', href=True)
    album_links = [l.get('href') for l in links if 'album' in l.get('href', '')]
    track_links = [l.get('href') for l in links if 'track' in l.get('href', '')]
    
    print(f'\nAlbum links found: {len(album_links)}')
    if album_links:
        print(f'  Sample: {album_links[0]}')
    
    print(f'Track links found: {len(track_links)}')
    if track_links:
        print(f'  Sample: {track_links[0]}')
except Exception as e:
    print(f'Error: {e}')
