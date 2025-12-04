import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        Group {
            if authService.isAuthenticated {
                MainTabView()
            } else {
                AuthView()
            }
        }
        .onAppear {
            authService.checkAuthenticationStatus()
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(1)
                
                LibraryView()
                    .tabItem {
                        Image(systemName: "music.note.list")
                        Text("Library")
                    }
                    .tag(2)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(3)
            }
            .accentColor(.blue)
            
            // Mini Player
            if audioPlayerManager.currentSong != nil {
                MiniPlayerView()
                    .padding(.bottom, 83) // Height of tab bar
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthService.shared)
        .environmentObject(AudioPlayerManager.shared)
        .environmentObject(NetworkMonitor())
}