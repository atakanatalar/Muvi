//
//  MoreView.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct MoreView: View {
    var body: some View {
        ZStack {
            Color.surfaceDark.ignoresSafeArea()
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 32) {
                    ProfileSectionView()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        SectionTitleView(title: "General Settings")
                        
                        VStack(alignment: .leading, spacing: 20) {
                            SectionItemView(imageTitle: "icon_user", title: "Account Settings")
                            SectionItemView(imageTitle: "icon_settings", title: "App Settings")
                            SectionItemView(imageTitle: "icon_message", title: "Help, FAQ")
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        SectionTitleView(title: "Terms")
                        
                        VStack(alignment: .leading, spacing: 20) {
                            SectionItemView(imageTitle: "icon_info", title: "Terms & Condition")
                            SectionItemView(imageTitle: "icon_lock", title: "Privacy & Policy")
                        }
                    }
                    
                    Button {
                        
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
                Button {
                    // Action for the button
                } label: {
                    Image(.iconInbox)
                }
            }
        }
    }
}

#Preview {
    MoreView()
}

struct ProfileSectionView: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(.profile)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60)
                .foregroundStyle(.surfaceWhite)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Atakan Atalar")
                    .font(.headline)
                    .foregroundStyle(.surfaceWhite)
                
                Text("atakanatalar")
                    .font(.subheadline)
                    .foregroundStyle(.highEmphasis)
            }
            
            Spacer()
            
            Button {
                
            } label: {
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
