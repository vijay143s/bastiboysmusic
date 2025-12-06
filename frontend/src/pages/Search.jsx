import React, { useMemo, useState, useEffect } from "react";
import { SongData } from "../context/Song";
import { useNavigate } from "react-router-dom";
import { UserData } from "../context/User";
import axios from "axios";

// Import new sub-components
import SearchInput from "../components/search/SearchInput";
import FilterChips from "../components/search/FilterChips";
import TrendingSection from "../components/search/TrendingSection";
import RecommendationsSection from "../components/search/RecommendationsSection";
import SearchResults from "../components/search/SearchResults";
import RecentSearches from "../components/search/RecentSearches";
import BrowseSection from "../components/search/BrowseSection";

import { useLanguage } from "../context/Language";

const Search = () => {
  const { songs, albums, playQueue } = SongData();
  const { addToPlaylist, user } = UserData();
  const { selectedLanguage } = useLanguage();
  const navigate = useNavigate();
  const [query, setQuery] = useState("");
  const [debouncedQuery, setDebouncedQuery] = useState(""); // Debounced for heavy filtering
  const [searchType, setSearchType] = useState("songs"); // 'songs', 'albums', 'artists', 'singers'
  const [yearFilter, setYearFilter] = useState("");
  const [availableYears, setAvailableYears] = useState([]);
  const [yearAlbums, setYearAlbums] = useState([]);
  const [loadingYearAlbums, setLoadingYearAlbums] = useState(false);
  const [apiSearchResults, setApiSearchResults] = useState([]);
  const [apiAlbumResults, setApiAlbumResults] = useState([]);
  const [apiArtistResults, setApiArtistResults] = useState([]);
  const [apiSingerResults, setApiSingerResults] = useState([]);
  const [searchLoading, setSearchLoading] = useState(false);
  const [trending, setTrending] = useState([]);
  const [recommendations, setRecommendations] = useState([]);
  const [recentSearches, setRecentSearches] = useState([]);
  const [loadingTrending, setLoadingTrending] = useState(false);
  const [loadingRecommendations, setLoadingRecommendations] = useState(false);

  // Fetch available years for filtering
  useEffect(() => {
    const fetchYears = async () => {
      try {
        const params = new URLSearchParams();
        if (selectedLanguage) params.append("language", selectedLanguage);

        const { data } = await axios.get(`/api/song/years/top?${params}`);
        const years = data.years.map((y) => y.year).sort((a, b) => b - a);
        setAvailableYears(years);
      } catch (error) {
        if (process.env.NODE_ENV === "development") {
          console.error("Error fetching years:", error);
        }
      }
    };
    fetchYears();
  }, [selectedLanguage]);

  // Fetch trending and recommendations when no search query
  // Debounce query for both API and client-side filtering
  useEffect(() => {
    const timer = setTimeout(() => {
      const trimmed = query.trim();
      setDebouncedQuery(trimmed);

      if (trimmed) {
        performApiSearch(trimmed);
      } else {
        // Clear API results if empty
        setApiSearchResults([]);
        setApiAlbumResults([]);
        setApiArtistResults([]);
        setApiSingerResults([]);
        fetchTrendingAndRecommendations();
      }
    }, 300);

    return () => clearTimeout(timer);
  }, [query, user, yearFilter, selectedLanguage]);

  // Handle empty query (immediate clear for better UX on clear button)
  useEffect(() => {
    if (!query) {
      setDebouncedQuery("");
    }
  }, [query]);

  // Set search type to albums when year filter is selected
  useEffect(() => {
    if (yearFilter && !query.trim()) {
      setSearchType("albums");
    }
  }, [yearFilter, query]);

  const fetchTrendingAndRecommendations = async () => {
    setLoadingTrending(true);
    setLoadingRecommendations(true);

    try {
      const params = new URLSearchParams({ limit: 10 });
      if (selectedLanguage) params.append("language", selectedLanguage);

      const trendingRes = await axios.get(`/api/interaction/trending?${params}`);
      setTrending(trendingRes.data.trending || []);
    } catch (error) {
      if (process.env.NODE_ENV === "development") {
        console.error("Error fetching trending:", error);
      }
      setTrending([]);
    } finally {
      setLoadingTrending(false);
    }

    if (user) {
      try {
        const params = new URLSearchParams({ limit: 20 });
        if (selectedLanguage) params.append("language", selectedLanguage);

        const recRes = await axios.get(`/api/interaction/recommendations?${params}`);
        const recs = (recRes.data.recommendations || []).map((s) => {
          const id = s._id ?? s.id ?? s.songId ?? s.song_id;
          return id ? { ...s, _id: String(id) } : s;
        });
        setRecommendations(recs);


      } catch (error) {
        if (process.env.NODE_ENV === "development") {
          console.error("Error fetching recommendations:", error);
        }
        setRecommendations([]);
      } finally {
        setLoadingRecommendations(false);
      }
    } else {
      setLoadingRecommendations(false);
    }
  };

  const performApiSearch = async (searchQuery) => {
    if (!searchQuery) return;

    setSearchLoading(true);
    try {
      const params = new URLSearchParams({ q: searchQuery, limit: 100 });
      if (yearFilter) params.append("year", yearFilter);
      if (selectedLanguage) params.append("language", selectedLanguage);

      const { data } = await axios.get(`/api/song/search?${params}`);
      setApiSearchResults(data.songs || []);
      setApiAlbumResults(data.albums || []);
      setApiArtistResults(data.artists || []);
      setApiSingerResults(data.singers || []);
    } catch (error) {
      if (process.env.NODE_ENV === "development") {
        console.error("Error searching:", error);
      }
      setApiSearchResults([]);
      setApiAlbumResults([]);
      setApiArtistResults([]);
      setApiSingerResults([]);
    } finally {
      setSearchLoading(false);
    }
  };

  // Load albums when year filter changes
  useEffect(() => {
    if (yearFilter) {
      loadAlbumsByYear(yearFilter);
    } else {
      setYearAlbums([]);
    }
  }, [yearFilter, selectedLanguage]);

  const loadAlbumsByYear = async (year) => {
    setLoadingYearAlbums(true);
    try {
      const params = new URLSearchParams();
      if (selectedLanguage) params.append("language", selectedLanguage);

      const { data } = await axios.get(`/api/song/years/${year}/albums?${params}`);
      setYearAlbums(data.albums || []);
    } catch (error) {
      if (process.env.NODE_ENV === "development") {
        console.error("Error loading albums by year:", error);
      }
      setYearAlbums([]);
    } finally {
      setLoadingYearAlbums(false);
    }
  };

  const normalizedQuery = debouncedQuery.toLowerCase();

  const albumMatches = useMemo(() => {
    if (yearFilter && !normalizedQuery) {
      return yearAlbums;
    }

    if (!normalizedQuery) return [];

    // Use API results if available
    if (apiAlbumResults.length > 0) {
      return apiAlbumResults;
    }

    // Fallback to client-side search
    const sourceAlbums = yearFilter ? yearAlbums : albums;
    const filtered = sourceAlbums.filter((album) =>
      [album.title, album.description]
        .filter(Boolean)
        .some((field) => field.toLowerCase().includes(normalizedQuery))
    );

    return filtered;
  }, [albums, yearAlbums, normalizedQuery, yearFilter, apiAlbumResults]);

  const artistMatches = useMemo(() => {
    if (!normalizedQuery) return [];
    return apiArtistResults;
  }, [normalizedQuery, apiArtistResults]);

  const singerMatches = useMemo(() => {
    if (!normalizedQuery) return [];
    return apiSingerResults;
  }, [normalizedQuery, apiSingerResults]);

  const songMatches = useMemo(() => {
    // If searching with query, use API results (even if empty)
    if (normalizedQuery) {
      if (apiSearchResults.length > 0) {
        return apiSearchResults;
      }
      // API returned no results, do client-side fallback
      let filtered = songs.filter((song) =>
        [song.title, song.singer, song.description]
          .filter(Boolean)
          .some((field) => field.toLowerCase().includes(normalizedQuery))
      );

      if (yearFilter) {
        filtered = filtered.filter((song) => {
          const album = albums.find((a) => a._id === song.album);
          return album && album.year && album.year.toString() === yearFilter;
        });
      }

      return filtered;
    }

    // If only year filter is active (no query), get songs by year
    if (yearFilter) {
      const filtered = songs.filter((song) => {
        const album = albums.find((a) => a._id === song.album);
        return album && album.year && album.year.toString() === yearFilter;
      });
      return filtered;
    }

    return [];
  }, [songs, albums, normalizedQuery, yearFilter, apiSearchResults]);

  const handlePlaySong = async (id, sourceList) => {
    // Prefer the explicit source list if provided (recommendations/trending/search results)
    let listToUse =
      Array.isArray(sourceList) && sourceList.length ? sourceList : null;
    let label = "All Songs";

    // If no explicit list, derive from current UI context
    if (!listToUse) {
      // When searching, use the active tab's matches
      if (normalizedQuery || yearFilter) {
        if (searchType === "songs") {
          listToUse = songMatches;
          label = "Search Results";
        } else if (searchType === "albums") {
          // Albums map to songs via album click; keep fallback minimal
          listToUse = songMatches;
          label = "Search Results";
        } else {
          listToUse = songMatches;
          label = "Search Results";
        }
      }
    }

    // Final fallback to global songs only if still missing
    if (!listToUse || !listToUse.length) {
      listToUse = songs;
      label = "All Songs";
    }

    // Specific labels for known sections
    if (sourceList === recommendations) label = "Recommendations";
    if (sourceList === trending) label = "Trending";

    // Ensure we have the correct ID format - normalize to string and handle both id and _id
    const normalizedId = String(id);

    playQueue(listToUse, normalizedId, label);

    // Track search click
    if (query.trim()) {
      try {
        await axios.post("/api/interaction/track/search", {
          query: query.trim(),
          resultsCount: songMatches.length + albumMatches.length,
          clickedSongId: id,
        });
      } catch (error) {
        if (process.env.NODE_ENV === "development") {
          console.error("Error tracking search:", error);
        }
      }
    }
  };

  const handleAddSong = async (songId) => {
    await addToPlaylist(songId);
  };

  const handleRecentSearchClick = (searchQuery) => {
    setQuery(searchQuery);
  };

  return (
    <div className="px-2 md:px-6 py-4 pb-24">
      {/* Search Header */}
      <div className="mb-6 md:mb-8">
        <h1 className="text-2xl md:text-3xl font-bold mb-4">Search</h1>

        <SearchInput query={query} setQuery={setQuery} />

        <FilterChips
          yearFilter={yearFilter}
          setYearFilter={setYearFilter}
          availableYears={availableYears}
          searchType={searchType}
          setSearchType={setSearchType}
          showSearchType={normalizedQuery || yearFilter}
          counts={{
            songs: songMatches.length,
            albums: albumMatches.length,
            artists: artistMatches.length,
            singers: singerMatches.length,
          }}
        />
      </div>

      {/* Empty State - Show Trending and Recommendations */}
      {!normalizedQuery && !yearFilter ? (
        <div className="space-y-6 md:space-y-8">


          <TrendingSection
            loading={loadingTrending}
            trending={trending}
            onPlay={handlePlaySong}
          />

          {user && (
            <RecommendationsSection
              loading={loadingRecommendations}
              recommendations={recommendations}
              onPlay={handlePlaySong}
            />
          )}

          <BrowseSection navigate={navigate} />
        </div>
      ) : (
        /* Search Results */
        <SearchResults
          searchLoading={searchLoading}
          normalizedQuery={normalizedQuery}
          yearFilter={yearFilter}
          searchType={searchType}
          albumMatches={albumMatches}
          songMatches={songMatches}
          artistMatches={artistMatches}
          singerMatches={singerMatches}
          loadingYearAlbums={loadingYearAlbums}
          navigate={navigate}
          onPlay={handlePlaySong}
          onAdd={handleAddSong}
          query={query}
          setQuery={setQuery}
          setYearFilter={setYearFilter}
        />
      )}
    </div>
  );
};

export default Search;
