package com.bastiboys.music.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.State
import com.bastiboys.music.data.model.Song
import com.bastiboys.music.data.model.Album
import com.bastiboys.music.data.repository.MusicRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class HomeViewModel @Inject constructor(
    private val repository: MusicRepository
) : ViewModel() {

    private val _homeState = mutableStateOf(HomeState())
    val homeState: State<HomeState> = _homeState

    init {
        loadHomeData()
    }

    private fun loadHomeData() {
        viewModelScope.launch {
            _homeState.value = _homeState.value.copy(isLoading = true, error = null)
            
            try {
                // Load top played songs
                val topSongsResponse = repository.getTopPlayedSongs()
                val topSongs = if (topSongsResponse.status == "success") {
                    topSongsResponse.data
                } else {
                    emptyList()
                }

                // Load latest albums
                val latestAlbumsResponse = repository.getLatestAlbums()
                val latestAlbums = if (latestAlbumsResponse.status == "success") {
                    latestAlbumsResponse.data
                } else {
                    emptyList()
                }

                _homeState.value = _homeState.value.copy(
                    isLoading = false,
                    topPlayedSongs = topSongs,
                    latestAlbums = latestAlbums
                )

            } catch (e: Exception) {
                _homeState.value = _homeState.value.copy(
                    isLoading = false,
                    error = e.message ?: "Failed to load home data"
                )
            }
        }
    }

    fun refresh() {
        loadHomeData()
    }
}

data class HomeState(
    val isLoading: Boolean = false,
    val topPlayedSongs: List<Song> = emptyList(),
    val latestAlbums: List<Album> = emptyList(),
    val error: String? = null
)