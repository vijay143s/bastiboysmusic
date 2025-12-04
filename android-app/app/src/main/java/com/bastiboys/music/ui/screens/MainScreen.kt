package com.bastiboys.music.ui.screens

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.filled.LibraryMusic
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.navigation.NavController
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import com.bastiboys.music.data.model.Song

@Composable
fun MainScreen(
    navController: NavHostController,
    onSongClick: (Song) -> Unit
) {
    val bottomNavController = rememberNavController()
    val navBackStackEntry by bottomNavController.currentBackStackEntryAsState()
    val currentDestination = navBackStackEntry?.destination

    Scaffold(
        modifier = Modifier.fillMaxSize(),
        bottomBar = {
            NavigationBar {
                NavigationBarItem(
                    icon = { Icon(Icons.Default.Home, contentDescription = "Home") },
                    label = { Text("Home") },
                    selected = currentDestination?.route == "home",
                    onClick = {
                        bottomNavController.navigate("home") {
                            popUpTo(bottomNavController.graph.startDestinationId) {
                                saveState = true
                            }
                            launchSingleTop = true
                            restoreState = true
                        }
                    }
                )
                NavigationBarItem(
                    icon = { Icon(Icons.Default.Search, contentDescription = "Search") },
                    label = { Text("Search") },
                    selected = currentDestination?.route == "search",
                    onClick = {
                        bottomNavController.navigate("search") {
                            popUpTo(bottomNavController.graph.startDestinationId) {
                                saveState = true
                            }
                            launchSingleTop = true
                            restoreState = true
                        }
                    }
                )
                NavigationBarItem(
                    icon = { Icon(Icons.Default.LibraryMusic, contentDescription = "Library") },
                    label = { Text("Library") },
                    selected = currentDestination?.route == "library",
                    onClick = {
                        bottomNavController.navigate("library") {
                            popUpTo(bottomNavController.graph.startDestinationId) {
                                saveState = true
                            }
                            launchSingleTop = true
                            restoreState = true
                        }
                    }
                )
                NavigationBarItem(
                    icon = { Icon(Icons.Default.Person, contentDescription = "Profile") },
                    label = { Text("Profile") },
                    selected = currentDestination?.route == "profile",
                    onClick = {
                        bottomNavController.navigate("profile") {
                            popUpTo(bottomNavController.graph.startDestinationId) {
                                saveState = true
                            }
                            launchSingleTop = true
                            restoreState = true
                        }
                    }
                )
            }
        }
    ) { innerPadding ->
        NavHost(
            navController = bottomNavController,
            startDestination = "home",
            modifier = Modifier.padding(innerPadding)
        ) {
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

    // Monitor logout from AuthViewModel and navigate back to login
    val authViewModel: com.bastiboys.music.viewmodel.AuthViewModel = androidx.hilt.navigation.compose.hiltViewModel()
    val isLoggedIn by authViewModel.isLoggedIn

    LaunchedEffect(isLoggedIn) {
        if (!isLoggedIn) {
            navController.navigate("login") {
                popUpTo("main") { inclusive = true }
            }
        }
    }
}