//
//  MyListViewModel.swift
//  Muvi
//
//  Created by Atakan Atalar on 26.08.2024.
//

import Foundation

class MyListViewModel: ObservableObject {
    @Published var savedMedias: [Result] = []
    @Published var mediaRecommendations: Media?
    @Published var isEmptyState: Bool = false
    
    func fetchMediaRecommendations() {
        Task {
            do {
                if let randomMedia = savedMedias.randomElement() {
                    let mediaType: MediaType = randomMedia.name == nil ? .movie : .tv
                    let mediaRecommendations: Media = try await NetworkManager.shared.fetchData(endpoint: .recommendations(mediaType, randomMedia.id))
                    DispatchQueue.main.async {
                        self.mediaRecommendations = mediaRecommendations
                    }
                } else {
                    let trendingMediaRecommendations: Media = try await NetworkManager.shared.fetchData(endpoint: .trendingMedia(.all, .week))
                    DispatchQueue.main.async {
                        self.mediaRecommendations = trendingMediaRecommendations
                    }
                }
            } catch {
                print("Failed to fetch data: \(error)")
            }
        }
    }
    
    func loadSavedMedias() {
        savedMedias = PersistenceManager.shared.loadResults()
        isEmptyState = savedMedias.isEmpty
    }
    
    func deleteMedia(at offsets: IndexSet) {
        for index in offsets {
            let media = savedMedias[index]
            PersistenceManager.shared.removeResult(by: media.id)
        }
        savedMedias.remove(atOffsets: offsets)
        isEmptyState = savedMedias.isEmpty
    }
}
