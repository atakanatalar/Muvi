//
//  MediaSectionView.swift
//  Muvi
//
//  Created by Atakan Atalar on 20.08.2024.
//

import SwiftUI

struct MediaSectionView: View {
    let title: String
    let medias: [Result]
    
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
                    ForEach(medias, id: \.id) { media in
                        MediaCell(media: media)
                    }
                }
            }
        }
        .contentMargins(.horizontal, horizontalPadding, for: .scrollContent)
        .padding(.bottom, verticalPadding)
    }
}

#Preview {
    ZStack {
        Color.surfaceDark.ignoresSafeArea()
        MediaSectionView(
            title: "Section Title",
            medias: [
                Result.mockResult,
                Result.emptyMockResult
            ]
        )
    }
}
