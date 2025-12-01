#!/usr/bin/env python3
"""Simple PostgreSQL initialization helper.

Connects to PostgreSQL using psycopg and executes the requested SQL files
so the backend can be prepared without relying on MySQL tooling.
"""

import os
import sys
from pathlib import Path

try:
    import psycopg
    from psycopg import errors as pg_errors
except ImportError as exc:
    print("Error: psycopg (v3) is required to run init_db.py. Install it via 'pip install psycopg'.")
    raise

# Load environment variables if available
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    print("Warning: python-dotenv not installed. Make sure environment variables are set.")


def get_db_config():
    """Build PostgreSQL connection settings from environment variables."""
    database_url = os.getenv("DATABASE_URL")
    if database_url:
        return {"conninfo": database_url}

    sslmode = "require" if os.getenv("POSTGRES_SSL", "").lower() == "true" else None
    settings = {
        "host": os.getenv("POSTGRES_HOST", "localhost"),
        "port": int(os.getenv("POSTGRES_PORT", 5432)),
        "user": os.getenv("POSTGRES_USER", "postgres"),
        "password": os.getenv("POSTGRES_PASSWORD", ""),
        "dbname": os.getenv("POSTGRES_DATABASE", "bastiboysmusic"),
        "sslmode": sslmode,
    }

    # Remove unset optional values
    return {"kwargs": {k: v for k, v in settings.items() if v}}


def get_connection(config):
    """Return an open psycopg connection from the provided config dict."""
    if "conninfo" in config:
        return psycopg.connect(config["conninfo"])
    return psycopg.connect(**config.get("kwargs", {}))


def execute_sql_file(connection, file_path):
    """Execute a SQL file against the provided PostgreSQL connection."""
    if not os.path.exists(file_path):
        print(f"Error: File not found - {file_path}")
        return False

    try:
        with open(file_path, "r", encoding="utf-8") as handle:
            sql_content = handle.read()

        print(f"Executing {file_path}...")
        with connection.cursor() as cursor:
            cursor.execute(sql_content)

        connection.commit()
        print(f"✓ Successfully executed {file_path}")
        return True
    except (pg_errors.DatabaseError, pg_errors.OperationalError) as err:
        connection.rollback()
        print(f"Error executing {file_path}: {err}")
        return False
    except Exception as err:
        connection.rollback()
        print(f"Unexpected error while executing {file_path}: {err}")
        return False


def init_database(sql_files=None):
    """Initialize the database by running SQL files in order."""
    connection = None
    try:
        config = get_db_config()
        print("Connecting to PostgreSQL database...")
        connection = get_connection(config)
        print("✓ Connected successfully!")

        script_dir = Path(__file__).parent.absolute()
        default_files = [
            "schema.sql",
            "insert.sql",  # Optional seed data file (ignored if missing)
        ]

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

        print("\n✗ Database initialization completed with errors")
        return 1
    except (pg_errors.DatabaseError, pg_errors.OperationalError) as err:
        print(f"Error connecting to PostgreSQL: {err}")
        return 1
    except Exception as err:
        print(f"Unexpected error: {err}")
        return 1
    finally:
        if connection is not None:
            try:
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
