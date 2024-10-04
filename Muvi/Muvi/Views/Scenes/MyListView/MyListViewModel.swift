//
//  MyListViewModel.swift
//  Muvi
//
//  Created by Atakan Atalar on 26.08.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class MyListViewModel: ObservableObject {
    @Published var savedMedias: [Result] = []
    @Published var mediaRecommendations: Media?
    @Published var isEmptyState: Bool = false
    @Published var isLoading: Bool = true
    
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
        isLoading = true
        guard let userId = Auth.auth().currentUser?.uid else {
            isLoading = false
            return
        }
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).getDocument { [weak self] (document, error) in
            self?.isLoading = false
            if let error = error {
                print("Error fetching saved medias: \(error)")
                return
            }
            
            guard let document = document, document.exists else {
                self?.isEmptyState = true
                return
            }
            
            if let myList = document.get("myList") as? [[String: Any]] {
                var tempSavedMedias: [Result] = []
                
                for dict in myList {
                    if let id = dict["id"] as? Int,
                       let title = dict["title"] as? String,
                       let backdropPath = dict["backdropPath"] as? String {
                        let media = Result(
                            backdropPath: backdropPath,
                            id: id,
                            title: title,
                            originalTitle: nil,
                            overview: nil,
                            posterPath: nil,
                            adult: nil,
                            originalLanguage: nil,
                            genreIDS: nil,
                            popularity: nil,
                            releaseDate: nil,
                            video: nil,
                            voteAverage: nil,
                            voteCount: nil,
                            name: nil,
                            originalName: nil,
                            firstAirDate: nil,
                            originCountry: nil,
                            mediaType: nil
                        )
                        tempSavedMedias.append(media)
                    } else {
                        print("Invalid data in myList, skipping entry: \(dict)")
                    }
                }
                
                self?.savedMedias = tempSavedMedias
                self?.isEmptyState = self?.savedMedias.isEmpty ?? true
            } else {
                self?.isEmptyState = true
            }
        }
    }
    
    
    func deleteMedia(at offsets: IndexSet) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        let mediasToDelete = offsets.map { savedMedias[$0] }
        
        db.collection("users").document(userId).getDocument { (document, error) in
            if let error = error {
                print("Error fetching myList: \(error)")
                return
            }
            
            guard let document = document, document.exists else {
                print("User document does not exist")
                return
            }
            
            var myList = document.data()?["myList"] as? [[String: Any]] ?? []
            
            mediasToDelete.forEach { media in
                myList.removeAll { mediaItem in
                    return mediaItem["id"] as? Int == media.id
                }
            }
            
            db.collection("users").document(userId).updateData([
                "myList": myList
            ]) { error in
                if let error = error {
                    print("Error updating myList after removal: \(error)")
                } else {
                    print("Media successfully removed from myList")
                    self.savedMedias.remove(atOffsets: offsets)
                    self.isEmptyState = self.savedMedias.isEmpty
                }
            }
        }
    }
}
