import React from "react";
import { RiSparklingFill } from "react-icons/ri";
import HorizontalCard from "./HorizontalCard";

const RecommendationsSection = ({ loading, recommendations, onPlay }) => {
    return (
        <section>
            <div className="flex items-center justify-between mb-4">
                <div className="flex items-center gap-2">
                    <RiSparklingFill className="text-yellow-500 text-lg" />
                    <h2 className="text-lg md:text-xl font-semibold">Recommended For You</h2>
                </div>
                {recommendations.length > 0 && (
                    <span className="text-xs text-slate-400">
                        {recommendations.length} songs
                    </span>
                )}
            </div>
            {loading ? (
                <div className="flex items-center justify-center py-10">
                    <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-500"></div>
                </div>
            ) : recommendations.length > 0 ? (
                <div className="flex gap-4 overflow-x-auto pb-4 scrollbar-hide">
                    {recommendations.map((song) => (
                        <HorizontalCard key={song._id || song.id} song={song} onPlay={(id) => onPlay(id, recommendations)} />
                    ))}
                </div>
            ) : (
                <div className="bg-[#1b1b1b] rounded-lg p-8 text-center">
                    <RiSparklingFill className="text-4xl text-slate-600 mx-auto mb-2" />
                    <p className="text-slate-400 mb-2">No recommendations yet</p>
                    <p className="text-xs text-slate-500">
                        Start listening to get personalized recommendations
                    </p>
                </div>
            )}
        </section>
    );
};

export default RecommendationsSection;
