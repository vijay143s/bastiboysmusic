import React, { useMemo, useState } from "react";
import { SongData } from "../context/Song";
import AlbumItem from "../components/AlbumItem";
import { FaPlay } from "react-icons/fa";
import { useNavigate } from "react-router-dom";
import { UserData } from "../context/User";

const Search = () => {
  const { songs, albums, playQueue, playFromSongs } = SongData();
  const { addToPlaylist } = UserData();
  const navigate = useNavigate();
  const [query, setQuery] = useState("");

  const normalizedQuery = query.trim().toLowerCase();

  const albumMatches = useMemo(() => {
    if (!normalizedQuery) return [];
    return albums.filter((album) =>
      [album.title, album.description]
        .filter(Boolean)
        .some((field) => field.toLowerCase().includes(normalizedQuery))
    );
  }, [albums, normalizedQuery]);

  const songMatches = useMemo(() => {
    if (!normalizedQuery) return [];
    return songs.filter((song) =>
      [song.title, song.singer, song.description]
        .filter(Boolean)
        .some((field) => field.toLowerCase().includes(normalizedQuery))
    );
  }, [songs, normalizedQuery]);

  const handlePlaySong = (id, sourceList) => {
    const listToUse = sourceList && sourceList.length ? sourceList : songs;
    const label = sourceList ? "Search Queue" : "All Songs";
    if (listToUse === songs && !sourceList) {
      playFromSongs(id);
    } else {
      playQueue(listToUse, id, label);
    }
  };

  const handleAddSong = async (id) => {
    await addToPlaylist(id);
  };

  return (
    <div className="py-4 md:py-6 px-2 md:px-0">
      <div className="mb-6 md:mb-8">
        <input
          type="text"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="Search albums or songs"
          className="w-full bg-[#1f1f1f] border border-[#2f2f2f] rounded-full px-4 md:px-5 py-2 md:py-3 text-sm md:text-base focus:outline-none focus:border-green-500"
        />
        {!normalizedQuery && (
          <p className="text-xs md:text-sm text-slate-400 mt-2">
            Start typing to search across your entire library.
          </p>
        )}
      </div>

      {normalizedQuery && (
        <div className="flex flex-col gap-8 md:gap-10">
          {/* Albums Section */}
          <section>
            <div className="flex items-center justify-between mb-3 md:mb-4">
              <h2 className="text-lg md:text-xl font-semibold">Albums</h2>
              {albumMatches.length > 0 && (
                <button
                  className="text-xs md:text-sm text-slate-400 hover:text-white"
                  onClick={() => setQuery("")}
                >
                  Clear
                </button>
              )}
            </div>
            {albumMatches.length === 0 ? (
              <p className="text-xs md:text-sm text-slate-400">No albums match "{query}".</p>
            ) : (
              <div className="grid gap-3 md:gap-4 grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5">
                {albumMatches.map((album) => (
                  <AlbumItem
                    key={album._id}
                    image={album.thumbnail.url}
                    name={album.title}
                    desc={album.description}
                    id={album._id}
                  />
                ))}
              </div>
            )}
          </section>

          {/* Songs Section */}
          <section>
            <h2 className="text-lg md:text-xl font-semibold mb-3 md:mb-4">Songs</h2>
            {songMatches.length === 0 ? (
              <p className="text-xs md:text-sm text-slate-400">No songs match "{query}".</p>
            ) : (
              <div className="space-y-4">
                {songMatches.map((song) => (
                  <div
                    key={song._id}
                    className="flex items-center justify-between bg-[#1b1b1b] rounded-lg p-4 hover:bg-[#252525] transition"
                  >
                    <div
                      className="flex items-center gap-4 cursor-pointer"
                      onClick={() => handlePlaySong(song._id, songMatches)}
                    >
                      <img
                        src={song.thumbnail?.url || "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='60' height='60'%3E%3Crect width='60' height='60' fill='%23333'/%3E%3C/svg%3E"}
                        alt={song.title}
                        className="w-12 h-12 rounded object-cover"
                      />
                      <div>
                        <p className="font-semibold">{song.title}</p>
                        <p className="text-sm text-slate-400">
                          {song.singer || "Unknown artist"}
                        </p>
                      </div>
                    </div>
                    <div className="flex gap-3">
                      <button
                        className="bg-green-500 text-black rounded-full px-4"
                        onClick={() => handleAddSong(song._id)}
                      >
                        + Playlist
                      </button>
                      {song.album && (
                        <button
                          className="text-sm text-slate-300 hover:text-white"
                          onClick={() => navigate(`/album/${song.album}`)}
                        >
                          View Album
                        </button>
                      )}
                    </div>
                  </div>
                ))}
              </div>
            )}
          </section>
        </div>
      )}
    </div>
  );
};

export default Search;
