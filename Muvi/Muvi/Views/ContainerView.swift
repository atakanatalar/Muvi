//
//  ContainerView.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct ContainerView: View {
    @State private var isSplashScreenPresented = true
    
    var body: some View {
        if !isSplashScreenPresented {
            AppTabView()
        } else {
            SplashView(isPresented: $isSplashScreenPresented)
        }
    }
}

#Preview {
    ContainerView()
}
