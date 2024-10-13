//
//  DetailViewModel.swift
//  Muvi
//
//  Created by Atakan Atalar on 22.08.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class DetailViewModel: ObservableObject {
    @Published var mediaDetail: MediaDetail?
    @Published var mediaCredits: Credits?
    @Published var mediaRecommendations: Media?
    @Published var creatorNames: String?
    @Published var directorNames: String?
    @Published var screenplayNames: String?
    @Published var storyNames: String?
    @Published var novelNames: String?
    @Published var isSaved: Bool = false
    @Published var mediaTrailerId: String?
    @Published var isPlayingMediaTrailer: Bool = false
    
    var media: Result
    
    init(media: Result) {
        self.media = media
        fetchMediaDetail()
    }
    
    func toggleSaveMedia() {
        if isSaved {
            removeMediaFromMyList()
            isSaved = false
        } else {
            addMediaToMyList()
            isSaved = true
        }
    }
    
    private func addMediaToMyList() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        let mediaData: [String: Any] = [
            "id": media.id,
            "name": media.name ?? "",
            "title": media.title ?? "",
            "backdropPath": media.backdropPath ?? "",
            "createdAt": Timestamp(date: Date())
        ]
        
        db.collection("users").document(userId).updateData([
            "myList": FieldValue.arrayUnion([mediaData])
        ]) { error in
            if let error = error {
                print("Error adding media to myList: \(error)")
            } else {
                print("Media successfully added to myList")
            }
        }
    }
    
    private func removeMediaFromMyList() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).getDocument { (document, error) in
            if let error = error {
                print("Error fetching myList: \(error)")
                return
            }
            
            if let document = document, document.exists {
                var myList = document.data()?["myList"] as? [[String: Any]] ?? []
                
                myList.removeAll { mediaItem in
                    return mediaItem["id"] as? Int == self.media.id
                }
                
                db.collection("users").document(userId).updateData([
                    "myList": myList
                ]) { error in
                    if let error = error {
                        print("Error updating myList after removal: \(error)")
                    } else {
                        print("Media successfully removed from myList")
                    }
                }
            } else {
                print("User document does not exist")
            }
        }
    }
    
    func checkIfMediaIsSaved() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).getDocument { document, error in
            if let error = error {
                print("Error fetching user document: \(error)")
                return
            }
            guard let document = document, document.exists,
                  let data = document.data(),
                  let myList = data["myList"] as? [[String: Any]] else {
                self.isSaved = false
                return
            }
            
            self.isSaved = myList.contains { $0["id"] as? Int == self.media.id }
        }
    }
    
    func playTrailer() {
        Task {
            do {
                let query = "\(media.name ?? media.title ?? "") Trailer"
                let mediaTrailer: VideoElement = try await NetworkManager.shared.getMediaTrailer(with: query)
                DispatchQueue.main.async {
                    self.mediaTrailerId = mediaTrailer.id.videoId
                }
            } catch {
                print("Failed to fetch data: \(error)")
            }
        }
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
