import Foundation

// MARK: - User Model
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let role: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Song Model
struct Song: Codable, Identifiable, Equatable {
    let id: Int
    let albumId: Int
    let title: String
    let description: String?
    let singer: String?
    let thumbnailId: Int?
    let thumbnailUrl: String?
    let audioId: Int?
    let audioUrl: String?
    let createdAt: String
    let updatedAt: String
    let playCount: Int?
    let albumTitle: String?
    let year: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, singer
        case albumId = "album_id"
        case thumbnailId = "thumbnail_id"
        case thumbnailUrl = "thumbnail_url"
        case audioId = "audio_id"
        case audioUrl = "audio_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case playCount = "play_count"
        case albumTitle = "album_title"
        case year
    }
    
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Album Model
struct Album: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let thumbnailId: Int?
    let thumbnailUrl: String?
    let year: Int?
    let director: String?
    let musicDirector: String?
    let starCast: String?
    let createdAt: String
    let updatedAt: String
    let songCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, year, director
        case thumbnailId = "thumbnail_id"
        case thumbnailUrl = "thumbnail_url"
        case musicDirector = "music_director"
        case starCast = "star_cast"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case songCount = "song_count"
    }
}

// MARK: - Artist Model
struct Artist: Codable, Identifiable {
    let artistId: Int
    let artistName: String
    let albumId: Int
    let albumName: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case artistId = "artist_id"
        case artistName = "artist_name"
        case albumId = "album_id"
        case albumName = "album_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    var id: Int { artistId }
}

// MARK: - Singer Model
struct Singer: Codable, Identifiable {
    let singerId: Int
    let singerName: String
    
    enum CodingKeys: String, CodingKey {
        case singerId = "singer_id"
        case singerName = "singer_name"
    }
    
    var id: Int { singerId }
}

// MARK: - Music Director Model
struct MusicDirector: Codable, Identifiable {
    let directorId: Int
    let directorName: String
    let albumId: Int
    let albumName: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case directorId = "director_id"
        case directorName = "director_name"
        case albumId = "album_id"
        case albumName = "album_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    var id: Int { directorId }
}

// MARK: - API Response Models
struct APIResponse<T: Codable>: Codable {
    let success: Bool
    let message: String
    let data: T?
}

struct LoginResponse: Codable {
    let user: User
    let token: String?
}

struct HomeResponse: Codable {
    let latestAlbums: [Album]
    let topPlayedSongs: [Song]
    let totalSongs: Int
    let totalAlbums: Int
    
    enum CodingKeys: String, CodingKey {
        case latestAlbums = "latest_albums"
        case topPlayedSongs = "top_played_songs"
        case totalSongs = "total_songs"
        case totalAlbums = "total_albums"
    }
}

struct SearchResponse: Codable {
    let songs: [Song]
    let total: Int
    let page: Int
    let limit: Int
    let hasMore: Bool
    
    enum CodingKeys: String, CodingKey {
        case songs, total, page, limit
        case hasMore = "hasMore"
    }
}

// MARK: - Queue Data
struct QueueData: Codable {
    let songs: [Song]
    let years: [Int]
    let totalSongs: Int
    
    enum CodingKeys: String, CodingKey {
        case songs, years
        case totalSongs = "total_songs"
    }
}

// MARK: - Playlist
struct Playlist: Codable, Identifiable {
    let id: Int
    let userId: Int
    let songId: Int
    let createdAt: String
    let updatedAt: String
    let song: Song?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case songId = "song_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case song
    }
}