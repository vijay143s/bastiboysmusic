package com.bastiboys.music.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.State
import com.bastiboys.music.data.model.Song
import com.bastiboys.music.data.repository.MusicRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class SearchViewModel @Inject constructor(
    private val repository: MusicRepository
) : ViewModel() {

    private val _searchState = mutableStateOf(SearchState())
    val searchState: State<SearchState> = _searchState

    fun searchSongs(query: String) {
        if (query.isEmpty()) {
            _searchState.value = _searchState.value.copy(
                searchResults = emptyList(),
                searchQuery = ""
            )
            return
        }

        viewModelScope.launch {
            _searchState.value = _searchState.value.copy(
                isLoading = true,
                error = null,
                searchQuery = query
            )
            
            try {
                val response = repository.searchSongs(query)
                if (response.status == "success") {
                    _searchState.value = _searchState.value.copy(
                        isLoading = false,
                        searchResults = response.data
                    )
                } else {
                    _searchState.value = _searchState.value.copy(
                        isLoading = false,
                        error = response.message,
                        searchResults = emptyList()
                    )
                }
            } catch (e: Exception) {
                _searchState.value = _searchState.value.copy(
                    isLoading = false,
                    error = e.message ?: "Search failed",
                    searchResults = emptyList()
                )
            }
        }
    }

    fun clearSearch() {
        _searchState.value = SearchState()
    }
}

data class SearchState(
    val isLoading: Boolean = false,
    val searchResults: List<Song> = emptyList(),
    val searchQuery: String = "",
    val error: String? = null
)