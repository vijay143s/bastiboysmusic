import React, { useState, useEffect } from "react";
import axios from "axios";
import { SongData } from "../context/Song";
import { FaPlay, FaPause, FaCalendarAlt } from "react-icons/fa";
import { AiFillHeart, AiOutlineHeart } from "react-icons/ai";
import { UserData } from "../context/User";

import { useLanguage } from "../context/Language";

const HeroSection = () => {
    const { setSelectedSong, setIsPlaying, selectedSong, isPlaying, playQueue } = SongData();
    const { user, addToPlaylist } = UserData();
    const { selectedLanguage } = useLanguage();
    const [featuredSong, setFeaturedSong] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchFeatured = async () => {
            try {
                setLoading(true);
                // Fetch top played song to feature, respecting language
                const params = new URLSearchParams();
                params.append("limit", 1);
                if (selectedLanguage) {
                    params.append("language", selectedLanguage);
                }

                const { data } = await axios.get(`/api/song/top-played?${params}`);
                if (data.songs && data.songs.length > 0) {
                    setFeaturedSong(data.songs[0]);
                } else {
                    // Fallback if no songs in language? Or just empty? 
                    // Let's try fetching without language as fallback if strictly needed, 
                    // but "filtering" usually means showing nothing if nothing matches.
                    // For a Hero section, showing *something* is better.
                    if (selectedLanguage) {
                        const fallbackParams = new URLSearchParams({ limit: 1 });
                        const { data: fallbackData } = await axios.get(`/api/song/top-played?${fallbackParams}`);
                        if (fallbackData.songs && fallbackData.songs.length > 0) {
                            setFeaturedSong(fallbackData.songs[0]);
                        }
                    }
                }
            } catch (error) {
                console.error("Error fetching featured song:", error);
            } finally {
                setLoading(false);
            }
        };
        fetchFeatured();
    }, [selectedLanguage]);

    if (loading || !featuredSong) return null;

    const handlePlay = () => {
        const songId = featuredSong._id || featuredSong.id;
        if (selectedSong === songId && isPlaying) {
            setIsPlaying(false);
        } else {
            playQueue([featuredSong], songId, "Featured Song");
        }
    };

    const handleAddToPlaylist = async (e) => {
        e.stopPropagation();
        if (!user || !user._id) return;
        const songId = featuredSong._id || featuredSong.id;
        await addToPlaylist(songId);
    };

    const isInPlaylist = user?.playlist?.includes(String(featuredSong._id || featuredSong.id));
    const isCurrentSong = selectedSong === (featuredSong._id || featuredSong.id);
    const isCurrentPlaying = isCurrentSong && isPlaying;

    return (
        <div className="relative w-full h-[400px] md:h-[500px] rounded-3xl overflow-hidden shadow-2xl group transition-all duration-500 hover:shadow-green-500/20 mb-12">
            {/* Background Image with Blur */}
            <div
                className="absolute inset-0 bg-cover bg-center transition-transform duration-1000 group-hover:scale-105"
                style={{ backgroundImage: `url(${featuredSong.thumbnail?.url || featuredSong.albumThumbnail})` }}
            ></div>

            {/* Gradient Overlay */}
            <div className="absolute inset-0 bg-gradient-to-t from-[#0f0f0f] via-[#0f0f0f]/60 to-transparent"></div>
            <div className="absolute inset-0 bg-gradient-to-r from-[#0f0f0f] via-[#0f0f0f]/40 to-transparent"></div>

            {/* Content */}
            <div className="absolute bottom-0 left-0 p-8 md:p-12 w-full md:w-2/3 flex flex-col items-start gap-4 md:gap-6 z-10">
                <div className="inline-block px-3 py-1 bg-green-500 text-black text-xs font-bold uppercase tracking-wider rounded-full mb-2 shadow-lg shadow-green-500/50">
                    #1 Trending Now
                </div>

                <h1 className="text-4xl md:text-6xl font-black text-white leading-tight drop-shadow-lg line-clamp-2">
                    {featuredSong.title}
                </h1>

                <div className="flex flex-wrap items-center gap-4 text-slate-300 text-sm md:text-base font-medium">
                    <span className="flex items-center gap-2">
                        <img
                            src={featuredSong.thumbnail?.url || featuredSong.albumThumbnail}
                            className="w-8 h-8 rounded-full border border-white/20"
                            alt="Artist"
                        />
                        {featuredSong.singer}
                    </span>
                    <span className="w-1.5 h-1.5 rounded-full bg-slate-500"></span>
                    <span>{featuredSong.albumName || "Single"}</span>
                    {featuredSong.year && (
                        <>
                            <span className="w-1.5 h-1.5 rounded-full bg-slate-500"></span>
                            <span className="flex items-center gap-1"><FaCalendarAlt size={12} /> {featuredSong.year}</span>
                        </>
                    )}
                </div>

                <div className="flex items-center gap-4 mt-4">
                    <button
                        onClick={handlePlay}
                        className="flex items-center gap-3 bg-green-500 text-black px-8 py-4 rounded-full font-bold text-lg hover:bg-green-400 hover:scale-105 transition-all shadow-xl shadow-green-500/30 active:scale-95"
                    >
                        {isCurrentPlaying ? <FaPause /> : <FaPlay />}
                        {isCurrentPlaying ? "Pause Now" : "Listen Now"}
                    </button>

                    <button
                        onClick={handleAddToPlaylist}
                        className={`p-4 rounded-full border-2 transition-all ${isInPlaylist ? 'bg-green-500/20 border-green-500 text-green-500' : 'border-white/20 text-white hover:bg-white/10'}`}
                    >
                        {isInPlaylist ? <AiFillHeart size={24} /> : <AiOutlineHeart size={24} />}
                    </button>
                </div>
            </div>
        </div>
    );
};

export default HeroSection;
