//
//  Helpers.swift
//  Muvi
//
//  Created by Atakan Atalar on 21.08.2024.
//

import Foundation
// Utility function to extract year from a date string and compare it
func isHdReleaseDate(releaseDate: String?, firstAirDate: String?) -> Bool {
    func extractYear(from dateString: String?) -> Int? {
        guard let dateString = dateString?.prefix(4) else { return nil }
        return Int(dateString)
    }
    
    let releaseYear = extractYear(from: releaseDate)
    let firstAirYear = extractYear(from: firstAirDate)
    
    return (releaseYear ?? 0) > 2010 || (firstAirYear ?? 0) > 2010
}

func determineMediaType(for mediaDetail: MediaDetail) -> String {
    return mediaDetail.name != nil ? "tv" : "movie"
}

func formattedDuration(from minutes: Int) -> String {
    let hours = minutes / 60
    let remainingMinutes = minutes % 60
    
    return String(format: "%dh %02dm", hours, remainingMinutes)
}

func genresToString(genres: [Genre]) -> String {
    return genres.map { $0.name }.joined(separator: ", ")
}

func formattedMediaInfo(releaseDate: String?, firstAirDate: String?, lastAirDate: String?, mediaType: String, numberOfSeasons: Int?, runtime: Int?, voteAverage: Double?, isHd: Bool) -> String {
    if !isHd {
        return formattedMediaInfoWithDots(releaseDate: releaseDate, firstAirDate: firstAirDate, lastAirDate: lastAirDate, mediaType: mediaType, numberOfSeasons: numberOfSeasons, runtime: runtime, voteAverage: voteAverage)
    }
    
    let year = releaseDate?.prefix(4) ?? "\(firstAirDate?.prefix(4) ?? "")-\(lastAirDate?.prefix(4) ?? "")"
    let typeInfo = mediaType == "tv" ? "\(numberOfSeasons ?? 0) Season" : formattedDuration(from: runtime ?? 0)
    let voteAverage = String(format: "%.1f", voteAverage ?? 0.0)
    let voteString = "IMDb \(voteAverage)"
    let components = [String(year), typeInfo, voteString].filter { !$0.isEmpty }
    
    return components.map { "\($0) •" }.joined(separator: " ")
}

func formattedMediaInfoWithDots(releaseDate: String?, firstAirDate: String?, lastAirDate: String?, mediaType: String, numberOfSeasons: Int?, runtime: Int?, voteAverage: Double?) -> String {
    let year = releaseDate?.prefix(4) ?? "\(firstAirDate?.prefix(4) ?? "")-\(lastAirDate?.prefix(4) ?? "")"
    let typeInfo = mediaType == "tv" ? "\(numberOfSeasons ?? 0) Season" : formattedDuration(from: runtime ?? 0)
    let voteAverage = String(format: "%.1f", voteAverage ?? 0.0)
    let voteString = "IMDb \(voteAverage)"
    
    return [String(year), typeInfo, voteString].filter { !$0.isEmpty }.joined(separator: " • ")
}

func getCreatorNames(from createdByArray: [CreatedBy]?) -> String? {
    guard let createdByArray = createdByArray, !createdByArray.isEmpty else {
        return nil
    }
    let names = createdByArray.map { $0.name }
    
    return names.joined(separator: ", ")
}

func getNames(for job: String, from crewArray: [Cast]?) -> String? {
    guard let crewArray = crewArray else {
        return nil
    }
    
    let relevantMembers = crewArray.filter { $0.job == job }
    let names = relevantMembers.map { $0.name }
    
    return names.isEmpty ? nil : names.joined(separator: ", ")
}
