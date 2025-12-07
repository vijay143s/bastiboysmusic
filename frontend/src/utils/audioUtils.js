/**
 * Transforms various audio URLs into browser-playable formats.
 * Specifically handles Google Drive "view" links by converting them to direct download links.
 * 
 * @param {string} url - The original audio URL
 * @returns {string} The playable audio URL
 */
export const getPlayableAudioUrl = (url) => {
    if (!url) return '';

    // Google Drive regex to extract file ID
    // Matches: 
    // - https://drive.google.com/file/d/FILE_ID/view
    // - https://drive.google.com/open?id=FILE_ID
    // - https://drive.google.com/uc?id=FILE_ID
    const driveRegex = /(?:drive\.google\.com\/(?:file\/d\/|open\?id=|uc\?id=)|drive\.google\.com\/file\/u\/[0-9]+\/d\/)([-\w]+)/;

    const match = url.match(driveRegex);

    if (match && match[1]) {
        const fileId = match[1];
        const directUrl = `https://drive.google.com/uc?export=download&id=${fileId}`;
        // Use the backend proxy to avoid CORS and format issues
        return `/api/audio/stream?url=${encodeURIComponent(directUrl)}`;
    }

    return url;
};
