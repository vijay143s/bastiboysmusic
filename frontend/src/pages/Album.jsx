import React, { useEffect } from "react";
import { SongData } from "../context/Song";
import { useParams } from "react-router-dom";
import { assets } from "../assets/assets";
import { UserData } from "../context/User";
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
    <div className="px-2 md:px-0">
      {albumData && (
        <>
          {/* Album Header */}
          <div className="mt-6 md:mt-10 flex gap-4 md:gap-8 flex-col md:flex-row md:items-end">
            {albumData.thumbnail && (
              <img
                src={albumData.thumbnail.url}
                className="w-40 md:w-48 rounded"
                alt=""
              />
            )}

            <div className="flex flex-col flex-1">
              <p className="text-xs md:text-sm text-slate-400 mb-2">Album</p>
              <h2 className="text-2xl md:text-4xl lg:text-5xl font-bold mb-3 md:mb-4">
                {albumData.title}
              </h2>
              <h4 className="text-sm md:text-base text-gray-400 mb-3">
                <img
                  src={assets.spotify_logo}
                  className="inline-block w-5 md:w-6 mr-2"
                  alt=""
                />
                {albumData.title}
              </h4>
              <div className="flex flex-wrap gap-2 md:gap-3">
                <button
                  className="bg-green-500 text-black font-semibold px-4 md:px-5 py-2 rounded-full text-sm md:text-base"
                  onClick={handleShufflePlay}
                >
                  Shuffle
                </button>
                <button
                  className="border border-slate-500 px-4 md:px-5 py-2 rounded-full text-xs md:text-sm hover:border-white"
                  onClick={handleAddAlbumToPlaylist}
                >
                  Add All
                </button>
              </div>
            </div>
          </div>

          {/* Songs List - Mobile Format */}
          <div className="mt-6 md:mt-10">
            <div className="hidden md:grid md:grid-cols-4 mb-4 pl-2 text-[#a7a7a7] text-sm">
              <p><b>#</b></p>
              <p>Artist</p>
              <p>Album</p>
              <p className="text-center">Actions</p>
            </div>
            <hr className="hidden md:block" />

            {/* Mobile: Scrollable list, Desktop: Table */}
            <div className="space-y-2 md:space-y-0">
              {albumSong &&
                albumSong.map((e, i) => {
                  const isActive = selectedSong === e._id;
                  return (
                    <div
                      key={i}
                      className={`md:grid md:grid-cols-4 rounded transition cursor-pointer p-2 md:p-0 md:mt-2 active:scale-95 ${
                        isActive ? "bg-[#1db9541a] md:bg-transparent" : "hover:bg-[#ffffff2b] md:hover:bg-[#ffffff0a]"
                      }`}
                      onClick={() => startAlbumQueue(e._id)}
                    >
                      {/* Mobile Card View */}
                      <div className="md:hidden flex gap-3 items-start">
                        <div className="flex-shrink-0">
                          <img
                            src={e.thumbnail.url}
                            className="w-14 h-14 rounded object-cover"
                            alt=""
                          />
                        </div>
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-2">
                            <p className="text-white font-semibold flex items-center gap-2 truncate">
                              {isActive && (
                                <RiPulseLine
                                  className={`text-green-400 text-lg flex-shrink-0 ${
                                    isPlaying ? "animate-pulse" : "opacity-60"
                                  }`}
                                />
                              )}
                              <span className="truncate">{e.title}</span>
                            </p>
                          </div>
                          <p className="text-xs text-slate-400 truncate">{e.singer}</p>
                        </div>
                        <button
                          className={`p-2 rounded-full transition-all flex-shrink-0 ${
                            playlistIds.includes(e._id)
                              ? "bg-green-500 shadow-lg"
                              : ""
                          }`}
                          onClick={(event) => {
                            event.stopPropagation();
                            savePlayListHandler(e._id);
                          }}
                        >
                          <img 
                            src="/src/assets/like.png" 
                            alt="like" 
                            className="w-4 h-4"
                          />
                        </button>
                      </div>

                      {/* Desktop Table View */}
                      <p className="hidden md:flex text-white items-center gap-2">
                        <b className="text-[#a7a7a7] w-6">{i + 1}</b>
                        <img
                          src={e.thumbnail.url}
                          className="w-10 h-10 rounded object-cover"
                          alt=""
                        />
                        {isActive && (
                          <RiPulseLine
                            className={`text-green-400 flex-shrink-0 ${
                              isPlaying ? "animate-pulse" : "opacity-60"
                            }`}
                          />
                        )}
                        <span className="truncate">{e.title}</span>
                      </p>
                      <p className="hidden md:block text-[#a7a7a7] text-sm truncate">{e.singer}</p>
                      <p className="hidden md:block text-[#a7a7a7] text-sm truncate">{albumData.title}</p>
                      <div className="hidden md:flex justify-center">
                        <button
                          className={`p-2 rounded-full transition-all ${
                            playlistIds.includes(e._id)
                              ? "bg-green-500 shadow-lg"
                              : ""
                          }`}
                          onClick={(event) => {
                            event.stopPropagation();
                            savePlayListHandler(e._id);
                          }}
                        >
                          <img 
                            src="/src/assets/like.png" 
                            alt="like" 
                            className="w-5 h-5"
                          />
                        </button>
                      </div>
                    </div>
                  );
                })}
            </div>
          </div>
        </>
      )}
    </div>
  );
};

export default Album;
