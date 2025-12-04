import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authService: AuthService
    @State private var showingLogoutAlert = false
    
    var body: some View {
        NavigationView {
            List {
                // User Profile Section
                Section {
                    if let user = authService.currentUser {
                        UserProfileHeader(user: user)
                    }
                }
                
                // Settings Section
                Section("Settings") {
                    SettingsRow(
                        title: "Notifications",
                        icon: "bell",
                        color: .orange
                    ) {
                        // Navigate to notifications settings
                    }
                    
                    SettingsRow(
                        title: "Audio Quality",
                        icon: "speaker.wave.2",
                        color: .blue
                    ) {
                        // Navigate to audio quality settings
                    }
                    
                    SettingsRow(
                        title: "Download Settings",
                        icon: "arrow.down.circle",
                        color: .green
                    ) {
                        // Navigate to download settings
                    }
                    
                    SettingsRow(
                        title: "Privacy",
                        icon: "lock.shield",
                        color: .gray
                    ) {
                        // Navigate to privacy settings
                    }
                }
                
                // About Section
                Section("About") {
                    SettingsRow(
                        title: "Help & Support",
                        icon: "questionmark.circle",
                        color: .blue
                    ) {
                        // Navigate to help
                    }
                    
                    SettingsRow(
                        title: "Terms of Service",
                        icon: "doc.text",
                        color: .gray
                    ) {
                        // Show terms of service
                    }
                    
                    SettingsRow(
                        title: "Privacy Policy",
                        icon: "hand.raised",
                        color: .gray
                    ) {
                        // Show privacy policy
                    }
                    
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                }
                
                // Account Actions
                Section {
                    Button(action: {
                        showingLogoutAlert = true
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.red)
                            Text("Logout")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
        }
        .alert("Logout", isPresented: $showingLogoutAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Logout", role: .destructive) {
                authService.logout()
            }
        } message: {
            Text("Are you sure you want to logout?")
        }
    }
}

// MARK: - Supporting Views
struct UserProfileHeader: View {
    let user: User
    
    var body: some View {
        VStack(spacing: 16) {
            // Profile Picture Placeholder
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 80, height: 80)
                .overlay(
                    Text(String(user.name.prefix(1)))
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                )
            
            VStack(spacing: 4) {
                Text(user.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if user.role == "admin" {
                    Text("Admin")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
    }
}

struct SettingsRow: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title3)
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthService.shared)
}