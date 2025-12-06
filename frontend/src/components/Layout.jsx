import React, { useState } from "react";
import Sidebar from "./Sidebar";
import Navbar from "./Navbar";
import Player from "./Player";
import MobileBottomNav from "./MobileBottomNav";
import Disclaimer from "./Disclaimer";
import FloatingSearchButton from "./FloatingSearchButton";
import SearchModal from "./SearchModal";

const Layout = ({ children }) => {
  const [isSearchModalOpen, setIsSearchModalOpen] = useState(false);

  return (
    <div className="h-screen flex flex-col bg-transparent">
      {/* Main Content Area */}
      <div className="flex-1 flex overflow-hidden">
        {/* Desktop Sidebar */}
        <div className="hidden lg:block lg:w-80 xl:w-64 flex-shrink-0 p-4">
          <Sidebar />
        </div>

        {/* Content Area - with bottom padding on mobile to account for nav + player */}
        <div className="flex-1 flex flex-col overflow-hidden min-w-0">
          <div className="flex-1 overflow-y-auto pb-32 lg:pb-0 scroll-smooth">
            <div className="w-full lg:px-6 pt-4 pb-28">
              <Navbar />
              {children}
            </div>
          </div>
        </div>
      </div>

      {/* Floating Search Button - Now toggles modal */}
      <FloatingSearchButton onClick={() => setIsSearchModalOpen(true)} />

      {/* Search Modal Overlay */}
      <SearchModal isOpen={isSearchModalOpen} onClose={() => setIsSearchModalOpen(false)} />

      {/* Player - always visible, above bottom nav on mobile */}
      <div className="absolute bottom-20 left-4 right-4 lg:bottom-4 lg:left-80 lg:right-4 z-20">
        <Player />
      </div>

      {/* Mobile Bottom Navigation (visible on mobile only) - positioned above player on mobile */}
      <div className="lg:hidden z-40 relative">
        <MobileBottomNav />
      </div>
    </div>
  );
};

export default Layout;
