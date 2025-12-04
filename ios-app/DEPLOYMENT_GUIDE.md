# iOS App Setup & Deployment Guide

## Quick Start

### 1. Prerequisites
- **Xcode 15.0+** installed on macOS
- **Apple Developer Account** (for device testing and App Store deployment)
- **Node.js Backend** running (your existing server)

### 2. Backend Preparation

#### Update CORS Settings
Add this to your `backend/index.js` before your routes:

```javascript
// CORS configuration for iOS app
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization, Cookie');
  res.header('Access-Control-Allow-Credentials', 'true');
  
  // Handle preflight requests
  if (req.method === 'OPTIONS') {
    res.sendStatus(200);
  } else {
    next();
  }
});
```

#### Test Backend APIs
Ensure these endpoints work from your browser/Postman:
- `GET http://localhost:5000/api/home`
- `POST http://localhost:5000/api/user/login`
- `GET http://localhost:5000/api/song/all`

### 3. iOS App Configuration

#### Open in Xcode
1. Navigate to the `ios-app` folder
2. Double-click `BastiBoysMusicApp.xcodeproj`
3. Wait for Xcode to load the project

#### Configure Network URL
In `Services/NetworkService.swift`, update the base URL:

```swift
// For local development (your computer's IP)
private let baseURL = "http://192.168.1.100:5000/api"  // Replace with your IP

// For production server
private let baseURL = "https://your-domain.com/api"
```

**Finding your IP address:**
- **Windows**: Open Command Prompt → `ipconfig` → look for IPv4 Address
- **Mac/Linux**: Terminal → `ifconfig` → look for inet address

#### Configure Bundle Identifier
1. Click on the project name in Xcode
2. Select "BastiBoysMusicApp" target
3. In "Signing & Capabilities" tab:
   - Change Bundle Identifier to something unique like `com.yourname.bastiboysmusic`
   - Select your Development Team (requires Apple Developer Account)

### 4. Build and Test

#### Simulator Testing
1. Select iPhone simulator from device menu
2. Press `Cmd + R` or click "Play" button
3. App should launch in simulator

#### Device Testing (Requires Apple Developer Account)
1. Connect iPhone/iPad via USB
2. Select your device from device menu
3. Build and run (`Cmd + R`)
4. Trust the developer certificate on device if prompted

### 5. Troubleshooting Setup

#### Common Issues:

**"Network request failed"**
- Check if backend server is running (`npm run dev` in backend folder)
- Verify the IP address in NetworkService.swift
- Test backend URL in web browser first

**"Could not connect to server"**
- If using localhost, change to your computer's actual IP address
- Disable firewall temporarily to test
- Check if backend is binding to 0.0.0.0 not just localhost

**Xcode build errors**
- Clean build folder: Product → Clean Build Folder
- Restart Xcode
- Check macOS and Xcode versions compatibility

## Production Deployment

### 1. Prepare for Production

#### Update Configuration
```swift
// In NetworkService.swift - use your production URL
private let baseURL = "https://your-production-domain.com/api"
```

#### Enable HTTPS
Update your backend for HTTPS:
```javascript
// Use proper SSL certificates
const https = require('https');
const fs = require('fs');

const options = {
  key: fs.readFileSync('path/to/private-key.pem'),
  cert: fs.readFileSync('path/to/certificate.pem')
};

https.createServer(options, app).listen(443);
```

### 2. App Store Preparation

#### Update App Information
In Xcode project settings:
- **Display Name**: "BastiBoys Music" 
- **Version**: 1.0
- **Build Number**: 1
- **Minimum iOS Version**: 15.0

#### App Icons and Assets
1. Create app icons in these sizes:
   - 1024x1024 (App Store)
   - 180x180 (iPhone)
   - 167x167 (iPad Pro)
   - 152x152 (iPad)
   - 120x120 (iPhone)

2. Add to `Assets.xcassets/AppIcon.appiconset`

#### Privacy Policy & Description
Create these documents for App Store submission:
- Privacy Policy (required)
- App Description
- Keywords for App Store search
- Screenshots for different device sizes

### 3. Testing Before Release

#### Test on Multiple Devices
- iPhone SE (smallest screen)
- iPhone 15 Pro (latest)
- iPad (different aspect ratio)

#### Test Different Scenarios
- Poor network connection
- No internet connection
- Background app usage
- Interrupted audio playback
- Different iOS versions

### 4. App Store Submission

#### Create App Store Connect Record
1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Create new app
3. Fill in metadata:
   - App Name: "BastiBoys Music"
   - Category: Music
   - Age Rating: 4+ (or appropriate for your content)

#### Archive and Upload
1. In Xcode: Product → Archive
2. When archive completes, click "Distribute App"
3. Choose "App Store Connect"
4. Upload to App Store Connect

#### Submit for Review
1. In App Store Connect, complete all sections:
   - App Information
   - Pricing and Availability
   - App Privacy
   - Prepare for Submission
2. Submit for App Store review

## Advanced Configuration

### Push Notifications (Optional)
To add push notifications for new music:

1. Enable Push Notifications capability in Xcode
2. Add this to your backend:

```javascript
// Install firebase-admin
const admin = require('firebase-admin');

// Send notification for new songs
const sendNewSongNotification = async (song) => {
  const message = {
    notification: {
      title: 'New Song Available!',
      body: `${song.title} by ${song.singer}`,
    },
    topic: 'new-songs'
  };
  
  await admin.messaging().send(message);
};
```

### Analytics (Optional)
Add analytics to track user behavior:

1. Integrate Firebase Analytics
2. Track events like:
   - Song plays
   - Search queries
   - User registration
   - App opens

### Offline Support (Optional)
Implement local caching:

```swift
// Add Core Data for offline storage
import CoreData

// Cache frequently played songs
// Store user preferences locally
// Sync when network available
```

## Maintenance & Updates

### Regular Updates
- Monitor App Store reviews
- Update for new iOS versions
- Add new features based on user feedback
- Fix bugs reported by users

### Backend Updates
When updating your Node.js backend:
- Maintain API compatibility
- Version your APIs (/api/v1/, /api/v2/)
- Test iOS app with backend changes
- Update iOS app if breaking changes

### Performance Monitoring
- Monitor app crashes
- Track API response times
- Monitor user engagement metrics
- Optimize for battery usage

## Support & Maintenance

### User Support
- Create FAQ section in app
- Provide contact information
- Monitor App Store reviews
- Set up crash reporting (like Crashlytics)

### Regular Maintenance Tasks
- **Weekly**: Check for crashes and user feedback
- **Monthly**: Review performance metrics
- **Quarterly**: Update for new iOS versions
- **As needed**: Add new features and bug fixes

---

This iOS app provides a professional, native mobile experience for your music streaming service. With proper setup and deployment, your users will have access to their favorite music on both web and mobile platforms seamlessly.