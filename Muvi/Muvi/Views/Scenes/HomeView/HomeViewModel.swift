//
//  HomeViewModel.swift
//  Muvi
//
//  Created by Atakan Atalar on 21.08.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var trendingMovies: Media?
    @Published var trendingTvShows: Media?
    @Published var heroMoviesItem: Result?
    @Published var heroTvShowsItem: Result?
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
                let trendingMovies: Media = try await NetworkManager.shared.fetchData(endpoint: .trendingMovie(.day))
                let trendingTvShows: Media = try await NetworkManager.shared.fetchData(endpoint: .trendingTvShows(.day))
                let topRatedMovies: Media = try await NetworkManager.shared.fetchData(endpoint: .topRated(.movie))
                let topRatedTVShows: Media = try await NetworkManager.shared.fetchData(endpoint: .topRated(.tv))
                let popularMovies: Media = try await NetworkManager.shared.fetchData(endpoint: .popular(.movie))
                let popularTVShows: Media = try await NetworkManager.shared.fetchData(endpoint: .popular(.tv))
                let upComing: Media = try await NetworkManager.shared.fetchData(endpoint: .upcoming)
                let onTheAir: Media = try await NetworkManager.shared.fetchData(endpoint: .onTheAir)
                let nowPlaying: Media = try await NetworkManager.shared.fetchData(endpoint: .nowPlaying)
                let airingToday: Media = try await NetworkManager.shared.fetchData(endpoint: .airingToday)
                
                DispatchQueue.main.async {
                    self.trendingMovies = trendingMovies
                    self.heroMoviesItem = trendingMovies.results.first
                    self.trendingTvShows = trendingTvShows
                    self.heroTvShowsItem = trendingTvShows.results.first
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
