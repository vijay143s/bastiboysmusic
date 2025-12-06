import React from "react";
import { FaHistory } from "react-icons/fa";

const RecentSearches = ({ recentSearches, onSearchClick }) => {
    if (!recentSearches || recentSearches.length === 0) return null;

    return (
        <section>
            <div className="flex items-center gap-2 mb-4">
                <FaHistory className="text-slate-400 text-lg" />
                <h2 className="text-lg md:text-xl font-semibold">Recent Searches</h2>
            </div>
            <div className="flex flex-wrap gap-2">
                {recentSearches.map((search, idx) => (
                    <button
                        key={idx}
                        onClick={() => onSearchClick(search)}
                        className="bg-[#1b1b1b] hover:bg-[#252525] text-slate-300 px-4 py-2 rounded-full text-sm transition-all"
                    >
                        {search}
                    </button>
                ))}
            </div>
        </section>
    );
};

export default RecentSearches;
