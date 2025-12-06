import React from "react";
import { FaPlay } from "react-icons/fa";

const HorizontalCard = ({ song, onPlay }) => {
    const songId = song._id || song.id;

    return (
        <div
            key={songId}
            className="flex-shrink-0 w-40 md:w-48 bg-[#181818] hover:bg-[#282828] rounded-lg p-3 transition-all cursor-pointer group"
            onClick={() => onPlay(songId)}
        >
            <div className="relative mb-3">
                <img
                    src={
                        song.thumbnail?.url ||
                        song.thumbnail ||
                        song.albumThumbnail ||
                        "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='160' height='160'%3E%3Crect width='160' height='160' fill='%23333'/%3E%3C/svg%3E"
                    }
                    alt={song.title}
                    className="w-full aspect-square rounded-md object-cover"
                />
                <button
                    className="absolute bottom-2 right-2 bg-green-500 hover:bg-green-400 text-black rounded-full p-3 opacity-0 group-hover:opacity-100 transform translate-y-2 group-hover:translate-y-0 transition-all shadow-lg"
                    onClick={(e) => {
                        e.stopPropagation();
                        onPlay(songId);
                    }}
                >
                    <FaPlay className="text-sm" />
                </button>
            </div>
            <div className="space-y-1">
                <p className="font-semibold text-white truncate text-sm">{song.title}</p>
                <p className="text-xs text-slate-400 truncate">
                    {song.singer || song.artist || "Unknown artist"}
                </p>
            </div>
        </div>
    );
};

export default HorizontalCard;
