import os
import shutil
import glob

# Configuration
SOURCE_DIR = r"d:\VinayKumar\bastiboysmusic"
DOCS_DIR = os.path.join(SOURCE_DIR, "docs")
ARCHIVE_DIR = os.path.join(DOCS_DIR, "archive")
SYSTEM_DOC_PATH = os.path.join(DOCS_DIR, "SYSTEM_DOCUMENTATION.md")
HISTORY_DOC_PATH = os.path.join(DOCS_DIR, "PROJECT_HISTORY.md")

# Ensure directories exist
os.makedirs(ARCHIVE_DIR, exist_ok=True)

# File Categories
system_keywords = [
    "GUIDE", "DOC", "README", "START", "HOW", "API", "SCHEMA", "STRUCTURE", 
    "IMPLEMENTATION", "INTEGRATION", "QUICK", "SCRAPER", "REQUIREMENTS",
    "SECTIONS", "LAYOUT", "OPTIMIZATION", "TRACKING"
]
history_keywords = [
    "SUMMARY", "FIX", "CHANGES", "UPDATE", "LOG", "CHECKLIST", "ERRORS",
    "ANALYSIS", "RESULTS", "COMPLETE", "READY"
]

def is_test_file(filename):
    return "TEST" in filename.upper()

def get_category(filename):
    upper_name = filename.upper()
    if is_test_file(upper_name):
        return "TEST"
    
    # Priority to history if it looks like a one-time event report
    for kw in history_keywords:
        if kw in upper_name:
            return "HISTORY"
            
    for kw in system_keywords:
        if kw in upper_name:
            return "SYSTEM"
            
    return "SYSTEM" # Default to system for unidentified knowledge

def process_files():
    # Initialize output files
    with open(SYSTEM_DOC_PATH, 'w', encoding='utf-8') as f:
        f.write("# System Documentation\n\nCombined documentation for the project.\n\n")
        
    with open(HISTORY_DOC_PATH, 'w', encoding='utf-8') as f:
        f.write("# Project History & Changelogs\n\nRecord of changes, fixes, and summaries.\n\n")

    # Find all .md files RECURSIVELY
    # Using glob with recursive=True
    all_md_files = glob.glob(os.path.join(SOURCE_DIR, "**/*.md"), recursive=True)
    
    # Filter out the files we just created or are in the docs dir already
    files_to_process = [
        f for f in all_md_files 
        if os.path.abspath(f) != os.path.abspath(SYSTEM_DOC_PATH)
        and os.path.abspath(f) != os.path.abspath(HISTORY_DOC_PATH)
        and "node_modules" not in f
        and ".agent" not in f
        and ".gemini" not in f
    ]

    print(f"Found {len(files_to_process)} Markdown files to process.")

    for file_path in files_to_process:
        filename = os.path.basename(file_path)
        # Skip this script if it were an md file (it's not)
        
        category = get_category(filename)
        
        print(f"Processing: {filename} -> {category}")

        # Read content
        try:
            with open(file_path, 'r', encoding='utf-8', errors='replace') as f:
                content = f.read()
        except Exception as e:
            print(f"Error reading {file_path}: {e}")
            continue

        # Prepare header
        rel_path = os.path.relpath(file_path, SOURCE_DIR)
        header = f"\n\n---\n\n# Source: {rel_path}\n\n"

        # Append to target if not TEST
        if category == "SYSTEM":
            with open(SYSTEM_DOC_PATH, 'a', encoding='utf-8') as f:
                f.write(header + content)
        elif category == "HISTORY":
            with open(HISTORY_DOC_PATH, 'a', encoding='utf-8') as f:
                f.write(header + content)
        else: # TEST
            print(f"Skipping content for test file: {filename}")

        # Move to archive (renaming to avoid collisions if flattened, 
        # but let's try to keep simple flat archive with path-slugs)
        slug_name = rel_path.replace(os.sep, "_").replace(":", "")
        dest_path = os.path.join(ARCHIVE_DIR, slug_name)
        
        try:
            shutil.move(file_path, dest_path)
        except Exception as e:
            print(f"Error moving {file_path} to {dest_path}: {e}")

if __name__ == "__main__":
    process_files()
