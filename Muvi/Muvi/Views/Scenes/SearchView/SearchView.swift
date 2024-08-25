//
//  SearchView.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        ZStack {
            Color.surfaceDark.ignoresSafeArea()
            
            VStack(spacing: 16) {
                SearchBarView(searchText: $viewModel.searchText)
                
                if let seachResults = viewModel.seachResults {
                    MediaListView(title: "Top Results", medias: seachResults)
                    
                } else {
                    if let mediaRecommendations = viewModel.mediaRecommendations {
                        MediaListView(title: "Recommended for You", medias: mediaRecommendations)
                    }
                }
            }
            .padding(.top, 16)
        }
        .navigationBar(title: "Search")
        .onAppear { viewModel.fetchRecommendations() }
    }
}

#Preview {
    SearchView()
}

struct MediaListView: View {
    var title: String
    var medias: [Result]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.surfaceWhite)
                
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(medias, id: \.id) { media in
                        NavigationLink(destination: DetailView(viewModel: DetailViewModel(media: media))) {
                            SearchCell(media: media)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
    }
}
