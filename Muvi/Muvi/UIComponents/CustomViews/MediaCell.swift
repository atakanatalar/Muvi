//
//  MediaCell.swift
//  Muvi
//
//  Created by Atakan Atalar on 20.08.2024.
//

import SwiftUI

struct MediaCell: View {
    
    let width: CGFloat = 128
    let height: CGFloat = 192
    let cornerRadius: CGFloat = 8
    let paddingIconHd: CGFloat = 4
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(.poster)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .clipped()
            
            Image(.iconHd)
                .padding([.leading, .bottom], paddingIconHd)
        }
    }
}

#Preview {
    MediaCell()
}
