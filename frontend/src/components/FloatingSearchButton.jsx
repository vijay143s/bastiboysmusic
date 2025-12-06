import React from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { FaSearch } from 'react-icons/fa';

const FloatingSearchButton = ({ onClick }) => {
    const navigate = useNavigate();
    const location = useLocation();

    // Hide button if already on search page (optional, but good for UX so we don't have double search)
    if (location.pathname === '/search') return null;

    return (
        <button
            onClick={onClick}
            className="fixed bottom-24 right-4 md:bottom-28 md:right-8 z-50 p-4 bg-green-500 text-black rounded-full shadow-lg hover:scale-110 active:scale-95 transition-all duration-300 group"
            aria-label="Search"
        >
            <FaSearch size={20} className="group-hover:rotate-90 transition-transform duration-300" />
        </button>
    );
};

export default FloatingSearchButton;
