package com.bastiboys.music.utils

import android.content.Context
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import com.bastiboys.music.data.models.User
import com.google.gson.Gson
import dagger.hilt.android.qualifiers.ApplicationContext
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.runBlocking
import javax.inject.Inject
import javax.inject.Singleton

private val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "bastibools_music_prefs")

@Singleton
class PreferenceManager @Inject constructor(
    @ApplicationContext private val context: Context,
    private val gson: Gson
) {
    
    private val dataStore = context.dataStore
    
    companion object {
        val AUTH_TOKEN_KEY = stringPreferencesKey("auth_token")
        val CURRENT_USER_KEY = stringPreferencesKey("current_user")
        val RECENT_SEARCHES_KEY = stringPreferencesKey("recent_searches")
        val AUDIO_QUALITY_KEY = stringPreferencesKey("audio_quality")
        val DOWNLOAD_WIFI_ONLY_KEY = stringPreferencesKey("download_wifi_only")
    }
    
    // Auth Token
    fun saveAuthToken(token: String) {
        runBlocking {
            dataStore.edit { preferences ->
                preferences[AUTH_TOKEN_KEY] = token
            }
        }
    }
    
    fun getAuthToken(): String? {
        return runBlocking {
            dataStore.data.map { preferences ->
                preferences[AUTH_TOKEN_KEY]
            }.first()
        }
    }
    
    // User
    fun saveUser(user: User) {
        runBlocking {
            dataStore.edit { preferences ->
                preferences[CURRENT_USER_KEY] = gson.toJson(user)
            }
        }
    }
    
    fun getCurrentUser(): User? {
        return runBlocking {
            dataStore.data.map { preferences ->
                preferences[CURRENT_USER_KEY]?.let { userJson ->
                    try {
                        gson.fromJson(userJson, User::class.java)
                    } catch (e: Exception) {
                        null
                    }
                }
            }.first()
        }
    }
    
    // Recent Searches
    fun saveRecentSearches(searches: List<String>) {
        runBlocking {
            dataStore.edit { preferences ->
                preferences[RECENT_SEARCHES_KEY] = gson.toJson(searches)
            }
        }
    }
    
    fun getRecentSearches(): List<String> {
        return runBlocking {
            dataStore.data.map { preferences ->
                preferences[RECENT_SEARCHES_KEY]?.let { searchesJson ->
                    try {
                        gson.fromJson(searchesJson, Array<String>::class.java).toList()
                    } catch (e: Exception) {
                        emptyList()
                    }
                } ?: emptyList()
            }.first()
        }
    }
    
    // Audio Quality
    fun saveAudioQuality(quality: String) {
        runBlocking {
            dataStore.edit { preferences ->
                preferences[AUDIO_QUALITY_KEY] = quality
            }
        }
    }
    
    fun getAudioQuality(): String {
        return runBlocking {
            dataStore.data.map { preferences ->
                preferences[AUDIO_QUALITY_KEY] ?: "high"
            }.first()
        }
    }
    
    // Download WiFi Only
    fun setDownloadWifiOnly(wifiOnly: Boolean) {
        runBlocking {
            dataStore.edit { preferences ->
                preferences[DOWNLOAD_WIFI_ONLY_KEY] = wifiOnly.toString()
            }
        }
    }
    
    fun isDownloadWifiOnly(): Boolean {
        return runBlocking {
            dataStore.data.map { preferences ->
                preferences[DOWNLOAD_WIFI_ONLY_KEY]?.toBoolean() ?: true
            }.first()
        }
    }
    
    // Clear all auth data
    fun clearAuthData() {
        runBlocking {
            dataStore.edit { preferences ->
                preferences.remove(AUTH_TOKEN_KEY)
                preferences.remove(CURRENT_USER_KEY)
            }
        }
    }
    
    // Clear all data
    fun clearAllData() {
        runBlocking {
            dataStore.edit { preferences ->
                preferences.clear()
            }
        }
    }
}