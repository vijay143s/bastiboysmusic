package com.bastiboys.music.ui

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import com.bastiboys.music.ui.auth.AuthScreen
import com.bastiboys.music.ui.auth.AuthViewModel
import com.bastiboys.music.ui.home.HomeScreen
import com.bastiboys.music.ui.search.SearchScreen
import com.bastiboys.music.ui.library.LibraryScreen
import com.bastiboys.music.ui.profile.ProfileScreen
import com.bastiboys.music.ui.player.MiniPlayerView
import com.bastiboys.music.ui.player.PlayerScreen
import com.bastiboys.music.ui.theme.BastiBoysMusicTheme

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BastiBoysMusicApp() {
    val authViewModel: AuthViewModel = hiltViewModel()
    val navController = rememberNavController()
    val isAuthenticated by authViewModel.isAuthenticated.collectAsState()
    
    LaunchedEffect(Unit) {
        authViewModel.checkAuthenticationStatus()
    }
    
    BastiBoysMusicTheme {
        if (isAuthenticated) {
            MainContent(navController = navController)
        } else {
            AuthScreen(
                onNavigateToHome = {
                    // Authentication successful, will automatically navigate due to isAuthenticated change
                }
            )
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MainContent(navController: NavHostController) {
    val currentBackStack by navController.currentBackStackEntryAsState()
    val currentDestination = currentBackStack?.destination
    val currentScreen = bottomNavItems.find { it.route == currentDestination?.route }
    
    Scaffold(
        bottomBar = {
            if (currentScreen != null) {
                Column {
                    MiniPlayerView()
                    BottomNavigation(
                        navController = navController,
                        currentRoute = currentDestination?.route
                    )
                }
            }
        }
    ) { paddingValues ->
        NavHost(
            navController = navController,
            startDestination = NavigationItem.Home.route,
            modifier = Modifier.padding(paddingValues)
        ) {
            composable(NavigationItem.Home.route) {
                HomeScreen()
            }
            composable(NavigationItem.Search.route) {
                SearchScreen()
            }
            composable(NavigationItem.Library.route) {
                LibraryScreen()
            }
            composable(NavigationItem.Profile.route) {
                ProfileScreen()
            }
            composable("player") {
                PlayerScreen(
                    onNavigateBack = {
                        navController.popBackStack()
                    }
                )
            }
        }
    }
}

@Composable
fun BottomNavigation(
    navController: NavHostController,
    currentRoute: String?
) {
    NavigationBar {
        bottomNavItems.forEach { item ->
            NavigationBarItem(
                icon = {
                    Icon(
                        imageVector = if (currentRoute == item.route) item.selectedIcon else item.unselectedIcon,
                        contentDescription = item.title
                    )
                },
                label = { Text(item.title) },
                selected = currentRoute == item.route,
                onClick = {
                    if (currentRoute != item.route) {
                        navController.navigate(item.route) {
                            popUpTo(NavigationItem.Home.route) {
                                saveState = true
                            }
                            launchSingleTop = true
                            restoreState = true
                        }
                    }
                }
            )
        }
    }
}