import React from "react";
import { assets } from "../assets/assets";
import { useNavigate } from "react-router-dom";
import { UserData } from "../context/User";

const NAV_ICON_SIZE = "w-5";

const Sidebar = () => {
  const navigate = useNavigate();
  const { user } = UserData();

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
      className={`w-full flex items-center gap-3 px-4 py-3 rounded-lg transition-colors text-left hover:bg-white/10 ${
        item.highlight ? "bg-white text-black hover:bg-white" : ""
      }`}
      onClick={() => navigate(item.path)}
    >
      <img src={item.icon} className={`${NAV_ICON_SIZE}`} alt="" />
      <div>
        <p className={`font-semibold ${item.highlight ? "text-black" : "text-white"}`}>
          {item.label}
        </p>
        {item.subtitle && (
          <p className={`text-xs ${item.highlight ? "text-black/70" : "text-gray-400"}`}>
            {item.subtitle}
          </p>
        )}
      </div>
    </button>
  );

  return (
    <aside className="hidden lg:flex w-[25%] h-full p-2 text-white">
      <div className="bg-[#121212] rounded-2xl flex flex-col w-full">
        <div className="px-5 py-4 border-b border-white/5">
          <p className="text-lg font-semibold">Browse</p>
        </div>

        <div className="flex-1 overflow-y-auto px-4 py-5 space-y-8">
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
      </div>
    </aside>
  );
};

export default Sidebar;
