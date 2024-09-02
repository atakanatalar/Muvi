//
//  SearchViewModel.swift
//  Muvi
//
//  Created by Atakan Atalar on 23.08.2024.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [Result]?
    @Published var mediaRecommendations: [Result]?
    @Published var isEmptyState: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] newValue in
                self?.search(query: newValue)
            }
            .store(in: &cancellables)
    }
    
    private func search(query: String) {
        guard !query.isEmpty else {
            searchResults = nil
            return
        }
        
        Task {
            do {
                let media: Media = try await NetworkManager.shared.fetchData(endpoint: .search(query))
                let filteredResults = media.results.filter { $0.mediaType != .person }
                                
                DispatchQueue.main.async {
                    self.searchResults = filteredResults
                    self.isEmptyState = filteredResults.isEmpty
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchRecommendations() {
        Task {
            do {
                let mediaRecommendations: Media = try await NetworkManager.shared.fetchData(endpoint: .trendingMedia(.all, .week))
                DispatchQueue.main.async {
                    self.mediaRecommendations = mediaRecommendations.results
                }
            } catch {
                print("Failed to fetch data: \(error)")
            }
        }
    }
}

