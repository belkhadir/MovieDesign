//
//  PaginatedGridView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 21/9/2023.
//

import SwiftUI

struct MoviesView<ViewModel: MoviesDiplayable & ObservableObject>: View {
    @ObservedObject private var viewModel: ViewModel
    private let imageResourceService: (MovieProviding) -> ImageResourceService
    
    init(viewModel: ViewModel, imageResourceService: @escaping (MovieProviding) -> ImageResourceService) {
        self.viewModel = viewModel
        self.imageResourceService = imageResourceService
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(repeating: .init(.flexible()), count: 2),
                spacing: 20) {
                    ForEach(viewModel.moviesPorvider, id: \.id) { movie in
                        AnyView(MoviePosterUIComposition
                            .constructView(
                                movieProvider: movie, 
                                imageResourceService: imageResourceService(movie)
                            ))
                            .aspectRatio(0.75, contentMode: .fit)
                            .onAppear(perform: {
                                if shouldLoadMore(movie) {
                                    viewModel.loadMoreMovies()
                                }
                            })
                    }
                    if viewModel.loadingState == .loading {
                        ProgressView()
                            .frame(height: 50)
                    }
                }
        }.padding()
        .onAppear(perform: {
            viewModel.fetchMovies()
        })
    }
}

// MARK: - Helpers
private extension MoviesView {
    func shouldLoadMore(_ movie: MovieProviding) -> Bool {
        guard let lastMovie = viewModel.moviesPorvider.last else {
            return false
        }
        return movie.id == lastMovie.id
    }
}
