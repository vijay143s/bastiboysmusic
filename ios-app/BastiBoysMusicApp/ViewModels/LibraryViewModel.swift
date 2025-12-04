import Foundation
import Combine

@MainActor
class LibraryViewModel: ObservableObject {
    @Published var playlistSongs: [Song] = []
    @Published var albums: [Album] = []
    @Published var artists: [Artist] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkService = NetworkService.shared
    
    func loadData() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.loadPlaylistSongs() }
            group.addTask { await self.loadAlbums() }
            group.addTask { await self.loadArtists() }
        }
    }
    
    func loadPlaylistSongs() async {
        do {
            playlistSongs = try await networkService.getPlaylistSongs()
        } catch {
            print("Failed to load playlist songs: \(error)")
        }
    }
    
    func loadAlbums() async {
        isLoading = true
        errorMessage = nil
        
        do {
            albums = try await networkService.getAllAlbums()
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    func loadArtists() async {
        // This would need to be implemented in your backend
        // For now, we'll extract unique artists from albums/songs
        do {
            // This is a placeholder - you might want to add a dedicated artists endpoint
            let allSongs = try await networkService.getAllSongs()
            let uniqueArtists = extractUniqueArtists(from: allSongs)
            artists = uniqueArtists
        } catch {
            print("Failed to load artists: \(error)")
        }
    }
    
    private func extractUniqueArtists(from songs: [Song]) -> [Artist] {
        var artistDict: [String: Artist] = [:]
        
        for song in songs {
            if let singer = song.singer,
               let albumTitle = song.albumTitle {
                let key = "\(singer)-\(song.albumId)"
                if artistDict[key] == nil {
                    artistDict[key] = Artist(
                        artistId: song.albumId,
                        artistName: singer,
                        albumId: song.albumId,
                        albumName: albumTitle,
                        createdAt: song.createdAt,
                        updatedAt: song.updatedAt
                    )
                }
            }
        }
        
        return Array(artistDict.values).sorted { $0.artistName < $1.artistName }
    }
    
    func removeFromPlaylist(_ song: Song) async {
        // Remove from local array immediately for UI responsiveness
        playlistSongs.removeAll { $0.id == song.id }
        
        // Note: You might need to implement a remove from playlist endpoint
        // For now, this just removes from the local array
        // In a real app, you'd call an API endpoint to remove the song
    }
    
    func loadAlbumSongs(_ album: Album) async {
        do {
            let songs = try await networkService.getAlbumSongs(albumId: album.id)
            if let firstSong = songs.first {
                AudioPlayerManager.shared.playSong(firstSong, in: songs)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}