//
//  MediaDetail.swift
//  Muvi
//
//  Created by Atakan Atalar on 22.08.2024.
//

import Foundation
// MARK: - MediaDetail
struct MediaDetail: Codable {
    let genres: [Genre]
    let id: Int
    let backdropPath: String
    let posterPath: String
    let originalLanguage: String
    let originalTitle: String?
    let originalName: String?
    let title: String?
    let name: String?
    let overview: String
    let releaseDate: String?
    let firstAirDate: String?
    let lastAirDate: String?
    let runtime: Int?
    let numberOfEpisodes: Int?
    let numberOfSeasons: Int?
    let voteAverage: Double
    let createdBy: [CreatedBy]?
    let tagline: String
    
    enum CodingKeys: String, CodingKey {
        case genres, id, tagline
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case originalName = "original_name"
        case title
        case name
        case overview
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case lastAirDate = "last_air_date"
        case runtime
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case voteAverage = "vote_average"
        case createdBy = "created_by"
    }
    
    // Computed property to determine media type
    var mediaDetailType: String {
        return determineMediaType(for: self)
    }
}

// MARK: - CreatedBy
struct CreatedBy: Codable {
    let id: Int
    let creditID, name, originalName: String
    let gender: Int
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name
        case originalName = "original_name"
        case gender
        case profilePath = "profile_path"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}
