package com.bastiboys.music.data.network

import android.content.Context
import com.bastiboys.music.BuildConfig
import com.bastiboys.music.utils.PreferenceManager
import dagger.hilt.android.qualifiers.ApplicationContext
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.Response
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class NetworkClient @Inject constructor(
    @ApplicationContext private val context: Context,
    private val preferenceManager: PreferenceManager
) {
    
    private val loggingInterceptor = HttpLoggingInterceptor().apply {
        level = if (BuildConfig.DEBUG) {
            HttpLoggingInterceptor.Level.BODY
        } else {
            HttpLoggingInterceptor.Level.NONE
        }
    }
    
    private val authInterceptor = AuthInterceptor(preferenceManager)
    
    private val okHttpClient = OkHttpClient.Builder()
        .addInterceptor(loggingInterceptor)
        .addInterceptor(authInterceptor)
        .connectTimeout(30, TimeUnit.SECONDS)
        .readTimeout(30, TimeUnit.SECONDS)
        .writeTimeout(30, TimeUnit.SECONDS)
        .build()
    
    private val retrofit = Retrofit.Builder()
        .baseUrl(BuildConfig.BASE_URL)
        .client(okHttpClient)
        .addConverterFactory(GsonConverterFactory.create())
        .build()
    
    val apiService: ApiService = retrofit.create(ApiService::class.java)
}

class AuthInterceptor @Inject constructor(
    private val preferenceManager: PreferenceManager
) : Interceptor {
    
    override fun intercept(chain: Interceptor.Chain): Response {
        val originalRequest = chain.request()
        
        // Get token from preferences
        val token = preferenceManager.getAuthToken()
        
        return if (!token.isNullOrEmpty()) {
            val authenticatedRequest = originalRequest.newBuilder()
                .header("Authorization", "Bearer $token")
                .header("Content-Type", "application/json")
                .build()
            chain.proceed(authenticatedRequest)
        } else {
            val request = originalRequest.newBuilder()
                .header("Content-Type", "application/json")
                .build()
            chain.proceed(request)
        }
    }
}

// Network Result wrapper
sealed class NetworkResult<T> {
    data class Success<T>(val data: T) : NetworkResult<T>()
    data class Error<T>(val message: String, val code: Int? = null) : NetworkResult<T>()
    data class Loading<T>(val isLoading: Boolean = true) : NetworkResult<T>()
}

// Extension function for safe API calls
suspend fun <T> safeApiCall(
    apiCall: suspend () -> retrofit2.Response<ApiResponse<T>>
): NetworkResult<T> {
    return try {
        val response = apiCall()
        if (response.isSuccessful) {
            val body = response.body()
            if (body?.success == true && body.data != null) {
                NetworkResult.Success(body.data)
            } else {
                NetworkResult.Error(body?.message ?: "Unknown error occurred")
            }
        } else {
            NetworkResult.Error(
                message = "HTTP ${response.code()}: ${response.message()}",
                code = response.code()
            )
        }
    } catch (e: Exception) {
        NetworkResult.Error(
            message = e.message ?: "Network error occurred"
        )
    }
}