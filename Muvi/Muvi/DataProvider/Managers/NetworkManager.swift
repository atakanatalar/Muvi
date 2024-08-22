//
//  NetworkManager.swift
//  Muvi
//
//  Created by Atakan Atalar on 20.08.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchData<T: Decodable>(endpoint: MediaEndpoint, language: String = "en-US", page: Int = 1) async throws -> T {
        let url = URL(string: NetworkConstants.baseURL + endpoint.path)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "page", value: String(page))
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": NetworkConstants.authorizationHeader
        ]
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}

enum MediaEndpoint {
    case topRated(MediaType)
    case popular(MediaType)
    case upcoming
    case onTheAir
    case nowPlaying
    case airingToday
    case trendingMedia(MediaType,TimeWindow)
    
    var path: String {
        switch self {
        case .topRated(let mediaType):
            return "\(mediaType.rawValue)/top_rated"
        case .popular(let mediaType):
            return "\(mediaType.rawValue)/popular"
        case .upcoming:
            return "movie/upcoming"
        case .onTheAir:
            return "tv/on_the_air"
        case .nowPlaying:
            return "movie/now_playing"
        case .airingToday:
            return "tv/airing_today"
        case .trendingMedia(let mediaType, let timeWindow):
            return "trending/\(mediaType.rawValue)/\(timeWindow.rawValue)"
        }
    }
}

enum MediaType: String, Codable {
    case all = "all"
    case movie = "movie"
    case tv = "tv"
}

enum TimeWindow: String {
    case day = "day"
    case week = "week"
}
