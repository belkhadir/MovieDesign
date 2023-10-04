//
//  MoviesView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 21/9/2023.
//

import SwiftUI

struct MoviesView<ViewModel: MoviesDisplaying & ObservableObject>: View {
    @ObservedObject private var viewModel: ViewModel
    private let movieDiscoveryViewModel: SegmentControlDisplayable
    private let imageResourceService: (MovieProviding) -> ImageResourceService
    private let selectedMovie: (MovieProviding) -> Void
    
    init(
        viewModel: ViewModel,
        movieDiscoveryViewModel: SegmentControlDisplayable,
        imageResourceService: @escaping (MovieProviding) -> ImageResourceService,
        selectedMovie: @escaping (MovieProviding) -> Void
    ) {
        self.viewModel = viewModel
        self.movieDiscoveryViewModel = movieDiscoveryViewModel
        self.imageResourceService = imageResourceService
        self.selectedMovie = selectedMovie
    }
    
    var body: some View {
        VStack(spacing: 20) {
            SegmentControlView(
                viewModel: movieDiscoveryViewModel,
                selectedItem: { selectedIndex in
                    Task {
                        await viewModel.refreshMovies()
                    }
                }
            )
            ScrollView {
                LazyVGrid(
                    columns: Array(repeating: .init(.flexible()), count: 2),
                    spacing: 20
                ) {
                    if let movies = viewModel.moviesProvider[viewModel.movieDiscovery] {
                        ForEach(movies, id: \.id) { movie in
                            moviePoster(for: movie)
                                .onTapGesture {
                                    selectedMovie(movie)
                                }
                                .onAppear {
                                    if movie.id == movies.last?.id {
                                        Task {
                                            await viewModel.fetchMoreMovies()
                                        }
                                    }
                                }
                        }
                        if viewModel.loadingState == .loading {
                            ProgressView()
                                .frame(height: 50)
                        }
                    } else {
                        Text("No movies to display")
                    }
                }
                .padding()
                .task {
                    await viewModel.refreshMovies()
                }
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
