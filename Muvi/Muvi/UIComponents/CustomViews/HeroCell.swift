//
//  HeroCell.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct HeroCell: View {
    var media: Result
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.width * 9 / 16
    let vStackSpacing: CGFloat = 8
    let padding: CGFloat = 12
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ImageView(
                imagePath: media.backdropPath ?? "",
                aspectRatio: .fit,
                width: width,
                height: height
            )
            
            LinearGradient(
                gradient: Gradient(colors: [Color.clear, Color.surfaceDark.opacity(1.0)]),
                startPoint: .center,
                endPoint: .bottom
            )
            
            VStack(alignment: .leading, spacing: vStackSpacing) {
                Text(media.title ?? media.name ?? "")
                    .font(.headline)
                    .foregroundStyle(.surfaceWhite)
                    .textCase(.uppercase)
                
                HStack {
                    if media.isHd { Image(.iconHd) }
                    
                    Text(media.releaseDate?.prefix(4) ?? media.firstAirDate?.prefix(4) ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.surfaceWhite)
                    
                }
            }
            .padding([.leading, .bottom], padding)
        }
    }
}

#Preview {
    HeroCell(media: Result.mockResult)
}
