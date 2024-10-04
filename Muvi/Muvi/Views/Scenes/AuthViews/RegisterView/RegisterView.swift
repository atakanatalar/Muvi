//
//  RegisterView.swift
//  Muvi
//
//  Created by Atakan Atalar on 17.09.2024.
//

import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = RegisterViewModel()
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        ZStack {
            Color.surfaceDark.ignoresSafeArea()
            
            VStack(spacing: 32) {
                LogoView(frameHeight: 35)
                DescriptionView(text: "Sign up to discover all our movies and enjoy our features")
                
                VStack(spacing: 24) {
                    CustomTextField(placeholder: "Email Address", icon: "icon_mail", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                    CustomSecureField(placeholder: "Password", icon: "icon_lock", text: $viewModel.password)
                    CustomSecureField(placeholder: "Confirm Password", icon: "icon_lock", text: $viewModel.confirmPassword)
                }
                
                VStack(spacing: 16) {
                    Button {
                        Task {
                            do {
                                try await viewModel.signUp()
                                if viewModel.errorMessage == nil {
                                    isLoggedIn = true
                                    Toast.shared.present(
                                        title: "🎉 Welcome!",
                                        symbol: "",
                                        tint: .lowEmphasis
                                    )
                                }
                            } catch {
                                Toast.shared.present(
                                    title: error.localizedDescription,
                                    symbol: "exclamationmark.triangle",
                                    tint: Color(.systemRed)
                                )
                            }
                        }
                    } label: {
                        Text("Sing Up")
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                    }
                    .primaryButtonStyle(backgroundColor: .brandPrimary, foregroundColor: .surfaceDark)
                }
                
                HStack {
                    Text("Already have an account?")
                        .font(.subheadline)
                        .foregroundStyle(.surfaceWhite)
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Sign In")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
                
                Spacer()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
        }
        .navigationTitle("Register")
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
    RegisterView(isLoggedIn: .constant(false))
}
