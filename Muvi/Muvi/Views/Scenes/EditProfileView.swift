//
//  EditProfileView.swift
//  Muvi
//
//  Created by Atakan Atalar on 28.08.2024.
//

import SwiftUI
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct EditProfileView: View {
    @State private var profileImage: UIImage? = UIImage(named: "default_profile")
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var birthday: Date = Date()
    @State private var isShowingPhotoPicker = false
    @State private var uploadProgress: Double = 0.0
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.surfaceDark.ignoresSafeArea()
            
            VStack(spacing: 32) {
                ProfileImageSection(profileImage: $profileImage, isShowingPhotoPicker: $isShowingPhotoPicker)
                
                VStack(spacing: 12) {
                    CustomTextFieldWithTitle(title: "Name", icon: "icon_user", text: $name)
                    CustomTextFieldWithTitle(title: "Username", icon: "icon_user", text: $username)
                    DatePickerSection(birthday: $birthday, icon: "icon_calendar")
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 20)
        }
        .navigationBar(inlineTitle: "Edit Profile")
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Spacer()
                Button() {
                    saveProfile()
                } label: {
                    Text("Save")
                        .foregroundStyle(.brandPrimary)
                }
            }
        }
        .onAppear(perform: loadProfile)
        .sheet(isPresented: $isShowingPhotoPicker) { PhotoPicker(image: $profileImage) }
    }
    
    private func saveProfile() {
        guard let user = Auth.auth().currentUser else { return }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)
        
        if let profileImage = profileImage {
            uploadProfileImage(profileImage) { imageUrl in
                var profileData: [String: Any] = [
                    "name": name,
                    "username": username,
                    "birthday": Timestamp(date: birthday)
                ]
                if let imageUrl = imageUrl {
                    profileData["profileImageUrl"] = imageUrl
                }
                
                updateFirestore(userRef: userRef, profileData: profileData)
            }
        } else {
            let profileData: [String: Any] = [
                "name": name,
                "username": username,
                "birthday": Timestamp(date: birthday)
            ]
            updateFirestore(userRef: userRef, profileData: profileData)
        }
    }
    
    private func updateFirestore(userRef: DocumentReference, profileData: [String: Any]) {
        userRef.setData(profileData, merge: true) { error in
            if let error = error {
                alertMessage = "Error updating profile: \(error.localizedDescription)"
                Toast.shared.present(
                    title: alertMessage,
                    symbol: "exclamationmark.triangle",
                    tint: Color(.systemRed)
                )
            } else {
                alertMessage = "Profile successfully updated!"
                Toast.shared.present(
                    title: alertMessage,
                    symbol: "checkmark.circle",
                    tint: Color(.systemGreen)
                )
            }
        }
    }
    
    private func uploadProfileImage(_ image: UIImage, completion: @escaping (String?) -> Void) {
        guard let user = Auth.auth().currentUser else { return }
        
        let storageRef = Storage.storage().reference().child("profile_images/\(user.uid).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        let uploadTask = storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Failed to retrieve download URL: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                completion(url?.absoluteString)
            }
        }
        
        uploadTask.observe(.progress) { snapshot in
            self.uploadProgress = Double(snapshot.progress?.fractionCompleted ?? 0.0)
        }
    }
    
    private func loadProfile() {
        guard let user = Auth.auth().currentUser else { return }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)
        
        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data() ?? [:]
                self.name = data["name"] as? String ?? ""
                self.username = data["username"] as? String ?? ""
                
                if let timestamp = data["birthday"] as? Timestamp {
                    self.birthday = timestamp.dateValue()
                }
                
                if let imageUrl = data["profileImageUrl"] as? String {
                    loadImage(from: imageUrl) { image in
                        self.profileImage = image
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    private func loadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = URL(string: url) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

#Preview {
    EditProfileView()
}

struct ProfileImageSection: View {
    @Binding var profileImage: UIImage?
    @Binding var isShowingPhotoPicker: Bool
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if let profileImage = profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .clipShape(Circle())
            }
            
            Image(.iconEdit)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
                .padding(8)
                .background(
                    Circle()
                        .fill(Color.surfaceDark)
                )
        }
        .onTapGesture { isShowingPhotoPicker = true }
    }
}

//MARK: CustomTextFieldWithTitle
struct CustomTextFieldWithTitle: View {
    let title: String
    let icon: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.mediumEmphasis)
            
            CustomTextField(placeholder: title, icon: icon, text: $text)
        }
    }
}

//MARK: CustomSecureFieldWithTitle
struct CustomSecureFieldWithTitle: View {
    let title: String
    let icon: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.mediumEmphasis)
            
            CustomSecureField(placeholder: title, icon: icon, text: $text)
        }
    }
}

struct DatePickerSection: View {
    @Binding var birthday: Date
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Birthday")
                .font(.caption)
                .foregroundColor(.mediumEmphasis)
            
            HStack {
                DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .foregroundColor(.highEmphasis)
                    .font(.headline)
                
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18)
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.lowEmphasis)
        }
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage { photoPicker.image = image }
            picker.dismiss(animated: true)
        }
    }
}
