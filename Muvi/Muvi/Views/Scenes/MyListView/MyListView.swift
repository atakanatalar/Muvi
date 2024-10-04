//
//  MyListView.swift
//  Muvi
//
//  Created by Atakan Atalar on 26.08.2024.
//

import SwiftUI

struct MyListView: View {
    @StateObject private var viewModel = MyListViewModel()
    let gridItems = [GridItem(.fixed(192))]
    
    var body: some View {
        ZStack {
            Color.surfaceDark.ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.0, anchor: .center)
            } else {
                List {
                    Section {
                        if viewModel.isEmptyState {
                            EmptyMyListView()
                                .listRowBackground(Color.surfaceDark)
                        } else {
                            ForEach(viewModel.savedMedias, id: \.id) { media in
                                NavigationLink(destination: DetailView(viewModel: DetailViewModel(media: media))) {
                                    MyListCell(media: media)
                                }
                                .listRowBackground(Color.surfaceDark)
                                .listRowSeparator(.hidden, edges: .all)
                                .foregroundStyle(.clear)
                            }
                            .onDelete(perform: viewModel.deleteMedia)
                        }
                    }
                    
                    Section {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Recommendations")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.surfaceWhite)
                                .padding(.horizontal, 20)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: gridItems, spacing: 10) {
                                    if let mediaRecommendations = viewModel.mediaRecommendations?.results {
                                        ForEach(mediaRecommendations, id: \.id) { mediaRecommendation in
                                            NavigationLink(destination: DetailView(viewModel: DetailViewModel(media: mediaRecommendation))) {
                                                MediaCell(media: mediaRecommendation)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .listRowBackground(Color.surfaceDark)
                        .listRowSeparator(.hidden, edges: .all)
                        .contentMargins(.horizontal, 20, for: .scrollContent)
                    }
                    .padding(.horizontal, -20)
                    .frame(height: 240)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationBar(title: "My List")
        .onAppear {
            viewModel.loadSavedMedias()
            viewModel.fetchMediaRecommendations()
        }
    }
}

#Preview {
    MyListView()
}

struct EmptyMyListView: View {
    var body: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .center, spacing: 24) {
                Image(.emptyMyList)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                
                VStack(alignment: .center, spacing: 8) {
                    Text("Your List is Empty")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.surfaceWhite)
                    
                    Text("You can add movies or series to your list from their detail pages")
                        .font(.body)
                        .foregroundStyle(.mediumEmphasis)
                        .multilineTextAlignment(.center)
                }
            }
            
            Spacer()
        }
    }
}
