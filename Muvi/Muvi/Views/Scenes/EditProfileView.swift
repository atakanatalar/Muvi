//
//  EditProfileView.swift
//  Muvi
//
//  Created by Atakan Atalar on 28.08.2024.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @State private var profileImage: UIImage? = UIImage(named: "profile")
    @State private var name: String = "Atakan Atalar"
    @State private var username: String = "atakanatalar"
    @State private var email: String = "atakanatalar@mail.com"
    @State private var birthday: Date = Date()
    @State private var isShowingPhotoPicker = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.surfaceDark.ignoresSafeArea()
            
            VStack(spacing: 32) {
                ProfileImageSection(profileImage: $profileImage, isShowingPhotoPicker: $isShowingPhotoPicker)
                
                VStack(spacing: 12) {
                    FormSection(title: "Name", text: $name, icon: "icon_user")
                    FormSection(title: "Username", text: $username, icon: "icon_user")
                    FormSection(title: "Email", text: $email, icon: "icon_mail")
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
                    //
                } label: {
                    Text("Save")
                        .foregroundStyle(.brandPrimary)
                }
            }
        }
        .sheet(isPresented: $isShowingPhotoPicker) { ImagePicker(image: $profileImage) }
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
                Image(.profile)
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

struct FormSection: View {
    let title: String
    @Binding var text: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.mediumEmphasis)
            
            HStack {
                TextField("", text: $text, prompt: Text(title).foregroundStyle(.mediumEmphasis))
                    .font(.headline)
                    .foregroundStyle(.highEmphasis)
                    .autocorrectionDisabled()
                
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24)
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.lowEmphasis)
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
                    .frame(width: 24)
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.lowEmphasis)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}
