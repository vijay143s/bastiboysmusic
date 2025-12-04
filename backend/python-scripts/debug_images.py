#!/usr/bin/env python3
"""Debug image extraction from song page"""

import requests
from bs4 import BeautifulSoup

url = 'https://pagalworldmusic.com/track/VphajinY-tu-meri-main-tera'
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'}

response = requests.get(url, headers=headers, timeout=15)
soup = BeautifulSoup(response.text, 'html.parser')

print("="*80)
print("IMAGE EXTRACTION DEBUG")
print("="*80 + "\n")

# Find all img tags
print("ALL IMG TAGS FOUND:\n")
img_tags = soup.find_all('img')
for i, img in enumerate(img_tags[:20]):
    src = img.get('src', '')
    data_src = img.get('data-src', '')
    alt = img.get('alt', '')
    classes = ' '.join(img.get('class', []))
    
    print(f"{i+1}. IMG TAG")
    print(f"   src: {src[:100]}")
    print(f"   data-src: {data_src[:100]}")
    print(f"   alt: {alt[:80]}")
    print(f"   class: {classes[:80]}")
    print()

# Check for picture tags
print("\nPICTURE TAGS FOUND:\n")
picture_tags = soup.find_all('picture')
for i, pic in enumerate(picture_tags[:5]):
    print(f"{i+1}. PICTURE TAG")
    img = pic.find('img')
    if img:
        print(f"   src: {img.get('src', '')[:100]}")
        print(f"   data-src: {img.get('data-src', '')[:100]}")
    sources = pic.find_all('source')
    for src in sources:
        print(f"   source srcset: {src.get('srcset', '')[:100]}")
    print()

# Check meta tags for images
print("\nMETA TAGS WITH IMAGE:\n")
meta_tags = soup.find_all('meta', attrs={'property': lambda x: x and 'image' in x.lower()})
for meta in meta_tags:
    prop = meta.get('property', '')
    content = meta.get('content', '')
    print(f"{prop}: {content}")

# Check for background images
print("\nSTYLE ATTRIBUTES WITH IMAGES:\n")
elements_with_bg = soup.find_all(style=lambda x: x and 'background' in x.lower())
for i, elem in enumerate(elements_with_bg[:5]):
    style = elem.get('style', '')
    if 'image' in style.lower() or 'url' in style.lower():
        print(f"{i+1}. {elem.name}: {style[:150]}")

# Search for album/track cover specifically
print("\nLOOKING FOR ALBUM/TRACK COVER:\n")
for img in soup.find_all('img'):
    alt = img.get('alt', '').lower()
    classes = ' '.join(img.get('class', [])).lower()
    src = img.get('src', '').lower()
    
    if any(x in alt for x in ['album', 'cover', 'artwork', 'track', 'song', 'image']):
        print(f"FOUND: {img.get('alt', '')}")
        print(f"  src: {img.get('src', '')[:120]}")
        print(f"  data-src: {img.get('data-src', '')[:120]}")
        print()

# Check inside specific containers
print("\nCHECKING .headinfo CONTAINER:\n")
headinfo = soup.find('div', class_='headinfo')
if headinfo:
    print("Found headinfo container")
    img_in_headinfo = headinfo.find('img')
    if img_in_headinfo:
        print(f"  Image found:")
        print(f"    src: {img_in_headinfo.get('src', '')[:120]}")
        print(f"    data-src: {img_in_headinfo.get('data-src', '')[:120]}")

# Save HTML for inspection
with open('song_page_images.html', 'w', encoding='utf-8') as f:
    f.write(response.text)
print("\nRaw HTML saved to song_page_images.html")
