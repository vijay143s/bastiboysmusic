package com.bastiboys.music.utils

import android.content.Context
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import java.text.SimpleDateFormat
import java.util.*
import java.util.concurrent.TimeUnit

// Extension functions
fun String.isValidEmail(): Boolean {
    return android.util.Patterns.EMAIL_ADDRESS.matcher(this).matches()
}

fun Long.formatAsTime(): String {
    val hours = TimeUnit.MILLISECONDS.toHours(this)
    val minutes = TimeUnit.MILLISECONDS.toMinutes(this) % 60
    val seconds = TimeUnit.MILLISECONDS.toSeconds(this) % 60
    
    return if (hours > 0) {
        String.format("%d:%02d:%02d", hours, minutes, seconds)
    } else {
        String.format("%d:%02d", minutes, seconds)
    }
}

fun String.truncate(maxLength: Int): String {
    return if (this.length > maxLength) {
        this.substring(0, maxLength - 3) + "..."
    } else {
        this
    }
}

fun Date.formatToString(pattern: String = "dd/MM/yyyy"): String {
    return SimpleDateFormat(pattern, Locale.getDefault()).format(this)
}

// Constants
object Constants {
    const val DEFAULT_PAGE_SIZE = 20
    const val MAX_RECENT_SEARCHES = 10
    const val NOTIFICATION_CHANNEL_ID = "music_playback"
    const val NOTIFICATION_ID = 1
    const val PLAYBACK_NOTIFICATION_ID = 2
    
    // Audio Quality
    const val QUALITY_LOW = "low"
    const val QUALITY_MEDIUM = "medium"
    const val QUALITY_HIGH = "high"
    const val QUALITY_LOSSLESS = "lossless"
    
    // Intent Actions
    const val ACTION_PLAY = "com.bastiboys.music.PLAY"
    const val ACTION_PAUSE = "com.bastiboys.music.PAUSE"
    const val ACTION_NEXT = "com.bastiboys.music.NEXT"
    const val ACTION_PREVIOUS = "com.bastiboys.music.PREVIOUS"
    
    // Extras
    const val EXTRA_SONG = "extra_song"
    const val EXTRA_SONG_LIST = "extra_song_list"
    const val EXTRA_ALBUM_ID = "extra_album_id"
}

// UI Constants
object UIConstants {
    val CARD_ELEVATION = 4.dp
    val CARD_CORNER_RADIUS = 12.dp
    val MINI_PLAYER_HEIGHT = 80.dp
    val BOTTOM_NAV_HEIGHT = 80.dp
    val ALBUM_ART_SIZE_SMALL = 48.dp
    val ALBUM_ART_SIZE_MEDIUM = 120.dp
    val ALBUM_ART_SIZE_LARGE = 300.dp
}

// Color Extensions
@Composable
fun getCardBackgroundColor(): Color {
    return MaterialTheme.colorScheme.surfaceVariant
}

@Composable
fun getTextSecondaryColor(): Color {
    return MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f)
}

// Network Utils
object NetworkUtils {
    fun isValidUrl(url: String?): Boolean {
        return url != null && (url.startsWith("http://") || url.startsWith("https://"))
    }
    
    fun getImageUrl(url: String?): String? {
        return if (isValidUrl(url)) url else null
    }
}

// Audio Utils
object AudioUtils {
    fun formatBitrate(quality: String): String {
        return when (quality) {
            Constants.QUALITY_LOW -> "96 kbps"
            Constants.QUALITY_MEDIUM -> "160 kbps"
            Constants.QUALITY_HIGH -> "320 kbps"
            Constants.QUALITY_LOSSLESS -> "1411 kbps"
            else -> "Unknown"
        }
    }
    
    fun getQualityDisplayName(quality: String): String {
        return when (quality) {
            Constants.QUALITY_LOW -> "Low Quality"
            Constants.QUALITY_MEDIUM -> "Medium Quality"
            Constants.QUALITY_HIGH -> "High Quality"
            Constants.QUALITY_LOSSLESS -> "Lossless"
            else -> "Unknown Quality"
        }
    }
}

// Search Utils
object SearchUtils {
    fun addRecentSearch(query: String, recentSearches: List<String>): List<String> {
        val mutableList = recentSearches.toMutableList()
        
        // Remove if already exists
        mutableList.remove(query)
        
        // Add to the beginning
        mutableList.add(0, query)
        
        // Keep only the last 10 searches
        return mutableList.take(Constants.MAX_RECENT_SEARCHES)
    }
    
    fun clearRecentSearches(): List<String> {
        return emptyList()
    }
}

// Device Utils
object DeviceUtils {
    fun getDeviceId(context: Context): String {
        return android.provider.Settings.Secure.getString(
            context.contentResolver,
            android.provider.Settings.Secure.ANDROID_ID
        )
    }
    
    fun isTablet(context: Context): Boolean {
        return context.resources.configuration.screenLayout and 
                android.content.res.Configuration.SCREENLAYOUT_SIZE_MASK >= 
                android.content.res.Configuration.SCREENLAYOUT_SIZE_LARGE
    }
}