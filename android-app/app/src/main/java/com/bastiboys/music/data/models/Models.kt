package com.bastiboys.music.data.models

import android.os.Parcelable
import com.google.gson.annotations.SerializedName
import kotlinx.parcelize.Parcelize

@Parcelize
data class User(
    @SerializedName("id") val id: Int,
    @SerializedName("name") val name: String,
    @SerializedName("email") val email: String,
    @SerializedName("role") val role: String,
    @SerializedName("created_at") val createdAt: String,
    @SerializedName("updated_at") val updatedAt: String
) : Parcelable

@Parcelize
data class Song(
    @SerializedName("id") val id: Int,
    @SerializedName("album_id") val albumId: Int,
    @SerializedName("title") val title: String,
    @SerializedName("description") val description: String?,
    @SerializedName("singer") val singer: String?,
    @SerializedName("thumbnail_id") val thumbnailId: Int?,
    @SerializedName("thumbnail_url") val thumbnailUrl: String?,
    @SerializedName("audio_id") val audioId: Int?,
    @SerializedName("audio_url") val audioUrl: String?,
    @SerializedName("created_at") val createdAt: String,
    @SerializedName("updated_at") val updatedAt: String,
    @SerializedName("play_count") val playCount: Int? = 0,
    @SerializedName("album_title") val albumTitle: String?,
    @SerializedName("year") val year: Int?
) : Parcelable

@Parcelize
data class Album(
    @SerializedName("id") val id: Int,
    @SerializedName("title") val title: String,
    @SerializedName("description") val description: String?,
    @SerializedName("thumbnail_id") val thumbnailId: Int?,
    @SerializedName("thumbnail_url") val thumbnailUrl: String?,
    @SerializedName("year") val year: Int?,
    @SerializedName("director") val director: String?,
    @SerializedName("music_director") val musicDirector: String?,
    @SerializedName("star_cast") val starCast: String?,
    @SerializedName("created_at") val createdAt: String,
    @SerializedName("updated_at") val updatedAt: String,
    @SerializedName("song_count") val songCount: Int?
) : Parcelable

@Parcelize
data class Artist(
    @SerializedName("artist_id") val artistId: Int,
    @SerializedName("artist_name") val artistName: String,
    @SerializedName("album_id") val albumId: Int,
    @SerializedName("album_name") val albumName: String,
    @SerializedName("created_at") val createdAt: String,
    @SerializedName("updated_at") val updatedAt: String
) : Parcelable

@Parcelize
data class Singer(
    @SerializedName("singer_id") val singerId: Int,
    @SerializedName("singer_name") val singerName: String
) : Parcelable

@Parcelize
data class MusicDirector(
    @SerializedName("director_id") val directorId: Int,
    @SerializedName("director_name") val directorName: String,
    @SerializedName("album_id") val albumId: Int,
    @SerializedName("album_name") val albumName: String,
    @SerializedName("created_at") val createdAt: String,
    @SerializedName("updated_at") val updatedAt: String
) : Parcelable

// API Response Models
data class ApiResponse<T>(
    @SerializedName("success") val success: Boolean,
    @SerializedName("message") val message: String,
    @SerializedName("data") val data: T?
)

data class LoginResponse(
    @SerializedName("user") val user: User,
    @SerializedName("token") val token: String?
)

data class HomeResponse(
    @SerializedName("latest_albums") val latestAlbums: List<Album>,
    @SerializedName("top_played_songs") val topPlayedSongs: List<Song>,
    @SerializedName("total_songs") val totalSongs: Int,
    @SerializedName("total_albums") val totalAlbums: Int
)

data class SearchResponse(
    @SerializedName("songs") val songs: List<Song>,
    @SerializedName("total") val total: Int,
    @SerializedName("page") val page: Int,
    @SerializedName("limit") val limit: Int,
    @SerializedName("hasMore") val hasMore: Boolean
)

data class QueueData(
    @SerializedName("songs") val songs: List<Song>,
    @SerializedName("years") val years: List<Int>,
    @SerializedName("total_songs") val totalSongs: Int
)

@Parcelize
data class Playlist(
    @SerializedName("id") val id: Int,
    @SerializedName("user_id") val userId: Int,
    @SerializedName("song_id") val songId: Int,
    @SerializedName("created_at") val createdAt: String,
    @SerializedName("updated_at") val updatedAt: String,
    @SerializedName("song") val song: Song?
) : Parcelable

// Login/Register request models
data class LoginRequest(
    @SerializedName("email") val email: String,
    @SerializedName("password") val password: String
)

data class RegisterRequest(
    @SerializedName("name") val name: String,
    @SerializedName("email") val email: String,
    @SerializedName("password") val password: String
)

data class LastPlayedRequest(
    @SerializedName("songId") val songId: Int
)

// Player related models
enum class RepeatMode {
    NONE, ONE, ALL
}

data class PlayerState(
    val currentSong: Song? = null,
    val isPlaying: Boolean = false,
    val currentPosition: Long = 0L,
    val duration: Long = 0L,
    val playbackSpeed: Float = 1.0f,
    val shuffleEnabled: Boolean = false,
    val repeatMode: RepeatMode = RepeatMode.NONE,
    val queue: List<Song> = emptyList(),
    val currentIndex: Int = 0,
    val isBuffering: Boolean = false
)