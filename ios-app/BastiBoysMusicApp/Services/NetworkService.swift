import Foundation
import Network

class NetworkService: ObservableObject {
    static let shared = NetworkService()
    
    private let baseURL = "http://localhost:5000/api" // Change this to your server URL
    private let session = URLSession.shared
    
    private init() {}
    
    // MARK: - Generic API Request
    private func makeRequest<T: Codable>(
        endpoint: String,
        method: HTTPMethod = .GET,
        body: Data? = nil,
        headers: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T {
        
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add auth token if available
        if let token = AuthService.shared.authToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Add custom headers
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(responseType, from: data)
            return decodedResponse
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingError
        }
    }
    
    // MARK: - Authentication API
    func login(email: String, password: String) async throws -> LoginResponse {
        let body = ["email": email, "password": password]
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        
        let response: APIResponse<LoginResponse> = try await makeRequest(
            endpoint: "/user/login",
            method: .POST,
            body: bodyData,
            responseType: APIResponse<LoginResponse>.self
        )
        
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }
    
    func register(name: String, email: String, password: String) async throws -> LoginResponse {
        let body = ["name": name, "email": email, "password": password]
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        
        let response: APIResponse<LoginResponse> = try await makeRequest(
            endpoint: "/user/register",
            method: .POST,
            body: bodyData,
            responseType: APIResponse<LoginResponse>.self
        )
        
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }
    
    func getProfile() async throws -> User {
        let response: APIResponse<User> = try await makeRequest(
            endpoint: "/user/me",
            responseType: APIResponse<User>.self
        )
        
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }
    
    // MARK: - Home API
    func getHomeData() async throws -> HomeResponse {
        let response: APIResponse<HomeResponse> = try await makeRequest(
            endpoint: "/home",
            responseType: APIResponse<HomeResponse>.self
        )
        
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }
    
    // MARK: - Songs API
    func getAllSongs(page: Int = 1, limit: Int = 20) async throws -> [Song] {
        let response: APIResponse<[Song]> = try await makeRequest(
            endpoint: "/song/all?page=\(page)&limit=\(limit)",
            responseType: APIResponse<[Song]>.self
        )
        
        return response.data ?? []
    }
    
    func getTopPlayedSongs(page: Int = 1, limit: Int = 20, shuffle: Bool = false) async throws -> [Song] {
        let response: APIResponse<[Song]> = try await makeRequest(
            endpoint: "/song/top-played?page=\(page)&limit=\(limit)&shuffle=\(shuffle)",
            responseType: APIResponse<[Song]>.self
        )
        
        return response.data ?? []
    }
    
    func getSingleSong(id: Int) async throws -> Song {
        let response: APIResponse<Song> = try await makeRequest(
            endpoint: "/song/single/\(id)",
            responseType: APIResponse<Song>.self
        )
        
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }
    
    func searchSongs(query: String, year: Int? = nil, page: Int = 1, limit: Int = 20) async throws -> SearchResponse {
        var endpoint = "/song/search?q=\(query)&page=\(page)&limit=\(limit)"
        if let year = year {
            endpoint += "&year=\(year)"
        }
        
        let response: APIResponse<SearchResponse> = try await makeRequest(
            endpoint: endpoint,
            responseType: APIResponse<SearchResponse>.self
        )
        
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }
    
    func updatePlayCount(songId: Int) async throws {
        let _: APIResponse<EmptyResponse> = try await makeRequest(
            endpoint: "/song/\(songId)/play",
            method: .POST,
            responseType: APIResponse<EmptyResponse>.self
        )
    }
    
    // MARK: - Albums API
    func getAllAlbums() async throws -> [Album] {
        let response: APIResponse<[Album]> = try await makeRequest(
            endpoint: "/song/album/all",
            responseType: APIResponse<[Album]>.self
        )
        
        return response.data ?? []
    }
    
    func getAlbumSongs(albumId: Int) async throws -> [Song] {
        let response: APIResponse<[Song]> = try await makeRequest(
            endpoint: "/song/album/\(albumId)",
            responseType: APIResponse<[Song]>.self
        )
        
        return response.data ?? []
    }
    
    // MARK: - Playlist API
    func getPlaylistSongs() async throws -> [Song] {
        let response: APIResponse<[Song]> = try await makeRequest(
            endpoint: "/song/playlist",
            responseType: APIResponse<[Song]>.self
        )
        
        return response.data ?? []
    }
    
    func addToPlaylist(songId: Int) async throws {
        let _: APIResponse<EmptyResponse> = try await makeRequest(
            endpoint: "/user/song/\(songId)",
            method: .POST,
            responseType: APIResponse<EmptyResponse>.self
        )
    }
    
    func updateLastPlayedSong(songId: Int) async throws {
        let body = ["songId": songId]
        let bodyData = try JSONSerialization.data(withJSONObject: body)
        
        let _: APIResponse<EmptyResponse> = try await makeRequest(
            endpoint: "/user/last-played",
            method: .POST,
            body: bodyData,
            responseType: APIResponse<EmptyResponse>.self
        )
    }
    
    // MARK: - Queue API
    func getQueueData() async throws -> QueueData {
        let response: APIResponse<QueueData> = try await makeRequest(
            endpoint: "/song/queue",
            responseType: APIResponse<QueueData>.self
        )
        
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }
}

// MARK: - Supporting Types
enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingError
    case noData
    case noInternetConnection
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .serverError(let code):
            return "Server error: \(code)"
        case .decodingError:
            return "Failed to decode response"
        case .noData:
            return "No data received"
        case .noInternetConnection:
            return "No internet connection"
        }
    }
}

struct EmptyResponse: Codable {}

// MARK: - Network Monitor
class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    @Published var isConnected = true
    @Published var connectionType = NWInterface.InterfaceType.other
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
                self.connectionType = path.availableInterfaces.first?.type ?? .other
            }
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}