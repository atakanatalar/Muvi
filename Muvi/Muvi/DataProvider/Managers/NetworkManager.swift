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
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        switch endpoint {
        case .search(let query):
            queryItems.append(URLQueryItem(name: "query", value: query))
        default:
            break
        }
        
        components.queryItems = queryItems
        
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
    
    func getMediaTrailer(with query: String) async throws -> VideoElement {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            throw URLError(.badURL)
        }
        
        guard let url = URL(string: "\(NetworkConstants.youTubeBaseURL)search?q=\(query)&key=\(NetworkConstants.youTubeAPIKey)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let results = try JSONDecoder().decode(MediaTrailer.self, from: data)
            
            guard let firstItem = results.items.first else {
                throw NSError(domain: "MediaTrailerErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "No trailer found in the search results."])
            }
            
            return firstItem
        } catch {
            throw NSError(domain: "MediaTrailerErrorDomain", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to decode the media trailer response."])
        }
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
    case detail(MediaType, Int)
    case credits(MediaType, Int)
    case recommendations(MediaType, Int)
    case search(String)
    
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
        case .detail(let mediaType, let id):
            return "\(mediaType.rawValue)/\(id)"
        case .credits(let mediaType, let id):
            return "\(mediaType.rawValue)/\(id)/credits"
        case .recommendations(let mediaType, let id):
            return "\(mediaType.rawValue)/\(id)/recommendations"
        case .search(_):
            return "search/multi"
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
