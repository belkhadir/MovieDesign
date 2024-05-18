//
//  DependencyContainer.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 5/10/2023.
//

public struct DependencyContainer {
    public let movieService: MovieResourceService
    public let movieDiscovery: MovieDiscovery
    public let paginationManager: PaginationManaging
    public let genericErrorViewConfiguration: GenericErrorViewConfiguration
    public let imageResourceService: (MovieProviding) -> ImageResourceService
    public let selectedMovie: (MovieProviding) -> Void
    
    public init(
        movieService: MovieResourceService,
        movieDiscovery: MovieDiscovery,
        paginationManager: PaginationManaging,
        genericErrorViewConfiguration: GenericErrorViewConfiguration,
        imageResourceService: @escaping (MovieProviding) -> ImageResourceService,
        selectedMovieAction: @escaping (MovieProviding) -> Void
    ) {
        self.movieService = movieService
        self.movieDiscovery = movieDiscovery
        self.paginationManager = paginationManager
        self.genericErrorViewConfiguration = genericErrorViewConfiguration
        self.imageResourceService = imageResourceService
        self.selectedMovie = selectedMovieAction
    }
}
