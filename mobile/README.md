# BastiBoys Music - Mobile App

React Native mobile application for BastiBoys Music streaming platform.

## Features

- 🎵 Stream music from BastiBoys Music catalog
- 🔐 User authentication (Login/Register)
- 🎨 Beautiful, modern UI with dark theme
- 🎧 Full-featured music player with background playback
- 📱 Queue management
- 🔍 Search functionality
- 🌐 Multi-language support (Telugu, Hindi, Tamil, Kannada, Malayalam)
- 💾 Offline queue persistence
- 🔔 Lock screen controls

## Prerequisites

- Node.js (v14 or higher)
- npm or yarn
- Expo CLI (`npm install -g expo-cli`)
- For iOS: macOS with Xcode
- For Android: Android Studio with Android SDK

## Installation

1. Navigate to the mobile directory:
```bash
cd mobile
```

2. Install dependencies:
```bash
npm install
```

3. Create `.env` file from `.env.example`:
```bash
cp .env.example .env
```

4. Update the API URL in `.env`:
```
API_BASE_URL=https://your-api-domain.com
```

**Important**: Replace `https://your-api-domain.com` with your actual backend API URL. Do NOT use `localhost` as mobile devices cannot access localhost from your computer.

## Running the App

### Development Mode

Start the Expo development server:
```bash
npm start
```

This will open Expo DevTools in your browser with a QR code.

### Test on Android

**Option 1: Physical Device**
1. Install Expo Go app from Google Play Store
2. Scan the QR code from Expo DevTools

**Option 2: Android Emulator**
1. Start Android emulator from Android Studio
2. Press `a` in the terminal where Expo is running

### Test on iOS

**Option 1: Physical Device (iPhone)**
1. Install Expo Go app from App Store
2. Scan the QR code using the Camera app

**Option 2: iOS Simulator (macOS only)**
1. Press `i` in the terminal where Expo is running

## Project Structure

```
mobile/
├── App.js                  # Root component
├── app.json               # Expo configuration
├── package.json           # Dependencies
├── src/
│   ├── components/        # Reusable components
│   │   ├── Loading.js
│   │   └── MiniPlayer.js
│   ├── screens/          # Screen components
│   │   ├── LoginScreen.js
│   │   ├── RegisterScreen.js
│   │   ├── HomeScreen.js
│   │   ├── SearchScreen.js
│   │   ├── PlayerScreen.js
│   │   ├── QueueScreen.js
│   │   ├── LibraryScreen.js
│   │   ├── ProfileScreen.js
│   │   ├── AlbumScreen.js
│   │   └── PlaylistScreen.js
│   ├── navigation/       # Navigation setup
│   │   └── AppNavigator.js
│   ├── context/          # Context providers
│   │   ├── User.jsx
│   │   ├── Song.jsx
│   │   └── Language.jsx
│   ├── services/         # API and audio services
│   │   ├── api.js
│   │   └── audioPlayer.js
│   ├── constants/        # App constants
│   │   └── index.js
│   └── utils/           # Utility functions
└── assets/              # Images, fonts, etc.
```

## Building for Production

### Android APK

```bash
expo build:android
```

### iOS IPA (requires Apple Developer account)

```bash
expo build:ios
```

## Key Technologies

- **React Native**: Cross-platform mobile framework
- **Expo**: Development platform and toolchain
- **React Navigation**: Navigation library
- **expo-av**: Audio/video playback
- **Axios**: HTTP client
- **AsyncStorage**: Local data persistence
- **SecureStore**: Secure token storage

## Features Implemented

### Authentication
- ✅ Login with email/password
- ✅ User registration
- ✅ Secure token storage
- ✅ Auto-login on app launch

### Music Playback
- ✅ Play/pause controls
- ✅ Next/previous track
- ✅ Seek functionality
- ✅ Background audio playback
- ✅ Lock screen controls
- ✅ Queue management

### User Interface
- ✅ Home screen with trending songs
- ✅ Search functionality
- ✅ Full-screen player
- ✅ Mini player on all screens
- ✅ Queue view and management
- ✅ Album browsing
- ✅ Profile and settings

### Additional Features
- ✅ Multi-language support
- ✅ Queue persistence
- ✅ Pull-to-refresh
- ✅ Dark theme
- ✅ Toast notifications

## Troubleshooting

### API Connection Issues

If you're having trouble connecting to the API:

1. Make sure your backend is running and accessible
2. Check that the API_BASE_URL in `.env` is correct
3. Ensure your mobile device/emulator can reach the API URL
4. For local development, use your computer's IP address instead of localhost:
   ```
   API_BASE_URL=http://192.168.1.100:5000
   ```

### Audio Playback Issues

If audio doesn't play:

1. Check that the audio URLs from your API are accessible
2. Verify that expo-av is properly installed
3. Check device volume and permissions

### Build Errors

If you encounter build errors:

1. Clear cache: `expo start -c`
2. Reinstall dependencies: `rm -rf node_modules && npm install`
3. Update Expo: `expo upgrade`

## Support

For issues or questions, please contact the development team.

## License

MIT
