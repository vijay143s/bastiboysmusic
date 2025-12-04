import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 24) {
                    // Welcome Section
                    if let user = viewModel.currentUser {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Welcome back,")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text(user.name)
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            
                            Button(action: {
                                // Quick action - could be shuffle all
                                if let songs = viewModel.topPlayedSongs.first {
                                    audioPlayerManager.playSong(songs, in: viewModel.topPlayedSongs)
                                }
                            }) {
                                Image(systemName: "shuffle")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                    .padding(12)
                                    .background(Color.blue.opacity(0.1))
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 16)
                    }
                    
                    // Stats Section
                    HStack(spacing: 20) {
                        StatCard(
                            title: "Total Songs",
                            value: "\(viewModel.totalSongs)",
                            icon: "music.note",
                            color: .blue
                        )
                        
                        StatCard(
                            title: "Total Albums",
                            value: "\(viewModel.totalAlbums)",
                            icon: "opticaldisc",
                            color: .purple
                        )
                    }
                    .padding(.horizontal)
                    
                    // Top Played Songs
                    if !viewModel.topPlayedSongs.isEmpty {
                        SectionView(title: "Top Played Songs") {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 16) {
                                    ForEach(viewModel.topPlayedSongs.prefix(10)) { song in
                                        TopSongCard(song: song) {
                                            audioPlayerManager.playSong(song, in: viewModel.topPlayedSongs)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // Latest Albums
                    if !viewModel.latestAlbums.isEmpty {
                        SectionView(title: "Latest Albums") {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 16) {
                                    ForEach(viewModel.latestAlbums) { album in
                                        AlbumCard(album: album) {
                                            // Navigate to album detail
                                            // This would trigger navigation in real app
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // Quick Actions
                    SectionView(title: "Quick Actions") {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                            QuickActionCard(
                                title: "Search Music",
                                icon: "magnifyingglass",
                                color: .green
                            ) {
                                // Navigate to search
                            }
                            
                            QuickActionCard(
                                title: "My Playlist",
                                icon: "heart.fill",
                                color: .red
                            ) {
                                // Navigate to playlist
                            }
                            
                            QuickActionCard(
                                title: "All Albums",
                                icon: "rectangle.stack.fill",
                                color: .orange
                            ) {
                                // Navigate to albums
                            }
                            
                            QuickActionCard(
                                title: "Random Song",
                                icon: "shuffle",
                                color: .purple
                            ) {
                                viewModel.playRandomSong()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 100) // Extra padding for mini player
            }
            .navigationTitle("Home")
            .refreshable {
                await viewModel.loadData()
            }
        }
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }
}

// MARK: - Supporting Views
struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct SectionView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                Spacer()
            }
            
            content
        }
    }
}

struct TopSongCard: View {
    let song: Song
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 12) {
                AsyncImage(url: URL(string: song.thumbnailUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            Image(systemName: "music.note")
                                .font(.title2)
                                .foregroundColor(.gray)
                        )
                }
                .frame(width: 120, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(spacing: 4) {
                    Text(song.title)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                    
                    Text(song.singer ?? "Unknown Artist")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            .frame(width: 120)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct AlbumCard: View {
    let album: Album
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 12) {
                AsyncImage(url: URL(string: album.thumbnailUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            Image(systemName: "opticaldisc")
                                .font(.title2)
                                .foregroundColor(.gray)
                        )
                }
                .frame(width: 140, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(spacing: 4) {
                    Text(album.title)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                    
                    if let year = album.year {
                        Text("\(year)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(width: 140)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct QuickActionCard: View {
    let title: String
    let icon: String
    let color: Color
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(color)
                    .frame(width: 32, height: 32)
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthService.shared)
        .environmentObject(AudioPlayerManager.shared)
}