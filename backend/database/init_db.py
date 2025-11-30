#!/usr/bin/env python3
"""
Database initialization script to execute SQL files
This script connects to MySQL and runs SQL files to set up the database schema
"""

import mysql.connector
import os
import sys
from pathlib import Path

# Load environment variables
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    print("Warning: python-dotenv not installed. Make sure environment variables are set.")


def get_db_config():
    """
    Get database configuration from environment variables
    """
    return {
        'host': os.getenv('MYSQL_HOST', 'localhost'),
        'port': int(os.getenv('MYSQL_PORT', 3306)),
        'user': os.getenv('MYSQL_USER', 'root'),
        'password': os.getenv('MYSQL_PASSWORD', ''),
        'database': os.getenv('MYSQL_DATABASE', 'bastiboysmusic')
    }


def execute_sql_file(connection, file_path):
    """
    Execute a single SQL file
    
    Args:
        connection: MySQL database connection
        file_path: Path to SQL file
    """
    if not os.path.exists(file_path):
        print(f"Error: File not found - {file_path}")
        return False
    
    cursor = None
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            sql_content = f.read()
        
        cursor = connection.cursor()
        
        # Disable foreign key checks for schema.sql to allow dropping tables
        if 'schema.sql' in file_path:
            cursor.execute("SET FOREIGN_KEY_CHECKS=0")
        
        # Split by semicolon and execute each statement
        statements = [stmt.strip() for stmt in sql_content.split(';') if stmt.strip()]
        
        for statement in statements:
            if statement:
                print(f"Executing: {statement[:80]}...")
                cursor.execute(statement)
                
                # Fetch and display results for SELECT queries
                if statement.strip().upper().startswith('SELECT'):
                    results = cursor.fetchall()
                    if results:
                        print(f"Results ({len(results)} rows):")
                        # Get column names
                        columns = [desc[0] for desc in cursor.description]
                        print(f"  {' | '.join(columns)}")
                        print("  " + "-" * 80)
                        for row in results:
                            print(f"  {' | '.join(str(val) for val in row)}")
                    else:
                        print("No results returned")
        
        # Re-enable foreign key checks after schema.sql
        if 'schema.sql' in file_path:
            cursor.execute("SET FOREIGN_KEY_CHECKS=1")
        
        connection.commit()
        
        print(f"✓ Successfully executed {file_path}")
        return True
        
    except mysql.connector.Error as err:
        print(f"Error executing {file_path}: {err}")
        # Rollback on error
        try:
            connection.rollback()
        except:
            pass
        return False
    except Exception as err:
        print(f"Unexpected error: {err}")
        # Rollback on error
        try:
            connection.rollback()
        except:
            pass
        return False
    finally:
        # Always close the cursor
        if cursor is not None:
            try:
                cursor.close()
            except Exception as err:
                print(f"Error closing cursor: {err}")


def init_database(sql_files=None):
    """
    Initialize the database by executing SQL files in order
    
    Args:
        sql_files: List of SQL files to execute. If None, runs all default files.
    """
    connection = None
    try:
        config = get_db_config()
        
        print("Connecting to MySQL database...")
        connection = mysql.connector.connect(**config)
        print("✓ Connected successfully!")
        
        # Get the directory where this script is located
        script_dir = Path(__file__).parent.absolute()
        
        # Default SQL files to execute in order
        default_files = [
            'schema.sql',
            'insert.sql',  # Optional: if you have initial data
        ]
        
        # Use provided files or defaults
        files_to_run = sql_files if sql_files else default_files
        
        success = True
        for sql_file in files_to_run:
            file_path = script_dir / sql_file
            if file_path.exists():
                if not execute_sql_file(connection, str(file_path)):
                    success = False
            else:
                print(f"Skipping {sql_file} (not found)")
        
        if success:
            print("\n✓ Database initialization completed successfully!")
            return 0
        else:
            print("\n✗ Database initialization completed with errors")
            return 1
            
    except mysql.connector.Error as err:
        print(f"Error connecting to MySQL: {err}")
        return 1
    except Exception as err:
        print(f"Unexpected error: {err}")
        return 1
    finally:
        # Close connection and cleanup
        if connection is not None:
            try:
                # Close all active cursors
                for cursor in connection.get_warnings():
                    pass
                
                # Rollback any uncommitted transactions in case of error
                if connection.is_connected():
                    connection.rollback()
                
                # Close the connection
                connection.close()
                print("\n✓ Database connection closed successfully")
            except Exception as err:
                print(f"Error closing connection: {err}")


if __name__ == '__main__':
    if len(sys.argv) > 1:
        # Run specific SQL files passed as arguments
        sql_files = sys.argv[1:]
        print(f"Running SQL files: {', '.join(sql_files)}")
        sys.exit(init_database(sql_files))
    else:
        # Run all default files
        print("Running all default SQL files...")
        sys.exit(init_database())
