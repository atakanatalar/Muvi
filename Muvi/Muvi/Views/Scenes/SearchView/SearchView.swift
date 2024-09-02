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
        ZStack(alignment: .top) {
            Color.surfaceDark.ignoresSafeArea()
            
            VStack(spacing: 16) {
                SearchBarView(searchText: $viewModel.searchText)
                
                if let searchResults = viewModel.searchResults {
                    if viewModel.isEmptyState {
                        EmptySearch(searchText: $viewModel.searchText)
                    } else {
                        SearchListView(title: "Top Results", medias: searchResults)
                    }
                } else {
                    if let mediaRecommendations = viewModel.mediaRecommendations {
                        SearchListView(title: "Popular Search", medias: mediaRecommendations)
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

struct SearchListView: View {
    var title: String
    var medias: [Result]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.surfaceWhite)
                
                LazyVStack(alignment: .leading, spacing: 16) {
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

struct EmptySearch: View {
    @Binding var searchText: String
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(.emptySearch)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
            
            VStack(spacing: 8) {
                Text("No Result")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.surfaceWhite)
                
                Text("\"\(searchText)\" not found")
                    .font(.body)
                    .foregroundStyle(.mediumEmphasis)
            }
            Spacer()
        }
    }
}
