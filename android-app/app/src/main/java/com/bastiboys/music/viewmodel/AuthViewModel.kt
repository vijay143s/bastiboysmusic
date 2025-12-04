package com.bastiboys.music.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.State
import com.bastiboys.music.data.model.LoginRequest
import com.bastiboys.music.data.model.RegisterRequest
import com.bastiboys.music.data.repository.MusicRepository
import com.bastiboys.music.utils.TokenManager
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class AuthViewModel @Inject constructor(
    private val repository: MusicRepository,
    private val tokenManager: TokenManager
) : ViewModel() {

    private val _loginState = mutableStateOf<AuthState>(AuthState.Idle)
    val loginState: State<AuthState> = _loginState

    private val _registerState = mutableStateOf<AuthState>(AuthState.Idle)
    val registerState: State<AuthState> = _registerState

    private val _isLoggedIn = mutableStateOf(false)
    val isLoggedIn: State<Boolean> = _isLoggedIn

    init {
        checkLoginStatus()
    }

    fun login(email: String, password: String) {
        viewModelScope.launch {
            _loginState.value = AuthState.Loading
            try {
                val response = repository.login(LoginRequest(email, password))
                if (response.status == "success") {
                    tokenManager.saveToken(response.token)
                    _isLoggedIn.value = true
                    _loginState.value = AuthState.Success(response.message)
                } else {
                    _loginState.value = AuthState.Error(response.message)
                }
            } catch (e: Exception) {
                _loginState.value = AuthState.Error(e.message ?: "Login failed")
            }
        }
    }

    fun register(firstName: String, lastName: String, email: String, password: String) {
        viewModelScope.launch {
            _registerState.value = AuthState.Loading
            try {
                val response = repository.register(
                    RegisterRequest(firstName, lastName, email, password)
                )
                if (response.status == "success") {
                    _registerState.value = AuthState.Success(response.message)
                } else {
                    _registerState.value = AuthState.Error(response.message)
                }
            } catch (e: Exception) {
                _registerState.value = AuthState.Error(e.message ?: "Registration failed")
            }
        }
    }

    fun logout() {
        viewModelScope.launch {
            tokenManager.clearToken()
            _isLoggedIn.value = false
        }
    }

    private fun checkLoginStatus() {
        _isLoggedIn.value = tokenManager.getToken() != null
    }

    fun resetLoginState() {
        _loginState.value = AuthState.Idle
    }

    fun resetRegisterState() {
        _registerState.value = AuthState.Idle
    }
}

sealed class AuthState {
    object Idle : AuthState()
    object Loading : AuthState()
    data class Success(val message: String) : AuthState()
    data class Error(val message: String) : AuthState()
}