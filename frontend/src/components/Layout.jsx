import React, { useState } from "react";
import Sidebar from "./Sidebar";
import Navbar from "./Navbar";
import Player from "./Player";
import MobileBottomNav from "./MobileBottomNav";
import Disclaimer from "./Disclaimer";
import SearchModal from "./SearchModal";

const Layout = ({ children }) => {
  const [isSearchModalOpen, setIsSearchModalOpen] = useState(false);

  return (
    <div className="h-[100dvh] flex flex-col bg-transparent">
      {/* Fixed Top Navbar (Mobile) - with safe area for status bar */}
      <div className="lg:hidden fixed top-0 left-0 right-0 z-30 pt-[env(safe-area-inset-top)]">
        <Navbar />
      </div>

      {/* Main Content Area */}
      <div className="flex-1 flex overflow-hidden">
        {/* Desktop Sidebar */}
        <div className="hidden lg:block lg:w-80 xl:w-64 flex-shrink-0 p-4">
          <Sidebar />
        </div>

        {/* Content Area - with padding for fixed navbar on mobile */}
        <div className="flex-1 flex flex-col overflow-hidden min-w-0">
          <div className="flex-1 overflow-y-auto pb-[180px] lg:pb-0 pt-[60px] lg:pt-0 scroll-smooth">
            <div className="w-full lg:px-6 pt-4 pb-28">
              {/* Desktop Navbar */}
              <div className="hidden lg:block">
                <Navbar />
              </div>
              {children}
            </div>
          </div>
        </div>
      </div>

      {/* Search Modal Overlay */}
      <SearchModal isOpen={isSearchModalOpen} onClose={() => setIsSearchModalOpen(false)} />

      {/* Player - edge-to-edge on mobile, with margins on desktop */}
      <div className="fixed bottom-[calc(60px+env(safe-area-inset-bottom))] left-0 right-0 lg:bottom-4 lg:left-80 lg:right-4 z-20">
        <Player onSearchClick={() => setIsSearchModalOpen(true)} />
      </div>

      {/* Mobile Bottom Navigation (visible on mobile only) - fixed at bottom with safe area */}
      <div className="lg:hidden fixed bottom-0 left-0 right-0 z-40 pb-[env(safe-area-inset-bottom)]">
        <MobileBottomNav />
      </div>
    </div>
  );
};

export default Layout;
