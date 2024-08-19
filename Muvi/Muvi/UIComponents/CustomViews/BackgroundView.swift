//
//  BackgroundView.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        GeometryReader { geo in
            let width: CGFloat = geo.size.width
            let height: CGFloat = geo.size.height
            
            Image(.onboardBackground)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
