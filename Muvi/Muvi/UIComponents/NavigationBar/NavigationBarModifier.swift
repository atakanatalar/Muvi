//
//  NavigationBarModifier.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    LogoView(frameHeight: 35)
                }
            }
            .toolbarBackground(.surfaceDark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}
