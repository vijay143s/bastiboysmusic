import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { SongData } from "../context/Song";
import { useLanguage } from "../context/Language";
import HorizontalScroll from "../components/HorizontalScroll";
import TopPlayedSongs from "../components/TopPlayedSongs";
import LatestAlbums from "../components/LatestAlbums";
import { FaCalendarAlt } from "react-icons/fa";
import axios from "axios";
import { 
  useAlbumsByLanguage, 
  useAvailableYearsByLanguage,
  useAllSongsByLanguage 
} from "../lib/useLanguageContent";

const ArtistCard = ({ artist, onNavigate }) => {
  return (
    <div
      onClick={() => onNavigate("artist", artist.artistId)}
      className="flex-shrink-0 w-40 text-center cursor-pointer group"
    >
      <div className="w-full h-40 bg-gradient-to-br from-gray-800 to-gray-900 rounded-lg flex items-center justify-center mb-3 group-hover:from-gray-700 group-hover:to-gray-800 transition-all">
        <div className="w-24 h-24 bg-green-500 rounded-full flex items-center justify-center group-hover:bg-green-400 transition-colors">
          <span className="text-4xl font-bold text-black">
            {artist.artistName?.[0]?.toUpperCase() || "A"}
          </span>
        </div>
      </div>
      <h3 className="text-white font-semibold text-sm truncate group-hover:text-green-400 transition-colors">
        {artist.artistName}
      </h3>
      <p className="text-gray-400 text-xs mt-1">
        {artist.albumCount} album{artist.albumCount !== 1 ? "s" : ""}
      </p>
    </div>
  );
};

const SingerCard = ({ singer, onNavigate }) => {
  return (
    <div
      onClick={() => onNavigate("singer", null, singer.singerName)}
      className="flex-shrink-0 w-40 text-center cursor-pointer group"
    >
      <div className="w-full h-40 bg-gradient-to-br from-gray-800 to-gray-900 rounded-lg flex items-center justify-center mb-3 group-hover:from-gray-700 group-hover:to-gray-800 transition-all">
        <div className="w-24 h-24 bg-green-500 rounded-full flex items-center justify-center group-hover:bg-green-400 transition-colors">
          <span className="text-4xl font-bold text-black">
            {singer.singerName?.[0]?.toUpperCase() || "S"}
          </span>
        </div>
      </div>
      <h3 className="text-white font-semibold text-sm truncate group-hover:text-green-400 transition-colors">
        {singer.singerName}
      </h3>
      <p className="text-gray-400 text-xs mt-1">Singer</p>
    </div>
  );
};

const MusicDirectorCard = ({ director, onNavigate }) => {
  return (
    <div
      onClick={() => onNavigate("director", null, director.directorName)}
      className="flex-shrink-0 w-40 text-center cursor-pointer group"
    >
      <div className="w-full h-40 bg-gradient-to-br from-gray-800 to-gray-900 rounded-lg flex items-center justify-center mb-3 group-hover:from-gray-700 group-hover:to-gray-800 transition-all">
        <div className="w-24 h-24 bg-green-500 rounded-full flex items-center justify-center group-hover:bg-green-400 transition-colors">
          <span className="text-4xl font-bold text-black">
            {director.directorName?.[0]?.toUpperCase() || "M"}
          </span>
        </div>
      </div>
      <h3 className="text-white font-semibold text-sm truncate group-hover:text-green-400 transition-colors">
        {director.directorName}
      </h3>
      <p className="text-gray-400 text-xs mt-1">
        {director.albumCount} album{director.albumCount !== 1 ? "s" : ""}
      </p>
    </div>
  );
};

const AlbumCard = ({ album, onNavigate }) => {
  return (
    <div
      onClick={() => onNavigate("album", album.id)}
      className="flex-shrink-0 w-40 cursor-pointer group"
    >
      <div className="w-full h-40 bg-gradient-to-br from-gray-800 to-gray-900 rounded-lg overflow-hidden mb-3 group-hover:opacity-80 transition-opacity">
        <img
          src={album.thumbnail?.url || album.thumbnail_url || "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='160' height='160'%3E%3Crect width='160' height='160' fill='%23333'/%3E%3Ctext x='80' y='80' text-anchor='middle' dy='0.3em' fill='%23fff' font-size='14'%3E${album.title || 'Album'}%3C/text%3E%3C/svg%3E"}
          alt={album.title}
          className="w-full h-full object-cover group-hover:scale-105 transition-transform"
          onError={(e) => {
            e.target.src = `data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='160' height='160'%3E%3Crect width='160' height='160' fill='%23333'/%3E%3Ctext x='80' y='80' text-anchor='middle' dy='0.3em' fill='%23fff' font-size='12'%3E${encodeURIComponent(album.title || 'Album')}%3C/text%3E%3C/svg%3E`;
          }}
        />
      </div>
      <h3 className="text-white font-semibold text-sm truncate group-hover:text-green-400 transition-colors">
        {album.title}
      </h3>
      <p className="text-gray-400 text-xs mt-1">{album.year}</p>
    </div>
  );
};

const Home = () => {
  const navigate = useNavigate();
  const { language } = useLanguage();
  
  // Fetch language-specific content
  const { albums: languageAlbums, loading: albumsLoading } = useAlbumsByLanguage(10, 1);
  const { years, loading: yearsLoading } = useAvailableYearsByLanguage();
  const { songs: allSongs, loading: songsLoading } = useAllSongsByLanguage();

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
        
        // Get unique artists, singers, directors from language-specific songs
        const artistSet = new Set();
        const singerSet = new Set();
        const directorSet = new Set();

        allSongs.forEach(song => {
          if (song.singer) {
            singerSet.add(song.singer);
          }
        });

        // Fetch artist and director info from API
        try {
          const artistsRes = await axios.get("/api/home/artists/top?limit=10");
          setTopArtists(artistsRes.data.data || []);
        } catch (e) {
          console.log("Artists fetch optional");
        }

        try {
          const singersRes = await axios.get("/api/home/singers/top?limit=10");
          setTopSingers(singersRes.data.data || []);
        } catch (e) {
          console.log("Singers fetch optional");
        }

        try {
          const directorsRes = await axios.get("/api/home/music-directors/top?limit=10");
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

    if (allSongs.length > 0) {
      fetchArtistsAndSingers();
    }
  }, [allSongs, language]);

  return (
    <div className="px-2 md:px-6 py-4">
      {/* Top Played Songs Section */}
      <TopPlayedSongs />

      {/* Latest Albums with Smart Logic */}
      <LatestAlbums />

      {/* Top Artists */}
      <HorizontalScroll
        title="Top Artists"
        items={topArtists}
        loading={loading}
        renderItem={(artist) => (
          <ArtistCard artist={artist} onNavigate={handleCardClick} />
        )}
        onMoreClick={() => navigate("/artists")}
      />

      {/* Top Singers */}
      <HorizontalScroll
        title="Top Singers"
        items={topSingers}
        loading={loading}
        renderItem={(singer) => (
          <SingerCard singer={singer} onNavigate={handleCardClick} />
        )}
        onMoreClick={() => navigate("/singers")}
      />

      {/* Top Music Directors */}
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
      <div className="block md:hidden">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-xl font-bold">Browse by Year ({language.toUpperCase()})</h2>
          <button
            onClick={() => navigate("/years")}
            className="text-sm text-green-400 hover:text-green-300 transition-colors"
          >
            See All
          </button>
        </div>
        <div className="grid grid-cols-3 gap-3">
          {yearsLoading ? (
            Array(6).fill(0).map((_, i) => (
              <div key={i} className="bg-[#1a1a1a] rounded-lg h-24 animate-pulse"></div>
            ))
          ) : (
            years.slice(0, 6).map((year) => (
              <button
                key={year}
                onClick={() => navigate(`/years?year=${year}`)}
                className="bg-gradient-to-br from-gray-800 to-gray-900 hover:from-gray-700 hover:to-gray-800 rounded-lg p-4 transition-all group"
              >
                <FaCalendarAlt className="text-green-500 text-2xl mb-2 mx-auto" />
                <p className="text-white font-bold text-center">{year}</p>
              </button>
            ))
          )}
        </div>
      </div>
    </div>
  );
};

export default Home;
