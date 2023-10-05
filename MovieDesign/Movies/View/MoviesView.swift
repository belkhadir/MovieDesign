//
//  MoviesView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 21/9/2023.
//

import SwiftUI

struct MoviesView<ViewModel: MoviesDisplayable & ObservableObject>: View {
    @ObservedObject private var viewModel: ViewModel
    private let imageResourceService: (MovieProviding) -> ImageResourceService
    private let selectedMovie: (MovieProviding) -> Void
    
    init(
        viewModel: ViewModel,
        imageResourceService: @escaping (MovieProviding) -> ImageResourceService,
        selectedMovie: @escaping (MovieProviding) -> Void
    ) {
        self.viewModel = viewModel
        self.imageResourceService = imageResourceService
        self.selectedMovie = selectedMovie
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(repeating: .init(.flexible()), count: 2),
                    spacing: 20
                ) {
                    ForEach(viewModel.moviesProvider, id: \.id) { movie in
                        moviePoster(for: movie)
                        .onTapGesture {
                            selectedMovie(movie)
                        }
                        .onAppear {
                            if movie.id == viewModel.moviesProvider.last?.id {
                                Task {
                                    await viewModel.loadMoreMovies()
                                }
                            }
                        }
                    }
                    if viewModel.loadingState == .loading {
                        ProgressView()
                            .frame(height: 50)
                    }
            }
            .padding()
            .task {
                await viewModel.fetchMovies()
            }
        }
    }
}

// MARK: - Helpers
private extension MoviesView {
    @ViewBuilder
    private func moviePoster(for movie: MovieProviding) -> some View {
        AnyView(MoviePosterUIComposition.constructView(
            movieProvider: movie,
            imageResourceService: imageResourceService(movie)
        ))
        .aspectRatio(0.75, contentMode: .fit)
    }
}
