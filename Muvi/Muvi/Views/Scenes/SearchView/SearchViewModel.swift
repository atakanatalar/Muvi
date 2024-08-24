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
    @Published var seachResults: [Result]?
    
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
            seachResults = nil
            return
        }
        
        Task {
            do {
                let media: Media = try await NetworkManager.shared.fetchData(endpoint: .search(query))
                let filteredResults = media.results.filter { $0.mediaType != .person }
                                
                DispatchQueue.main.async {
                    self.seachResults = filteredResults
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

