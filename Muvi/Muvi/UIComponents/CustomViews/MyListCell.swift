//
//  MyListCell.swift
//  Muvi
//
//  Created by Atakan Atalar on 26.08.2024.
//

import SwiftUI

struct MyListCell: View {
    let media: Result
    
    let width: CGFloat = 160
    let height: CGFloat = 90
    let cornerRadius: CGFloat = 8
    let paddingIconHd: CGFloat = 4
    
    var body: some View {
        HStack(alignment: .center) {
            ZStack(alignment: .bottomLeading) {
                ImageView(
                    imagePath: media.backdropPath ?? "",
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
            
            VStack(alignment: .leading) {
                Text(media.name ?? media.title ?? "")
                    .font(.headline)
                    .foregroundStyle(.surfaceWhite)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.surfaceDark.ignoresSafeArea()
        MyListCell(media: Result.mockResult)
    }
}
