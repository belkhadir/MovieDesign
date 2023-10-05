//
//  DependencyContainer.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 5/10/2023.
//

public struct DependencyContainer {
    public let movieService: MovieResourceService
    public let movieCache: MoviesPaginationCaching
    public let imageResourceService: (MovieProviding) -> ImageResourceService
    public let selectedMovie: (MovieProviding) -> Void
    
    public init(
        movieService: MovieResourceService,
        movieCache: MoviesPaginationCaching,
        imageResourceService: @escaping (MovieProviding) -> ImageResourceService,
        selectedMovieAction: @escaping (MovieProviding) -> Void
    ) {
        self.movieService = movieService
        self.movieCache = movieCache
        self.imageResourceService = imageResourceService
        self.selectedMovie = selectedMovieAction
    }
}
