import React, { useState, useEffect, useMemo } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import { FaTimes } from 'react-icons/fa';
import { SongData } from '../context/Song';
import { UserData } from '../context/User';
import SearchInput from './search/SearchInput';
import SearchResults from './search/SearchResults';

import { useLanguage } from '../context/Language';

// Reusing logic from Search.jsx (simplified for modal)
const SearchModal = ({ isOpen, onClose }) => {
    const { songs, albums, playQueue } = SongData();
    const { addToPlaylist } = UserData();
    const { selectedLanguage } = useLanguage();
    const navigate = useNavigate();

    const [query, setQuery] = useState("");
    const [debouncedQuery, setDebouncedQuery] = useState("");
    const [searchLoading, setSearchLoading] = useState(false);

    // Search Results State
    const [apiSearchResults, setApiSearchResults] = useState([]);
    const [apiAlbumResults, setApiAlbumResults] = useState([]);
    const [apiArtistResults, setApiArtistResults] = useState([]);
    const [apiSingerResults, setApiSingerResults] = useState([]);

    // Search Type & Filters (Defaulting to 'songs' for modal to keep it simple initially)
    const [searchType, setSearchType] = useState("songs");
    const [yearFilter, setYearFilter] = useState("");

    // Close on Escape key
    useEffect(() => {
        const handleEsc = (e) => {
            if (e.key === 'Escape') onClose();
        };
        window.addEventListener('keydown', handleEsc);
        return () => window.removeEventListener('keydown', handleEsc);
    }, [onClose]);

    // Debouncing
    useEffect(() => {
        const timer = setTimeout(() => {
            setDebouncedQuery(query.trim());
        }, 300);
        return () => clearTimeout(timer);
    }, [query]);

    // Perform API Search
    useEffect(() => {
        if (!debouncedQuery) {
            setApiSearchResults([]);
            setApiAlbumResults([]);
            setApiArtistResults([]);
            setApiSingerResults([]);
            return;
        }

        const performSearch = async () => {
            setSearchLoading(true);
            try {
                const params = new URLSearchParams({ q: debouncedQuery, limit: 20 });
                if (selectedLanguage) params.append("language", selectedLanguage);

                const { data } = await axios.get(`/api/song/search?${params}`);
                setApiSearchResults(data.songs || []);
                setApiAlbumResults(data.albums || []);
                setApiArtistResults(data.artists || []);
                setApiSingerResults(data.singers || []);
            } catch (error) {
                console.error("Search error:", error);
            } finally {
                setSearchLoading(false);
            }
        };
        performSearch();
    }, [debouncedQuery, selectedLanguage]);

    // Derived Matches (Client-side fallback matches logic from Search.jsx)
    const normalizedQuery = debouncedQuery.toLowerCase();

    const albumMatches = useMemo(() => {
        if (!normalizedQuery) return [];
        if (apiAlbumResults.length > 0) return apiAlbumResults;
        // Fallback
        return albums.filter((album) =>
            [album.title, album.description].filter(Boolean).some((field) => field.toLowerCase().includes(normalizedQuery))
        );
    }, [albums, normalizedQuery, apiAlbumResults]);

    const songMatches = useMemo(() => {
        if (!normalizedQuery) return [];
        if (apiSearchResults.length > 0) return apiSearchResults;
        // Fallback
        return songs.filter((song) =>
            [song.title, song.singer, song.description].filter(Boolean).some((field) => field.toLowerCase().includes(normalizedQuery))
        );
    }, [songs, normalizedQuery, apiSearchResults]);

    // Handlers
    const handlePlaySong = (id) => {
        // Determine context
        let listToUse = songMatches.length > 0 ? songMatches : songs;
        const label = songMatches.length > 0 ? "Search Results" : "All Songs";
        const normalizedId = String(id);
        playQueue(listToUse, normalizedId, label);
        onClose(); // Optional: Close modal on play? Let's keep it open for now or user preference. User said "search in that page only", implies checking stuff. Let's keep open or close? Usually selecting a song plays it. I'll close it to show the player.
    };

    const handleAddSong = async (songId) => {
        await addToPlaylist(songId);
    };

    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 z-[60] flex items-start justify-center pt-20 px-4">
            {/* Backdrop */}
            <div
                className="absolute inset-0 bg-black/80 backdrop-blur-sm transition-opacity"
                onClick={onClose}
            ></div>

            {/* Modal Content */}
            <div className="relative w-full max-w-2xl bg-[#1e1e1e] border border-white/10 rounded-2xl shadow-2xl overflow-hidden flex flex-col max-h-[70vh] animate-in fade-in zoom-in-95 duration-200">

                {/* Header */}
                <div className="flex items-center gap-4 p-4 border-b border-white/5 bg-white/5">
                    <div className="flex-1">
                        <SearchInput query={query} setQuery={setQuery} autoFocus={true} />
                    </div>
                    {/* Close Button */}
                    <button
                        onClick={onClose}
                        className="p-2 text-gray-400 hover:text-white bg-white/5 hover:bg-white/10 rounded-full transition-colors"
                        aria-label="Close Search"
                    >
                        <FaTimes size={20} />
                    </button>
                </div>

                {/* Results Area */}
                <div className="flex-1 overflow-y-auto p-4 custom-scrollbar">
                    {normalizedQuery ? (
                        <SearchResults
                            searchLoading={searchLoading}
                            normalizedQuery={normalizedQuery}
                            yearFilter={yearFilter}
                            searchType={searchType}
                            albumMatches={albumMatches}
                            songMatches={songMatches}
                            artistMatches={apiArtistResults} // Simplified: passing api results directly
                            singerMatches={apiSingerResults}
                            navigate={(path) => { navigate(path); onClose(); }} // Close modal on navigation
                            onPlay={handlePlaySong}
                            onAdd={handleAddSong}
                            query={query}
                            setQuery={setQuery}
                            setYearFilter={null} // Disable year filter in simple modal for now
                            isModal={true} // Hint to sub-component if needed
                        />
                    ) : (
                        <div className="flex flex-col items-center justify-center h-40 text-gray-500 text-sm">
                            <p>Start typing to search...</p>
                        </div>
                    )}

                </div>
            </div>
        </div>
    );
};

export default SearchModal;
