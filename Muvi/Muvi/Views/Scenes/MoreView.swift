//
//  MoreView.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct MoreView: View {
    @Binding var isShowingLoginView: Bool
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var profileImage: UIImage? = UIImage(named: "default_profile")
    @State private var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            Color.surfaceDark.ignoresSafeArea()
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 32) {
                    ProfileSectionView(name: $name, email: $email, profileImage: $profileImage, isLoading: $isLoading)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        SectionTitleView(title: "General Settings")
                        
                        VStack(alignment: .leading, spacing: 20) {
                            NavigationLink(destination: AccountSettings(isShowingLoginView: $isShowingLoginView, email: $email)) {
                                SectionItemView(imageTitle: "icon_user", title: "Account Settings")
                            }
                            SectionItemView(imageTitle: "icon_settings", title: "App Settings")
                            NavigationLink(destination: HelpFAQView()) {
                                SectionItemView(imageTitle: "icon_message", title: "Help, FAQ")
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        SectionTitleView(title: "Terms")
                        
                        VStack(alignment: .leading, spacing: 20) {
                            NavigationLink(destination: TermsOfServicesView()) {
                                SectionItemView(imageTitle: "icon_info", title: "Terms of Services")
                            }
                            NavigationLink(destination: PrivacyPolicyView()) {
                                SectionItemView(imageTitle: "icon_shield", title: "Privacy & Policy")
                            }
                        }
                    }
                    
                    Button {
                        do {
                            try AuthenticationManager.shared.signOut()
                            isShowingLoginView = true
                        } catch {
                            print(error)
                        }
                    } label: {
                        Text("Logout")
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                    }
                    .primaryButtonStyle(backgroundColor: .lowEmphasis, foregroundColor: .brandSecondary)
                }
                .padding(.vertical, 16)
            }
            .padding(.horizontal, 20)
        }
        .navigationBar(title: "More")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: InboxView()) {
                    Image(.iconInbox)
                }
            }
        }
        .onAppear {
            loadUserData()
        }
    }
    
    private func loadUserData() {
        if let user = Auth.auth().currentUser {
            self.email = user.email ?? "No Email"
            
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(user.uid)
            
            userRef.getDocument { document, error in
                if let document = document, document.exists {
                    let data = document.data()
                    self.name = data?["name"] as? String ?? "No Name"
                    
                    if let profileImageUrl = data?["profileImageUrl"] as? String {
                        loadImage(from: profileImageUrl) { image in
                            self.profileImage = image
                            self.isLoading = false
                        }
                    } else {
                        self.isLoading = false
                    }
                } else {
                    print("Document does not exist")
                    self.isLoading = false
                }
            }
        } else {
            self.isLoading = false
        }
    }
    
    private func loadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}

#Preview {
    MoreView(isShowingLoginView: .constant(false))
}

struct ProfileSectionView: View {
    @Binding var name: String
    @Binding var email: String
    @Binding var profileImage: UIImage?
    @Binding var isLoading: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Group {
                if let profileImage = profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60)
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                        .foregroundStyle(.surfaceWhite)
                    
                    Text(email)
                        .font(.subheadline)
                        .foregroundStyle(.highEmphasis)
                }
            }
            .redacted(reason: isLoading ? .placeholder : [])
            
            Spacer()
            
            NavigationLink(destination: EditProfileView()) {
                Image(.iconEdit)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
            }
        }
    }
}

struct SectionTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundStyle(.mediumEmphasis)
    }
}

struct SectionItemView: View {
    let imageTitle: String
    let title: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(imageTitle)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 22)
            Text(title)
                .foregroundStyle(.highEmphasis)
        }
    }
}
