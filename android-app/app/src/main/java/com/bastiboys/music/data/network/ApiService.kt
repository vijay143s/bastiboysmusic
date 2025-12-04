package com.bastiboys.music.data.network

import com.bastiboys.music.data.models.*
import retrofit2.Response
import retrofit2.http.*

interface ApiService {
    
    // Authentication endpoints
    @POST("user/login")
    suspend fun login(@Body request: LoginRequest): Response<ApiResponse<LoginResponse>>
    
    @POST("user/register")
    suspend fun register(@Body request: RegisterRequest): Response<ApiResponse<LoginResponse>>
    
    @GET("user/me")
    suspend fun getProfile(): Response<ApiResponse<User>>
    
    @GET("user/logout")
    suspend fun logout(): Response<ApiResponse<Any>>
    
    // Home endpoint
    @GET("home")
    suspend fun getHomeData(): Response<ApiResponse<HomeResponse>>
    
    // Songs endpoints
    @GET("song/all")
    suspend fun getAllSongs(
        @Query("page") page: Int = 1,
        @Query("limit") limit: Int = 20
    ): Response<ApiResponse<List<Song>>>
    
    @GET("song/top-played")
    suspend fun getTopPlayedSongs(
        @Query("page") page: Int = 1,
        @Query("limit") limit: Int = 20,
        @Query("shuffle") shuffle: Boolean = false
    ): Response<ApiResponse<List<Song>>>
    
    @GET("song/single/{id}")
    suspend fun getSingleSong(@Path("id") songId: Int): Response<ApiResponse<Song>>
    
    @GET("song/search")
    suspend fun searchSongs(
        @Query("q") query: String,
        @Query("year") year: Int? = null,
        @Query("page") page: Int = 1,
        @Query("limit") limit: Int = 20
    ): Response<ApiResponse<SearchResponse>>
    
    @POST("song/{id}/play")
    suspend fun updatePlayCount(@Path("id") songId: Int): Response<ApiResponse<Any>>
    
    // Albums endpoints
    @GET("song/album/all")
    suspend fun getAllAlbums(): Response<ApiResponse<List<Album>>>
    
    @GET("song/album/{id}")
    suspend fun getAlbumSongs(@Path("id") albumId: Int): Response<ApiResponse<List<Song>>>
    
    // Playlist endpoints
    @GET("song/playlist")
    suspend fun getPlaylistSongs(): Response<ApiResponse<List<Song>>>
    
    @POST("user/song/{id}")
    suspend fun addToPlaylist(@Path("id") songId: Int): Response<ApiResponse<Any>>
    
    @POST("user/last-played")
    suspend fun updateLastPlayedSong(@Body request: LastPlayedRequest): Response<ApiResponse<Any>>
    
    @GET("user/playlists/all")
    suspend fun getAllCommunityPlaylists(): Response<ApiResponse<List<Playlist>>>
    
    // Queue endpoints
    @GET("song/queue")
    suspend fun getQueueData(): Response<ApiResponse<QueueData>>
    
    @GET("song/queue/years")
    suspend fun getQueueYears(): Response<ApiResponse<List<Int>>>
    
    @GET("song/queue/year/{year}")
    suspend fun getQueueByYear(@Path("year") year: Int): Response<ApiResponse<List<Song>>>
    
    @GET("song/queue/batch")
    suspend fun getQueueByYearBatch(
        @Query("year") year: Int? = null,
        @Query("page") page: Int = 1,
        @Query("limit") limit: Int = 20
    ): Response<ApiResponse<List<Song>>>
    
    // Additional endpoints for artists, singers, music directors
    @GET("song/years")
    suspend fun getTopYears(): Response<ApiResponse<List<Int>>>
    
    @GET("song/albums/year/{year}")
    suspend fun getAlbumsByYear(@Path("year") year: Int): Response<ApiResponse<List<Album>>>
}