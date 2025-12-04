# BastiBoys Music - Android App

A native Android music streaming application built with modern Android development practices.

## Features

- **User Authentication**: Login and registration system
- **Music Streaming**: Browse and play music tracks
- **Search**: Search for songs, artists, and albums
- **Library**: Manage your music library and playlists
- **Modern UI**: Material Design 3 with Jetpack Compose

## Tech Stack

### Core
- **Kotlin**: Primary programming language
- **Jetpack Compose**: Modern declarative UI toolkit
- **Material Design 3**: Latest Material Design components

### Architecture
- **MVVM**: Model-View-ViewModel architecture pattern
- **Repository Pattern**: Data layer abstraction
- **Dependency Injection**: Hilt for DI

### Network & Data
- **Retrofit**: HTTP client for API calls
- **OkHttp**: HTTP client with interceptors
- **SharedPreferences**: Token storage
- **Coil**: Image loading library

### Navigation
- **Navigation Compose**: Type-safe navigation
- **Bottom Navigation**: Tab-based navigation

### Media
- **ExoPlayer**: Audio playback (planned)
- **Media3**: Modern media framework (planned)

## Project Structure

```
app/src/main/java/com/bastiboys/music/
├── data/
│   ├── api/           # API service and client
│   ├── model/         # Data models
│   └── repository/    # Repository implementation
├── di/                # Dependency injection modules
├── ui/
│   ├── components/    # Reusable UI components
│   ├── screens/       # App screens
│   └── theme/         # Theme and styling
├── utils/             # Utility classes
├── viewmodel/         # ViewModels
├── BastiBoysMusicApp.kt    # Main app composable
├── MainActivity.kt         # Main activity
└── Navigation.kt          # Navigation setup
```

## API Integration

The app integrates with the BastiBoys Music backend API:

- **Base URL**: `https://api.bastiboysmusic.example.com`
- **Authentication**: JWT token-based
- **Endpoints**:
  - `/auth/login` - User authentication
  - `/auth/register` - User registration
  - `/songs/top-played` - Top played songs
  - `/albums/latest` - Latest albums
  - `/search` - Search functionality

## Setup Instructions

### Prerequisites
- Android Studio Arctic Fox or later
- JDK 11 or higher
- Android SDK 24 (Android 7.0) or higher

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/bastiboys/music-app.git
   cd music-app/android-app
   ```

2. **Open in Android Studio**:
   - Launch Android Studio
   - Select "Open an Existing Project"
   - Navigate to the `android-app` folder

3. **Configure API Base URL**:
   - Update the base URL in `NetworkClient.kt`
   - Replace with your backend server URL

4. **Build the project**:
   ```bash
   ./gradlew build
   ```

5. **Run the app**:
   - Connect an Android device or start an emulator
   - Click "Run" in Android Studio or use:
   ```bash
   ./gradlew installDebug
   ```

## Key Components

### Authentication Flow
- Login and registration screens
- JWT token management
- Automatic logout handling

### Music Streaming
- Browse top played songs
- Latest albums carousel
- Song playback (planned)

### Search Functionality
- Real-time search
- Song, artist, and album results
- Search history (planned)

### User Interface
- Material Design 3 theming
- Dark/Light theme support (planned)
- Responsive layouts
- Bottom navigation

## Dependencies

Key dependencies defined in `build.gradle`:

```kotlin
// Core Android
implementation "androidx.core:core-ktx:1.12.0"
implementation "androidx.lifecycle:lifecycle-runtime-ktx:2.7.0"
implementation "androidx.activity:activity-compose:1.8.2"

// Compose
implementation "androidx.compose.ui:ui:$compose_version"
implementation "androidx.compose.material3:material3:1.1.2"
implementation "androidx.navigation:navigation-compose:2.7.6"

// Networking
implementation "com.squareup.retrofit2:retrofit:2.9.0"
implementation "com.squareup.okhttp3:logging-interceptor:4.12.0"

// Dependency Injection
implementation "com.google.dagger:hilt-android:2.48.1"
kapt "com.google.dagger:hilt-compiler:2.48.1"

// Image Loading
implementation "io.coil-kt:coil-compose:2.5.0"
```

## Development Guidelines

### Code Style
- Follow Kotlin coding conventions
- Use meaningful variable and function names
- Add documentation for public APIs
- Implement proper error handling

### Architecture
- Use MVVM pattern consistently
- Keep ViewModels lean and testable
- Use Repository pattern for data access
- Implement proper separation of concerns

### UI/UX
- Follow Material Design 3 guidelines
- Ensure accessibility compliance
- Test on different screen sizes
- Implement proper loading states

## Testing (Planned)

- Unit tests for ViewModels
- Repository tests with mock data
- UI tests with Compose Test
- Integration tests for API calls

## Future Enhancements

- [ ] Audio player with ExoPlayer
- [ ] Offline music caching
- [ ] Playlist management
- [ ] User favorites
- [ ] Push notifications
- [ ] Social features
- [ ] Music recommendations
- [ ] Dark theme support
- [ ] Accessibility improvements

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Email: support@bastiboysmusic.com
- GitHub Issues: [Create an issue](https://github.com/bastiboys/music-app/issues)