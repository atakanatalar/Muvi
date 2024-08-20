//
//  HeroCell.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct HeroCell: View {
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.width * 9 / 16
    let vStackSpacing: CGFloat = 8
    let padding: CGFloat = 12
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(.backdrop)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
            
            LinearGradient(
                gradient: Gradient(colors: [Color.clear, Color.surfaceDark.opacity(1.0)]),
                startPoint: .center,
                endPoint: .bottom
            )
            
            VStack(alignment: .leading, spacing: vStackSpacing) {
                Text("Movie Title")
                    .font(.headline)
                    .foregroundStyle(.surfaceWhite)
                    .textCase(.uppercase)
                
                HStack {
                    Image(.iconHd)
                    
                    Text("2024")
                        .font(.subheadline)
                        .foregroundStyle(.surfaceWhite)
                    
                }
            }
            .padding([.leading, .bottom], padding)
        }
    }
}

#Preview {
    HeroCell()
}
