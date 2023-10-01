//
//  PaginatedGridView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 21/9/2023.
//

import SwiftUI

struct MoviesView<ViewModel: MoviesDiplayable & ObservableObject>: View {
    @ObservedObject private var moviesviewModel: ViewModel
    private let imageResourceService: (MovieProviding) -> ImageResourceService
    
    init(moviesviewModel: ViewModel, imageResourceService: @escaping (MovieProviding) -> ImageResourceService) {
        self.moviesviewModel = moviesviewModel
        self.imageResourceService = imageResourceService
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(repeating: .init(.flexible()), count: 2),
                spacing: 20) {
                    ForEach(moviesviewModel.moviesPorvider, id: \.id) { movie in
                        AnyView(MoviePosterUIComposition
                            .constructView(
                                movieProvider: movie, 
                                imageResourceService: imageResourceService(movie)
                            ))
                            .aspectRatio(0.75, contentMode: .fit)
                            .onAppear(perform: {
//                                if shouldLoadMore(movie) {
//                                    moviesviewModel.loadMoreMovies()
//                                }
                            })
                    }
                }
        }.padding()
        .onAppear(perform: {
            moviesviewModel.fetchMovies()
        })
    }
}

// MARK: - Helpers
private extension MoviesView {
    func shouldLoadMore(_ movie: MovieProviding) -> Bool {
        guard let lastMovie = moviesviewModel.moviesPorvider.last else {
            return false
        }
        return movie.id == lastMovie.id
    }
}
