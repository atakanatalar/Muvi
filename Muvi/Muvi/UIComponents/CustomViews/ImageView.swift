//
//  ImageView.swift
//  Muvi
//
//  Created by Atakan Atalar on 21.08.2024.
//

import SwiftUI

struct ImageView: View {
    let baseUrl = "https://image.tmdb.org/t/p/w500"
    let imagePath: String
    
    var aspectRatio: ContentMode
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat?
    var blur: CGFloat?
    var overlayCornerRadius: CGFloat?
    var overlayLineWidth: CGFloat?
    
    var body: some View {
        if let url = URL(string: "\(baseUrl)\(imagePath)") {
            AsyncImage(url: url) { image in
                ZStack(alignment: .bottomLeading) {
                    image.resizable()
                        .resizable()
                        .aspectRatio(contentMode: aspectRatio)
                        .frame(width: width, height: height)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius ?? 0))
                        .blur(radius: blur ?? 0)
                        .overlay(
                            RoundedRectangle(cornerRadius: overlayCornerRadius ?? 0)
                                .stroke(Color.white, lineWidth: overlayLineWidth ?? 0)
                        )
                }
                
            } placeholder: {
                ShimmerView(width: width, height: height, cornerRadius: cornerRadius ?? 0)
            }
        } else {
            Rectangle()
                .fill(.highEmphasis.opacity(0.2))
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius ?? 0))
        }
    }
}

#Preview {
    ImageView(imagePath: "", aspectRatio: .fit, width: 128, height: 192, cornerRadius: 8, blur: 0, overlayCornerRadius: 0, overlayLineWidth: 0)
}
