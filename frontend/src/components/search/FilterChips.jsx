import React from "react";

const FilterChips = ({
    yearFilter,
    setYearFilter,
    availableYears,
    searchType,
    setSearchType,
    showSearchType,
    counts,
}) => {
    return (
        <>
            {/* Year Filter Chips - Always visible */}
            <div className="flex gap-2 overflow-x-auto pb-2 scrollbar-hide mb-4">
                <button
                    onClick={() => setYearFilter("")}
                    className={`px-4 py-2 rounded-full text-xs md:text-sm font-medium transition-all flex-shrink-0 ${!yearFilter
                            ? "bg-green-500 text-black"
                            : "bg-[#1b1b1b] text-slate-300 hover:bg-[#252525]"
                        }`}
                >
                    All Years
                </button>
                {availableYears.slice(0, 10).map((year) => (
                    <button
                        key={year}
                        onClick={() => setYearFilter(year.toString())}
                        className={`px-4 py-2 rounded-full text-xs md:text-sm font-medium transition-all flex-shrink-0 ${yearFilter === year.toString()
                                ? "bg-green-500 text-black"
                                : "bg-[#1b1b1b] text-slate-300 hover:bg-[#252525]"
                            }`}
                    >
                        {year}
                    </button>
                ))}
            </div>

            {/* Search Type Filter - Show when searching or year filter active */}
            {showSearchType && (
                <div className="flex gap-2 border-b border-slate-700 overflow-x-auto">
                    <button
                        onClick={() => setSearchType("songs")}
                        className={`px-4 py-2 text-sm font-medium transition-all flex-shrink-0 ${searchType === "songs"
                                ? "text-green-500 border-b-2 border-green-500"
                                : "text-slate-400 hover:text-white"
                            }`}
                    >
                        Songs ({counts.songs})
                    </button>
                    <button
                        onClick={() => setSearchType("albums")}
                        className={`px-4 py-2 text-sm font-medium transition-all flex-shrink-0 ${searchType === "albums"
                                ? "text-green-500 border-b-2 border-green-500"
                                : "text-slate-400 hover:text-white"
                            }`}
                    >
                        Albums ({counts.albums})
                    </button>
                    <button
                        onClick={() => setSearchType("artists")}
                        className={`px-4 py-2 text-sm font-medium transition-all flex-shrink-0 ${searchType === "artists"
                                ? "text-green-500 border-b-2 border-green-500"
                                : "text-slate-400 hover:text-white"
                            }`}
                    >
                        Artists ({counts.artists})
                    </button>
                    <button
                        onClick={() => setSearchType("singers")}
                        className={`px-4 py-2 text-sm font-medium transition-all flex-shrink-0 ${searchType === "singers"
                                ? "text-green-500 border-b-2 border-green-500"
                                : "text-slate-400 hover:text-white"
                            }`}
                    >
                        Singers ({counts.singers})
                    </button>
                </div>
            )}
        </>
    );
};

export default FilterChips;
