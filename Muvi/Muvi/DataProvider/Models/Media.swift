//
//  Media.swift
//  Muvi
//
//  Created by Atakan Atalar on 20.08.2024.
//

import Foundation
// MARK: - Media
struct Media: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let backdropPath: String?
    let id: Int
    let title, originalTitle: String?
    let overview: String?
    let posterPath: String?
    let adult: Bool
    let originalLanguage: OriginalLanguage?
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let name, originalName, firstAirDate: String?
    let originCountry: [String]?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case adult
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case hi = "hi"
    case ja = "ja"
    case ko = "ko"
    case it = "it"
    case es = "es"
    case fr = "fr"
    // Add other known languages here
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self = OriginalLanguage(rawValue: value) ?? .unknown
    }
}

extension Result {
    static let mockResult: Result = Result(
        backdropPath: "",
        id: 1,
        title: "Media Title",
        originalTitle: "originalTitle",
        overview: "overview",
        posterPath: "posterPath.jpg",
        adult: true,
        originalLanguage: .en,
        genreIDS: [
            1,
            2
        ],
        popularity: 7.8,
        releaseDate: "2024-08-13",
        video: false,
        voteAverage: 8.2,
        voteCount: 123,
        name: "Media Name",
        originalName: "originalName",
        firstAirDate: "2024-08-13",
        originCountry: [
            "TR"
        ]
    )
    
    static let emptyMockResult: Result = Result(
        backdropPath: "",
        id: 0,
        title: "",
        originalTitle: "",
        overview: "",
        posterPath: "",
        adult: true,
        originalLanguage: .unknown,
        genreIDS: [
            0
        ],
        popularity: 0,
        releaseDate: "",
        video: false,
        voteAverage: 0,
        voteCount: 0,
        name: "",
        originalName: "",
        firstAirDate: "",
        originCountry: [
            ""
        ]
    )
}
