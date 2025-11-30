import React, { useEffect, useMemo, useState } from "react";
import { SongData } from "../context/Song";
import { assets } from "../assets/assets";
import { RiPulseLine } from "react-icons/ri";
import { UserData } from "../context/User";
import toast from "react-hot-toast";

const PlayList = () => {
  const {
    songs,
    albums,
    selectedSong,
    isPlaying,
    playQueue,
  } = SongData();
  const { user, addToPlaylist } = UserData();
  const albumTitleMap = useMemo(() => {
    const map = new Map();
    albums.forEach((album) => map.set(album._id, album.title));
    return map;
  }, [albums]);

  const [myPlaylist, setMyPlaylist] = useState([]);

  useEffect(() => {
    if (songs && user && Array.isArray(user.playlist)) {
      const filteredSongs = songs.filter((e) =>
        user.playlist.includes(e._id.toString())
      );
      setMyPlaylist(filteredSongs);
    } else {
      setMyPlaylist([]);
    }
  }, [songs, user]);

  const startPlaylistQueue = (songId) => {
    if (!myPlaylist.length) return;
    playQueue(myPlaylist, songId, "My Playlist");
  };

  const savePlayListHandler = (id) => {
    addToPlaylist(id);
  };

  const handleShufflePlay = () => {
    if (!myPlaylist.length) {
      toast.error("Your playlist is empty");
      return;
    }
    const randomSong =
      myPlaylist[Math.floor(Math.random() * myPlaylist.length)];
    startPlaylistQueue(randomSong._id);
  };

  return (
    <div className="px-2 md:px-0">
      {/* Header Section */}
      <div className="mt-6 md:mt-10 flex gap-4 md:gap-8 flex-col md:flex-row md:items-end">
        {myPlaylist && myPlaylist[0] ? (
          <img
            src={myPlaylist[0].thumbnail.url}
            className="w-40 md:w-48 rounded"
            alt=""
          />
        ) : (
          <div className="w-40 md:w-48 aspect-square bg-[#333] rounded"></div>
        )}

        <div className="flex flex-col flex-1">
          <p className="text-xs md:text-sm text-slate-400 mb-2">Playlist</p>
          <h2 className="text-2xl md:text-4xl lg:text-5xl font-bold mb-2 md:mb-3">
            {user?.name ? `${user.name}'s Playlist` : "My Playlist"}
          </h2>
          <h4 className="text-sm md:text-base text-gray-400 mb-3">Your favorite songs</h4>
          <p className="mb-3 md:mb-4">
            <img
              src={assets.spotify_logo}
              className="inline-block w-5 md:w-6"
              alt=""
            />
          </p>
          <div className="flex gap-2 md:gap-3">
            <button
              className="bg-green-500 text-black font-semibold px-4 md:px-5 py-2 rounded-full text-sm md:text-base"
              onClick={handleShufflePlay}
            >
              Shuffle
            </button>
          </div>
        </div>
      </div>

      {/* Songs List */}
      <div className="mt-6 md:mt-10">
        {myPlaylist && myPlaylist.length === 0 ? (
          <div className="bg-[#161616] border border-dashed border-slate-700 rounded-xl p-6 md:p-10 text-center">
            <p className="text-lg md:text-xl font-semibold mb-2">Your playlist is empty</p>
            <p className="text-sm md:text-base text-slate-400">
              Start adding songs by clicking the like button on any track.
            </p>
          </div>
        ) : (
          <>
            {/* Desktop: Table Header */}
            <div className="hidden md:grid md:grid-cols-4 mb-4 pl-2 text-[#a7a7a7] text-sm">
              <p><b>#</b></p>
              <p>Artist</p>
              <p>Album</p>
              <p className="text-center">Actions</p>
            </div>
            <hr className="hidden md:block" />

            {/* Songs List */}
            <div className="space-y-2 md:space-y-0">
              {myPlaylist &&
                myPlaylist.map((e, i) => {
                  const isActive = selectedSong === e._id;
                  return (
                    <div
                      key={i}
                      className={`md:grid md:grid-cols-4 rounded transition cursor-pointer p-2 md:p-0 md:mt-2 active:scale-95 ${
                        isActive ? "bg-[#1db9541a] md:bg-transparent" : "hover:bg-[#ffffff0a]"
                      }`}
                      onClick={() => startPlaylistQueue(e._id)}
                    >
                      {/* Mobile Card View */}
                      <div className="md:hidden flex gap-3 items-start">
                        <div className="flex-shrink-0">
                          <img src={e.thumbnail.url} className="w-14 h-14 rounded object-cover" alt="" />
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
                          className="p-2 rounded-full bg-green-500 shadow-lg flex-shrink-0"
                          title="Remove from playlist"
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
                        <img src={e.thumbnail.url} className="w-10 h-10 rounded object-cover" alt="" />
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
                      <p className="hidden md:block text-[#a7a7a7] text-sm truncate">
                        {albumTitleMap.get(e.album) || "Single"}
                      </p>
                      <div className="hidden md:flex justify-center">
                        <button
                          className="p-2 rounded-full bg-green-500 shadow-lg"
                          title="Remove from playlist"
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
          </>
        )}
      </div>
    </div>
  );
};

export default PlayList;
