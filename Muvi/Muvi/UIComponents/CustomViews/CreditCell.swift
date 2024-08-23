//
//  CreditCell.swift
//  Muvi
//
//  Created by Atakan Atalar on 22.08.2024.
//

import SwiftUI

struct CreditCell: View {
    let credit: Cast?
    
    let imageWidth: CGFloat = 100
    let imageHeight: CGFloat = 150
    let cardWidth: CGFloat = 100
    let cardHeight: CGFloat = 240
    let textWidth: CGFloat = 96
    let cornerRadius: CGFloat = 8
    
    var body: some View {
        VStack(spacing: 8) {
            ImageView(
                imagePath: credit?.profilePath ?? "",
                aspectRatio: .fit,
                width: imageWidth,
                height: imageHeight
            )
            
            VStack(spacing: 4) {
                Text(credit?.name ?? "")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.highEmphasis)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                Text(credit?.character ?? credit?.job ?? "")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.mediumEmphasis)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                Spacer()
            }
            .frame(width: textWidth)
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(.lowEmphasis)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

#Preview {
    ZStack {
        Color.surfaceDark.ignoresSafeArea()
        CreditCell(
            credit: Cast(
                adult: true,
                gender: 0,
                id: 0,
                knownForDepartment: "",
                name: "Name",
                originalName: "",
                popularity: 0.0,
                profilePath: "",
                castID: 0,
                character: "Character",
                creditID: "",
                order: 0,
                department: "",
                job: ""
            )
        )
    }
}
