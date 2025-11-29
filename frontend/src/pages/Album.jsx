import React, { useEffect } from "react";
import { SongData } from "../context/Song";
import { useParams } from "react-router-dom";
import { assets } from "../assets/assets";
import { UserData } from "../context/User";
import { FaBookmark, FaPlay } from "react-icons/fa";
import { RiPulseLine } from "react-icons/ri";
import toast from "react-hot-toast";

const Album = () => {
  const {
    fetchAlbumSong,
    albumSong,
    albumData,
    selectedSong,
    isPlaying,
    playQueue,
  } = SongData();

  const params = useParams();

  useEffect(() => {
    fetchAlbumSong(params.id);
  }, [params.id]);

  const startAlbumQueue = (songId) => {
    if (!albumSong || albumSong.length === 0) return;
    const label = albumData?.title
      ? `${albumData.title} Queue`
      : "Album Queue";
    playQueue(albumSong, songId, label);
  };

  const { addToPlaylist, user } = UserData();
  const playlistIds = Array.isArray(user?.playlist) ? user.playlist : [];

  const handleShufflePlay = () => {
    if (!albumSong || albumSong.length === 0) {
      toast.error("No songs available to shuffle");
      return;
    }
    const randomSong =
      albumSong[Math.floor(Math.random() * albumSong.length)];
    startAlbumQueue(randomSong._id);
  };

  const handleAddAlbumToPlaylist = async () => {
    if (!albumSong || albumSong.length === 0) {
      toast.error("No songs available to add");
      return;
    }

    const playlistSet = new Set(playlistIds);
    const songsToAdd = albumSong.filter((song) => !playlistSet.has(song._id));

    if (songsToAdd.length === 0) {
      toast.success("All songs from this album are already in your playlist");
      return;
    }

    try {
      await Promise.all(
        songsToAdd.map((song) => addToPlaylist(song._id, { silent: true }))
      );
      toast.success(`Added ${songsToAdd.length} songs to your playlist`);
    } catch (error) {
      toast.error("Failed to add album to playlist");
    }
  };

  const savePlayListHandler = (id) => {
    addToPlaylist(id);
  };
  return (
    <div>
      {albumData && (
        <>
          <div className="mt-10 flex gap-8 flex-col md:flex-row md:items-center">
            {albumData.thumbnail && (
              <img
                src={albumData.thumbnail.url}
                className="w-48 rounded"
                alt=""
              />
            )}

            <div className="flex flex-col">
              <p>Playlist</p>
              <h2 className="text-3xl font-bold mb-4 md:text-5xl">
                {albumData.title} PlayList
              </h2>
              <h4 className="text-gray-300">Album • {albumData.title}</h4>
              <p className="mt-1">
                <img
                  src={assets.spotify_logo}
                  className="inline-block w-6"
                  alt=""
                />
              </p>
              <div className="flex flex-wrap gap-3 mt-4">
                <button
                  className="bg-green-500 text-black font-semibold px-5 py-2 rounded-full"
                  onClick={handleShufflePlay}
                >
                  Shuffle Play
                </button>
                <button
                  className="border border-slate-500 px-5 py-2 rounded-full text-sm hover:border-white"
                  onClick={handleAddAlbumToPlaylist}
                >
                  Add Album to Playlist
                </button>
              </div>
            </div>
          </div>

          <div className="grid grid-cols-3 sm:grid-cols-4 mt-10 mb-4 pl-2 text-[#a7a7a7]">
            <p>
              <b className="mr-4">#</b>
            </p>
            <p>Artist</p>
            <p className="hidden sm:block">Album</p>
            <p className="text-center">Actions</p>
          </div>

          <hr />
          {albumSong &&
            albumSong.map((e, i) => {
              const isActive = selectedSong === e._id;
              return (
                <div
                  className={`grid grid-cols-3 sm:grid-cols-4 mt-10 mb-4 pl-2 text-[#a7a7a7] cursor-pointer rounded ${
                    isActive ? "bg-[#1db9541a]" : "hover:bg-[#ffffff2b]"
                  }`}
                  key={i}
                  onClick={() => startAlbumQueue(e._id)}
                >
                  <p className="text-white flex items-center gap-3">
                    <b className="text-[#a7a7a7]">{i + 1}</b>
                    <img
                      src={e.thumbnail.url}
                      className="inline w-10"
                      alt=""
                    />
                    {isActive && (
                      <RiPulseLine
                        className={`text-green-400 ${
                          isPlaying ? "animate-pulse" : "opacity-60"
                        }`}
                      />
                    )}
                    {e.title}
                  </p>
                <p className="text-[15px]">{e.singer}</p>
                <p className="text-[15px] hidden sm:block">
                  {albumData.title}
                </p>
                <div className="flex justify-center items-center gap-5">
                  <button
                    className={`text-[15px] text-center p-2 rounded-full transition-all duration-200 ${
                      playlistIds.includes(e._id)
                        ? "bg-green-500 text-white shadow-lg"
                        : "bg-white bg-opacity-80 text-black"
                    }`}
                    title={
                      playlistIds.includes(e._id)
                        ? "Remove from playlist"
                        : "Save to playlist"
                    }
                    onClick={(event) => {
                      event.stopPropagation();
                      savePlayListHandler(e._id);
                    }}
                  >
                    <FaBookmark />
                  </button>
                  <button
                    className="text-[15px] text-center p-2 bg-white bg-opacity-80 rounded-full hover:bg-opacity-100"
                    onClick={(event) => {
                      event.stopPropagation();
                      startAlbumQueue(e._id);
                    }}
                  >
                    <FaPlay />
                  </button>
                </div>
                </div>
              );
            })}
        </>
      )}
    </div>
  );
};

export default Album;
