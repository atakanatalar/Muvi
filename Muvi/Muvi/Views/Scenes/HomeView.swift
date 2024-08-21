//
//  HomeView.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct HomeView: View {
    @State var activeTabs: SegmentedTab = .all
    @State var trendingMovies: Media?
    
    var body: some View {
        ZStack {
            Color.surfaceDark
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                segmentedControl
                HeroCell(media: trendingMovies?.results.first ?? Result.emptyMockResult)
                MediaSectionView(title: "Trending Movies", medias: trendingMovies?.results ?? [])
            }
        }
        .navigationBar()
        .onAppear { fetchMediaSamples() }
    }
    
    var segmentedControl: some View {
        SegmentedControl(tabs: SegmentedTab.allCases,
                         activeTab: $activeTabs,
                         height: 40,
                         font: .subheadline,
                         activeTint: .brandPrimary,
                         inActiveTint: .surfaceWhite
        ) { size in
            Rectangle()
                .fill(.brandPrimary)
                .frame(height: 4)
                .padding(.horizontal, 10)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .background {
            RoundedRectangle(cornerRadius: 0)
                .fill(.surfaceDark)
                .ignoresSafeArea()
        }
    }
    
    func fetchMediaSamples() {
        Task {
            do {
                let trendingMovies: Media = try await NetworkManager.shared.fetchData(endpoint: .trendingMovie(.day))
                DispatchQueue.main.async {
                    self.trendingMovies = trendingMovies
                }
            } catch {
                print("Failed to fetch data: \(error)")
            }
        }
    }
}

enum SegmentedTab: String, CaseIterable {
    case all = "All"
    case movies = "Movies"
    case tvShows = "TV Shows"
}

#Preview {
    HomeView()
}
