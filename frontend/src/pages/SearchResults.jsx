import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import axios from "axios";
import SongItem from "../components/SongItem";
import AlbumItem from "../components/AlbumItem";
import Loading from "../components/Loading";

const SearchResults = () => {
  const { type, id, name } = useParams();
  const navigate = useNavigate();
  const [results, setResults] = useState([]);
  const [loading, setLoading] = useState(true);
  const [title, setTitle] = useState("");

  useEffect(() => {
    const fetchResults = async () => {
      try {
        setLoading(true);
        let response;
        let finalName = name;

        if (type === "album" && id) {
          response = await axios.get(`/api/home/albums/${id}/songs`);
          setTitle(`Songs from Album`);
        } else if (type === "artist" && id) {
          response = await axios.get(`/api/home/artists/${id}/albums`);
          setTitle(`Albums by Artist`);
        } else if (type === "singer") {
          finalName = decodeURIComponent(id);
          response = await axios.get(
            `/api/home/singers/${encodeURIComponent(finalName)}/songs`
          );
          setTitle(`Songs by ${finalName}`);
        } else if (type === "director") {
          finalName = decodeURIComponent(id);
          response = await axios.get(
            `/api/home/music-directors/${encodeURIComponent(finalName)}/albums`
          );
          setTitle(`Albums by Music Director ${finalName}`);
        }

        setResults(response?.data?.data || []);
      } catch (error) {
        console.error("Failed to fetch results:", error);
        setResults([]);
      } finally {
        setLoading(false);
      }
    };

    fetchResults();
  }, [type, id, name]);

  if (loading) return <Loading />;

  return (
    <div className="w-full px-4 md:px-6 py-4">
      <div className="flex items-center gap-4 mb-6">
        <button
          onClick={() => navigate(-1)}
          className="px-4 py-2 bg-gray-700 hover:bg-gray-600 text-white rounded-lg transition-colors"
        >
          ← Back
        </button>
        <h1 className="text-2xl md:text-3xl font-bold text-white">{title}</h1>
      </div>

      {results.length > 0 ? (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {type === "album" || type === "director" ? (
            results.map((album) => {
              const albumId = String(album._id || album.id);
              return (
                <AlbumItem
                  key={albumId}
                  image={album.thumbnail?.url}
                  name={album.title}
                  desc={album.description}
                  id={albumId}
                />
              );
            })
          ) : (
            results.map((song) => (
              <SongItem
                key={song._id}
                song={{
                  ...song,
                  id: song._id,
                }}
              />
            ))
          )}
        </div>
      ) : (
        <div className="text-gray-400 text-center py-12">
          No {type === "album" || type === "director" ? "albums" : "songs"} found
        </div>
      )}
    </div>
  );
};

export default SearchResults;
