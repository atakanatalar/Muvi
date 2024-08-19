//
//  OnboardView.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct OnboardView: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    @Binding var isShowingOnboardView: Bool
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                
                Text("Enjoy your favourite movie everywhere")
                    .headline1TextStyle()
                
                Text("Browse through our collections and discover hundreds of movies and series that you’ll love!")
                    .headline2TextStyle()
                
                Spacer()
                
                Button {
                    isFirstTime = false
                    isShowingOnboardView = false
                } label: {
                    Text("Get Started")
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                }
                .primaryButtonStyle(backgroundColor: .brandPrimary, foregroundColor: .surfaceDark)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
}

#Preview {
    OnboardView(isShowingOnboardView: .constant(true))
}
