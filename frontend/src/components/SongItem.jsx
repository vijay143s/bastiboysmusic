import React, { useEffect, useState } from "react";
import { FaBookmark, FaPlay, FaRegBookmark } from "react-icons/fa";
import { RiPulseLine } from "react-icons/ri";
import { UserData } from "../context/User";
import { SongData } from "../context/Song";

const SongItem = ({ image, name, albumTitle, id }) => {
  const [saved, setSaved] = useState(false);

  const { addToPlaylist, user } = UserData();

  const { playFromSongs, selectedSong, isPlaying } = SongData();

  const playList = Array.isArray(user?.playlist) ? user.playlist : [];

  useEffect(() => {
    setSaved(playList.includes(id));
  }, [playList, id]);

  const handlePlay = () => {
    if (selectedSong === id && isPlaying) return;
    playFromSongs(id);
  };

  const savetoPlaylistHandler = () => {
    setSaved(!saved);
    addToPlaylist(id);
  };
  return (
    <div
      className={`min-w-[180px] p-2 px-3 rounded cursor-pointer transition-colors duration-200 hover:bg-[#ffffff26] ${
        selectedSong === id ? "bg-[#1db9541a] border border-green-500" : ""
      }`}
      onClick={handlePlay}
    >
      <div className="relative group">
        <img src={image} className="rounded w-[160px]" alt="" />
        <div className="flex gap-2">
          <button
            className="absolute bottom-2 right-14 bg-green-500 text-black p-3 rounded-full opacity-0 group-hover:opacity-100 transition-opacity duration-300"
            onClick={(e) => {
              e.stopPropagation();
              handlePlay();
            }}
          >
            <FaPlay />
          </button>
          <button
            className={`absolute bottom-2 right-2 p-3 rounded-full transition-all duration-300 ${
              saved
                ? "bg-green-500 text-white opacity-100 shadow-lg"
                : "bg-white bg-opacity-80 text-black opacity-0 group-hover:opacity-100"
            }`}
            onClick={(e) => {
              e.stopPropagation();
              savetoPlaylistHandler();
            }}
          >
            {saved ? <FaBookmark /> : <FaRegBookmark />}
          </button>
        </div>
      </div>
      <div className="flex items-center gap-2 mt-2 mb-1">
        {selectedSong === id && (
          <RiPulseLine
            className={`text-green-400 text-xl ${
              isPlaying ? "animate-pulse" : "opacity-50"
            }`}
          />
        )}
        <p className="font-bold">{name}</p>
      </div>
      <p className="text-slate-200 text-sm">{albumTitle || "Single"}</p>
    </div>
  );
};

export default SongItem;
