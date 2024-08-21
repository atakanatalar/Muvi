//
//  MediaCell.swift
//  Muvi
//
//  Created by Atakan Atalar on 20.08.2024.
//

import SwiftUI

struct MediaCell: View {
    let media: Result
    var topTenRanking: Int? = nil
    
    let width: CGFloat = 128
    let height: CGFloat = 192
    let cornerRadius: CGFloat = 8
    let paddingIconHd: CGFloat = 4
    let hStackSpacing: CGFloat = -25
    let rankFontSize: CGFloat = 140
    let rankOffset: CGFloat = 32
    
    var body: some View {
        HStack(alignment: .bottom, spacing: hStackSpacing) {
            if let topTenRanking {
                Text("\(topTenRanking)")
                    .font(.system(size: rankFontSize, weight: .bold, design: .default))
                    .foregroundStyle(.surfaceWhite)
                    .offset(y: rankOffset)
            }
            
            ZStack(alignment: .bottomLeading) {
                ImageView(
                    imagePath: media.posterPath ?? "",
                    aspectRatio: .fit,
                    width: width,
                    height: height,
                    cornerRadius: cornerRadius
                )
                
                if media.isHd {
                    Image(.iconHd)
                        .padding([.leading, .bottom], paddingIconHd)
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.surfaceDark.ignoresSafeArea()
        
        ScrollView(showsIndicators: false) {
            VStack {
                MediaCell(media: Result.mockResult, topTenRanking: 1)
                MediaCell(media: Result.mockResult, topTenRanking: 2)
                MediaCell(media: Result.mockResult, topTenRanking: 3)
                MediaCell(media: Result.mockResult, topTenRanking: 4)
                MediaCell(media: Result.mockResult, topTenRanking: 5)
                MediaCell(media: Result.mockResult, topTenRanking: 6)
                MediaCell(media: Result.mockResult, topTenRanking: 7)
                MediaCell(media: Result.mockResult, topTenRanking: 8)
                MediaCell(media: Result.mockResult, topTenRanking: 9)
                MediaCell(media: Result.mockResult, topTenRanking: 10)
            }
        }
    }
}
