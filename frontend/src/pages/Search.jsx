import React, { useMemo, useState } from "react";
import { SongData } from "../context/Song";
import AlbumItem from "../components/AlbumItem";
import { FaPlay } from "react-icons/fa";
import { useNavigate } from "react-router-dom";
import { UserData } from "../context/User";

const Search = () => {
  const { songs, albums, setSelectedSong, setIsPlaying } = SongData();
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

  const handlePlaySong = (id) => {
    setSelectedSong(id);
    setIsPlaying(true);
  };

  const handleAddSong = async (id) => {
    await addToPlaylist(id);
  };

  return (
    <div className="py-6">
      <div className="mb-8">
        <input
          type="text"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="Search albums or songs"
          className="w-full bg-[#1f1f1f] border border-[#2f2f2f] rounded-full px-5 py-3 focus:outline-none focus:border-green-500"
        />
        {!normalizedQuery && (
          <p className="text-sm text-slate-400 mt-2">
            Start typing to search across your entire library.
          </p>
        )}
      </div>

      {normalizedQuery && (
        <div className="flex flex-col gap-10">
          <section>
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-xl font-semibold">Albums</h2>
              {albumMatches.length > 0 && (
                <button
                  className="text-sm text-slate-300 hover:text-white"
                  onClick={() => setQuery("")}
                >
                  Clear
                </button>
              )}
            </div>
            {albumMatches.length === 0 ? (
              <p className="text-slate-400">No albums match "{query}".</p>
            ) : (
              <div className="grid gap-4 grid-cols-[repeat(auto-fill,minmax(180px,1fr))]">
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

          <section>
            <h2 className="text-xl font-semibold mb-4">Songs</h2>
            {songMatches.length === 0 ? (
              <p className="text-slate-400">No songs match "{query}".</p>
            ) : (
              <div className="space-y-4">
                {songMatches.map((song) => (
                  <div
                    key={song._id}
                    className="flex items-center justify-between bg-[#1b1b1b] rounded-lg p-4 hover:bg-[#252525] transition"
                  >
                    <div
                      className="flex items-center gap-4 cursor-pointer"
                      onClick={() => handlePlaySong(song._id)}
                    >
                      <img
                        src={song.thumbnail?.url || "https://via.placeholder.com/60"}
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
                        className="bg-white text-black rounded-full p-3 hover:scale-95 transition"
                        title="Play"
                        onClick={() => handlePlaySong(song._id)}
                      >
                        <FaPlay />
                      </button>
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
