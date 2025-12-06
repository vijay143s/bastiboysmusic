import React from "react";

const BrowseSection = ({ navigate }) => {
    return (
        <section>
            <h2 className="text-lg md:text-xl font-semibold mb-4">Browse</h2>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-3 md:gap-4">
                <button
                    key="browse-albums"
                    onClick={() => navigate("/albums")}
                    className="bg-gradient-to-br from-blue-600 to-blue-800 hover:from-blue-500 hover:to-blue-700 rounded-lg p-6 text-left transition-all group"
                >
                    <h3 className="font-bold text-lg mb-1">Albums</h3>
                    <p className="text-sm text-blue-200">Browse all albums</p>
                </button>
                <button
                    key="browse-artists"
                    onClick={() => navigate("/artists")}
                    className="bg-gradient-to-br from-purple-600 to-purple-800 hover:from-purple-500 hover:to-purple-700 rounded-lg p-6 text-left transition-all group"
                >
                    <h3 className="font-bold text-lg mb-1">Artists</h3>
                    <p className="text-sm text-purple-200">Explore artists</p>
                </button>
                <button
                    key="browse-singers"
                    onClick={() => navigate("/singers")}
                    className="bg-gradient-to-br from-pink-600 to-pink-800 hover:from-pink-500 hover:to-pink-700 rounded-lg p-6 text-left transition-all group"
                >
                    <h3 className="font-bold text-lg mb-1">Singers</h3>
                    <p className="text-sm text-pink-200">Find singers</p>
                </button>
                <button
                    key="browse-years"
                    onClick={() => navigate("/years")}
                    className="bg-gradient-to-br from-green-600 to-green-800 hover:from-green-500 hover:to-green-700 rounded-lg p-6 text-left transition-all group"
                >
                    <h3 className="font-bold text-lg mb-1">Years</h3>
                    <p className="text-sm text-green-200">Browse by year</p>
                </button>
            </div>
        </section>
    );
};

export default BrowseSection;
