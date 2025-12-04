#!/usr/bin/env python3
"""
Quick test runner for Pagal World Language Scraper
Run this to test the scraper locally and see logs
"""

import sys
import os

# Add backend directory to path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

if __name__ == '__main__':
    from pagalworld_language_scraper import main
    main()
