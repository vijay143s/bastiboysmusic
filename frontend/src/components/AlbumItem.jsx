import React from "react";
import { useNavigate } from "react-router-dom";

const AlbumItem = ({ image, name, desc, id }) => {
  const navigate = useNavigate();
  return (
    <div
      onClick={() => navigate("/album/" + id)}
      className="bg-[#1c1c1c] rounded-xl p-4 cursor-pointer hover:bg-[#2a2a2a] transition flex flex-col"
    >
      <div className="aspect-square w-full overflow-hidden rounded-lg">
        <img src={image} className="w-full h-full object-cover" alt="" />
      </div>
      <p className="font-bold mt-4 mb-1 truncate">{name}</p>
    </div>
  );
};

export default AlbumItem;
