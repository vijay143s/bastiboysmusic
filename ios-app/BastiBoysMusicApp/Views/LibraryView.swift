import SwiftUI

struct LibraryView: View {
    @StateObject private var viewModel = LibraryViewModel()
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Tab Selector
                Picker("Library Section", selection: $selectedTab) {
                    Text("Playlist").tag(0)
                    Text("Albums").tag(1)
                    Text("Artists").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Content based on selected tab
                TabView(selection: $selectedTab) {
                    PlaylistView(viewModel: viewModel)
                        .tag(0)
                    
                    AlbumsView(viewModel: viewModel)
                        .tag(1)
                    
                    ArtistsView(viewModel: viewModel)
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .navigationTitle("Your Library")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }
}

// MARK: - Playlist View
struct PlaylistView: View {
    @ObservedObject var viewModel: LibraryViewModel
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView()
            } else if viewModel.playlistSongs.isEmpty {
                EmptyPlaylistView()
            } else {
                List {
                    // Playlist Header
                    Section {
                        PlaylistHeaderView(
                            songCount: viewModel.playlistSongs.count,
                            onPlayAll: {
                                if let firstSong = viewModel.playlistSongs.first {
                                    audioPlayerManager.playSong(firstSong, in: viewModel.playlistSongs)
                                }
                            },
                            onShuffle: {
                                let shuffledSongs = viewModel.playlistSongs.shuffled()
                                if let firstSong = shuffledSongs.first {
                                    audioPlayerManager.playSong(firstSong, in: shuffledSongs)
                                }
                            }
                        )
                    }
                    
                    // Playlist Songs
                    Section("Your Favorite Songs") {
                        ForEach(viewModel.playlistSongs) { song in
                            PlaylistSongRow(song: song) {
                                audioPlayerManager.playSong(song, in: viewModel.playlistSongs)
                            } onRemove: {
                                Task {
                                    await viewModel.removeFromPlaylist(song)
                                }
                            }
                        }
                    }
                }
                .refreshable {
                    await viewModel.loadPlaylistSongs()
                }
            }
        }
    }
}

// MARK: - Albums View
struct AlbumsView: View {
    @ObservedObject var viewModel: LibraryViewModel
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView()
            } else if viewModel.albums.isEmpty {
                EmptyAlbumsView()
            } else {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                        ForEach(viewModel.albums) { album in
                            AlbumGridCard(album: album) {
                                Task {
                                    await viewModel.loadAlbumSongs(album)
                                }
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 100)
                }
                .refreshable {
                    await viewModel.loadAlbums()
                }
            }
        }
    }
}

// MARK: - Artists View
struct ArtistsView: View {
    @ObservedObject var viewModel: LibraryViewModel
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView()
            } else if viewModel.artists.isEmpty {
                EmptyArtistsView()
            } else {
                List(viewModel.artists) { artist in
                    ArtistRow(artist: artist) {
                        // Navigate to artist detail
                    }
                }
                .refreshable {
                    await viewModel.loadArtists()
                }
            }
        }
    }
}

// MARK: - Supporting Views

struct PlaylistHeaderView: View {
    let songCount: Int
    let onPlayAll: () -> Void
    let onShuffle: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Image(systemName: "heart.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.red)
                
                Text("Liked Songs")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("\(songCount) songs")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 16) {
                Button(action: onPlayAll) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Play All")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                }
                
                Button(action: onShuffle) {
                    HStack {
                        Image(systemName: "shuffle")
                        Text("Shuffle")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(25)
                }
            }
        }
        .padding()
    }
}

struct PlaylistSongRow: View {
    let song: Song
    let onPlay: () -> Void
    let onRemove: () -> Void
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    
    var body: some View {
        HStack(spacing: 12) {
            // Thumbnail
            AsyncImage(url: URL(string: song.thumbnailUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "music.note")
                            .foregroundColor(.gray)
                    )
            }
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Song Info
            VStack(alignment: .leading, spacing: 4) {
                Text(song.title)
                    .font(.headline)
                    .lineLimit(1)
                
                HStack {
                    if let singer = song.singer {
                        Text(singer)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    if let year = song.year {
                        Text("• \(year)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Spacer()
            
            // Play indicator
            if audioPlayerManager.currentSong?.id == song.id {
                Image(systemName: audioPlayerManager.isPlaying ? "speaker.wave.2.fill" : "speaker.fill")
                    .foregroundColor(.blue)
                    .font(.caption)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onPlay()
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: onRemove) {
                Label("Remove", systemImage: "heart.slash")
            }
        }
    }
}

struct AlbumGridCard: View {
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
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(spacing: 4) {
                    Text(album.title)
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                    
                    if let year = album.year {
                        Text("\(year)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ArtistRow: View {
    let artist: Artist
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Text(String(artist.artistName.prefix(1)))
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(artist.artistName)
                        .font(.headline)
                    
                    Text(artist.albumName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Empty States
struct EmptyPlaylistView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No liked songs yet")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Songs you like will appear here")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct EmptyAlbumsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "opticaldisc")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No albums found")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Check back later for new albums")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct EmptyArtistsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "person.2")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No artists found")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Artists will appear as the library grows")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LibraryView()
        .environmentObject(AudioPlayerManager.shared)
}