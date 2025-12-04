import SwiftUI

// MARK: - View Extensions
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - Color Extensions
extension Color {
    static let spotifyGreen = Color(red: 0.114, green: 0.733, blue: 0.322)
    static let darkBackground = Color(red: 0.071, green: 0.071, blue: 0.071)
    static let cardBackground = Color(red: 0.114, green: 0.114, blue: 0.114)
}

// MARK: - String Extensions
extension String {
    func truncated(to length: Int) -> String {
        if self.count > length {
            return String(self.prefix(length)) + "..."
        }
        return self
    }
    
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: self)
    }
}

// MARK: - Double Extensions
extension Double {
    func formatAsTime() -> String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

// MARK: - Array Extensions
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// MARK: - Custom View Modifiers
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    var isEnabled: Bool = true
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(isEnabled ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

extension View {
    func cardStyle() -> some View {
        self.modifier(CardModifier())
    }
    
    func primaryButton(enabled: Bool = true) -> some View {
        self.buttonStyle(PrimaryButtonStyle(isEnabled: enabled))
    }
}

// MARK: - Constants
struct AppConstants {
    static let defaultThumbnail = "music.note"
    static let defaultArtwork = "opticaldisc"
    static let maxRecentSearches = 10
    static let defaultPageSize = 20
    
    struct API {
        static let baseURL = "http://localhost:5000/api"
        static let timeout: TimeInterval = 30
    }
    
    struct UserDefaults {
        static let authToken = "auth_token"
        static let currentUser = "current_user"
        static let recentSearches = "recent_searches"
        static let audioQuality = "audio_quality"
        static let downloadOnWiFiOnly = "download_wifi_only"
    }
}

// MARK: - Error Handling
enum AppError: Error, LocalizedError {
    case networkUnavailable
    case invalidCredentials
    case unauthorized
    case serverError(String)
    case decodingError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .networkUnavailable:
            return "Network connection unavailable"
        case .invalidCredentials:
            return "Invalid email or password"
        case .unauthorized:
            return "You are not authorized to perform this action"
        case .serverError(let message):
            return message
        case .decodingError:
            return "Failed to process server response"
        case .unknown:
            return "An unknown error occurred"
        }
    }
}

// MARK: - Audio Quality
enum AudioQuality: String, CaseIterable {
    case low = "Low (96 kbps)"
    case medium = "Medium (160 kbps)"
    case high = "High (320 kbps)"
    case lossless = "Lossless"
    
    var bitrate: Int {
        switch self {
        case .low: return 96
        case .medium: return 160
        case .high: return 320
        case .lossless: return 1411
        }
    }
}

// MARK: - Haptic Feedback
struct HapticManager {
    static func light() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
    
    static func medium() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
    
    static func heavy() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedback.impactOccurred()
    }
    
    static func success() {
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(.success)
    }
    
    static func error() {
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(.error)
    }
}

// MARK: - Image Cache
class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 50 // 50MB
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }
    
    func removeImage(forKey key: String) {
        cache.removeObject(forKey: NSString(string: key))
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}