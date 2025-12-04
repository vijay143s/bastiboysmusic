# BastiBoys Music - iOS Application

A native iOS music streaming application built with SwiftUI that connects to your existing Node.js backend API.

## Features

### 🎵 Core Features
- **Authentication**: Login and registration with JWT token management
- **Music Streaming**: Stream songs with high-quality audio playback
- **Search**: Smart search with filters by year and category
- **Playlists**: Create and manage personal playlists
- **Library**: Browse albums, artists, and your music collection
- **Queue Management**: Advanced queue with shuffle and repeat modes

### 🎨 User Interface
- **Modern SwiftUI Design**: Native iOS interface with smooth animations
- **Dark Mode Support**: Automatic dark/light mode switching
- **Responsive Layout**: Optimized for iPhone and iPad
- **Mini Player**: Background music control with full-screen player
- **Tab Navigation**: Easy navigation between Home, Search, Library, and Profile

### 🔊 Audio Features
- **Background Playback**: Continue listening when app is minimized
- **Remote Control**: Control playback from Control Center and Lock Screen
- **Audio Session Management**: Proper audio interruption handling
- **Multiple Audio Quality**: Adaptive streaming based on network conditions

### 🚀 Performance & UX
- **Network Monitoring**: Automatic offline detection
- **Image Caching**: Efficient thumbnail and artwork loading
- **Pull-to-Refresh**: Intuitive content refresh
- **Error Handling**: Graceful error states with retry options
- **Haptic Feedback**: Enhanced user interaction feedback

## Architecture

### MVVM Pattern
```
BastiBoysMusicApp/
├── Models/                 # Data models matching backend API
├── Views/                  # SwiftUI views and UI components
├── ViewModels/            # Business logic and state management
├── Services/              # Network and core services
└── Utils/                 # Extensions and utilities
```

### Key Components

#### Services
- **NetworkService**: API communication with your Node.js backend
- **AuthService**: User authentication and session management
- **AudioPlayerManager**: Advanced audio playback with queue management

#### Views
- **HomeView**: Dashboard with latest albums and top songs
- **SearchView**: Smart search with filters and recent searches
- **LibraryView**: Personal music collection with playlists
- **ProfileView**: User settings and account management
- **MiniPlayerView** & **FullPlayerView**: Music playback interface

## Backend Integration

### API Endpoints Supported
The iOS app integrates with all your existing API endpoints:

#### Authentication
- `POST /api/user/register` - User registration
- `POST /api/user/login` - User login
- `GET /api/user/me` - Get user profile
- `GET /api/user/logout` - User logout

#### Songs & Music
- `GET /api/home` - Homepage data (latest albums, top songs)
- `GET /api/song/all` - All songs with pagination
- `GET /api/song/top-played` - Top played songs
- `GET /api/song/search` - Search songs with filters
- `GET /api/song/single/:id` - Get single song details
- `POST /api/song/:id/play` - Update play count
- `GET /api/song/playlist` - User's playlist songs

#### Albums & Library
- `GET /api/song/album/all` - All albums
- `GET /api/song/album/:id` - Songs in specific album
- `GET /api/song/queue` - Queue data with years

#### User Interactions
- `POST /api/user/song/:id` - Add song to playlist
- `POST /api/user/last-played` - Update last played song
- `POST /api/interaction/*` - Track user interactions

## Installation & Setup

### Prerequisites
- **Xcode 15.0+** with iOS 15.0+ deployment target
- **macOS** for iOS development
- **Your Node.js backend** running (from the existing project)

### Backend Configuration
1. **Update Base URL**: In `NetworkService.swift`, change the base URL:
```swift
private let baseURL = "http://your-server-url:5000/api"
```

2. **CORS Configuration**: Ensure your backend accepts requests from the iOS app:
```javascript
// In your backend/index.js, add CORS for mobile
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
  next();
});
```

### iOS App Setup

1. **Open Xcode Project**:
```bash
cd ios-app
open BastiBoysMusicApp.xcodeproj
```

2. **Configure Bundle Identifier**:
   - Select the project in Xcode
   - Change Bundle Identifier to your unique identifier
   - Set your Development Team (for device testing)

3. **Update App Transport Security** (if using HTTP):
   - The `Info.plist` is already configured to allow localhost HTTP connections
   - For production, use HTTPS endpoints

4. **Build and Run**:
   - Select your target device/simulator
   - Press `Cmd + R` to build and run

## Configuration

### Network Configuration
Update the base URL in `NetworkService.swift` to match your backend:

```swift
// For local development
private let baseURL = "http://localhost:5000/api"

// For production
private let baseURL = "https://your-domain.com/api"
```

### Audio Session
The app is configured for background audio playback. Ensure your `Info.plist` includes:
```xml
<key>UIBackgroundModes</key>
<array>
    <string>audio</string>
    <string>background-processing</string>
</array>
```

## Usage

### Authentication
1. Launch the app
2. Register a new account or login with existing credentials
3. The app will automatically store JWT tokens for session persistence

### Music Playback
1. **Browse**: Explore home feed, search for songs, or browse library
2. **Play**: Tap any song to start playback
3. **Control**: Use mini player for quick controls or full player for advanced features
4. **Queue**: Songs automatically queue for continuous playback

### Library Management
1. **Add to Playlist**: Tap heart icon to add songs to your personal playlist
2. **Browse Albums**: Explore full album collections
3. **Search**: Use smart search with year filters and categories

## Development Notes

### State Management
The app uses SwiftUI's `@StateObject` and `@ObservableObject` for reactive state management:
- `AuthService`: Manages authentication state
- `AudioPlayerManager`: Handles music playback state
- `ViewModels`: Manage view-specific data and business logic

### Network Layer
- **Async/Await**: Modern concurrency for API calls
- **Generic Request Handler**: Reusable network request processing
- **Error Handling**: Comprehensive error states with user-friendly messages

### Audio Implementation
- **AVFoundation**: Core audio playback functionality
- **MediaPlayer**: Remote control and Now Playing info
- **Background Audio**: Continuous playback when app is backgrounded

## Troubleshooting

### Common Issues

1. **Network Connection Failed**
   - Verify backend server is running
   - Check base URL configuration
   - Ensure proper CORS headers in backend

2. **Authentication Issues**
   - Clear app data (delete and reinstall)
   - Check JWT token format in backend
   - Verify API endpoints match backend routes

3. **Audio Playback Issues**
   - Check audio URLs are accessible
   - Verify audio file formats are supported
   - Test with different audio sources

### Debug Tips
- Use Xcode console for detailed error logs
- Test API endpoints with network inspector
- Check backend logs for request/response details

## Production Deployment

### App Store Preparation
1. **Update Configuration**:
   - Set production API base URL
   - Enable HTTPS for all network requests
   - Configure proper bundle identifier

2. **Build Settings**:
   - Set Release configuration
   - Enable code signing with distribution certificate
   - Configure App Store Connect metadata

3. **Testing**:
   - Test on physical devices
   - Verify background audio functionality
   - Test with poor network conditions

## Contributing

This iOS application is designed to work seamlessly with your existing Node.js backend. The architecture is modular and can be extended with additional features:

- **New Views**: Add to `Views/` folder and register in navigation
- **API Integration**: Extend `NetworkService` for new endpoints
- **Audio Features**: Enhance `AudioPlayerManager` for advanced playback
- **UI Components**: Create reusable components in `Views/`

## License

This iOS application follows the same license as your main project.

---

**Note**: This iOS app is designed to perfectly complement your existing web application, providing a native mobile experience while maintaining feature parity with your React frontend.