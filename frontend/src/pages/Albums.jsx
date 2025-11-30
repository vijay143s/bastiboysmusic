import React, { useEffect, useState } from "react";
import { useSearchParams } from "react-router-dom";
import axios from "axios";
import AlbumItem from "../components/AlbumItem";
import Loading from "../components/Loading";

const Albums = () => {
  const [albums, setAlbums] = useState([]);
  const [loading, setLoading] = useState(true);
  const [pagination, setPagination] = useState(null);
  const [searchParams, setSearchParams] = useSearchParams();

  const page = Number(searchParams.get("page")) || 1;
  const limit = 12;

  useEffect(() => {
    const fetchAlbums = async () => {
      try {
        setLoading(true);
        const response = await axios.get(
          `/api/home/albums?page=${page}&limit=${limit}`
        );
        setAlbums(response.data.data);
        setPagination(response.data.pagination);
      } catch (error) {
        console.error("Failed to fetch albums:", error);
        setAlbums([]);
      } finally {
        setLoading(false);
      }
    };

    fetchAlbums();
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
        All Albums
      </h1>

      {albums.length > 0 ? (
        <>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 mb-8">
            {albums.map((album) => (
              <AlbumItem key={album._id} album={album} />
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
          No albums available
        </div>
      )}
    </div>
  );
};

export default Albums;
