import React, { useEffect } from "react";
import { SongData } from "../context/Song";
import { useParams, useNavigate } from "react-router-dom";
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
  const navigate = useNavigate();

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
    <div className="px-2 md:px-0 pb-24">
      {/* Back Button */}
      <div className="mb-4 md:mb-6">
        <button
          onClick={() => navigate(-1)}
          className="flex items-center justify-center w-10 h-10 bg-[#282828] hover:bg-[#3e3e3e] text-white rounded-full transition-all"
        >
          <img src={assets.arrow_left} alt="Back" className="w-4 h-4" />
        </button>
      </div>
      
      {albumData && (
        <>
          {/* Album Header with Gradient Background */}
          <div className="relative mb-8 md:mb-10">
            {/* Gradient Overlay */}
            <div className="absolute inset-0 bg-gradient-to-b from-[#1a1a1a] via-[#121212]/80 to-transparent -z-10 rounded-2xl blur-3xl opacity-60"></div>
            
            <div className="flex gap-4 md:gap-8 flex-col md:flex-row md:items-end">
              {albumData.thumbnail && (
                <div className="relative group">
                  <img
                    src={albumData.thumbnail.url}
                    className="w-48 h-48 md:w-56 md:h-56 lg:w-64 lg:h-64 rounded-lg shadow-2xl object-cover"
                    alt={`${albumData.title} album cover`}
                  />
                  <div className="absolute inset-0 bg-black/0 group-hover:bg-black/10 rounded-lg transition-all"></div>
                </div>
              )}

              <div className="flex flex-col flex-1 pb-2">
                <p className="text-xs md:text-sm font-semibold text-slate-400 mb-1 md:mb-2 tracking-wider uppercase">Album</p>
                <h2 className="text-3xl md:text-5xl lg:text-7xl font-black mb-4 md:mb-6 leading-tight tracking-tight">
                  {albumData.title}
                </h2>
                <div className="flex items-center gap-2 text-sm md:text-base text-slate-300 mb-4 md:mb-6">
                  <img
                    src={assets.spotify_logo}
                    className="w-6 h-6 md:w-7 md:h-7"
                    alt=""
                  />
                  <span className="font-semibold">{albumData.title}</span>
                  {albumSong && albumSong.length > 0 && (
                    <>
                      <span className="text-slate-500">•</span>
                      <span className="text-slate-400">{albumSong.length} song{albumSong.length !== 1 ? 's' : ''}</span>
                    </>
                  )}
                </div>
                <div className="flex flex-wrap gap-3 md:gap-4">
                  <button
                    className="bg-green-500 hover:bg-green-400 text-black font-bold px-8 py-3 rounded-full text-base md:text-lg transition-all hover:scale-105 shadow-lg"
                    onClick={handleShufflePlay}
                  >
                    Shuffle Play
                  </button>
                  <button
                    className="bg-transparent border-2 border-slate-600 hover:border-white text-white px-6 py-3 rounded-full text-sm md:text-base font-semibold transition-all hover:scale-105"
                    onClick={handleAddAlbumToPlaylist}
                  >
                    Add All to Playlist
                  </button>
                </div>
              </div>
            </div>
          </div>

          {/* Songs List */}
          <div className="bg-black/20 rounded-xl p-4 md:p-6">
            {/* Table Header - Desktop Only */}
            <div className="hidden md:grid md:grid-cols-[40px_1fr_200px_200px_80px] gap-4 px-4 pb-3 text-slate-400 text-xs uppercase tracking-wider border-b border-slate-800">
              <p className="text-center">#</p>
              <p>Title</p>
              <p>Artist</p>
              <p>Album</p>
              <p className="text-center">Like</p>
            </div>

            {/* Songs List */}
            <div className="mt-2 space-y-1">
              {albumSong &&
                albumSong.map((e, i) => {
                  const isActive = selectedSong === e._id;
                  const isSaved = playlistIds.includes(e._id);
                  return (
                    <div
                      key={i}
                      className={`group md:grid md:grid-cols-[40px_1fr_200px_200px_80px] gap-4 rounded-lg transition-all cursor-pointer p-3 md:px-4 md:py-3 ${
                        isActive 
                          ? "bg-[#1db954]/20 border border-green-500/30" 
                          : "hover:bg-white/5 active:bg-white/10"
                      }`}
                      onClick={() => startAlbumQueue(e._id)}
                    >
                      {/* Mobile Card View */}
                      <div className="md:hidden flex gap-3 items-center">
                        <div className="w-8 text-slate-400 text-sm font-medium flex-shrink-0 text-center">
                          {isActive ? (
                            <RiPulseLine className={`text-green-400 text-lg ${isPlaying ? "animate-pulse" : ""}`} />
                          ) : (
                            <span>{i + 1}</span>
                          )}
                        </div>
                        <div className="flex-shrink-0">
                          <img
                            src={e.thumbnail.url}
                            className="w-12 h-12 rounded-md object-cover shadow-md"
                            alt=""
                          />
                        </div>
                        <div className="flex-1 min-w-0">
                          <p className={`font-semibold truncate ${isActive ? 'text-green-400' : 'text-white'}`}>
                            {e.title}
                          </p>
                          <p className="text-sm text-slate-400 truncate">{e.singer}</p>
                        </div>
                        <button
                          className={`p-2 rounded-full transition-all flex-shrink-0 ${
                            isSaved ? "bg-green-500" : "hover:bg-white/10"
                          }`}
                          onClick={(event) => {
                            event.stopPropagation();
                            savePlayListHandler(e._id);
                          }}
                        >
                          <span className="text-white text-lg">{isSaved ? '\u2665' : '\u2661'}</span>
                        </button>
                      </div>

                      {/* Desktop Table View */}
                      <div className="hidden md:flex items-center justify-center text-slate-400 font-medium">
                        {isActive ? (
                          <RiPulseLine className={`text-green-400 text-xl ${isPlaying ? "animate-pulse" : ""}`} />
                        ) : (
                          <span className="group-hover:hidden">{i + 1}</span>
                        )}
                      </div>
                      
                      <div className="hidden md:flex items-center gap-3 min-w-0">
                        <img
                          src={e.thumbnail.url}
                          className="w-11 h-11 rounded-md object-cover shadow-md flex-shrink-0"
                          alt=""
                        />
                        <p className={`font-semibold truncate ${isActive ? 'text-green-400' : 'text-white group-hover:text-white'}`}>
                          {e.title}
                        </p>
                      </div>
                      
                      <p className="hidden md:block text-slate-400 text-sm truncate self-center group-hover:text-slate-300">
                        {e.singer}
                      </p>
                      
                      <p className="hidden md:block text-slate-500 text-sm truncate self-center">
                        {albumData.title}
                      </p>
                      
                      <div className="hidden md:flex justify-center items-center">
                        <button
                          className={`p-2 rounded-full transition-all ${
                            isSaved ? "bg-green-500" : "hover:bg-white/10"
                          }`}
                          onClick={(event) => {
                            event.stopPropagation();
                            savePlayListHandler(e._id);
                          }}
                        >
                          <span className="text-white text-lg">{isSaved ? '\u2665' : '\u2661'}</span>
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
