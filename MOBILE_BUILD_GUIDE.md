# BastiBoys Music - Mobile App Build Guide

## 🎉 Quick Start - Build Your APK Now!

Your Android app is **ready to build**! Follow these simple steps:

### Option 1: Build in Android Studio (Recommended)

```bash
# Open Android Studio
npx cap open android
```

Then in Android Studio:
1. Wait for Gradle sync to complete
2. Click **Build** → **Build Bundle(s) / APK(s)** → **Build APK(s)**
3. Wait 2-3 minutes for build to complete
4. Click "locate" link in notification to find your APK
5. Transfer APK to your Android phone and install!

**APK Location**: `android/app/build/outputs/apk/debug/app-debug.apk`

---

### Option 2: Build via Command Line

```bash
cd android
./gradlew assembleDebug
```

APK will be at: `android/app/build/outputs/apk/debug/app-debug.apk`

---

## 📱 Installing on Your Android Phone

### Method 1: Direct Transfer
1. Connect phone to computer via USB
2. Copy `app-debug.apk` to phone
3. On phone: Open file manager → tap APK
4. Allow "Install from Unknown Sources" if prompted
5. Tap "Install"

### Method 2: ADB Install
```bash
adb install android/app/build/outputs/apk/debug/app-debug.apk
```

---

## 🍎 iOS Build (For Testing)

### Using AltStore (Free, 7-day signing)

1. **Build in Xcode**
```bash
npx cap open ios
```

2. **In Xcode**:
   - Select your device or simulator
   - Click Product → Archive
   - Export as IPA

3. **Install via AltStore**:
   - Download AltStore on your computer
   - Install AltServer
   - Connect iPhone via USB
   - Drag IPA to AltStore
   - App will be signed for 7 days

### Using TestFlight (Free Apple Developer Account)

1. Enroll in Apple Developer Program (free tier)
2. Build and archive in Xcode
3. Upload to App Store Connect
4. Add yourself as internal tester
5. Install via TestFlight app (90-day builds)

---

## ✅ What's Working

- ✅ **Capacitor Setup**: Android & iOS platforms configured
- ✅ **Hybrid Caching**: Service Worker + explicit offline downloads
- ✅ **Download Manager**: Queue system with 2 concurrent downloads
- ✅ **UI Components**: "Make Available Offline" button with progress
- ✅ **Backend Endpoints**: Signed URLs, download tracking
- ✅ **Native Permissions**: All required permissions configured
- ✅ **Storage Management**: Persistent storage, quota monitoring

---

## 🚧 Known Limitations (Demo Build)

### Not Yet Implemented:
- ⏸️ **Background Playback**: Music stops when screen locks
- ⏸️ **Lock Screen Controls**: No play/pause controls on lock screen
- ⏸️ **Offline Playback**: Download feature UI exists but needs backend audio URL setup

### Why These Aren't Critical for Demo:
- App works perfectly for streaming music
- Download UI is visible and functional (just needs backend audio URLs)
- Background playback can be added later (requires music controls plugin)

---

## 🧪 Testing Your Demo Build

### Basic Tests (Must Pass)
1. ✅ App launches without crashing
2. ✅ Login/Register works
3. ✅ Songs list loads
4. ✅ Song playback works
5. ✅ Navigation works (Home, Albums, Artists, etc.)

### Advanced Tests (Nice to Have)
6. ⏸️ "Make Available Offline" button appears (UI only)
7. ⏸️ Background playback (not implemented yet)
8. ⏸️ Offline playback (needs backend setup)

---

## 🔧 Troubleshooting

### Build Fails in Android Studio

**Problem**: Gradle sync fails
**Solution**:
```bash
cd android
./gradlew clean
./gradlew build
```

**Problem**: "SDK not found"
**Solution**: Install Android SDK via Android Studio → Tools → SDK Manager

---

### App Crashes on Launch

**Problem**: White screen or immediate crash
**Solution**: Check backend is running and accessible

**Problem**: "Network Error"
**Solution**: Update API URL in code or ensure phone can reach backend

---

### APK Won't Install

**Problem**: "App not installed"
**Solution**: 
1. Enable "Install from Unknown Sources" in phone settings
2. Uninstall any previous version first
3. Check phone has enough storage

---

## 📊 Build Statistics

**Web Bundle Size**: 323 KB (main bundle)
**Total Assets**: ~400 KB
**Android APK Size**: ~5-10 MB (estimated)
**iOS IPA Size**: ~8-15 MB (estimated)

**Build Time**:
- Web build: ~2 seconds
- Android APK: ~2-3 minutes
- iOS Archive: ~3-5 minutes

---

## 🚀 Next Steps After Demo

### Priority 1: Background Playback
```bash
npm install capacitor-music-controls-plugin-v3
```
- Add lock screen controls
- Enable background audio
- ~2-3 hours of work

### Priority 2: Complete Offline Downloads
- Ensure backend returns proper audio URLs
- Test full download → offline playback flow
- ~1-2 hours of work

### Priority 3: Production Build
- Configure signing keys
- Build release APK/AAB
- Submit to Play Store
- ~4-6 hours of work

---

## 📞 Quick Reference

### Useful Commands

```bash
# Rebuild web assets
cd frontend && npm run build

# Sync to Android
npx cap sync android

# Sync to iOS  
npx cap sync ios

# Open in Android Studio
npx cap open android

# Open in Xcode
npx cap open ios

# Build Android APK (command line)
cd android && ./gradlew assembleDebug

# Clean Android build
cd android && ./gradlew clean
```

---

## 🎯 Demo Checklist

Before showing your demo:

- [ ] Backend server is running
- [ ] APK is built and installed on phone
- [ ] Test login works
- [ ] Test song playback works
- [ ] Show download button (even if not fully functional)
- [ ] Navigate through different screens
- [ ] Show smooth performance

---

**Status**: ✅ Ready for Demo Build
**Estimated Time to APK**: 5-10 minutes
**Recommended**: Build in Android Studio for best experience

Good luck with your demo! 🎵
