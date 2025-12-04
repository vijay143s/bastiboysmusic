import React from "react";
import { assets } from "../assets/assets";
import { useNavigate } from "react-router-dom";
import { UserData } from "../context/User";
import { useLanguage } from "../context/Language";
import ProfileMenu from "./ProfileMenu";

const Navbar = () => {
  const navigate = useNavigate();
  const { user } = UserData();
  const { selectedLanguage, availableLanguages, changeLanguage } = useLanguage();
  
  return (
    <>
      <div className="w-full flex justify-between items-center font-semibold px-3 py-2 bg-[#121212] border-b border-white/10">
        {/* Mobile logo and name - visible on mobile only */}
        <div className="lg:hidden flex items-center gap-2">
          <img 
            src={assets.logo} 
            alt="Logo" 
            className="w-6 h-6 cursor-pointer"
            onClick={() => navigate("/")}
          />
          <span className="text-white text-sm">Basti Boys Music</span>
        </div>
        
        {/* Desktop - empty div for spacing */}
        <div className="hidden lg:block"></div>
        
        <div className="flex items-center gap-4">
          {/* Language Selector */}
          <select
            value={selectedLanguage || ""}
            onChange={(e) => changeLanguage(e.target.value)}
            className="px-3 py-1 rounded bg-[#282828] text-white border border-white/20 hover:bg-[#3a3a3a] transition cursor-pointer text-sm"
          >
            {availableLanguages.length > 0 ? (
              availableLanguages.map((lang) => (
                <option key={lang} value={lang}>
                  {lang.charAt(0).toUpperCase() + lang.slice(1)}
                </option>
              ))
            ) : (
              <option value="">Loading languages...</option>
            )}
          </select>
          
          {user && <ProfileMenu />}
        </div>
      </div>
    </>
  );
};

export default Navbar;
