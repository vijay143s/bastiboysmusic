import React from 'react';
import { FaDownload, FaTrash, FaSpinner, FaTimes } from 'react-icons/fa';
import { MdOfflinePin } from 'react-icons/md';
import useDownloadManager from '../hooks/useDownloadManager';

/**
 * Download Button Component - Hybrid Approach
 * Shows: "Make Available Offline" button for explicit downloads
 * Auto-cached songs show a subtle indicator but no download button
 */
const DownloadButton = ({ song, size = 'md', showLabel = false }) => {
    const songId = song?._id || song?.id;

    const {
        isDownloaded,
        downloadStatus,
        progress,
        startDownload,
        cancelDownload,
        deleteDownload
    } = useDownloadManager(songId);

    if (!song || !songId) return null;

    // Size configurations
    const sizeConfig = {
        sm: { icon: 14, button: 'p-1.5', text: 'text-xs' },
        md: { icon: 16, button: 'p-2', text: 'text-sm' },
        lg: { icon: 20, button: 'p-2.5', text: 'text-base' }
    };

    const config = sizeConfig[size] || sizeConfig.md;

    // State: Downloaded - Show "Available Offline" with delete option
    if (isDownloaded) {
        return (
            <div className="flex items-center gap-2">
                <div className="flex items-center gap-1 text-green-400">
                    <MdOfflinePin size={config.icon} />
                    {showLabel && <span className={config.text}>Offline</span>}
                </div>
                <button
                    onClick={(e) => {
                        e.stopPropagation();
                        if (window.confirm('Remove from offline storage?')) {
                            deleteDownload();
                        }
                    }}
                    className={`${config.button} rounded-full hover:bg-red-500/20 text-red-400 hover:text-red-300 transition-colors`}
                    title="Remove from offline storage"
                >
                    <FaTrash size={config.icon} />
                </button>
            </div>
        );
    }

    // State: Downloading - Show progress
    if (downloadStatus === 'downloading') {
        return (
            <div className="flex items-center gap-2">
                <div className="relative">
                    <svg className="transform -rotate-90" width={config.icon * 2} height={config.icon * 2}>
                        <circle
                            cx={config.icon}
                            cy={config.icon}
                            r={config.icon - 2}
                            stroke="currentColor"
                            strokeWidth="2"
                            fill="none"
                            className="text-gray-700"
                        />
                        <circle
                            cx={config.icon}
                            cy={config.icon}
                            r={config.icon - 2}
                            stroke="currentColor"
                            strokeWidth="2"
                            fill="none"
                            strokeDasharray={`${2 * Math.PI * (config.icon - 2)}`}
                            strokeDashoffset={`${2 * Math.PI * (config.icon - 2) * (1 - progress / 100)}`}
                            className="text-green-400 transition-all duration-300"
                        />
                    </svg>
                    <div className="absolute inset-0 flex items-center justify-center">
                        <span className="text-[8px] font-bold text-white">{progress}%</span>
                    </div>
                </div>
                {showLabel && (
                    <span className={`${config.text} text-gray-400`}>Saving...</span>
                )}
                <button
                    onClick={(e) => {
                        e.stopPropagation();
                        cancelDownload();
                    }}
                    className={`${config.button} rounded-full hover:bg-red-500/20 text-red-400 hover:text-red-300 transition-colors`}
                    title="Cancel"
                >
                    <FaTimes size={config.icon} />
                </button>
            </div>
        );
    }

    // State: Queued - Show spinner
    if (downloadStatus === 'queued') {
        return (
            <div className="flex items-center gap-2">
                <FaSpinner className="animate-spin text-yellow-400" size={config.icon} />
                {showLabel && (
                    <span className={`${config.text} text-gray-400`}>Queued...</span>
                )}
                <button
                    onClick={(e) => {
                        e.stopPropagation();
                        cancelDownload();
                    }}
                    className={`${config.button} rounded-full hover:bg-red-500/20 text-red-400 hover:text-red-300 transition-colors`}
                    title="Cancel"
                >
                    <FaTimes size={config.icon} />
                </button>
            </div>
        );
    }

    // State: Failed - Show retry button
    if (downloadStatus === 'failed') {
        return (
            <button
                onClick={(e) => {
                    e.stopPropagation();
                    startDownload(song);
                }}
                className={`${config.button} rounded-full hover:bg-yellow-500/20 text-yellow-400 hover:text-yellow-300 transition-colors flex items-center gap-1`}
                title="Retry download"
            >
                <FaDownload size={config.icon} />
                {showLabel && <span className={config.text}>Retry</span>}
            </button>
        );
    }

    // Default State: Show "Make Available Offline" button
    return (
        <button
            onClick={(e) => {
                e.stopPropagation();
                startDownload(song);
            }}
            className={`${config.button} rounded-full hover:bg-green-500/20 text-gray-400 hover:text-green-400 transition-colors flex items-center gap-1`}
            title="Make available offline"
        >
            <FaDownload size={config.icon} />
            {showLabel && <span className={config.text}>Offline</span>}
        </button>
    );
};

export default DownloadButton;
