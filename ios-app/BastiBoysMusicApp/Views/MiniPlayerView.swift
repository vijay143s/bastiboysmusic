import SwiftUI

struct MiniPlayerView: View {
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    @State private var showingFullPlayer = false
    
    var body: some View {
        if let currentSong = audioPlayerManager.currentSong {
            VStack(spacing: 0) {
                // Progress Bar
                ProgressView(value: audioPlayerManager.currentTime, 
                           total: audioPlayerManager.duration)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .scaleEffect(x: 1, y: 0.5)
                
                // Mini Player Content
                HStack(spacing: 12) {
                    // Song thumbnail
                    AsyncImage(url: URL(string: currentSong.thumbnailUrl ?? "")) { image in
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
                    .frame(width: 44, height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    // Song info
                    VStack(alignment: .leading, spacing: 2) {
                        Text(currentSong.title)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                        
                        Text(currentSong.singer ?? "Unknown Artist")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    // Controls
                    HStack(spacing: 16) {
                        Button(action: {
                            audioPlayerManager.previousSong()
                        }) {
                            Image(systemName: "backward.fill")
                                .font(.title3)
                                .foregroundColor(.primary)
                        }
                        
                        Button(action: {
                            audioPlayerManager.togglePlayPause()
                        }) {
                            Image(systemName: audioPlayerManager.isPlaying ? "pause.fill" : "play.fill")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                        
                        Button(action: {
                            audioPlayerManager.nextSong()
                        }) {
                            Image(systemName: "forward.fill")
                                .font(.title3)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(.systemBackground))
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -2)
            .padding(.horizontal, 16)
            .onTapGesture {
                showingFullPlayer = true
            }
            .sheet(isPresented: $showingFullPlayer) {
                FullPlayerView()
            }
        }
    }
}

struct FullPlayerView: View {
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    @Environment(\.dismiss) private var dismiss
    @State private var isDraggingSlider = false
    @State private var sliderValue: Double = 0
    
    var body: some View {
        if let currentSong = audioPlayerManager.currentSong {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.down")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 2) {
                        Text("PLAYING FROM")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                        
                        Text("Queue")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Show more options
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                .padding()
                
                Spacer()
                
                // Album Art
                AsyncImage(url: URL(string: currentSong.thumbnailUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            Image(systemName: "music.note")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                        )
                }
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                Spacer()
                
                // Song Info
                VStack(spacing: 8) {
                    Text(currentSong.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                    
                    Text(currentSong.singer ?? "Unknown Artist")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Progress Slider
                VStack(spacing: 8) {
                    Slider(
                        value: isDraggingSlider ? $sliderValue : .constant(audioPlayerManager.currentTime),
                        in: 0...max(audioPlayerManager.duration, 1)
                    ) { editing in
                        isDraggingSlider = editing
                        if !editing {
                            audioPlayerManager.seek(to: sliderValue)
                        }
                    }
                    .accentColor(.blue)
                    .onReceive(audioPlayerManager.$currentTime) { currentTime in
                        if !isDraggingSlider {
                            sliderValue = currentTime
                        }
                    }
                    
                    HStack {
                        Text(formatTime(audioPlayerManager.currentTime))
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text(formatTime(audioPlayerManager.duration))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Main Controls
                HStack(spacing: 40) {
                    Button(action: {
                        audioPlayerManager.toggleShuffle()
                    }) {
                        Image(systemName: audioPlayerManager.shuffleMode ? "shuffle.circle.fill" : "shuffle")
                            .font(.title2)
                            .foregroundColor(audioPlayerManager.shuffleMode ? .blue : .primary)
                    }
                    
                    Button(action: {
                        audioPlayerManager.previousSong()
                    }) {
                        Image(systemName: "backward.fill")
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                    }
                    
                    Button(action: {
                        audioPlayerManager.togglePlayPause()
                    }) {
                        Image(systemName: audioPlayerManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 64))
                            .foregroundColor(.primary)
                    }
                    
                    Button(action: {
                        audioPlayerManager.nextSong()
                    }) {
                        Image(systemName: "forward.fill")
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                    }
                    
                    Button(action: {
                        audioPlayerManager.toggleRepeat()
                    }) {
                        Image(systemName: audioPlayerManager.repeatMode.systemImageName)
                            .font(.title2)
                            .foregroundColor(audioPlayerManager.repeatMode != .none ? .blue : .primary)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Secondary Controls
                HStack(spacing: 20) {
                    Button(action: {
                        // Add to playlist
                    }) {
                        Image(systemName: "heart")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Show queue
                    }) {
                        Image(systemName: "list.bullet")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    
                    Button(action: {
                        // Share song
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background(Color(.systemBackground))
        }
    }
    
    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

#Preview {
    MiniPlayerView()
        .environmentObject(AudioPlayerManager.shared)
}