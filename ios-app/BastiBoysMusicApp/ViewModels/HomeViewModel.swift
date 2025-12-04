import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var latestAlbums: [Album] = []
    @Published var topPlayedSongs: [Song] = []
    @Published var totalSongs = 0
    @Published var totalAlbums = 0
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var currentUser: User? {
        AuthService.shared.currentUser
    }
    
    private let networkService = NetworkService.shared
    
    func loadData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let homeData = try await networkService.getHomeData()
            
            latestAlbums = homeData.latestAlbums
            topPlayedSongs = homeData.topPlayedSongs
            totalSongs = homeData.totalSongs
            totalAlbums = homeData.totalAlbums
            
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    func playRandomSong() {
        guard !topPlayedSongs.isEmpty else { return }
        
        let randomSong = topPlayedSongs.randomElement()!
        AudioPlayerManager.shared.playSong(randomSong, in: topPlayedSongs.shuffled())
    }
}