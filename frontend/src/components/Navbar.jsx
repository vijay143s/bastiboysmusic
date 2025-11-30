import React from "react";
import { assets } from "../assets/assets";
import { useNavigate } from "react-router-dom";
import { UserData } from "../context/User";
import ProfileMenu from "./ProfileMenu";

const Navbar = () => {
  const navigate = useNavigate();
  const { user } = UserData();
  
  return (
    <>
      <div className="w-full flex justify-between items-center font-semibold px-3 py-2 bg-[#121212] border-b border-white/10">
        <div className="flex items-center gap-2">
          <img 
            src={assets.logo} 
            alt="Logo" 
            className="w-6 h-6 cursor-pointer"
            onClick={() => navigate("/")}
          />
          <span className="hidden sm:inline text-white text-sm">Basti Boys Music</span>
        </div>
        
        {user && <ProfileMenu />}
      </div>
    </>
  );
};

export default Navbar;
