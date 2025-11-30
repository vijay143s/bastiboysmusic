import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { SongData } from "../context/Song";
import HorizontalScroll from "../components/HorizontalScroll";
import axios from "axios";

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
          src={album.thumbnail?.url}
          alt={album.title}
          className="w-full h-full object-cover group-hover:scale-105 transition-transform"
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
  const [latestAlbums, setLatestAlbums] = useState([]);
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
    const fetchHomeSections = async () => {
      try {
        setLoading(true);
        const [albumsRes, artistsRes, singersRes, directorsRes] = await Promise.all([
          axios.get("/api/home/albums/latest?limit=10"),
          axios.get("/api/home/artists/top?limit=10"),
          axios.get("/api/home/singers/top?limit=10"),
          axios.get("/api/home/music-directors/top?limit=10"),
        ]);

        setLatestAlbums(albumsRes.data.data);
        setTopArtists(artistsRes.data.data);
        setTopSingers(singersRes.data.data);
        setTopDirectors(directorsRes.data.data);
      } catch (error) {
        console.error("Failed to fetch home sections:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchHomeSections();
  }, []);

  return (
    <div className="px-2 md:px-6 py-4">
      {/* Latest Albums 2025 */}
      <HorizontalScroll
        title="Latest Albums (2025)"
        items={latestAlbums}
        loading={loading}
        renderItem={(album) => (
          <AlbumCard album={album} onNavigate={handleCardClick} />
        )}
        onMoreClick={() => navigate("/albums")}
      />

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
    </div>
  );
};

export default Home;
