package com.bastiboys.music

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.navigation.compose.rememberNavController
import com.bastiboys.music.ui.theme.BastiBoysMusicTheme
import com.bastiboys.music.data.model.Song

@Composable
fun BastiBoysMusicApp() {
    BastiBoysMusicTheme {
        Surface(
            modifier = Modifier.fillMaxSize(),
            color = MaterialTheme.colorScheme.background
        ) {
            val navController = rememberNavController()
            var currentSong by remember { mutableStateOf<Song?>(null) }
            
            Navigation(
                navController = navController,
                onSongClick = { song ->
                    currentSong = song
                    // TODO: Implement audio player service
                }
            )
        }
    }
}