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
