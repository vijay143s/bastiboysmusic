import React from "react";
import { SongData } from "../context/Song";
import AlbumItem from "../components/AlbumItem";

const Home = () => {
  const { albums } = SongData();
  return (
    <div className="mb-8">
      <div className="flex items-center justify-between my-5">
        <h1 className="font-bold text-2xl">Featured Albums</h1>
        <p className="text-slate-400 text-sm">{albums.length} collections</p>
      </div>
      <div className="grid gap-4 grid-cols-[repeat(auto-fill,minmax(180px,1fr))]">
        {albums.map((e, i) => (
          <AlbumItem
            key={i}
            image={e.thumbnail.url}
            name={e.title}
            desc={e.description}
            id={e._id}
          />
        ))}
      </div>
    </div>
  );
};

export default Home;
