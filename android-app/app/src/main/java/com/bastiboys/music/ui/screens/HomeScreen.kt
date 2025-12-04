package com.bastiboys.music.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import com.bastiboys.music.ui.components.SongItem
import com.bastiboys.music.ui.components.AlbumItem
import com.bastiboys.music.viewmodel.HomeViewModel
import com.bastiboys.music.data.model.Song

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun HomeScreen(
    onSongClick: (Song) -> Unit,
    viewModel: HomeViewModel = hiltViewModel()
) {
    val homeState by viewModel.homeState

    Column(
        modifier = Modifier.fillMaxSize()
    ) {
        // Top app bar
        TopAppBar(
            title = {
                Text(
                    text = "BastiBoys Music",
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold
                )
            },
            actions = {
                IconButton(onClick = { viewModel.refresh() }) {
                    Icon(Icons.Default.Refresh, contentDescription = "Refresh")
                }
            }
        )

        if (homeState.isLoading) {
            Box(
                modifier = Modifier.fillMaxSize(),
                contentAlignment = Alignment.Center
            ) {
                CircularProgressIndicator()
            }
        } else if (homeState.error != null) {
            Box(
                modifier = Modifier.fillMaxSize(),
                contentAlignment = Alignment.Center
            ) {
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Text(
                        text = "Error loading home data",
                        style = MaterialTheme.typography.titleMedium,
                        color = MaterialTheme.colorScheme.error
                    )
                    Text(
                        text = homeState.error!!,
                        style = MaterialTheme.typography.bodyMedium,
                        color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f),
                        modifier = Modifier.padding(top = 8.dp)
                    )
                    Button(
                        onClick = { viewModel.refresh() },
                        modifier = Modifier.padding(top = 16.dp)
                    ) {
                        Text("Retry")
                    }
                }
            }
        } else {
            LazyColumn(
                modifier = Modifier.fillMaxSize(),
                contentPadding = PaddingValues(16.dp),
                verticalArrangement = Arrangement.spacedBy(24.dp)
            ) {
                // Top Played Songs Section
                if (homeState.topPlayedSongs.isNotEmpty()) {
                    item {
                        Column {
                            Text(
                                text = "Top Played Songs",
                                fontSize = 24.sp,
                                fontWeight = FontWeight.Bold,
                                modifier = Modifier.padding(bottom = 16.dp)
                            )
                            
                            homeState.topPlayedSongs.take(5).forEach { song ->
                                SongItem(
                                    song = song,
                                    onClick = { onSongClick(song) }
                                )
                                Spacer(modifier = Modifier.height(8.dp))
                            }
                        }
                    }
                }

                // Latest Albums Section
                if (homeState.latestAlbums.isNotEmpty()) {
                    item {
                        Column {
                            Text(
                                text = "Latest Albums",
                                fontSize = 24.sp,
                                fontWeight = FontWeight.Bold,
                                modifier = Modifier.padding(bottom = 16.dp)
                            )
                            
                            LazyRow(
                                horizontalArrangement = Arrangement.spacedBy(16.dp)
                            ) {
                                items(homeState.latestAlbums) { album ->
                                    AlbumItem(album = album)
                                }
                            }
                        }
                    }
                }

                // Empty state
                if (homeState.topPlayedSongs.isEmpty() && homeState.latestAlbums.isEmpty()) {
                    item {
                        Box(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(vertical = 48.dp),
                            contentAlignment = Alignment.Center
                        ) {
                            Column(
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                Text(
                                    text = "No music available",
                                    style = MaterialTheme.typography.titleMedium
                                )
                                Text(
                                    text = "Check back later for new content",
                                    style = MaterialTheme.typography.bodyMedium,
                                    color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f),
                                    modifier = Modifier.padding(top = 8.dp)
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}