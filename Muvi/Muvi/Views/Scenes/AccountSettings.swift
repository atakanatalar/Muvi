//
//  AccountSettings.swift
//  Muvi
//
//  Created by Atakan Atalar on 28.09.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct AccountSettings: View {
    @Binding var isShowingLoginView: Bool
    @Binding var email: String
    @State private var isShowingUpdateEmail = false
    @State private var isShowingUpdatePassword = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.surfaceDark.ignoresSafeArea()
            
            VStack(spacing: 32) {
                VStack(spacing: 20) {
                    Button(action: {
                        isShowingUpdateEmail = true
                    }) {
                        HStack {
                            Text("Update Email")
                                .foregroundStyle(.highEmphasis)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.forward")
                                .foregroundStyle(.brandPrimary)
                        }
                    }
                    
                    Button(action: {
                        isShowingUpdatePassword = true
                    }) {
                        HStack {
                            Text("Update Password")
                                .foregroundStyle(.highEmphasis)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.forward")
                                .foregroundStyle(.brandPrimary)
                        }
                    }
                }
                
                Button {
                    Task {
                        do {
                            if let userId = Auth.auth().currentUser?.uid {
                                let db = Firestore.firestore()
                                try await db.collection("users").document(userId).delete()
                            }
                            
                            try await AuthenticationManager.shared.delete()
                            
                            Toast.shared.present(
                                title: "Account deleted",
                                symbol: "checkmark.circle",
                                tint: Color(.systemGreen)
                            )
                            
                            isShowingLoginView = true
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    Text("Delete Account")
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                }
                .primaryButtonStyle(backgroundColor: .lowEmphasis, foregroundColor: .brandSecondary)
            }
            .padding(.top, 16)
            .padding(.horizontal, 20)
        }
        .navigationBar(inlineTitle: "Account Settings")
        .navigationDestination(isPresented: $isShowingUpdateEmail) {
            UpdateEmailView(email: $email)
        }
        .navigationDestination(isPresented: $isShowingUpdatePassword) {
            UpdatePasswordView()
        }
    }
}

#Preview {
    AccountSettings(isShowingLoginView: .constant(false), email: .constant("mail@mail.com"))
}

struct UpdateEmailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var email: String
    @State private var newEmail: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.surfaceDark.ignoresSafeArea()
                
                VStack() {
                    CustomTextFieldWithTitle(title: "Email", icon: "icon_mail", text: $newEmail)
                        .keyboardType(.emailAddress)
                    Spacer()
                }
                .padding(.top, 16)
                .padding(.horizontal, 20)
            }
            .navigationBar(inlineTitle: "Update Email")
            .navigationBarItems(trailing: Button("Save") {
                email = newEmail
                Task {
                    do {
                        try await AuthenticationManager.shared.updateEmail(email: email)
                        Toast.shared.present(
                            title: "Email has been updated",
                            symbol: "checkmark.circle",
                            tint: Color(.systemGreen)
                        )
                    } catch {
                        Toast.shared.present(
                            title: error.localizedDescription,
                            symbol: "exclamationmark.triangle",
                            tint: Color(.systemRed)
                        )
                    }
                }
                presentationMode.wrappedValue.dismiss()
            }.foregroundColor(.brandPrimary))
            .onAppear {
                newEmail = email
            }
        }
    }
}

struct UpdatePasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var newPassword: String = ""
    @State private var confirmNewPassword: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.surfaceDark.ignoresSafeArea()
                
                VStack(spacing: 16) {
                    CustomSecureFieldWithTitle(title: "New Password", icon: "icon_lock", text: $newPassword)
                    CustomSecureField(placeholder: "Confirm Password", icon: "icon_lock", text: $confirmNewPassword)
                    Spacer()
                }
                .padding(.top, 16)
                .padding(.horizontal, 20)
            }
            .navigationBar(inlineTitle: "Update Password")
            .navigationBarItems(trailing: Button("Save") {
                if newPassword == confirmNewPassword {
                    Task {
                        do {
                            try await AuthenticationManager.shared.updatePassword(password: newPassword)
                            Toast.shared.present(
                                title: "Password has been updated",
                                symbol: "checkmark.circle",
                                tint: Color(.systemGreen)
                            )
                        } catch {
                            Toast.shared.present(
                                title: error.localizedDescription,
                                symbol: "exclamationmark.triangle",
                                tint: Color(.systemRed)
                            )
                        }
                    }
                } else {
                    print("Not matched")
                    Toast.shared.present(
                        title: "Passwords do not match",
                        symbol: "exclamationmark.triangle",
                        tint: Color(.mediumEmphasis)
                    )
                }
                presentationMode.wrappedValue.dismiss()
            }.foregroundColor(.brandPrimary))
        }
    }
}
