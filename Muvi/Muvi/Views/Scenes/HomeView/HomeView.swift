//
//  HomeView.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State var activeTabs: SegmentedTab = .all
    
    var body: some View {
        ZStack {
            Color.surfaceDark
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    segmentedControl
                    HeroCell(media: heroMedia)
                    ForEach(mediaSections, id: \.title) { section in
                        section
                    }
                }
            }
        }
        .navigationBar()
        .onAppear { viewModel.fetchMedias() }
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
    
    private var heroMedia: Result {
        switch activeTabs {
        case .all:
            return viewModel.heroMoviesItem ?? Result.emptyMockResult
        case .movies:
            return viewModel.heroMoviesItem ?? Result.emptyMockResult
        case .tvShows:
            return viewModel.heroTvShowsItem ?? Result.emptyMockResult
        }
    }
    
    private var mediaSections: [MediaSectionView] {
        var sections: [MediaSectionView] = []
        
        switch activeTabs {
        case .all:
            if let popularMovies = viewModel.popularMovies?.results {
                sections.append(MediaSectionView(title: "Popular Movies", medias: popularMovies, isRanked: false))
            }
            
            if let airingToday = viewModel.airingToday?.results {
                sections.append(MediaSectionView(title: "Airing Today", medias: airingToday, isRanked: false))
            }
            
            if let trendingMovie = viewModel.trendingMovies?.results {
                sections.append(MediaSectionView(title: "Top 10 Movie", medias: trendingMovie, isRanked: true))
            }
            
            if let popularTvShows = viewModel.popularTvShows?.results {
                sections.append(MediaSectionView(title: "Popular TV Shows", medias: popularTvShows, isRanked: false))
            }
            
            if let nowPlaying = viewModel.nowPlaying?.results {
                sections.append(MediaSectionView(title: "Now Playing", medias: nowPlaying, isRanked: false))
            }
            
            if let trendingTvShows = viewModel.trendingTvShows?.results {
                sections.append(MediaSectionView(title: "Top 10 TV Shows", medias: trendingTvShows, isRanked: true))
            }
            
            if let topRatedMovies = viewModel.topRatedMovies?.results {
                sections.append(MediaSectionView(title: "Top Rated Movies", medias: topRatedMovies, isRanked: false))
            }
            
            if let onTheAir = viewModel.onTheAir?.results {
                sections.append(MediaSectionView(title: "On The Air", medias: onTheAir, isRanked: false))
            }
            
            if let topRatedTVShows = viewModel.topRatedTVShows?.results {
                sections.append(MediaSectionView(title: "Top Rated TV Shows", medias: topRatedTVShows, isRanked: false))
            }
            
            if let upComing = viewModel.upComing?.results {
                sections.append(MediaSectionView(title: "Up Coming", medias: upComing, isRanked: false))
            }
            
        case .movies:
            if let trending = viewModel.trendingMovies?.results {
                sections.append(MediaSectionView(title: "Top 10", medias: trending, isRanked: true))
            }
            
            if let nowPlaying = viewModel.nowPlaying?.results {
                sections.append(MediaSectionView(title: "Now Playing", medias: nowPlaying, isRanked: false))
            }
            
            if let popularMovies = viewModel.popularMovies?.results {
                sections.append(MediaSectionView(title: "Popular Movies", medias: popularMovies, isRanked: false))
            }
            
            if let topRatedMovies = viewModel.topRatedMovies?.results {
                sections.append(MediaSectionView(title: "Top Rated Movies", medias: topRatedMovies, isRanked: false))
            }
            
            if let upComing = viewModel.upComing?.results {
                sections.append(MediaSectionView(title: "Up Coming", medias: upComing, isRanked: false))
            }
            
        case .tvShows:
            if let trending = viewModel.trendingTvShows?.results {
                sections.append(MediaSectionView(title: "Top 10", medias: trending, isRanked: true))
            }
            
            if let airingToday = viewModel.airingToday?.results {
                sections.append(MediaSectionView(title: "Airing Today", medias: airingToday, isRanked: false))
            }
            
            if let popularTvShows = viewModel.popularTvShows?.results {
                sections.append(MediaSectionView(title: "Popular TV Shows", medias: popularTvShows, isRanked: false))
            }
            
            if let topRatedTVShows = viewModel.topRatedTVShows?.results {
                sections.append(MediaSectionView(title: "Top Rated TV Shows", medias: topRatedTVShows, isRanked: false))
            }
            
            if let onTheAir = viewModel.onTheAir?.results {
                sections.append(MediaSectionView(title: "On The Air", medias: onTheAir, isRanked: false))
            }
        }
        
        return sections
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
