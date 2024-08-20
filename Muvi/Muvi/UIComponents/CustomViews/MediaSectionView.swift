//
//  MediaSectionView.swift
//  Muvi
//
//  Created by Atakan Atalar on 20.08.2024.
//

import SwiftUI

struct MediaSectionView: View {
    let title: String
    
    let verticalPadding: CGFloat = 20
    let horizontalPadding: CGFloat = 20
    let vStackSpacing: CGFloat = 12
    let hStackSpacing: CGFloat = 10
    let gridItems = [GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading, spacing: vStackSpacing) {
            Text(title)
                .foregroundStyle(.white)
                .font(.headline)
                .padding(.horizontal, horizontalPadding)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItems, spacing: 10) {
                    ForEach(0..<20) { _ in
                        MediaCell()
                    }
                }
            }
        }
        .contentMargins(.horizontal, horizontalPadding, for: .scrollContent)
        .padding(.bottom, verticalPadding)
    }
}

#Preview {
    MediaSectionView(title: "Section Title")
}
