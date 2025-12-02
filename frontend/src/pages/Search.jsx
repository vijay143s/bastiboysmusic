import React, { useMemo, useState, useEffect } from "react";
import { SongData } from "../context/Song";
import AlbumItem from "../components/AlbumItem";
import { FaPlay } from "react-icons/fa";
import { useNavigate } from "react-router-dom";
import { UserData } from "../context/User";
import axios from "axios";

const Search = () => {
  const { songs, albums, playQueue, playFromSongs } = SongData();
  const { addToPlaylist } = UserData();
  const navigate = useNavigate();
  const [query, setQuery] = useState("");
  const [yearFilter, setYearFilter] = useState("");
  const [availableYears, setAvailableYears] = useState([]);
  const [yearAlbums, setYearAlbums] = useState([]);
  const [loadingYearAlbums, setLoadingYearAlbums] = useState(false);

  // Fetch available years for filtering
  useEffect(() => {
    const fetchYears = async () => {
      try {
        const { data } = await axios.get("/api/song/years/top");
        const years = data.years.map(y => y.year).sort((a, b) => b - a);
        setAvailableYears(years);
      } catch (error) {
        console.error("Error fetching years:", error);
      }
    };
    fetchYears();
  }, []);
  
  // Load albums when year filter changes
  useEffect(() => {
    if (yearFilter) {
      loadAlbumsByYear(yearFilter);
    } else {
      setYearAlbums([]);
    }
  }, [yearFilter]);
  
  const loadAlbumsByYear = async (year) => {
    setLoadingYearAlbums(true);
    try {
      const { data } = await axios.get(`/api/song/years/${year}/albums`);
      setYearAlbums(data.albums || []);
    } catch (error) {
      console.error("Error loading albums by year:", error);
      setYearAlbums([]);
    } finally {
      setLoadingYearAlbums(false);
    }
  };

  const normalizedQuery = query.trim().toLowerCase();

  const albumMatches = useMemo(() => {
    // If year filter is selected but no search query, show all albums from that year
    if (yearFilter && !normalizedQuery) {
      return yearAlbums;
    }
    
    // If searching, filter from yearAlbums if year is selected, otherwise from all albums
    if (!normalizedQuery) return [];
    
    const sourceAlbums = yearFilter ? yearAlbums : albums;
    const filtered = sourceAlbums.filter((album) =>
      [album.title, album.description]
        .filter(Boolean)
        .some((field) => field.toLowerCase().includes(normalizedQuery))
    );
    
    return filtered;
  }, [albums, yearAlbums, normalizedQuery, yearFilter]);

  const songMatches = useMemo(() => {
    if (!normalizedQuery) return [];
    let filtered = songs.filter((song) =>
      [song.title, song.singer, song.description]
        .filter(Boolean)
        .some((field) => field.toLowerCase().includes(normalizedQuery))
    );
    
    if (yearFilter) {
      filtered = filtered.filter(song => {
        const album = albums.find(a => a._id === song.album);
        return album && album.year && album.year.toString() === yearFilter;
      });
    }
    
    return filtered;
  }, [songs, albums, normalizedQuery, yearFilter]);

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
        <div className="flex gap-3 mb-3">
          <input
            type="text"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Search albums or songs"
            className="flex-1 bg-[#1f1f1f] border border-[#2f2f2f] rounded-full px-4 md:px-5 py-2 md:py-3 text-sm md:text-base focus:outline-none focus:border-green-500"
          />
          <select
            value={yearFilter}
            onChange={(e) => setYearFilter(e.target.value)}
            className="bg-[#1f1f1f] border border-[#2f2f2f] rounded-full px-4 py-2 md:py-3 text-sm md:text-base focus:outline-none focus:border-green-500"
          >
            <option value="">All Years</option>
            {availableYears.map(year => (
              <option key={year} value={year}>{year}</option>
            ))}
          </select>
        </div>
        {!normalizedQuery && !yearFilter && (
          <p className="text-xs md:text-sm text-slate-400 mt-2">
            Start typing to search across your entire library. Filter by year for more specific results.
          </p>
        )}
        {yearFilter && !normalizedQuery && (
          <p className="text-xs md:text-sm text-slate-400 mt-2">
            Showing all albums from {yearFilter}. Type to search within this year.
          </p>
        )}
      </div>

      {(normalizedQuery || yearFilter) && (
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
              <p className="text-xs md:text-sm text-slate-400">
                {yearFilter && !normalizedQuery 
                  ? `No albums found for ${yearFilter}` 
                  : `No albums match "${query}"`}
              </p>
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
