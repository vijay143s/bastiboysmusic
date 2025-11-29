import React, { useEffect, useMemo, useState } from "react";
import { SongData } from "../context/Song";
import { assets } from "../assets/assets";
import { FaBookmark, FaPlay } from "react-icons/fa";
import { RiPulseLine } from "react-icons/ri";
import { UserData } from "../context/User";
import toast from "react-hot-toast";

const PlayList = () => {
  const {
    songs,
    setSelectedSong,
    setIsPlaying,
    albums,
    selectedSong,
    isPlaying,
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

  const onclickHander = (id) => {
    setSelectedSong(id);
    setIsPlaying(true);
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
    onclickHander(randomSong._id);
  };

  return (
    <div>
      <div className="mt-10 flex gap-8 flex-col md:flex-row md:items-center">
        {myPlaylist && myPlaylist[0] ? (
          <img
            src={myPlaylist[0].thumbnail.url}
            className="w-48 rounded"
            alt=""
          />
        ) : (
          <img
            src="https://via.placeholder.com/250"
            className="w-48 rounded"
            alt=""
          />
        )}

        <div className="flex flex-col">
          <p>Playlist</p>
          <h2 className="text-3xl font-bold mb-4 md:text-5xl">
            {user?.name ? `${user.name} PlayList` : "My PlayList"}
          </h2>
          <h4>Your Favourate songs</h4>
          <p className="mt-1">
            <img
              src={assets.spotify_logo}
              className="inline-block w-6"
              alt=""
            />
          </p>
          <div className="flex gap-3 mt-4 flex-wrap">
            <button
              className="bg-green-500 text-black font-semibold px-5 py-2 rounded-full"
              onClick={handleShufflePlay}
            >
              Shuffle Play
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
      {myPlaylist &&
        myPlaylist.map((e, i) => {
          const isActive = selectedSong === e._id;
          return (
            <div
              className={`grid grid-cols-3 sm:grid-cols-4 mt-10 mb-4 pl-2 text-[#a7a7a7] cursor-pointer rounded ${
                isActive ? "bg-[#1db9541a]" : "hover:bg-[#ffffff2b]"
              }`}
              key={i}
              onClick={() => onclickHander(e._id)}
            >
              <p className="text-white flex items-center gap-3">
                <b className="text-[#a7a7a7]">{i + 1}</b>
                <img src={e.thumbnail.url} className="inline w-10" alt="" />
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
                {albumTitleMap.get(e.album) || "Single"}
              </p>
              <div className="flex justify-center items-center gap-5">
                <button
                  className="text-[15px] text-center text-green-500"
                  title="Remove from playlist"
                  onClick={(event) => {
                    event.stopPropagation();
                    savePlayListHandler(e._id);
                  }}
                >
                  <FaBookmark />
                </button>
                <button
                  className="text-[15px] text-center"
                  onClick={(event) => {
                    event.stopPropagation();
                    onclickHander(e._id);
                  }}
                >
                  <FaPlay />
                </button>
              </div>
            </div>
          );
        })}
    </div>
  );
};

export default PlayList;
