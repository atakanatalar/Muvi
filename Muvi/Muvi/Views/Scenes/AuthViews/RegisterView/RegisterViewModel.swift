//
//  RegisterViewModel.swift
//  Muvi
//
//  Created by Atakan Atalar on 18.09.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String?
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            DispatchQueue.main.async { self.errorMessage = "Please fill in all fields" }
            return
        }
        
        guard password == confirmPassword else {
            DispatchQueue.main.async { self.errorMessage = "Passwords do not match" }
            return
        }
        
        let authResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        
        let userId = authResult.uid
        
        let userData: [String: Any] = [
            "id": userId,
            "name": "",
            "username": "",
            "birthday": Timestamp(date: Date()),
            "createdAt": Timestamp(date: Date()),
            "profileImageUrl": "",
            "myList": []
        ]
        
        let db = Firestore.firestore()
        try await db.collection("users").document(userId).setData(userData)
    }
}
