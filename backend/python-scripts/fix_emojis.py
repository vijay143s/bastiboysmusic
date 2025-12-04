#!/usr/bin/env python3
import re

with open('pagalworld_incremental_scraper.py', 'r', encoding='utf-8') as f:
    content = f.read()

# Replace emojis with text
emojis = {
    '✅': '[OK]',
    '❌': '[FAIL]',
    '🚀': '[RUN]',
    '📀': '[ALBUM]',
    '🎵': '[SONG]',
    '📊': '[GEN]',
    '💾': '[EXEC]',
    '📄': '[PAGE]',
    '📥': '[INPUT]',
    '🔍': '[SEARCH]',
    '📈': '[INC]',
    '⚠️': '[WARN]',
}

for emoji, text in emojis.items():
    content = content.replace(emoji, text)

with open('pagalworld_incremental_scraper.py', 'w', encoding='utf-8') as f:
    f.write(content)

print("Emojis replaced successfully!")
