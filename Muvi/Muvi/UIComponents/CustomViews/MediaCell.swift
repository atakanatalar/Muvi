//
//  MediaCell.swift
//  Muvi
//
//  Created by Atakan Atalar on 20.08.2024.
//

import SwiftUI

struct MediaCell: View {
    let media: Result
    
    let width: CGFloat = 128
    let height: CGFloat = 192
    let cornerRadius: CGFloat = 8
    let paddingIconHd: CGFloat = 4
    
    var body: some View {
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

#Preview {
    MediaCell(media: Result.emptyMockResult)
}
