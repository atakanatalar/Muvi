//
//  MediaTrailer.swift
//  Muvi
//
//  Created by Atakan Atalar on 5.09.2024.
//

import Foundation

struct MediaTrailer: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
