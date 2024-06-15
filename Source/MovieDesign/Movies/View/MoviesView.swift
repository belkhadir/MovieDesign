//
//  MoviesView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 21/9/2023.
//

import SwiftUI
import ImageResourceAPI

struct MoviesView<ViewModel: MoviesDisplayable & ObservableObject, ServiceProvider: ImageResourceServiceProviding ,ErrorView: View>: View {
    @ObservedObject private var viewModel: ViewModel
    private let imageResourceServiceProvider: (MovieProviding) -> ServiceProvider
    private let selectedMovie: (MovieProviding) -> Void
    private let errorView: ErrorView
    
    init(
        viewModel: ViewModel,
        imageResourceServiceProvider: @escaping (MovieProviding) -> ServiceProvider,
        selectedMovie: @escaping (MovieProviding) -> Void,
        errorView: ErrorView
    ) {
        self.viewModel = viewModel
        self.imageResourceServiceProvider = imageResourceServiceProvider
        self.selectedMovie = selectedMovie
        self.errorView = errorView
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
                            if movie.id == viewModel.moviesProvider.last?.id && viewModel.loadingState != .loading {
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

        }.overlay(content: {
            if viewModel.shouldDisplayOverlay() {
                errorView
            }
        })
        .task {
            await viewModel.fetchMovies()
        }
    }
}

// MARK: - Helpers
private extension MoviesView {
    @ViewBuilder
    func moviePoster(for movie: MovieProviding) -> some View {
        MoviePosterUIComposition.constructView(
            movieProvider: movie,
            imageServiceProvider: imageResourceServiceProvider(movie)
        )
        .aspectRatio(0.75, contentMode: .fit)
    }
}
