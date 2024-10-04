//
//  LoginViewModel.swift
//  Muvi
//
//  Created by Atakan Atalar on 18.09.2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            DispatchQueue.main.async { self.errorMessage = "Please fill in all fields." }
            return
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
