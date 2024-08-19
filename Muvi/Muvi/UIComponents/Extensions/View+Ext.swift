//
//  View+Ext.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

//MARK: Text
extension View {
    func headline1TextStyle() -> some View {
        self.modifier(Headline1TextModifier())
    }
    
    func headline2TextStyle() -> some View {
        self.modifier(Headline2TextModifier())
    }
}

//MARK: Button
extension View {
    func primaryButtonStyle(backgroundColor: Color, foregroundColor: Color) -> some View {
        self.modifier(PrimaryButtonModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor))
    }
}
