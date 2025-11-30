import React, { useEffect, useState } from "react";
import { useSearchParams } from "react-router-dom";
import axios from "axios";
import Loading from "../components/Loading";

const ArtistCard = ({ artist }) => {
  return (
    <div className="bg-gradient-to-br from-gray-800 to-gray-900 rounded-lg p-4 text-center hover:from-gray-700 hover:to-gray-800 transition-all cursor-pointer">
      <div className="w-20 h-20 mx-auto bg-green-500 rounded-full flex items-center justify-center mb-3">
        <span className="text-3xl font-bold text-black">
          {artist.artistName?.[0]?.toUpperCase() || "A"}
        </span>
      </div>
      <h3 className="text-white font-semibold text-sm truncate">
        {artist.artistName}
      </h3>
      <p className="text-gray-400 text-xs mt-1">
        {artist.albumCount} album{artist.albumCount !== 1 ? "s" : ""}
      </p>
    </div>
  );
};

const Artists = () => {
  const [artists, setArtists] = useState([]);
  const [loading, setLoading] = useState(true);
  const [pagination, setPagination] = useState(null);
  const [searchParams, setSearchParams] = useSearchParams();

  const page = Number(searchParams.get("page")) || 1;
  const limit = 12;

  useEffect(() => {
    const fetchArtists = async () => {
      try {
        setLoading(true);
        const response = await axios.get(
          `/api/home/artists?page=${page}&limit=${limit}`
        );
        setArtists(response.data.data);
        setPagination(response.data.pagination);
      } catch (error) {
        console.error("Failed to fetch artists:", error);
        setArtists([]);
      } finally {
        setLoading(false);
      }
    };

    fetchArtists();
  }, [page]);

  const handlePrevPage = () => {
    if (page > 1) {
      setSearchParams({ page: page - 1 });
    }
  };

  const handleNextPage = () => {
    if (pagination && page < pagination.pages) {
      setSearchParams({ page: page + 1 });
    }
  };

  if (loading) return <Loading />;

  return (
    <div className="w-full px-4 md:px-6 py-4">
      <h1 className="text-2xl md:text-3xl font-bold text-white mb-6">
        All Artists
      </h1>

      {artists.length > 0 ? (
        <>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 mb-8">
            {artists.map((artist) => (
              <ArtistCard key={artist.artistId} artist={artist} />
            ))}
          </div>

          {pagination && pagination.pages > 1 && (
            <div className="flex items-center justify-center gap-4 mt-8">
              <button
                onClick={handlePrevPage}
                disabled={page === 1}
                className="px-4 py-2 bg-green-500 text-black font-semibold rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-green-400 transition-colors"
              >
                Previous
              </button>

              <span className="text-white font-semibold">
                Page {pagination.page} of {pagination.pages}
              </span>

              <button
                onClick={handleNextPage}
                disabled={page >= pagination.pages}
                className="px-4 py-2 bg-green-500 text-black font-semibold rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-green-400 transition-colors"
              >
                Next
              </button>
            </div>
          )}
        </>
      ) : (
        <div className="text-gray-400 text-center py-12">
          No artists available
        </div>
      )}
    </div>
  );
};

export default Artists;
