import Foundation
import AVFoundation
import Combine
import MediaPlayer

class AudioPlayerManager: NSObject, ObservableObject {
    static let shared = AudioPlayerManager()
    
    @Published var currentSong: Song?
    @Published var isPlaying = false
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    @Published var playbackRate: Float = 1.0
    @Published var volume: Float = 0.8
    @Published var queue: [Song] = []
    @Published var currentIndex: Int = 0
    @Published var shuffleMode = false
    @Published var repeatMode: RepeatMode = .none
    @Published var isBuffering = false
    
    private var player: AVPlayer?
    private var timeObserver: Any?
    private var cancellables = Set<AnyCancellable>()
    
    enum RepeatMode: CaseIterable {
        case none, one, all
        
        var systemImageName: String {
            switch self {
            case .none: return "repeat"
            case .one: return "repeat.1"
            case .all: return "repeat.circle"
            }
        }
    }
    
    override init() {
        super.init()
        setupAudioSession()
        setupRemoteTransportControls()
        setupNotifications()
    }
    
    deinit {
        removeTimeObserver()
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Audio Session Setup
    private func setupAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [.allowAirPlay, .allowBluetoothA2DP])
            try audioSession.setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }
    
    // MARK: - Remote Control Setup
    private func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget { [weak self] _ in
            self?.play()
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { [weak self] _ in
            self?.pause()
            return .success
        }
        
        commandCenter.nextTrackCommand.addTarget { [weak self] _ in
            self?.nextSong()
            return .success
        }
        
        commandCenter.previousTrackCommand.addTarget { [weak self] _ in
            self?.previousSong()
            return .success
        }
        
        commandCenter.changePlaybackPositionCommand.addTarget { [weak self] event in
            if let event = event as? MPChangePlaybackPositionCommandEvent {
                self?.seek(to: event.positionTime)
                return .success
            }
            return .commandFailed
        }
    }
    
    // MARK: - Notifications Setup
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerStalled),
            name: .AVPlayerItemPlaybackStalled,
            object: nil
        )
    }
    
    // MARK: - Playback Control
    func playSong(_ song: Song, in songQueue: [Song] = []) {
        currentSong = song
        
        if !songQueue.isEmpty {
            queue = songQueue
            if let index = queue.firstIndex(where: { $0.id == song.id }) {
                currentIndex = index
            }
        }
        
        guard let audioUrl = song.audioUrl, let url = URL(string: audioUrl) else {
            print("Invalid audio URL for song: \(song.title)")
            return
        }
        
        // Create new player item
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        // Set up time observer
        setupTimeObserver()
        
        // Update Now Playing Info
        updateNowPlayingInfo()
        
        // Start playing
        play()
        
        // Update play count
        Task {
            try? await NetworkService.shared.updatePlayCount(songId: song.id)
            try? await NetworkService.shared.updateLastPlayedSong(songId: song.id)
        }
    }
    
    func play() {
        player?.play()
        isPlaying = true
        isBuffering = false
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func togglePlayPause() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    func nextSong() {
        guard !queue.isEmpty else { return }
        
        switch repeatMode {
        case .one:
            // Replay current song
            seek(to: 0)
            play()
            return
        case .all, .none:
            if shuffleMode {
                playRandomSong()
            } else {
                let nextIndex = (currentIndex + 1) % queue.count
                if nextIndex == 0 && repeatMode == .none && currentIndex == queue.count - 1 {
                    // End of queue and no repeat
                    pause()
                    return
                }
                currentIndex = nextIndex
                playSong(queue[currentIndex], in: queue)
            }
        }
    }
    
    func previousSong() {
        guard !queue.isEmpty else { return }
        
        // If we're more than 3 seconds into the song, restart it
        if currentTime > 3.0 {
            seek(to: 0)
            return
        }
        
        if shuffleMode {
            playRandomSong()
        } else {
            let previousIndex = currentIndex - 1 < 0 ? queue.count - 1 : currentIndex - 1
            currentIndex = previousIndex
            playSong(queue[currentIndex], in: queue)
        }
    }
    
    private func playRandomSong() {
        guard queue.count > 1 else { return }
        
        var randomIndex: Int
        repeat {
            randomIndex = Int.random(in: 0..<queue.count)
        } while randomIndex == currentIndex
        
        currentIndex = randomIndex
        playSong(queue[currentIndex], in: queue)
    }
    
    func seek(to time: Double) {
        let cmTime = CMTime(seconds: time, preferredTimescale: 1)
        player?.seek(to: cmTime)
        currentTime = time
    }
    
    func setVolume(_ volume: Float) {
        self.volume = volume
        player?.volume = volume
    }
    
    func setPlaybackRate(_ rate: Float) {
        playbackRate = rate
        player?.rate = rate
    }
    
    func toggleShuffle() {
        shuffleMode.toggle()
    }
    
    func toggleRepeat() {
        switch repeatMode {
        case .none:
            repeatMode = .one
        case .one:
            repeatMode = .all
        case .all:
            repeatMode = .none
        }
    }
    
    // MARK: - Time Observer
    private func setupTimeObserver() {
        removeTimeObserver()
        
        let interval = CMTime(seconds: 1, preferredTimescale: 1)
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.currentTime = time.seconds
            
            if let duration = self?.player?.currentItem?.duration.seconds, duration.isFinite {
                self?.duration = duration
            }
        }
    }
    
    private func removeTimeObserver() {
        if let timeObserver = timeObserver {
            player?.removeTimeObserver(timeObserver)
            self.timeObserver = nil
        }
    }
    
    // MARK: - Now Playing Info
    private func updateNowPlayingInfo() {
        guard let song = currentSong else { return }
        
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = song.title
        nowPlayingInfo[MPMediaItemPropertyArtist] = song.singer ?? "Unknown Artist"
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = song.albumTitle ?? "Unknown Album"
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = isPlaying ? playbackRate : 0.0
        
        // Load artwork if available
        if let thumbnailUrl = song.thumbnailUrl, let url = URL(string: thumbnailUrl) {
            Task {
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    let artwork = MPMediaItemArtwork(boundsSize: image.size) { _ in image }
                    nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
                    
                    DispatchQueue.main.async {
                        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
                    }
                }
            }
        }
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    // MARK: - Notification Handlers
    @objc private func playerDidFinishPlaying() {
        nextSong()
    }
    
    @objc private func playerStalled() {
        isBuffering = true
    }
}