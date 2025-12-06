import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { SongData } from "../context/Song";
import { useLanguage } from "../context/Language";
import HorizontalScroll from "../components/HorizontalScroll";
import TopPlayedSongs from "../components/TopPlayedSongs";
import LatestAlbums from "../components/LatestAlbums";
import { FaCalendarAlt, FaPlay } from "react-icons/fa";
import axios from "axios";
import HeroSection from "../components/HeroSection";


const ArtistCard = ({ artist, onNavigate }) => {
    return (
        <div
            onClick={() => onNavigate("artist", artist.artistId)}
            className="flex-shrink-0 w-36 md:w-44 text-center cursor-pointer group glass rounded-3xl p-3 hover:bg-white/10 transition-all hover:-translate-y-2 duration-300"
        >
            <div className="w-full aspect-square rounded-full relative mb-3 overflow-hidden shadow-2xl border-2 border-white/5 group-hover:border-green-500/50 transition-colors">
                <div className="absolute inset-0 bg-gradient-to-tr from-[#333] to-[#111] flex items-center justify-center">
                    <span className="text-5xl font-black text-white/20 group-hover:text-white transition-colors">
                        {artist.artistName?.[0]?.toUpperCase() || "A"}
                    </span>
                </div>
            </div>
            <h3 className="text-white font-bold text-sm md:text-base truncate group-hover:text-green-400 transition-colors">
                {artist.artistName}
            </h3>
            <p className="text-slate-400 text-xs mt-1 font-medium tracking-wide">
                {artist.albumCount} Releases
            </p>
        </div>
    );
};

const SingerCard = ({ singer, onNavigate }) => {
    return (
        <div
            onClick={() => onNavigate("singer", null, singer.singerName)}
            className="flex-shrink-0 w-36 md:w-44 text-center cursor-pointer group glass rounded-3xl p-3 hover:bg-white/10 transition-all hover:-translate-y-2 duration-300"
        >
            <div className="w-full aspect-square rounded-full relative mb-3 overflow-hidden shadow-2xl border-2 border-white/5 group-hover:border-blue-500/50 transition-colors">
                <div className="absolute inset-0 bg-gradient-to-tr from-indigo-900 to-purple-900 flex items-center justify-center pt-2">
                    <span className="text-5xl font-black text-white/40 group-hover:text-white transition-colors">
                        {singer.singerName?.[0]?.toUpperCase() || "S"}
                    </span>
                </div>
            </div>
            <h3 className="text-white font-bold text-sm md:text-base truncate group-hover:text-blue-400 transition-colors">
                {singer.singerName}
            </h3>
            <p className="text-slate-400 text-xs mt-1 font-medium tracking-wide">Vocalist</p>
        </div>
    );
};

const MusicDirectorCard = ({ director, onNavigate }) => {
    return (
        <div
            onClick={() => onNavigate("director", null, director.directorName)}
            className="flex-shrink-0 w-36 md:w-44 text-center cursor-pointer group glass rounded-3xl p-3 hover:bg-white/10 transition-all hover:-translate-y-2 duration-300"
        >
            <div className="w-full aspect-square rounded-full relative mb-3 overflow-hidden shadow-2xl border-2 border-white/5 group-hover:border-pink-500/50 transition-colors">
                <div className="absolute inset-0 bg-gradient-to-tr from-pink-900 to-rose-900 flex items-center justify-center">
                    <span className="text-5xl font-black text-white/40 group-hover:text-white transition-colors">
                        {director.directorName?.[0]?.toUpperCase() || "M"}
                    </span>
                </div>
            </div>
            <h3 className="text-white font-bold text-sm md:text-base truncate group-hover:text-pink-400 transition-colors">
                {director.directorName}
            </h3>
            <p className="text-slate-400 text-xs mt-1 font-medium tracking-wide">
                {director.albumCount} Albums
            </p>
        </div>
    );
};

const AlbumCard = ({ album, onNavigate }) => {
    return (
        <div
            onClick={() => onNavigate("album", album.id)}
            className="flex-shrink-0 w-40 md:w-48 cursor-pointer group p-3 glass rounded-2xl hover:bg-white/10 transition-all hover:-translate-y-1 duration-300"
        >
            <div className="w-full aspect-square rounded-xl overflow-hidden mb-4 relative shadow-lg group-hover:shadow-2xl transition-shadow">
                <img
                    src={album.thumbnail?.url || album.thumbnail_url || `data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='160' height='160'%3E%3Crect width='160' height='160' fill='%23333'/%3E%3Ctext x='80' y='80' text-anchor='middle' dy='0.3em' fill='%23fff' font-size='14'%3E${album.title || 'Album'}%3C/text%3E%3C/svg%3E`}
                    alt={album.title}
                    className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
                    onError={(e) => {
                        e.target.src = `data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='160' height='160'%3E%3Crect width='160' height='160' fill='%23333'/%3E%3Ctext x='80' y='80' text-anchor='middle' dy='0.3em' fill='%23fff' font-size='12'%3E${encodeURIComponent(album.title || 'Album')}%3C/text%3E%3C/svg%3E`;
                    }}
                />
                <div className="absolute inset-0 bg-black/20 group-hover:bg-transparent transition-colors"></div>
                {/* Play Icon on Hover */}
                <div className="absolute right-2 bottom-2 translate-y-4 opacity-0 group-hover:translate-y-0 group-hover:opacity-100 transition-all duration-300">
                    <div className="w-10 h-10 bg-green-500 rounded-full flex items-center justify-center shadow-xl text-black pl-1">
                        <FaPlay />
                    </div>
                </div>
            </div>
            <h3 className="text-white font-bold text-sm md:text-base truncate leading-tight">
                {album.title}
            </h3>
            <p className="text-slate-400 text-xs mt-1 font-medium">{album.year} • Album</p>
        </div>
    );
};

const Home = () => {
    const navigate = useNavigate();
    const { selectedLanguage } = useLanguage();
    const { albums: languageAlbums, loading: albumsLoading } = SongData();

    const [topArtists, setTopArtists] = useState([]);
    const [topSingers, setTopSingers] = useState([]);
    const [topDirectors, setTopDirectors] = useState([]);
    const [loading, setLoading] = useState(true);

    const handleCardClick = (type, id, name) => {
        if (type === "album") {
            navigate(`/results/album/${id}`);
        } else if (type === "artist") {
            navigate(`/results/artist/${id}`);
        } else if (type === "singer") {
            navigate(`/results/singer/${encodeURIComponent(name)}`);
        } else if (type === "director") {
            navigate(`/results/director/${encodeURIComponent(name)}`);
        }
    };

    useEffect(() => {
        const fetchArtistsAndSingers = async () => {
            try {
                setLoading(true);

                // Fetch artist and director info from API
                const params = new URLSearchParams();
                params.append("limit", 10);
                if (selectedLanguage) {
                    params.append("language", selectedLanguage);
                }

                try {
                    const artistsRes = await axios.get(`/api/home/artists/top?${params}`);
                    setTopArtists(artistsRes.data.data || []);
                } catch (e) {
                    console.log("Artists fetch optional");
                }

                try {
                    const singersRes = await axios.get(`/api/home/singers/top?${params}`);
                    setTopSingers(singersRes.data.data || []);
                } catch (e) {
                    console.log("Singers fetch optional");
                }

                try {
                    const directorsRes = await axios.get(`/api/home/music-directors/top?${params}`);
                    setTopDirectors(directorsRes.data.data || []);
                } catch (e) {
                    console.log("Directors fetch optional");
                }
            } catch (error) {
                console.error("Failed to fetch artists/singers:", error);
            } finally {
                setLoading(false);
            }
        };

        fetchArtistsAndSingers();
    }, [selectedLanguage]);



    // ... existing imports

    return (
        <div className="px-2 md:px-6 py-4 space-y-12">
            {/* Hero Section */}
            <HeroSection />

            {/* Top Played Songs Section */}
            <section className="relative">
                <TopPlayedSongs />
            </section>

            {/* Latest Albums with Smart Logic */}
            <LatestAlbums />

            {/* Top Artists Carousel */}
            <HorizontalScroll
                title="Top Artists"
                items={topArtists}
                loading={loading}
                renderItem={(artist) => (
                    <ArtistCard artist={artist} onNavigate={handleCardClick} />
                )}
                onMoreClick={() => navigate("/artists")}
            />

            {/* Top Singers Carousel */}
            <HorizontalScroll
                title="Top Singers"
                items={topSingers}
                loading={loading}
                renderItem={(singer) => (
                    <SingerCard singer={singer} onNavigate={handleCardClick} />
                )}
                onMoreClick={() => navigate("/singers")}
            />

            {/* Top Music Directors Carousel */}
            <HorizontalScroll
                title="Top Music Directors"
                items={topDirectors}
                loading={loading}
                renderItem={(director) => (
                    <MusicDirectorCard director={director} onNavigate={handleCardClick} />
                )}
                onMoreClick={() => navigate("/music-directors")}
            />

            {/* Years Section - Mobile Only */}
            <div className="block md:hidden pb-10">
                <div className="glass p-4 rounded-2xl flex items-center justify-between shadow-lg">
                    <h2 className="text-lg font-bold">Browse by Year</h2>
                    <button
                        onClick={() => navigate("/years")}
                        className="px-4 py-2 bg-white/10 rounded-full text-sm font-semibold hover:bg-white/20 transition-all"
                    >
                        See All
                    </button>
                </div>
            </div>
        </div>
    );
};

export default Home;
