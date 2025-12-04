package com.bastiboys.music

import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.currentBackStackEntryAsState
import com.bastiboys.music.viewmodel.AuthViewModel
import com.bastiboys.music.ui.screens.*
import com.bastiboys.music.data.model.Song

@Composable
fun Navigation(
    navController: NavHostController,
    onSongClick: (Song) -> Unit
) {
    val authViewModel: AuthViewModel = hiltViewModel()
    val isLoggedIn by authViewModel.isLoggedIn
    
    val navBackStackEntry by navController.currentBackStackEntryAsState()
    val currentDestination = navBackStackEntry?.destination

    NavHost(
        navController = navController,
        startDestination = if (isLoggedIn) "main" else "login"
    ) {
        // Authentication screens
        composable("login") {
            LoginScreen(
                onNavigateToRegister = {
                    navController.navigate("register") {
                        popUpTo("login") { inclusive = true }
                    }
                },
                onLoginSuccess = {
                    navController.navigate("main") {
                        popUpTo("login") { inclusive = true }
                    }
                }
            )
        }
        
        composable("register") {
            RegisterScreen(
                onNavigateToLogin = {
                    navController.navigate("login") {
                        popUpTo("register") { inclusive = true }
                    }
                },
                onRegisterSuccess = {
                    navController.navigate("login") {
                        popUpTo("register") { inclusive = true }
                    }
                }
            )
        }

        // Main app screens
        composable("main") {
            MainScreen(
                navController = navController,
                onSongClick = onSongClick
            )
        }

        composable("home") {
            HomeScreen(onSongClick = onSongClick)
        }

        composable("search") {
            SearchScreen(onSongClick = onSongClick)
        }

        composable("library") {
            LibraryScreen()
        }

        composable("profile") {
            ProfileScreen()
        }
    }
}