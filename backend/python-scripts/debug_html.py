import requests
from bs4 import BeautifulSoup

url = 'https://pagalworldmusic.com/language/hindi'
headers = {'User-Agent': 'Mozilla/5.0'}

response = requests.get(url, headers=headers, timeout=10)
soup = BeautifulSoup(response.content, 'html.parser')

items = soup.find_all('div', class_='track-box')
print(f'Found {len(items)} track-boxes\n')

# Print the HTML of first item
for idx, item in enumerate(items[:1], 1):
    print(f'=== ITEM {idx} HTML ===')
    print(item.prettify()[:1000])
    
# Also look for the track div
print('\n=== LOOKING FOR TRACK DIVs ===')
tracks = soup.find_all('div', class_='track')
print(f'Found {len(tracks)} track divs')

for idx, track in enumerate(tracks[:1], 1):
    print(f'\n=== TRACK {idx} HTML ===')
    print(track.prettify()[:1000])

# Look at parent structure
print('\n=== PARENT STRUCTURE ===')
first_track_box = items[0]
parent = first_track_box.parent
print(f'Parent: {parent.name}, class: {parent.get("class")}')
print(f'Parent HTML:\n{parent.prettify()[:800]}')
