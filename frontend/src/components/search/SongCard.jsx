import React, { useState, useEffect, useRef } from "react";
import { FaPlay, FaEllipsisV } from "react-icons/fa";
import { AiOutlineMenu } from "react-icons/ai";
import { MdSkipNext, MdQueueMusic } from "react-icons/md";
import { SongData } from "../../context/Song";

const SongCard = ({ song, onPlay, onAdd }) => {
    const { addToQueue, playNext } = SongData();
    const [showMenu, setShowMenu] = useState(false);
    const menuRef = useRef(null);

    // Close menu when clicking outside
    useEffect(() => {
        const handleClickOutside = (event) => {
            if (menuRef.current && !menuRef.current.contains(event.target)) {
                setShowMenu(false);
            }
        };

        document.addEventListener("mousedown", handleClickOutside);
        return () => {
            document.removeEventListener("mousedown", handleClickOutside);
        };
    }, []);

    const handlePlayNext = (e) => {
        e.stopPropagation();
        playNext(song);
        setShowMenu(false);
    };

    const handleAddToQueue = (e) => {
        e.stopPropagation();
        addToQueue(song);
        setShowMenu(false);
    };

    return (
        <div
            className="glass hover:bg-white/10 rounded-2xl p-3 md:p-4 transition-all hover:scale-[1.02] cursor-pointer group relative border-transparent hover:border-white/10"
            onClick={() => onPlay(song._id || song.id)}
        >
            <div className="flex items-center gap-4">
                <div className="relative flex-shrink-0 w-14 h-14 md:w-16 md:h-16">
                    <img
                        src={
                            song.thumbnail?.url ||
                            song.thumbnail ||
                            "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='64' height='64'%3E%3Crect width='64' height='64' fill='%23333'/%3E%3C/svg%3E"
                        }
                        alt={song.title}
                        className="w-full h-full rounded-xl object-cover shadow-lg group-hover:shadow-xl transition-shadow"
                    />
                    <div className="absolute inset-0 bg-black/40 rounded-xl opacity-0 group-hover:opacity-100 flex items-center justify-center transition-all backdrop-blur-[2px]">
                        <FaPlay className="text-white text-xl drop-shadow-lg" />
                    </div>
                </div>
                <div className="flex-1 min-w-0">
                    <p className="font-bold text-white truncate text-sm md:text-base group-hover:text-green-400 transition-colors">
                        {song.title}
                    </p>
                    <p className="text-xs md:text-sm text-slate-400 truncate font-medium">
                        {song.singer || "Unknown artist"}
                    </p>
                    {song.albumName && (
                        <p className="text-[10px] md:text-xs text-slate-500 truncate mt-0.5">
                            {song.albumName}
                        </p>
                    )}
                </div>

                {/* Actions */}
                <div className="flex items-center gap-1 opacity-100 md:opacity-0 group-hover:opacity-100 transition-opacity">
                    <button
                        className="p-2.5 rounded-full transition-all hover:bg-white/10 active:scale-95"
                        title="Save to playlist"
                        onClick={(e) => {
                            e.stopPropagation();
                            onAdd(song._id || song.id);
                        }}
                    >
                        <span className="text-white text-xl">♡</span>
                    </button>

                    <div className="relative" ref={menuRef}>
                        <button
                            className="p-2.5 rounded-full transition-all hover:bg-white/10 active:scale-95"
                            onClick={(e) => {
                                e.stopPropagation();
                                setShowMenu(!showMenu);
                            }}
                        >
                            <FaEllipsisV className="text-slate-400 hover:text-white" />
                        </button>

                        {showMenu && (
                            <div className="absolute right-0 top-full mt-2 w-52 glass bg-[#1a1a1a]/90 rounded-xl shadow-2xl py-2 z-50 animate-fadeIn border border-white/10 backdrop-blur-xl">
                                <button
                                    onClick={handlePlayNext}
                                    className="w-full text-left px-4 py-3 text-sm text-white hover:bg-white/10 flex items-center gap-3 transition-colors"
                                >
                                    <MdSkipNext className="text-lg text-green-400" /> Play Next
                                </button>
                                <div className="h-px bg-white/10 mx-4 my-1"></div>
                                <button
                                    onClick={handleAddToQueue}
                                    className="w-full text-left px-4 py-3 text-sm text-white hover:bg-white/10 flex items-center gap-3 transition-colors"
                                >
                                    <MdQueueMusic className="text-lg text-blue-400" /> Add to Queue
                                </button>
                            </div>
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
};

export default SongCard;
