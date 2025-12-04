package com.bastiboys.music.data.repository

import com.bastiboys.music.data.models.*
import com.bastiboys.music.data.network.ApiService
import com.bastiboys.music.data.network.NetworkResult
import com.bastiboys.music.data.network.safeApiCall
import com.bastiboys.music.utils.PreferenceManager
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class MusicRepository @Inject constructor(
    private val apiService: ApiService,
    private val preferenceManager: PreferenceManager
) {
    
    // Authentication
    suspend fun login(email: String, password: String): NetworkResult<LoginResponse> {
        return safeApiCall {
            apiService.login(LoginRequest(email, password))
        }
    }
    
    suspend fun register(name: String, email: String, password: String): NetworkResult<LoginResponse> {
        return safeApiCall {
            apiService.register(RegisterRequest(name, email, password))
        }
    }
    
    suspend fun getProfile(): NetworkResult<User> {
        return safeApiCall {
            apiService.getProfile()
        }
    }
    
    suspend fun logout(): NetworkResult<Any> {
        return safeApiCall {
            apiService.logout()
        }
    }
    
    // Home
    suspend fun getHomeData(): NetworkResult<HomeResponse> {
        return safeApiCall {
            apiService.getHomeData()
        }
    }
    
    // Songs
    suspend fun getAllSongs(page: Int = 1, limit: Int = 20): NetworkResult<List<Song>> {
        return safeApiCall {
            apiService.getAllSongs(page, limit)
        }
    }
    
    suspend fun getTopPlayedSongs(
        page: Int = 1, 
        limit: Int = 20, 
        shuffle: Boolean = false
    ): NetworkResult<List<Song>> {
        return safeApiCall {
            apiService.getTopPlayedSongs(page, limit, shuffle)
        }
    }
    
    suspend fun getSingleSong(songId: Int): NetworkResult<Song> {
        return safeApiCall {
            apiService.getSingleSong(songId)
        }
    }
    
    suspend fun searchSongs(
        query: String,
        year: Int? = null,
        page: Int = 1,
        limit: Int = 20
    ): NetworkResult<SearchResponse> {
        return safeApiCall {
            apiService.searchSongs(query, year, page, limit)
        }
    }
    
    suspend fun updatePlayCount(songId: Int): NetworkResult<Any> {
        return safeApiCall {
            apiService.updatePlayCount(songId)
        }
    }
    
    // Albums
    suspend fun getAllAlbums(): NetworkResult<List<Album>> {
        return safeApiCall {
            apiService.getAllAlbums()
        }
    }
    
    suspend fun getAlbumSongs(albumId: Int): NetworkResult<List<Song>> {
        return safeApiCall {
            apiService.getAlbumSongs(albumId)
        }
    }
    
    // Playlists
    suspend fun getPlaylistSongs(): NetworkResult<List<Song>> {
        return safeApiCall {
            apiService.getPlaylistSongs()
        }
    }
    
    suspend fun addToPlaylist(songId: Int): NetworkResult<Any> {
        return safeApiCall {
            apiService.addToPlaylist(songId)
        }
    }
    
    suspend fun updateLastPlayedSong(songId: Int): NetworkResult<Any> {
        return safeApiCall {
            apiService.updateLastPlayedSong(LastPlayedRequest(songId))
        }
    }
    
    suspend fun getAllCommunityPlaylists(): NetworkResult<List<Playlist>> {
        return safeApiCall {
            apiService.getAllCommunityPlaylists()
        }
    }
    
    // Queue
    suspend fun getQueueData(): NetworkResult<QueueData> {
        return safeApiCall {
            apiService.getQueueData()
        }
    }
    
    suspend fun getQueueYears(): NetworkResult<List<Int>> {
        return safeApiCall {
            apiService.getQueueYears()
        }
    }
    
    suspend fun getQueueByYear(year: Int): NetworkResult<List<Song>> {
        return safeApiCall {
            apiService.getQueueByYear(year)
        }
    }
    
    // Additional methods
    suspend fun getTopYears(): NetworkResult<List<Int>> {
        return safeApiCall {
            apiService.getTopYears()
        }
    }
    
    suspend fun getAlbumsByYear(year: Int): NetworkResult<List<Album>> {
        return safeApiCall {
            apiService.getAlbumsByYear(year)
        }
    }
    
    // Local data management
    fun saveAuthToken(token: String) {
        preferenceManager.saveAuthToken(token)
    }
    
    fun saveUser(user: User) {
        preferenceManager.saveUser(user)
    }
    
    fun getAuthToken(): String? {
        return preferenceManager.getAuthToken()
    }
    
    fun getCurrentUser(): User? {
        return preferenceManager.getCurrentUser()
    }
    
    fun clearAuthData() {
        preferenceManager.clearAuthData()
    }
    
    fun isUserLoggedIn(): Boolean {
        return !getAuthToken().isNullOrEmpty()
    }
}