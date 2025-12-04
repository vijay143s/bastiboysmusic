import Foundation
import Combine

class AuthService: ObservableObject {
    static let shared = AuthService()
    
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let tokenKey = "auth_token"
    private let userKey = "current_user"
    
    var authToken: String? {
        get { UserDefaults.standard.string(forKey: tokenKey) }
        set { UserDefaults.standard.set(newValue, forKey: tokenKey) }
    }
    
    private init() {
        checkAuthenticationStatus()
    }
    
    func checkAuthenticationStatus() {
        if let token = authToken, !token.isEmpty {
            loadSavedUser()
            isAuthenticated = true
            // Optionally verify token with server
            Task {
                await refreshUserProfile()
            }
        } else {
            isAuthenticated = false
            currentUser = nil
        }
    }
    
    @MainActor
    func login(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let loginResponse = try await NetworkService.shared.login(email: email, password: password)
            
            // Save token and user data
            authToken = loginResponse.token
            currentUser = loginResponse.user
            saveUser(loginResponse.user)
            
            isAuthenticated = true
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    @MainActor
    func register(name: String, email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let registerResponse = try await NetworkService.shared.register(name: name, email: email, password: password)
            
            // Save token and user data
            authToken = registerResponse.token
            currentUser = registerResponse.user
            saveUser(registerResponse.user)
            
            isAuthenticated = true
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    @MainActor
    func logout() {
        // Clear stored data
        authToken = nil
        UserDefaults.standard.removeObject(forKey: userKey)
        
        // Reset state
        isAuthenticated = false
        currentUser = nil
        errorMessage = nil
    }
    
    @MainActor
    private func refreshUserProfile() async {
        do {
            let user = try await NetworkService.shared.getProfile()
            currentUser = user
            saveUser(user)
        } catch {
            // Token might be invalid, logout user
            logout()
        }
    }
    
    private func saveUser(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
        }
    }
    
    private func loadSavedUser() {
        if let data = UserDefaults.standard.data(forKey: userKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            currentUser = user
        }
    }
    
    func clearError() {
        errorMessage = nil
    }
}