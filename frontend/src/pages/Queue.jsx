import React, { useMemo } from "react";
import { SongData } from "../context/Song";
import { UserData } from "../context/User";
import { RiPulseLine } from "react-icons/ri";
import { FaBookmark, FaPlay, FaRegBookmark } from "react-icons/fa";

const Queue = () => {
  const { queue, queueIndex, queueLabel, playQueue, albums } = SongData();
  const { user, addToPlaylist } = UserData();

  const albumTitleMap = useMemo(() => {
    const map = new Map();
    albums.forEach((album) => map.set(album._id, album.title));
    return map;
  }, [albums]);

  const playlistSet = useMemo(() => {
    if (!user || !Array.isArray(user.playlist)) return new Set();
    return new Set(user.playlist);
  }, [user]);

  const nowPlaying = queue[queueIndex];
  const upcoming = queue.slice(queueIndex + 1);
  const previouslyPlayed = queue.slice(0, queueIndex).reverse();

  const handlePlayFromQueue = (songId) => {
    playQueue(queue, songId, queueLabel || "Queue");
  };

  const renderSongRow = (song, indexDisplay, isActive = false) => {
    const isSaved = playlistSet.has(song._id);
    return (
      <div
      key={song._id}
      className={`flex items-center justify-between px-4 py-3 rounded-lg transition cursor-pointer ${
        isActive ? "bg-[#1db9541a] border border-green-500" : "bg-[#1b1b1b] hover:bg-[#1f1f1f]"
      }`}
      onClick={() => handlePlayFromQueue(song._id)}
    >
      <div className="flex items-center gap-4">
        <div className="w-8 text-sm text-slate-400 text-center">{indexDisplay}</div>
        <img
          src={song.thumbnail?.url || "https://via.placeholder.com/64"}
          alt={song.title}
          className="w-12 h-12 rounded object-cover"
        />
        <div>
          <p className="font-semibold flex items-center gap-2">
            {isActive && (
              <RiPulseLine
                className={`text-green-400 text-xl ${
                  isActive ? "animate-pulse" : "opacity-60"
                }`}
              />
            )}
            {song.title}
          </p>
          <p className="text-sm text-slate-300">
            {song.singer || "Unknown artist"} • {albumTitleMap.get(song.album) || "Single"}
          </p>
        </div>
      </div>
      <div className="flex items-center gap-2">
        <button
          className="bg-white text-black rounded-full p-2"
          title="Play"
          onClick={(event) => {
            event.stopPropagation();
            handlePlayFromQueue(song._id);
          }}
        >
          <FaPlay />
        </button>
        <button
          className={`p-2 rounded-full transition-all duration-200 ${
            isSaved ? "bg-green-500 text-white shadow-lg" : "bg-white bg-opacity-80 text-black"
          }`}
          title={isSaved ? "Remove from playlist" : "Save to playlist"}
          onClick={async (event) => {
            event.stopPropagation();
            await addToPlaylist(song._id);
          }}
        >
          {isSaved ? <FaBookmark /> : <FaRegBookmark />}
        </button>
      </div>
    </div>
  );
  };

  return (
    <div className="py-8 space-y-8">
      <header className="space-y-2">
        <p className="uppercase text-xs tracking-[0.2em] text-slate-400">Current Queue</p>
        <h1 className="text-3xl font-bold">{queueLabel || "Queue"}</h1>
        <p className="text-slate-400">{queue.length} track{queue.length === 1 ? "" : "s"} queued</p>
        {queue.length > 0 && (
          <div className="flex gap-3 flex-wrap">
            <button
              className="bg-green-500 text-black font-semibold px-5 py-2 rounded-full"
              onClick={() => handlePlayFromQueue(queue[0]._id)}
            >
              Play from start
            </button>
            <button
              className="border border-slate-600 px-5 py-2 rounded-full text-sm"
              onClick={() => handlePlayFromQueue(nowPlaying?._id)}
              disabled={!nowPlaying}
            >
              Resume
            </button>
          </div>
        )}
      </header>

      {queue.length === 0 ? (
        <div className="bg-[#161616] border border-dashed border-slate-700 rounded-xl p-10 text-center">
          <p className="text-xl font-semibold mb-2">Your queue is empty</p>
          <p className="text-slate-400">
            Start playing any song, album, or playlist and we will keep the music going for you.
          </p>
        </div>
      ) : (
        <div className="space-y-8">
          {nowPlaying && (
            <section className="space-y-4">
              <h2 className="text-xl font-semibold">Now Playing</h2>
              {renderSongRow(nowPlaying, queueIndex + 1, true)}
            </section>
          )}

          {upcoming.length > 0 && (
            <section className="space-y-4">
              <h2 className="text-xl font-semibold">Up Next</h2>
              <div className="space-y-3">
                {upcoming.map((song, idx) => renderSongRow(song, queueIndex + idx + 2))}
              </div>
            </section>
          )}

          {previouslyPlayed.length > 0 && (
            <section className="space-y-4">
              <h2 className="text-xl font-semibold text-slate-300">Played Earlier</h2>
              <div className="space-y-3">
                {previouslyPlayed.map((song, idx) =>
                  renderSongRow(song, queueIndex - idx)
                )}
              </div>
            </section>
          )}
        </div>
      )}
    </div>
  );
};

export default Queue;
