//
//  DetailView.swift
//  Muvi
//
//  Created by Atakan Atalar on 22.08.2024.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    
    let backdropWidth: CGFloat = UIScreen.main.bounds.width
    let backdropHeight: CGFloat = UIScreen.main.bounds.width * 9 / 16
    let posterWidth: CGFloat = UIScreen.main.bounds.width * 0.4
    let posterHeight: CGFloat = UIScreen.main.bounds.width * 0.4 * 3 / 2
    let gridItems = [GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color.surfaceDark.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 12) {
                    ZStack(alignment: .center) {
                        ImageView(
                            imagePath: viewModel.mediaDetail?.backdropPath ?? "",
                            aspectRatio: .fill,
                            width: backdropWidth,
                            height: backdropHeight * 1.5,
                            blur: 8
                        )
                        .clipped()
                        
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color.surfaceDark.opacity(1.0)]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color.surfaceDark.opacity(1.0)]),
                            startPoint: .center,
                            endPoint: .top
                        )
                        
                        ImageView(
                            imagePath:viewModel.mediaDetail?.posterPath ?? "",
                            aspectRatio: .fit,
                            width: posterWidth,
                            height: posterHeight,
                            cornerRadius: 10,
                            overlayCornerRadius: 10,
                            overlayLineWidth: 2
                        )
                    }
                    
                    VStack(alignment: .center, spacing: 8) {
                        Text(viewModel.mediaDetail?.title ?? viewModel.mediaDetail?.name ?? "")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.surfaceWhite)
                        
                        VStack(spacing: 4) {
                            HStack {
                                Text(formattedMediaInfo(
                                    releaseDate: viewModel.mediaDetail?.releaseDate,
                                    lastAirDate: viewModel.mediaDetail?.lastAirDate,
                                    mediaType: viewModel.mediaDetail?.mediaDetailType ?? "",
                                    numberOfSeasons: viewModel.mediaDetail?.numberOfSeasons,
                                    runtime: viewModel.mediaDetail?.runtime,
                                    voteAverage: viewModel.mediaDetail?.voteAverage,
                                    isHd: viewModel.media.isHd
                                ))
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundStyle(.highEmphasis)
                                
                                if viewModel.media.isHd { Image(.iconHd) }
                            }
                            
                            Text(genresToString(genres: viewModel.mediaDetail?.genres ?? []))
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundStyle(.highEmphasis)
                                .padding(.horizontal, 20)
                        }
                    }
                    .padding(.top, -12)
                    .padding(.horizontal, 20)
                    
                    HStack {
                        Button {
                            viewModel.playTrailer()
                            viewModel.isPlayingMediaTrailer = true
                        } label: {
                            Label("Watch Trailer", systemImage: "play")
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                        }
                        .primaryButtonStyle(backgroundColor: .brandPrimary, foregroundColor: .black)
                        
                        Button {
                            viewModel.toggleSaveMedia()
                        } label: {
                            Label("My List", systemImage: viewModel.isSaved ? "checkmark" : "plus")
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                        }
                        .primaryButtonStyle(backgroundColor: .mediumEmphasis, foregroundColor: .surfaceWhite)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.mediaDetail?.tagline ?? "")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.surfaceWhite)
                        
                        Text(viewModel.mediaDetail?.overview ?? "No overview available")
                            .font(.body)
                            .foregroundStyle(.highEmphasis)
                            .padding(.bottom, 4)
                        
                        let details = [
                            viewModel.creatorNames.map { ("Creators", $0) },
                            viewModel.directorNames.map { ("Director", $0) },
                            viewModel.screenplayNames.map { ("Screenplay", $0) },
                            viewModel.storyNames.map { ("Story", $0) },
                            viewModel.novelNames.map { ("Novel", $0) }
                        ].compactMap { $0 }

                        if !details.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(details, id: \.0) { (label, value) in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(label)
                                            .font(.footnote)
                                            .foregroundStyle(.highEmphasis)
                                        Text(value)
                                            .font(.body)
                                            .foregroundStyle(.mediumEmphasis)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)
                    
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Cast and Crew")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.surfaceWhite)
                                .padding(.horizontal, 20)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: gridItems, spacing: 10) {
                                    let castAndCrew = viewModel.mediaCredits
                                    let combinedCredits = (castAndCrew?.cast ?? []) + (castAndCrew?.crew ?? [])
                                    ForEach(combinedCredits, id: \.id) { credit in
                                        CreditCell(credit: credit)
                                    }
                                }
                            }
                        }
                        .contentMargins(.horizontal, 20, for: .scrollContent)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Recommendations")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.surfaceWhite)
                                .padding(.horizontal, 20)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: gridItems, spacing: 10) {
                                    if let mediaRecommendations = viewModel.mediaRecommendations {
                                        ForEach(mediaRecommendations.results, id: \.id) { mediaRecommendation in
                                            NavigationLink(destination: DetailView(viewModel: DetailViewModel(media: mediaRecommendation))) {
                                                MediaCell(media: mediaRecommendation)
                                            }
                                        }
                                    } else {
                                        Text("No recommendations available")
                                            .font(.headline)
                                            .foregroundStyle(.highEmphasis)
                                    }
                                }
                            }
                        }
                        .contentMargins(.horizontal, 20, for: .scrollContent)
                    }
                }
                .padding(.bottom, 16)
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(.surfaceDark, for: .navigationBar)
        .onAppear {
            viewModel.checkIfMediaIsSaved()
        }
        .sheet(isPresented: $viewModel.isPlayingMediaTrailer) {
            MediaTrailerView(mediaTrailerId: viewModel.mediaTrailerId ?? "")
        }
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel(media: Result.mockResult))
}
