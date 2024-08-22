//
//  HomeViewModel.swift
//  Muvi
//
//  Created by Atakan Atalar on 21.08.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var trendingAll: Media?
    @Published var trendingMovies: Media?
    @Published var trendingTvShows: Media?
    @Published var heroAll: Result?
    @Published var heroMovie: Result?
    @Published var heroTvShow: Result?
    @Published var topRatedMovies: Media?
    @Published var topRatedTVShows: Media?
    @Published var popularMovies: Media?
    @Published var popularTvShows: Media?
    @Published var upComing: Media?
    @Published var onTheAir: Media?
    @Published var nowPlaying: Media?
    @Published var airingToday: Media?
    
    func fetchMedias() {
        Task {
            do {
                let trendingAll: Media = try await NetworkManager.shared.fetchData(endpoint: .trendingMedia(.all, .week))
                let trendingMovies: Media = try await NetworkManager.shared.fetchData(endpoint: .trendingMedia(.movie, .day))
                let trendingTvShows: Media = try await NetworkManager.shared.fetchData(endpoint: .trendingMedia(.tv, .day))
                let topRatedMovies: Media = try await NetworkManager.shared.fetchData(endpoint: .topRated(.movie))
                let topRatedTVShows: Media = try await NetworkManager.shared.fetchData(endpoint: .topRated(.tv))
                let popularMovies: Media = try await NetworkManager.shared.fetchData(endpoint: .popular(.movie))
                let popularTVShows: Media = try await NetworkManager.shared.fetchData(endpoint: .popular(.tv))
                let upComing: Media = try await NetworkManager.shared.fetchData(endpoint: .upcoming)
                let onTheAir: Media = try await NetworkManager.shared.fetchData(endpoint: .onTheAir)
                let nowPlaying: Media = try await NetworkManager.shared.fetchData(endpoint: .nowPlaying)
                let airingToday: Media = try await NetworkManager.shared.fetchData(endpoint: .airingToday)
                
                DispatchQueue.main.async {
                    self.heroAll = trendingAll.results.first
                    self.trendingAll = trendingAll
                    self.heroMovie = trendingMovies.results.first
                    self.trendingMovies = trendingMovies
                    self.heroTvShow = trendingTvShows.results.first
                    self.trendingTvShows = trendingTvShows
                    self.topRatedMovies = topRatedMovies
                    self.topRatedTVShows = topRatedTVShows
                    self.popularMovies = popularMovies
                    self.popularTvShows = popularTVShows
                    self.upComing = upComing
                    self.onTheAir = onTheAir
                    self.nowPlaying = nowPlaying
                    self.airingToday = airingToday
                }
            } catch {
                print("Failed to fetch data: \(error)")
                DispatchQueue.main.async {
                }
            }
        }
    }
}
