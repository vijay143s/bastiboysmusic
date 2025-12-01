import React, { useState } from "react";
import { assets } from "../assets/assets";
import { useNavigate } from "react-router-dom";
import { UserData } from "../context/User";

const NAV_ICON_SIZE = "w-5";

const Sidebar = () => {
  const navigate = useNavigate();
  const { user, logoutUser } = UserData();
  const [isOpen, setIsOpen] = useState(false);

  const mainMenu = [
    {
      label: "Home",
      icon: assets.home_icon,
      path: "/",
    },
    {
      label: "Search",
      icon: assets.search_icon,
      path: "/search",
    },
    {
      label: "Queue",
      icon: assets.stack_icon,
      path: "/queue",
    },
    {
      label: "Community",
      icon: assets.plus_icon,
      path: "/community",
    },
  ];

  const libraryMenu = [
    {
      label: "My Playlist",
      icon: assets.stack_icon,
      path: "/playlist",
      subtitle: user?.name ? `Playlist • ${user.name}` : "Your saved songs",
    },
  ];

  if (user && user.role === "admin") {
    libraryMenu.push({
      label: "Admin Dashboard",
      icon: assets.arrow_icon,
      path: "/admin",
      highlight: true,
    });
  }

  const renderNavItem = (item) => (
    <button
      key={item.label}
      className={`w-full flex items-center gap-3 px-3 py-3 rounded-lg transition-colors text-left hover:bg-white/10 ${
        item.highlight ? "bg-white text-black hover:bg-white" : ""
      }`}
      onClick={() => navigate(item.path)}
    >
      <img src={item.icon} className={`${NAV_ICON_SIZE} flex-shrink-0`} alt="" />
      <div className="min-w-0 flex-1">
        <p className={`font-semibold truncate ${item.highlight ? "text-black" : "text-white"}`}>
          {item.label}
        </p>
        {item.subtitle && (
          <p className={`text-xs truncate ${item.highlight ? "text-black/70" : "text-gray-400"}`}>
            {item.subtitle}
          </p>
        )}
      </div>
    </button>
  );

  return (
    <>
      {/* Desktop Sidebar */}
      <aside className="hidden lg:flex w-full h-full p-2 text-white">
        <div className="bg-[#121212] rounded-2xl flex flex-col w-full min-w-0">
          <div className="px-5 py-4 border-b border-white/5 flex-shrink-0">
            <div className="flex items-center gap-2">
              <img src={assets.logo} alt="Logo" className="w-6 h-6" />
              <p className="text-lg font-semibold">Basti Boys Music</p>
            </div>
          </div>

          <div className="flex-1 overflow-y-auto px-4 py-5 space-y-6">
            <section className="space-y-1">
              {mainMenu.map(renderNavItem)}
            </section>
            <section className="space-y-2">
              <p className="uppercase text-xs tracking-[0.2em] text-gray-400 px-1">
                Your Library
              </p>
              <div className="space-y-1">{libraryMenu.map(renderNavItem)}</div>
            </section>
          </div>

          <div className="px-4 py-4 border-t border-white/5">
            <button
              className="w-full bg-white text-black font-semibold px-4 py-2 rounded-2xl cursor-pointer hover:bg-gray-200 transition-colors"
              onClick={logoutUser}
            >
              Logout
            </button>
          </div>
        </div>
      </aside>

      {/* Mobile Sidebar - Header with Menu Button */}
      <div className="lg:hidden">
        {/* Mobile Menu Button - Top Left */}
        <button
          onClick={() => setIsOpen(!isOpen)}
          className="fixed top-4 left-4 z-40 text-white text-3xl bg-[#1a1a1a] p-2 rounded-lg hover:bg-[#2a2a2a] transition active:scale-95"
        >
          ☰
        </button>
      </div>

      {/* Mobile Sidebar - Slide Out Menu */}
      {isOpen && (
        <div className="fixed inset-0 z-50 lg:hidden">
          {/* Overlay */}
          <div
            className="absolute inset-0 bg-black/60 backdrop-blur-sm"
            onClick={() => setIsOpen(false)}
          ></div>

          {/* Sidebar Content */}
          <aside className="absolute left-0 top-0 h-full w-72 bg-[#0f0f0f] text-white flex flex-col p-2 z-50 overflow-y-auto shadow-2xl rounded-r-2xl border-r border-white/10">
            {/* Header with Close Button */}
            <div className="flex justify-between items-center px-5 py-4 border-b border-white/5">
              <div className="flex items-center gap-2">
                <img src={assets.logo} alt="Logo" className="w-5 h-5" />
                <p className="text-lg font-semibold">Basti Boys Music</p>
              </div>
              <button
                onClick={() => setIsOpen(false)}
                className="text-white text-2xl hover:bg-white/10 p-1 rounded transition"
              >
                ✕
              </button>
            </div>

            {/* Menu Content */}
            <div className="flex-1 overflow-y-auto px-4 py-5 space-y-6">
              <section className="space-y-1">
                {mainMenu.map((item) => (
                  <button
                    key={item.label}
                    className="w-full flex items-center gap-3 px-4 py-3 rounded-lg transition-colors text-left hover:bg-white/10 active:bg-white/20"
                    onClick={() => {
                      navigate(item.path);
                      setIsOpen(false);
                    }}
                  >
                    <img src={item.icon} className="w-5" alt="" />
                    <p className="font-semibold text-white">{item.label}</p>
                  </button>
                ))}
              </section>

              <hr className="border-white/10" />

              <section className="space-y-2">
                <p className="uppercase text-xs tracking-[0.2em] text-gray-500 px-1">
                  Your Library
                </p>
                <div className="space-y-1">
                  {libraryMenu.map((item) => (
                    <button
                      key={item.label}
                      className={`w-full flex items-center gap-3 px-4 py-3 rounded-lg transition-colors text-left ${
                        item.highlight
                          ? "bg-white text-black hover:bg-gray-200"
                          : "hover:bg-white/10 active:bg-white/20"
                      }`}
                      onClick={() => {
                        navigate(item.path);
                        setIsOpen(false);
                      }}
                    >
                      <img src={item.icon} className="w-5" alt="" />
                      <div>
                        <p className={`font-semibold ${item.highlight ? "text-black" : "text-white"}`}>
                          {item.label}
                        </p>
                        {item.subtitle && (
                          <p className={`text-xs ${item.highlight ? "text-black/70" : "text-gray-500"}`}>
                            {item.subtitle}
                          </p>
                        )}
                      </div>
                    </button>
                  ))}
                </div>
              </section>
            </div>

            {/* Logout Button */}
            <div className="px-4 py-4 border-t border-white/5">
              <button
                className="w-full bg-green-500 text-black font-semibold px-4 py-3 rounded-2xl cursor-pointer hover:bg-green-400 transition-colors active:scale-95"
                onClick={() => {
                  logoutUser();
                  setIsOpen(false);
                }}
              >
                Logout
              </button>
            </div>
          </aside>
        </div>
      )}
    </>
  );
};

export default Sidebar;
