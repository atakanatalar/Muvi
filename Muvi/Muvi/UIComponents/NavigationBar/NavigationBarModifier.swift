//
//  NavigationBarModifier.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    let showLogo: Bool
    let title: String?
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if showLogo {
                        LogoView(frameHeight: 35)
                    } else if let title = title {
                        Text(title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.surfaceWhite)
                    }
                }
            }
            .toolbarBackground(.surfaceDark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}
