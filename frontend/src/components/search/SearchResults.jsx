import React from "react";
import { RiSearchLine } from "react-icons/ri";
import AlbumItem from "../AlbumItem";
import SongCard from "./SongCard";

const SearchResults = ({
    searchLoading,
    normalizedQuery,
    yearFilter,
    searchType,
    albumMatches,
    songMatches,
    artistMatches,
    singerMatches,
    loadingYearAlbums,
    navigate,
    onPlay,
    onAdd,
    query,
    setQuery,
    setYearFilter,
}) => {

    // No Results State
    if (
        !searchLoading &&
        albumMatches.length === 0 &&
        songMatches.length === 0 &&
        artistMatches.length === 0 &&
        singerMatches.length === 0
    ) {
        return (
            <div className="bg-[#1b1b1b] rounded-lg p-12 text-center">
                <RiSearchLine className="text-5xl text-slate-600 mx-auto mb-4" />
                <h3 className="text-xl font-semibold mb-2">No results found</h3>
                <p className="text-slate-400 mb-4">
                    {yearFilter
                        ? `No matches for "${query}" in ${yearFilter}`
                        : `No matches for "${query}"`}
                </p>
                <button
                    onClick={() => {
                        setQuery("");
                        setYearFilter("");
                    }}
                    className="bg-green-500 hover:bg-green-600 text-black px-6 py-2 rounded-full font-medium transition-all"
                >
                    Clear filters
                </button>
            </div>
        );
    }

    return (
        <div className="space-y-6 md:space-y-8">
            {/* Loading State */}
            {searchLoading && (
                <div className="flex justify-center items-center py-10">
                    <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-500"></div>
                    <span className="ml-3 text-slate-400">Searching...</span>
                </div>
            )}

            {/* Results Count */}
            {!searchLoading && (normalizedQuery || yearFilter) && (
                <div className="text-sm text-slate-400">
                    {albumMatches.length +
                        songMatches.length +
                        artistMatches.length +
                        singerMatches.length}{" "}
                    result
                    {albumMatches.length +
                        songMatches.length +
                        artistMatches.length +
                        singerMatches.length !==
                        1
                        ? "s"
                        : ""}{" "}
                    found
                    {yearFilter && ` in ${yearFilter}`}
                </div>
            )}

            {/* Artists Section */}
            {!searchLoading && searchType === "artists" && artistMatches.length > 0 && (
                <section className="animate-slideUp">
                    <div className="flex items-center justify-between mb-4">
                        <h2 className="text-lg md:text-xl font-semibold">Artists</h2>
                        <span className="text-sm text-slate-400">{artistMatches.length}</span>
                    </div>
                    <div className="grid gap-3 md:gap-4 grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5">
                        {artistMatches.map((artist) => (
                            <div
                                key={artist.artistId}
                                onClick={() => navigate(`/results/artist/${artist.artistId}`)}
                                className="bg-[#181818] hover:bg-[#282828] rounded-lg p-4 transition-all cursor-pointer group hover:scale-105 duration-300"
                            >
                                <div className="aspect-square rounded-full bg-gradient-to-br from-purple-600 to-blue-600 mb-3 flex items-center justify-center group-hover:shadow-lg group-hover:shadow-purple-500/20 transition-all">
                                    <span className="text-4xl font-bold text-white">
                                        {artist.artistName?.charAt(0).toUpperCase()}
                                    </span>
                                </div>
                                <p className="font-semibold text-white truncate text-sm">
                                    {artist.artistName}
                                </p>
                                <p className="text-xs text-slate-400 truncate">
                                    {artist.albumCount} album{artist.albumCount !== 1 ? "s" : ""}
                                </p>
                            </div>
                        ))}
                    </div>
                </section>
            )}

            {/* Singers Section */}
            {!searchLoading && searchType === "singers" && singerMatches.length > 0 && (
                <section className="animate-slideUp" style={{ animationDelay: '0.1s' }}>
                    <div className="flex items-center justify-between mb-4">
                        <h2 className="text-lg md:text-xl font-semibold">Singers</h2>
                        <span className="text-sm text-slate-400">{singerMatches.length}</span>
                    </div>
                    <div className="grid gap-3 md:gap-4 grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5">
                        {singerMatches.map((singer) => (
                            <div
                                key={singer.singerId}
                                onClick={() =>
                                    navigate(`/results/singer/${encodeURIComponent(singer.singerName)}`)
                                }
                                className="bg-[#181818] hover:bg-[#282828] rounded-lg p-4 transition-all cursor-pointer group hover:scale-105 duration-300"
                            >
                                <div className="aspect-square rounded-full bg-gradient-to-br from-pink-600 to-rose-600 mb-3 flex items-center justify-center group-hover:shadow-lg group-hover:shadow-pink-500/20 transition-all">
                                    <span className="text-4xl font-bold text-white">
                                        {singer.singerName?.charAt(0).toUpperCase()}
                                    </span>
                                </div>
                                <p className="font-semibold text-white truncate text-sm">
                                    {singer.singerName}
                                </p>
                                <p className="text-xs text-slate-400 truncate">
                                    {singer.songCount} song{singer.songCount !== 1 ? "s" : ""}
                                </p>
                            </div>
                        ))}
                    </div>
                </section>
            )}

            {/* Albums Section */}
            {loadingYearAlbums ? (
                <div className="flex justify-center items-center py-10">
                    <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-500"></div>
                    <span className="ml-3 text-slate-400">Loading albums...</span>
                </div>
            ) : (
                !searchLoading &&
                searchType === "albums" &&
                albumMatches.length > 0 && (
                    <section className="animate-slideUp" style={{ animationDelay: '0.1s' }}>
                        <div className="flex items-center justify-between mb-4">
                            <h2 className="text-lg md:text-xl font-semibold">Albums</h2>
                            <span className="text-sm text-slate-400">{albumMatches.length}</span>
                        </div>
                        <div className="grid gap-3 md:gap-4 grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5">
                            {albumMatches.map((album) => (
                                <div key={album._id} className="hover:scale-105 transition-transform duration-300">
                                    <AlbumItem
                                        image={album.thumbnail?.url || ""}
                                        name={album.title}
                                        desc={album.description}
                                        id={album._id}
                                    />
                                </div>
                            ))}
                        </div>
                    </section>
                )
            )}

            {/* Songs Section */}
            {!searchLoading && searchType === "songs" && songMatches.length > 0 && (
                <section className="animate-slideUp" style={{ animationDelay: '0.2s' }}>
                    <div className="flex items-center justify-between mb-4">
                        <h2 className="text-lg md:text-xl font-semibold">Songs</h2>
                        <span className="text-sm text-slate-400">{songMatches.length}</span>
                    </div>
                    <div className="grid gap-3 md:gap-4">
                        {songMatches.map((song, index) => (
                            <div key={song._id} style={{ animationDelay: `${index * 0.05}s` }} className="animate-fadeIn">
                                <SongCard
                                    song={song}
                                    onPlay={(id) => onPlay(id, songMatches)}
                                    onAdd={onAdd}
                                />
                            </div>
                        ))}
                    </div>
                </section>
            )}
        </div>
    );
};

export default SearchResults;
