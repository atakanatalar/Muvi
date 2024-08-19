//
//  SplashView.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct SplashView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.surfaceDark
                .ignoresSafeArea()
            
            LogoView(frameHeight: 50)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                withAnimation(.easeIn(duration: 0.2)) {
                    isPresented.toggle()
                }
            })
        }
    }
}

#Preview {
    SplashView(isPresented: .constant(true))
}
