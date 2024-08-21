//
//  ShimmerView.swift
//  Muvi
//
//  Created by Atakan Atalar on 21.08.2024.
//

import SwiftUI

struct ShimmerView: View {
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat?
    
    var gradientColors = [
        Color.highEmphasis.opacity(0.2),
        Color.highEmphasis.opacity(0.3),
        Color.highEmphasis.opacity(0.2)
    ]
    
    @State private var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
    @State private var endPoint: UnitPoint = .init(x: 0, y: -0.2)
    
    var body: some View {
        LinearGradient(colors: gradientColors, startPoint: startPoint, endPoint: endPoint)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: false)) {
                    startPoint = .init(x: 1.5, y: 1)
                    endPoint = .init(x: 2.2, y: 2.2)
                }
            }
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius ?? 0))
    }
}

#Preview {
    ZStack {
        Color.surfaceDark.ignoresSafeArea()
        ShimmerView(width: 128, height: 192, cornerRadius: 8)
    }
}
