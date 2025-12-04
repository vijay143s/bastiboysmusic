package com.bastiboys.music.di

import android.content.Context
import com.bastiboys.music.data.network.ApiService
import com.bastiboys.music.data.network.NetworkClient
import com.bastiboys.music.data.repository.MusicRepository
import com.bastiboys.music.utils.PreferenceManager
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object NetworkModule {
    
    @Provides
    @Singleton
    fun provideGson(): Gson {
        return GsonBuilder()
            .setLenient()
            .create()
    }
    
    @Provides
    @Singleton
    fun providePreferenceManager(
        @ApplicationContext context: Context,
        gson: Gson
    ): PreferenceManager {
        return PreferenceManager(context, gson)
    }
    
    @Provides
    @Singleton
    fun provideNetworkClient(
        @ApplicationContext context: Context,
        preferenceManager: PreferenceManager
    ): NetworkClient {
        return NetworkClient(context, preferenceManager)
    }
    
    @Provides
    @Singleton
    fun provideApiService(networkClient: NetworkClient): ApiService {
        return networkClient.apiService
    }
    
    @Provides
    @Singleton
    fun provideMusicRepository(
        apiService: ApiService,
        preferenceManager: PreferenceManager
    ): MusicRepository {
        return MusicRepository(apiService, preferenceManager)
    }
}