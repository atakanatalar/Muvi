//
//  ForgetPasswordViewModel.swift
//  Muvi
//
//  Created by Atakan Atalar on 20.09.2024.
//

import Foundation
import FirebaseAuth

class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var errorMessage: String?
    
    func resetPassword() async throws {
        guard !email.isEmpty else {
            DispatchQueue.main.async { self.errorMessage = "Please fill in email field." }
            return
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
}
