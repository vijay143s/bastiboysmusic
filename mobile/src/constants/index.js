// Use your local network IP instead of localhost for mobile devices
// Find your IP: Windows (ipconfig), Mac/Linux (ifconfig)
export const API_BASE_URL = process.env.EXPO_PUBLIC_API_URL || 'http://192.168.31.112:5000';

export const COLORS = {
    primary: '#1DB954',
    secondary: '#191414',
    background: '#121212',
    card: '#181818',
    text: '#FFFFFF',
    textSecondary: '#B3B3B3',
    border: '#282828',
    error: '#E22134',
    success: '#1DB954',
    warning: '#FFA500',
};

export const SIZES = {
    padding: 16,
    margin: 16,
    borderRadius: 8,
    iconSize: 24,
    headerHeight: 60,
    miniPlayerHeight: 70,
    tabBarHeight: 60,
};

export const FONTS = {
    regular: 'System',
    medium: 'System',
    bold: 'System',
    light: 'System',
};
