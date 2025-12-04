#!/usr/bin/env python3
"""
Master Scraper & SQL Import Tool
One-command solution for language-wise scraping and database import
"""

import argparse
import sys
import os
from scraper_language_wise import PagalWorldLanguageScraper
from generate_sql_advanced import AdvancedSQLGenerator

class MasterTool:
    def __init__(self):
        self.supported_languages = ['hindi', 'punjabi', 'tamil', 'telugu', 'marathi', 'bengali']
    
    def scrape_language(self, language, pages=1):
        """Scrape specific language"""
        print(f"\n{'='*70}")
        print(f"🎵 SCRAPING LANGUAGE: {language.upper()}")
        print(f"{'='*70}\n")
        
        try:
            scraper = PagalWorldLanguageScraper()
            scraper.scrape_language(language=language, pages=pages)
            scraper.print_summary()
            
            # Save results
            output_file = scraper.save_results()
            return output_file
        
        except Exception as e:
            print(f"❌ Scraping failed: {e}")
            return None
    
    def generate_sql(self, json_file):
        """Generate SQL from JSON output"""
        print(f"\n{'='*70}")
        print(f"📊 GENERATING SQL INSERT STATEMENTS")
        print(f"{'='*70}\n")
        
        try:
            gen = AdvancedSQLGenerator(json_file)
            gen.map_songs_to_albums()
            
            # Get base filename
            base_name = os.path.splitext(json_file)[0]
            sql_file = f"{base_name}_insert.sql"
            mapping_file = f"{base_name}_mapping.md"
            
            gen.generate_complete_sql(sql_file)
            gen.generate_album_song_mapping(mapping_file)
            
            return sql_file, mapping_file
        
        except Exception as e:
            print(f"❌ SQL generation failed: {e}")
            return None, None
    
    def full_pipeline(self, language, pages=1):
        """Run complete pipeline: scrape -> generate SQL"""
        print(f"\n{'='*70}")
        print(f"🚀 RUNNING FULL PIPELINE")
        print(f"Language: {language.upper()}")
        print(f"Pages: {pages}")
        print(f"{'='*70}")
        
        # Step 1: Scrape
        json_file = self.scrape_language(language, pages)
        if not json_file:
            return False
        
        # Step 2: Generate SQL
        sql_file, mapping_file = self.generate_sql(json_file)
        if not sql_file:
            return False
        
        # Print results
        print(f"\n{'='*70}")
        print(f"✅ PIPELINE COMPLETE")
        print(f"{'='*70}")
        print(f"\n📁 Generated Files:")
        print(f"  1. {json_file}")
        print(f"     └─ Raw scraper output (JSON)")
        print(f"  2. {sql_file}")
        print(f"     └─ SQL INSERT statements (Ready to execute)")
        print(f"  3. {mapping_file}")
        print(f"     └─ Album-Song mapping reference")
        
        print(f"\n📋 Next Steps:")
        print(f"  1. Review the mapping: cat {mapping_file}")
        print(f"  2. Execute the SQL:")
        print(f"     mysql -u root -p database_name < {sql_file}")
        print(f"  3. Verify import:")
        print(f"     SELECT COUNT(*) FROM albums;")
        print(f"     SELECT COUNT(*) FROM songs;")
        print(f"\n{'='*70}\n")
        
        return True
    
    def batch_scrape(self, languages, pages=1):
        """Scrape multiple languages"""
        print(f"\n{'='*70}")
        print(f"🎵 BATCH SCRAPING")
        print(f"Languages: {', '.join(languages)}")
        print(f"Pages per language: {pages}")
        print(f"{'='*70}\n")
        
        results = {}
        for lang in languages:
            print(f"\n[{languages.index(lang)+1}/{len(languages)}] Scraping {lang.upper()}...")
            json_file = self.scrape_language(lang, pages)
            if json_file:
                results[lang] = json_file
        
        print(f"\n{'='*70}")
        print(f"✅ BATCH SCRAPING COMPLETE")
        print(f"{'='*70}")
        print(f"Successful: {len(results)}/{len(languages)}")
        
        # Generate SQL for each
        print(f"\nGenerating SQL files...")
        for lang, json_file in results.items():
            sql_file, mapping_file = self.generate_sql(json_file)
            if sql_file:
                print(f"✓ {lang}: {sql_file}")
        
        return results
    
    def show_examples(self):
        """Show usage examples"""
        examples = f"""
{'='*70}
USAGE EXAMPLES
{'='*70}

1. Scrape and Generate SQL (Full Pipeline)
   python master_tool.py --scrape hindi
   
2. Scrape Multiple Pages
   python master_tool.py --scrape hindi --pages 3
   
3. Batch Scrape Multiple Languages
   python master_tool.py --batch hindi punjabi tamil telugu
   
4. Generate SQL from Existing JSON
   python master_tool.py --generate pagalworld_hindi_results.json
   
5. List Supported Languages
   python master_tool.py --list-languages
   
6. Show Help
   python master_tool.py --help

{'='*70}
"""
        print(examples)


def main():
    parser = argparse.ArgumentParser(
        description='Master Scraper & SQL Import Tool for Pagal World Music',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Full pipeline (scrape + generate SQL)
  python master_tool.py --scrape hindi
  
  # Scrape 3 pages
  python master_tool.py --scrape hindi --pages 3
  
  # Batch scrape multiple languages
  python master_tool.py --batch hindi punjabi tamil telugu
  
  # Generate SQL from existing JSON
  python master_tool.py --generate pagalworld_hindi_results.json
  
  # Show supported languages
  python master_tool.py --list-languages
        """
    )
    
    parser.add_argument('--scrape', 
                       metavar='LANGUAGE',
                       help='Scrape specific language and generate SQL')
    
    parser.add_argument('--generate',
                       metavar='JSON_FILE',
                       help='Generate SQL from existing JSON file')
    
    parser.add_argument('--batch',
                       nargs='+',
                       metavar='LANGUAGES',
                       help='Batch scrape multiple languages')
    
    parser.add_argument('--pages',
                       type=int,
                       default=1,
                       help='Number of pages to scrape (default: 1)')
    
    parser.add_argument('--list-languages',
                       action='store_true',
                       help='Show supported languages')
    
    parser.add_argument('--examples',
                       action='store_true',
                       help='Show usage examples')
    
    args = parser.parse_args()
    
    tool = MasterTool()
    
    # Handle requests
    if args.list_languages:
        print(f"\n✅ Supported Languages:")
        for lang in tool.supported_languages:
            print(f"   - {lang.upper()}")
        print()
        return True
    
    if args.examples:
        tool.show_examples()
        return True
    
    if args.scrape:
        return tool.full_pipeline(args.scrape, args.pages)
    
    if args.generate:
        if not os.path.exists(args.generate):
            print(f"❌ File not found: {args.generate}")
            return False
        sql_file, mapping_file = tool.generate_sql(args.generate)
        if sql_file:
            print(f"\n✅ Generated:")
            print(f"  - {sql_file}")
            print(f"  - {mapping_file}")
            return True
        return False
    
    if args.batch:
        tool.batch_scrape(args.batch, args.pages)
        return True
    
    # Default: show help
    parser.print_help()
    return True


if __name__ == "__main__":
    try:
        success = main()
        sys.exit(0 if success else 1)
    except KeyboardInterrupt:
        print("\n\n⚠️  Interrupted by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Fatal error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
