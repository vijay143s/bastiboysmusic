import React, { useMemo } from "react";
import { SongData } from "../context/Song";
import AlbumItem from "../components/AlbumItem";
import SongItem from "../components/SongItem";

const Home = () => {
  const { songs, albums } = SongData();

  const albumTitleMap = useMemo(() => {
    const map = new Map();
    albums.forEach((album) => map.set(album._id, album.title));
    return map;
  }, [albums]);
  return (
    <div className="mb-4">
      <h1 className="my-5 font-bold text-2xl">Featured Charts</h1>
      <div className="flex overflow-auto">
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

      <h1 className="my-5 font-bold text-2xl">Today's biggest hits</h1>
      <div className="flex overflow-auto">
        {songs.map((e, i) => (
          <SongItem
            key={i}
            image={e.thumbnail.url}
            name={e.title}
            id={e._id}
            albumTitle={albumTitleMap.get(e.album) || "Single"}
          />
        ))}
      </div>
    </div>
  );
};

export default Home;
