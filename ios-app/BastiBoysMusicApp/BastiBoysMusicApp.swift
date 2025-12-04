import SwiftUI
import AVFoundation

@main
struct BastiBoysMusicApp: App {
    @StateObject private var authService = AuthService.shared
    @StateObject private var audioPlayerManager = AudioPlayerManager.shared
    @StateObject private var networkMonitor = NetworkMonitor()
    
    init() {
        // Configure audio session for music playback
        configureAudioSession()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authService)
                .environmentObject(audioPlayerManager)
                .environmentObject(networkMonitor)
                .preferredColorScheme(.dark)
        }
    }
    
    private func configureAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [.allowAirPlay, .allowBluetoothA2DP])
            try audioSession.setActive(true)
        } catch {
            print("Failed to configure audio session: \(error)")
        }
    }
}