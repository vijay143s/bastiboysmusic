#!/usr/bin/env python3
"""
Database utility functions for incremental updates.
Provides connection management, timestamp queries, and idempotent inserts.
"""

import mysql.connector
import os
import logging
from datetime import datetime
from pathlib import Path
from typing import Optional, Dict, Any, List
from contextlib import contextmanager

try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass

logger = logging.getLogger(__name__)


def get_db_config() -> Dict[str, Any]:
    """
    Get database configuration from environment variables.
    
    Returns:
        Dict with database connection parameters
    """
    return {
        'host': os.getenv('MYSQL_HOST', 'localhost'),
        'port': int(os.getenv('MYSQL_PORT', 3306)),
        'user': os.getenv('MYSQL_USER', 'root'),
        'password': os.getenv('MYSQL_PASSWORD', ''),
        'database': os.getenv('MYSQL_DATABASE', 'bastiboysmusic')
    }


@contextmanager
def get_db_connection():
    """
    Context manager for database connections.
    Automatically handles connection cleanup.
    
    Usage:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            # ... do work
    """
    connection = None
    try:
        config = get_db_config()
        connection = mysql.connector.connect(**config)
        logger.info("Database connection established")
        yield connection
    except mysql.connector.Error as err:
        logger.error(f"Database connection error: {err}")
        raise
    finally:
        if connection and connection.is_connected():
            connection.close()
            logger.info("Database connection closed")


def get_max_created_at(table_name: str) -> Optional[datetime]:
    """
    Get the maximum created_at timestamp from a table.
    
    Args:
        table_name: Name of the table (albums, songs, etc.)
    
    Returns:
        Maximum created_at timestamp or None if table is empty
    """
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            query = f"SELECT MAX(created_at) FROM {table_name}"
            cursor.execute(query)
            result = cursor.fetchone()
            cursor.close()
            
            max_timestamp = result[0] if result and result[0] else None
            if max_timestamp:
                logger.info(f"Max created_at in {table_name}: {max_timestamp}")
            else:
                logger.info(f"No records found in {table_name}")
            
            return max_timestamp
    except Exception as e:
        logger.error(f"Error getting max created_at from {table_name}: {e}")
        return None


def execute_sql_file(file_path: Path, connection=None) -> bool:
    """
    Execute a SQL file with proper error handling.
    
    Args:
        file_path: Path to SQL file
        connection: Optional existing connection (will create new if None)
    
    Returns:
        True if successful, False otherwise
    """
    if not file_path.exists():
        logger.error(f"SQL file not found: {file_path}")
        return False
    
    close_conn = False
    cursor = None
    
    try:
        if connection is None:
            connection = mysql.connector.connect(**get_db_config())
            close_conn = True
        
        with open(file_path, 'r', encoding='utf-8') as f:
            sql_content = f.read()
        
        cursor = connection.cursor()
        
        # Split by semicolon and execute each statement
        statements = [stmt.strip() for stmt in sql_content.split(';') if stmt.strip()]
        
        for i, statement in enumerate(statements, 1):
            if statement:
                logger.debug(f"Executing statement {i}/{len(statements)}")
                cursor.execute(statement)
        
        connection.commit()
        logger.info(f"Successfully executed {file_path}")
        return True
        
    except mysql.connector.Error as err:
        logger.error(f"Error executing {file_path}: {err}")
        if connection:
            connection.rollback()
        return False
    except Exception as err:
        logger.error(f"Unexpected error executing {file_path}: {err}")
        if connection:
            connection.rollback()
        return False
    finally:
        if cursor:
            cursor.close()
        if close_conn and connection:
            connection.close()


def execute_sql_files_batch(file_paths: List[Path], batch_size: int = 100) -> Dict[str, Any]:
    """
    Execute multiple SQL files in batches with progress tracking.
    
    Args:
        file_paths: List of SQL file paths to execute
        batch_size: Number of statements to execute before committing
    
    Returns:
        Dictionary with success count, failure count, and error details
    """
    results = {
        'success': 0,
        'failed': 0,
        'errors': []
    }
    
    try:
        with get_db_connection() as conn:
            for file_path in file_paths:
                logger.info(f"Processing: {file_path}")
                if execute_sql_file(file_path, conn):
                    results['success'] += 1
                else:
                    results['failed'] += 1
                    results['errors'].append(str(file_path))
    except Exception as e:
        logger.error(f"Error in batch execution: {e}")
        results['errors'].append(f"Batch error: {str(e)}")
    
    return results


def check_album_exists(album_title: str) -> bool:
    """
    Check if an album with the given title already exists.
    
    Args:
        album_title: Title of the album
    
    Returns:
        True if album exists, False otherwise
    """
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            query = "SELECT COUNT(*) FROM albums WHERE title = %s"
            cursor.execute(query, (album_title,))
            result = cursor.fetchone()
            cursor.close()
            
            exists = result[0] > 0 if result else False
            return exists
    except Exception as e:
        logger.error(f"Error checking album existence: {e}")
        return False


def check_song_exists(album_id: int, song_title: str) -> bool:
    """
    Check if a song with the given title and album already exists.
    
    Args:
        album_id: ID of the album
        song_title: Title of the song
    
    Returns:
        True if song exists, False otherwise
    """
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            query = "SELECT COUNT(*) FROM songs WHERE album_id = %s AND title = %s"
            cursor.execute(query, (album_id, song_title))
            result = cursor.fetchone()
            cursor.close()
            
            exists = result[0] > 0 if result else False
            return exists
    except Exception as e:
        logger.error(f"Error checking song existence: {e}")
        return False


def get_album_id_by_title(album_title: str) -> Optional[int]:
    """
    Get album ID by title.
    
    Args:
        album_title: Title of the album
    
    Returns:
        Album ID or None if not found
    """
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            query = "SELECT id FROM albums WHERE title = %s LIMIT 1"
            cursor.execute(query, (album_title,))
            result = cursor.fetchone()
            cursor.close()
            
            return result[0] if result else None
    except Exception as e:
        logger.error(f"Error getting album ID: {e}")
        return None


def get_table_row_count(table_name: str) -> int:
    """
    Get the number of rows in a table.
    
    Args:
        table_name: Name of the table
    
    Returns:
        Row count
    """
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            query = f"SELECT COUNT(*) FROM {table_name}"
            cursor.execute(query)
            result = cursor.fetchone()
            cursor.close()
            
            return result[0] if result else 0
    except Exception as e:
        logger.error(f"Error getting row count from {table_name}: {e}")
        return 0


def truncate_all_tables() -> bool:
    """
    Truncate all tables in the correct order (respecting foreign keys).
    
    Returns:
        True if successful, False otherwise
    """
    tables = ['user_playlists', 'singers', 'music_directors', 'artists', 'songs', 'albums']
    
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            
            # Disable foreign key checks
            cursor.execute("SET FOREIGN_KEY_CHECKS=0")
            
            for table in tables:
                logger.info(f"Truncating table: {table}")
                cursor.execute(f"TRUNCATE TABLE {table}")
            
            # Re-enable foreign key checks
            cursor.execute("SET FOREIGN_KEY_CHECKS=1")
            
            conn.commit()
            cursor.close()
            
            logger.info("All tables truncated successfully")
            return True
    except Exception as e:
        logger.error(f"Error truncating tables: {e}")
        return False


def execute_sql_files_with_truncate(sql_dir: Path, truncate: bool = False) -> Dict[str, Any]:
    """
    Execute SQL files from a directory with optional truncate.
    
    Args:
        sql_dir: Directory containing SQL files
        truncate: Whether to truncate tables before inserting
    
    Returns:
        Dictionary with execution results
    """
    results = {
        'success': 0,
        'failed': 0,
        'errors': [],
        'truncated': False
    }
    
    if not sql_dir.exists():
        logger.error(f"SQL directory not found: {sql_dir}")
        results['errors'].append(f"Directory not found: {sql_dir}")
        return results
    
    # Truncate if requested
    if truncate:
        logger.info("Truncating all tables before insertion...")
        if truncate_all_tables():
            results['truncated'] = True
            logger.info("Tables truncated successfully")
        else:
            results['errors'].append("Failed to truncate tables")
            return results
    
    # Find all SQL files in order
    sql_files = []
    file_order = ['albums.sql', 'songs.sql', 'artists.sql', 'singers.sql', 'music_directors.sql']
    
    for filename in file_order:
        file_path = sql_dir / filename
        if file_path.exists():
            sql_files.append(file_path)
    
    # Execute SQL files
    logger.info(f"Executing {len(sql_files)} SQL files...")
    batch_results = execute_sql_files_batch(sql_files)
    
    results['success'] = batch_results['success']
    results['failed'] = batch_results['failed']
    results['errors'].extend(batch_results['errors'])
    
    return results


def test_connection() -> bool:
    """
    Test database connection.
    
    Returns:
        True if connection successful, False otherwise
    """
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT 1")
            result = cursor.fetchone()
            cursor.close()
            return result is not None
    except Exception as e:
        logger.error(f"Connection test failed: {e}")
        return False


if __name__ == '__main__':
    # Test the connection
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )
    
    print("Testing database connection...")
    if test_connection():
        print("[OK] Connection successful!")
        
        # Test getting max timestamps
        print("\nChecking max timestamps:")
        for table in ['albums', 'songs']:
            max_ts = get_max_created_at(table)
            print(f"  {table}: {max_ts}")
        
        # Test row counts
        print("\nRow counts:")
        for table in ['albums', 'songs', 'artists', 'singers', 'music_directors']:
            count = get_table_row_count(table)
            print(f"  {table}: {count}")
    else:
        print("[ERROR] Connection failed!")
