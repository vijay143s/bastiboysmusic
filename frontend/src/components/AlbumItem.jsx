import React from "react";
import { useNavigate } from "react-router-dom";

const AlbumItem = ({ image, name, desc, id }) => {
  const navigate = useNavigate();
  return (
    <div
      onClick={() => navigate("/album/" + id)}
      className="bg-[#1c1c1c] rounded-lg p-2 md:p-4 cursor-pointer hover:bg-[#2a2a2a] transition flex flex-col active:scale-95"
    >
      <div className="aspect-square w-full overflow-hidden rounded">
        <img src={image} className="w-full h-full object-cover hover:scale-105 transition" alt="" />
      </div>
      <p className="font-bold mt-2 md:mt-4 mb-1 truncate text-sm md:text-base">{name}</p>
      <p className="text-xs md:text-sm text-gray-400 line-clamp-2">{desc}</p>
    </div>
  );
};

export default AlbumItem;
