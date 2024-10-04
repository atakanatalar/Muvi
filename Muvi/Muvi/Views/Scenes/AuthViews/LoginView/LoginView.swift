//
//  LoginView.swift
//  Muvi
//
//  Created by Atakan Atalar on 17.09.2024.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        ZStack {
            Color.surfaceDark.ignoresSafeArea()
            
            VStack(spacing: 32) {
                LogoView(frameHeight: 35)
                DescriptionView(text: "Please Login to enjoy more benefits and we won’t let You go")
                
                VStack(spacing: 24) {
                    CustomTextField(placeholder: "Email Address", icon: "icon_mail", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                    CustomSecureField(placeholder: "Password", icon: "icon_lock", text: $viewModel.password)
                    
                    HStack {
                        Spacer()
                        NavigationLink("Forget Password") {
                            ForgetPasswordView()
                        }
                    }
                }
                
                VStack(spacing: 16) {
                    Button {
                        Task {
                            do {
                                try await viewModel.signIn()
                                if (viewModel.errorMessage == nil) { isLoggedIn = true }
                            } catch {
                                Toast.shared.present(
                                    title: error.localizedDescription,
                                    symbol: "exclamationmark.triangle",
                                    tint: Color(.systemRed)
                                )
                            }
                        }
                    } label: {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                    }
                    .primaryButtonStyle(backgroundColor: .brandPrimary, foregroundColor: .surfaceDark)
                }
                
                HStack {
                    Text("Don’t have an account?")
                        .font(.subheadline)
                        .foregroundStyle(.surfaceWhite)
                    
                    NavigationLink {
                        RegisterView(isLoggedIn: $isLoggedIn)
                    } label: {
                        Text("Sign Up")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
                
                Spacer()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
        }
        .navigationTitle("Login")
        .fullScreenCover(isPresented: $isLoggedIn) {
            AppTabView()
        }
        .onChange(of: viewModel.errorMessage) { errorMessage in
            if let errorMessage = errorMessage {
                Toast.shared.present(
                    title: errorMessage,
                    symbol: "exclamationmark.triangle",
                    tint: Color(.mediumEmphasis)
                )
            }
            
            DispatchQueue.main.async { viewModel.errorMessage = nil }
        }
    }
}

#Preview {
    LoginView()
}

// MARK: - Description
struct DescriptionView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.body)
            .foregroundStyle(.surfaceWhite)
            .multilineTextAlignment(.center)
    }
}

// MARK: - CustomTextField
struct CustomTextField: View {
    var placeholder: String
    var icon: String
    @Binding var text: String
    @FocusState var isEmailFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                TextField(
                    placeholder,
                    text: $text
                )
                .focused($isEmailFocused)
                .font(.headline)
                .foregroundStyle(.highEmphasis)
                .autocorrectionDisabled()
                
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
            }
            
            Divider()
                .background(isEmailFocused ? .brandPrimary : .lowEmphasis)
        }
    }
}

// MARK: - CustomSecureField
struct CustomSecureField: View {
    var placeholder: String
    var icon: String
    @Binding var text: String
    @FocusState private var isPasswordFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                SecureField(
                    placeholder,
                    text: $text
                )
                .focused($isPasswordFocused)
                .font(.headline)
                .foregroundStyle(.highEmphasis)
                .autocorrectionDisabled()
                
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
            }
            
            Divider()
                .background(isPasswordFocused ? .brandPrimary : .lowEmphasis)
        }
    }
}
