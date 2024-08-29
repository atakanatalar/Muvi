//
//  View+Ext.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

extension View {
    //MARK: Text
    func headline1TextStyle() -> some View {
        self.modifier(Headline1TextModifier())
    }
    
    func headline2TextStyle() -> some View {
        self.modifier(Headline2TextModifier())
    }
    
    //MARK: Button
    func primaryButtonStyle(backgroundColor: Color, foregroundColor: Color) -> some View {
        self.modifier(PrimaryButtonModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor))
    }
    
    //MARK: NavigationBar
    func navigationBar(showLogo: Bool = false, title: String? = nil, inlineTitle: String? = nil) -> some View {
            self.modifier(NavigationBarModifier(showLogo: showLogo, title: title, inlineTitle: inlineTitle))
        }
}
