//
//  LogoView.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct LogoView: View {
    var frameHeight: CGFloat
    
    var body: some View {
        Image(.logoWhite)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: frameHeight)
    }
}

#Preview {
    LogoView(frameHeight: 50)
}
