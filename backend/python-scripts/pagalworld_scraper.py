#!/usr/bin/env python3
"""Standalone Pagalworld album ingestion script."""

from __future__ import annotations

import argparse
import logging
import sys
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
if str(BASE_DIR) not in sys.path:
    sys.path.append(str(BASE_DIR))

from senslive_incremental import (  # type: ignore
    DEFAULT_TIMEOUT,
    SQLDataCollector,
    check_existing_single_article_records,
    scrape_pagalworld_album,
)
from db_utils import execute_sql_files_batch  # type: ignore

logger = logging.getLogger("pagalworld_ingest")
if not logger.handlers:
    handler = logging.StreamHandler(sys.stdout)
    handler.setFormatter(logging.Formatter("%(asctime)s - %(levelname)s - %(message)s"))
    logger.addHandler(handler)
logger.setLevel(logging.INFO)


def dump_collector_details(collector: SQLDataCollector) -> None:
    """Log album, song, and contributor details for manual verification."""
    logger.info("\n" + "="*70)
    logger.info("EXTRACTED DATA SUMMARY")
    logger.info("="*70)

    # Album details
    if collector.albums:
        logger.info("\n📀 ALBUM DETAILS (%d album(s)):", len(collector.albums))
        for idx, album in enumerate(collector.albums.values(), start=1):
            logger.info("  [%d] Title: %s", idx, album.get("title", "Unknown"))
            logger.info("       Year: %s", album.get("year") or "N/A")
            logger.info("       Director: %s", album.get("director") or "N/A")
            logger.info("       Music Director: %s", album.get("music_director") or "N/A")
            logger.info("       Star Cast: %s", album.get("star_cast") or "N/A")
            logger.info("       Language: %s", album.get("language") or "N/A")
            logger.info("       Thumbnail URL: %s", album.get("thumbnail_url") or "N/A")
    else:
        logger.info("\n📀 ALBUM DETAILS: No albums found")

    # Song details
    if collector.songs:
        logger.info("\n🎵 SONG DETAILS (%d song(s)):", len(collector.songs))
        for idx, song in enumerate(collector.songs, start=1):
            logger.info("  [%d] Title: %s", idx, song.get("title", "Unknown"))
            logger.info("       Album: %s", song.get("album_name") or "N/A")
            logger.info("       Singers: %s", song.get("singer") or "N/A")
            logger.info("       Audio URL: %s", song.get("audio_url") or "(no audio URL)")
    else:
        logger.info("\n🎵 SONG DETAILS: No songs found")

    # Artist details
    if collector.artists:
        logger.info("\n👤 ARTISTS (%d artist(s)):", len(collector.artists))
        for idx, (artist_name, album_name) in enumerate(sorted(collector.artists), start=1):
            logger.info("  [%d] %s (Album: %s)", idx, artist_name, album_name)
    else:
        logger.info("\n👤 ARTISTS: No artists found")

    # Singer details
    if collector.singers:
        logger.info("\n🎤 SINGERS (%d singer(s)):", len(collector.singers))
        for idx, singer_name in enumerate(sorted(collector.singers), start=1):
            logger.info("  [%d] %s", idx, singer_name)
    else:
        logger.info("\n🎤 SINGERS: No singers found")

    # Music Director details
    if collector.music_directors:
        logger.info("\n🎼 MUSIC DIRECTORS (%d director(s)):", len(collector.music_directors))
        for idx, (director_name, album_name) in enumerate(sorted(collector.music_directors), start=1):
            logger.info("  [%d] %s (Album: %s)", idx, director_name, album_name)
    else:
        logger.info("\n🎼 MUSIC DIRECTORS: No music directors found")

    logger.info("\n" + "="*70)
    logger.info("SUMMARY: %d albums | %d songs | %d artists | %d singers | %d directors",
                len(collector.albums), len(collector.songs), len(collector.artists),
                len(collector.singers), len(collector.music_directors))
    logger.info("="*70 + "\n")


def run_pagalworld_ingestion(
    article_url: str,
    sql_output: Path,
    execute_sql: bool = False,
    timeout: int = DEFAULT_TIMEOUT,
) -> None:
    logger.info("=" * 70)
    logger.info("PAGALWORLD SINGLE ARTICLE")
    logger.info("=" * 70)
    logger.info("Target URL: %s", article_url)

    scraped = scrape_pagalworld_album(article_url, timeout=timeout)
    if not scraped or "error" in scraped:
        logger.error("Failed to scrape Pagalworld page: %s", scraped.get("error", "unknown error"))
        return

    album_details = scraped.get("album_details", {})
    album_name = album_details.get("album_name", "").strip() or "Unknown Album"
    album_year = album_details.get("year", "") or ""
    songs = scraped.get("songs", [])

    logger.info("Album: %s", album_name)
    logger.info("Songs detected: %d", len(songs))

    conflicts = check_existing_single_article_records(
        album_name,
        str(album_year) if album_year else "",
        songs,
    )
    conflict_count = len(conflicts["albums"]) + sum(len(item["matches"]) for item in conflicts["songs"])
    if conflict_count:
        logger.warning("Conflicts detected — review database entries before continuing.")
        return

    collector = SQLDataCollector(incremental_mode=True)
    collector.add_article_data(scraped)
    dump_collector_details(collector)

    sql_output.mkdir(parents=True, exist_ok=True)
    logger.info("Generating SQL files under %s", sql_output)
    collector.generate_sql_files(sql_output)

    if execute_sql:
        sql_files = [
            sql_output / "albums.sql",
            sql_output / "songs.sql",
            sql_output / "artists.sql",
            sql_output / "singers.sql",
            sql_output / "music_directors.sql",
        ]
        existing = [path for path in sql_files if path.exists()]
        if not existing:
            logger.warning("No SQL files found to execute.")
        else:
            try:
                execute_sql_files_batch(existing)
                logger.info("SQL executed successfully (INSERT IGNORE semantics).")
            except Exception as exc:  # pragma: no cover
                logger.error("SQL execution failed: %s", exc)

    logger.info("=" * 70)
    logger.info("PAGALWORLD RUN COMPLETE")
    logger.info("=" * 70)


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Pagalworld single-article ingestion")
    parser.add_argument("--url", required=True, help="Pagalworld album URL to scrape")
    parser.add_argument(
        "--sql-output",
        type=Path,
        default=Path("sql_output/pagalworld"),
        help="Directory to write SQL files",
    )
    parser.add_argument(
        "--execute-sql",
        action="store_true",
        help="Execute generated SQL files after creation",
    )
    parser.add_argument(
        "--timeout",
        type=int,
        default=DEFAULT_TIMEOUT,
        help="HTTP timeout for requests",
    )
    return parser.parse_args(argv)


def main(argv: list[str]) -> int:
    args = parse_args(argv)
    run_pagalworld_ingestion(
        article_url=args.url,
        sql_output=args.sql_output,
        execute_sql=args.execute_sql,
        timeout=args.timeout,
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
