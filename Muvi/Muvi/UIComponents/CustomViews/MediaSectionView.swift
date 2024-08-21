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
    let isRanked: Bool
    
    let verticalPadding: CGFloat = 20
    let horizontalPadding: CGFloat = 20
    let vStackSpacing: CGFloat = 12
    let hStackSpacing: CGFloat = 10
    let gridItems = [GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading, spacing: vStackSpacing) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.horizontal, horizontalPadding)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItems, spacing: 10) {
                    let itemToDisplay = isRanked ? Array(medias.prefix(10)) : medias
                    ForEach(Array(itemToDisplay.enumerated()), id: \.element.id) { index, media in
                        MediaCell(media: media, topTenRanking: isRanked ? index + 1 : nil)
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
            ], 
            isRanked: false
        )
    }
}
