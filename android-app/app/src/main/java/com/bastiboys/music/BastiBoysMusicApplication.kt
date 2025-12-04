package com.bastiboys.music

import android.app.Application
import dagger.hilt.android.HiltAndroidApp

@HiltAndroidApp
class BastiBoysMusicApplication : Application() {
    
    override fun onCreate() {
        super.onCreate()
        instance = this
    }
    
    companion object {
        lateinit var instance: BastiBoysMusicApplication
            private set
    }
}