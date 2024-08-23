//
//  DetailViewModel.swift
//  Muvi
//
//  Created by Atakan Atalar on 22.08.2024.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var mediaDetail: MediaDetail?
    @Published var mediaCredits: Credits?
    @Published var mediaRecommendations: Media?
    @Published var creatorNames: String?
    @Published var directorNames: String?
    @Published var screenplayNames: String?
    @Published var storyNames: String?
    @Published var novelNames: String?
    var media: Result
    
    init(media: Result) {
        self.media = media
        fetchMediaDetail()
    }
    
    func fetchMediaDetail() {
        Task {
            do {
                let mediaDetail: MediaDetail = try await NetworkManager.shared.fetchData(endpoint: .detail(media.name == nil ? .movie : .tv, media.id))
                let mediaCredits: Credits = try await NetworkManager.shared.fetchData(endpoint: .credits(media.name == nil ? .movie : .tv, media.id))
                let mediaRecommendations: Media = try await NetworkManager.shared.fetchData(endpoint: .recommendations(media.name == nil ? .movie : .tv, media.id))
                DispatchQueue.main.async {
                    self.mediaDetail = mediaDetail
                    self.mediaCredits = mediaCredits
                    self.mediaRecommendations = mediaRecommendations
                    
                    if let creatorNames = getCreatorNames(from: mediaDetail.createdBy) {
                        self.creatorNames = creatorNames
                    }
                    
                    if let directorNames = getNames(for: "Director", from: mediaCredits.crew) {
                        self.directorNames = directorNames
                    }

                    if let screenplayNames = getNames(for: "Screenplay", from: mediaCredits.crew) {
                        self.screenplayNames = screenplayNames
                    }

                    if let storyNames = getNames(for: "Story", from: mediaCredits.crew) {
                        self.storyNames = storyNames
                    }

                    if let novelNames = getNames(for: "Novel", from: mediaCredits.crew) {
                        self.novelNames = novelNames
                    }
                }
            } catch {
                print("Failed to fetch data: \(error)")
            }
        }
    }
}
