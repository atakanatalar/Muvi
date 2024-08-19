//
//  AppTabView.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct AppTabView: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    @State var isShowingOnboardView: Bool = false
    
    var body: some View {
        TabView() {
            //
        }
        .onAppear {
            if isFirstTime {
                DispatchQueue.main.async() { isShowingOnboardView = true }
            }
        }
        .fullScreenCover(isPresented: $isShowingOnboardView) {
            OnboardView(isShowingOnboardView: $isShowingOnboardView)
        }
    }
}

#Preview {
    AppTabView()
}
