import React from "react";
import { FaFire } from "react-icons/fa";
import { RiMusicFill } from "react-icons/ri";
import HorizontalCard from "./HorizontalCard";

const TrendingSection = ({ loading, trending, onPlay }) => {
    return (
        <section>
            <div className="flex items-center justify-between mb-4">
                <div className="flex items-center gap-2">
                    <FaFire className="text-orange-500 text-lg" />
                    <h2 className="text-lg md:text-xl font-semibold">Trending Now</h2>
                    <span className="text-xs text-slate-500">Last 7 days</span>
                </div>
                {trending.length > 0 && (
                    <span className="text-xs text-slate-400">{trending.length} songs</span>
                )}
            </div>
            {loading ? (
                <div className="flex items-center justify-center py-10">
                    <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-500"></div>
                </div>
            ) : trending.length > 0 ? (
                <div className="flex gap-4 overflow-x-auto pb-4 scrollbar-hide">
                    {trending.map((song) => (
                        <HorizontalCard key={song._id || song.id} song={song} onPlay={(id) => onPlay(id, trending)} />
                    ))}
                </div>
            ) : (
                <div className="bg-[#1b1b1b] rounded-lg p-8 text-center">
                    <RiMusicFill className="text-4xl text-slate-600 mx-auto mb-2" />
                    <p className="text-slate-400">No trending songs available</p>
                </div>
            )}
        </section>
    );
};

export default TrendingSection;
