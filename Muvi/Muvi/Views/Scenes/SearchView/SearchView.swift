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
            
            VStack {
                SearchBarView(searchText: $viewModel.searchText)
                
                if let media = viewModel.seachResults {
                    List(media, id: \.id) { media in
                        NavigationLink(destination: DetailView(viewModel: DetailViewModel(media: media))) {
                            SearchCell(media: media)
                        }
                        .listRowBackground(Color.clear)
                        .foregroundStyle(.mediumEmphasis)
                    }
                    .listStyle(.plain)
                } else {
                    //
                }
                
                Spacer()
            }
            .padding(.top, 16)
        }
        .navigationBar(title: "Search")
    }
}

#Preview {
    SearchView()
}
