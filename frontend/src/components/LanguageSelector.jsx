import React, { useState, useRef, useEffect } from 'react';
import { useLanguage } from '../context/Language';
import { FaChevronDown } from 'react-icons/fa6';
import { IoLanguage } from 'react-icons/io5';

const LanguageSelector = () => {
    const { selectedLanguage, availableLanguages, changeLanguage } = useLanguage();
    const [isOpen, setIsOpen] = useState(false);
    const dropdownRef = useRef(null);

    // Close dropdown when clicking outside
    useEffect(() => {
        const handleClickOutside = (event) => {
            if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
                setIsOpen(false);
            }
        };

        document.addEventListener('mousedown', handleClickOutside);
        return () => {
            document.removeEventListener('mousedown', handleClickOutside);
        };
    }, []);

    const handleSelect = (lang) => {
        changeLanguage(lang);
        setIsOpen(false);
    };

    return (
        <div className="relative" ref={dropdownRef}>
            {/* Trigger Button */}
            <button
                onClick={() => setIsOpen(!isOpen)}
                className="flex items-center gap-2 px-4 py-2 bg-white/10 hover:bg-white/20 border border-white/10 rounded-full transition-all duration-300 backdrop-blur-md group"
            >
                <IoLanguage className="text-gray-300 group-hover:text-green-400 transition-colors" />
                <span className="text-sm font-medium text-white capitalize">
                    {selectedLanguage || "Select Language"}
                </span>
                <FaChevronDown
                    className={`text-xs text-gray-400 transition-transform duration-300 ${isOpen ? 'rotate-180' : ''}`}
                />
            </button>

            {/* Dropdown Menu */}
            {isOpen && (
                <div className="absolute right-0 mt-2 w-48 bg-[#1e1e1e]/90 backdrop-blur-xl border border-white/10 rounded-xl shadow-2xl overflow-hidden z-50 animate-in fade-in zoom-in-95 duration-200">
                    <div className="py-2">
                        {availableLanguages && availableLanguages.length > 0 ? (
                            availableLanguages.map((lang) => (
                                <button
                                    key={lang}
                                    onClick={() => handleSelect(lang)}
                                    className={`w-full text-left px-4 py-3 text-sm font-medium transition-all hover:bg-white/10 flex items-center justify-between group
                                        ${selectedLanguage === lang ? 'text-green-400 bg-green-500/10' : 'text-gray-300'}
                                    `}
                                >
                                    <span className="capitalize">{lang}</span>
                                    {selectedLanguage === lang && (
                                        <div className="w-2 h-2 rounded-full bg-green-400 shadow-[0_0_10px_rgba(74,222,128,0.5)]"></div>
                                    )}
                                </button>
                            ))
                        ) : (
                            <div className="px-4 py-3 text-sm text-gray-500 text-center">Loading...</div>
                        )}
                    </div>
                </div>
            )}
        </div>
    );
};

export default LanguageSelector;
