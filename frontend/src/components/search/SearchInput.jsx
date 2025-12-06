import React from "react";
import { RiSearchLine, RiCloseLine } from "react-icons/ri";

const SearchInput = ({ query, setQuery }) => {
    return (
        <div className="relative mb-4">
            <RiSearchLine className="absolute left-4 top-1/2 transform -translate-y-1/2 text-slate-400 text-xl" />
            <input
                type="text"
                placeholder="Search songs, albums, artists, or year..."
                value={query}
                onChange={(e) => setQuery(e.target.value)}
                className="w-full bg-[#1b1b1b] text-white placeholder-slate-400 pl-12 pr-12 py-3 md:py-4 rounded-xl border border-slate-700 focus:border-green-500 focus:outline-none transition-all text-sm md:text-base"
            />
            {query && (
                <button
                    onClick={() => setQuery("")}
                    className="absolute right-4 top-1/2 transform -translate-y-1/2 text-slate-400 hover:text-white transition-colors"
                >
                    <RiCloseLine className="text-2xl" />
                </button>
            )}
        </div>
    );
};

export default SearchInput;
