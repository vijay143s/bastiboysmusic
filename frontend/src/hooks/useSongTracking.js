import axios from "axios";

/**
 * Hook to handle song interaction tracking (plays, completions, sessions)
 */
const useSongTracking = () => {

    const trackPlay = async (songId, duration) => {
        if (!songId) return;
        try {
            await axios.post(`/api/interaction/track/play/${songId}`, {
                source: 'player',
                listenDuration: duration
            });
        } catch (err) {
            if (process.env.NODE_ENV === 'development') {
                console.error("Error tracking play interaction:", err);
            }
        }
    };

    const trackCompletion = async (songId, duration, totalDuration) => {
        if (!songId) return;
        try {
            await axios.post(`/api/interaction/track/completion/${songId}`, {
                listenDuration: duration,
                totalDuration: totalDuration,
                source: 'player'
            });
        } catch (err) {
            if (process.env.NODE_ENV === 'development') {
                console.error("Error tracking completion:", err);
            }
        }
    };

    const trackSession = async (songId, duration, totalDuration) => {
        if (!songId) return;
        try {
            await axios.post(`/api/interaction/track/completion/${songId}`, {
                listenDuration: duration,
                totalDuration: totalDuration,
                source: 'player'
            });
        } catch (err) {
            if (process.env.NODE_ENV === 'development') {
                console.error("Error tracking listening session:", err);
            }
        }
    };

    return { trackPlay, trackCompletion, trackSession };
};

export default useSongTracking;
