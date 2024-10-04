//
//  ForgetPasswordView.swift
//  Muvi
//
//  Created by Atakan Atalar on 20.09.2024.
//

import SwiftUI

struct ForgetPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ForgotPasswordViewModel()
    
    var body: some View {
        ZStack {
            Color.surfaceDark.ignoresSafeArea()
            
            VStack(spacing: 32) {
                LogoView(frameHeight: 35)
                DescriptionView(text: "Enter your email to reset your password.")
                CustomTextField(placeholder: "Email Address", icon: "icon_mail", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                
                Button {
                    Task {
                        do {
                            try await viewModel.resetPassword()
                            if viewModel.errorMessage == nil {
                                presentationMode.wrappedValue.dismiss()
                                Toast.shared.present(
                                    title: "Password reset link has been sent!",
                                    symbol: "checkmark.circle",
                                    tint: Color(.systemGreen)
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
                    Text("Send Reset Link")
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                }
                .primaryButtonStyle(backgroundColor: .brandPrimary, foregroundColor: .surfaceDark)
                
                Spacer()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
        }
        .navigationTitle("Forget Password")
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
    ForgetPasswordView()
}
