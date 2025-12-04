import SwiftUI

struct AuthView: View {
    @State private var isLoginMode = true
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    // App Logo/Header
                    VStack(spacing: 16) {
                        Image(systemName: "music.note")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        Text("BastiBoys Music")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text(isLoginMode ? "Welcome back!" : "Join the music community")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 40)
                    
                    // Auth Form
                    VStack(spacing: 20) {
                        if !isLoginMode {
                            TextField("Full Name", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.words)
                        }
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        if !isLoginMode {
                            SecureField("Confirm Password", text: $confirmPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        // Error Message
                        if let errorMessage = authService.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        
                        // Submit Button
                        Button(action: handleSubmit) {
                            if authService.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            } else {
                                Text(isLoginMode ? "Login" : "Register")
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(isFormValid ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(!isFormValid || authService.isLoading)
                        
                        // Toggle Auth Mode
                        Button(action: {
                            isLoginMode.toggle()
                            clearForm()
                        }) {
                            Text(isLoginMode ? "Don't have an account? Sign Up" : "Already have an account? Login")
                                .font(.footnote)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onChange(of: authService.errorMessage) { _ in
            // Clear error after 5 seconds
            if authService.errorMessage != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    authService.clearError()
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        let emailValid = !email.isEmpty && email.contains("@")
        let passwordValid = !password.isEmpty && password.count >= 6
        
        if isLoginMode {
            return emailValid && passwordValid
        } else {
            let nameValid = !name.isEmpty && name.count >= 2
            let passwordsMatch = password == confirmPassword
            return nameValid && emailValid && passwordValid && passwordsMatch
        }
    }
    
    private func handleSubmit() {
        hideKeyboard()
        
        Task {
            if isLoginMode {
                await authService.login(email: email, password: password)
            } else {
                await authService.register(name: name, email: email, password: password)
            }
        }
    }
    
    private func clearForm() {
        name = ""
        email = ""
        password = ""
        confirmPassword = ""
        authService.clearError()
    }
}

#Preview {
    AuthView()
        .environmentObject(AuthService.shared)
        .preferredColorScheme(.dark)
}