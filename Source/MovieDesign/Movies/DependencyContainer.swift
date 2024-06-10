//
//  DependencyContainer.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 5/10/2023.
//

import ImageResourceAPI

public struct DependencyContainer<Service: ImageResourceServiceProviding> {
    public let movieService: MovieResourceService
    public let paginationManager: PaginationManaging
    public let genericErrorViewConfiguration: GenericErrorViewConfigurable
    public let imageResourceServiceProvider: (MovieProviding) -> Service
    public let selectedMovie: (MovieProviding) -> Void
    
    public init(
        movieService: MovieResourceService,
        paginationManager: PaginationManaging,
        genericErrorViewConfiguration: GenericErrorViewConfigurable,
        imageResourceServiceProvider: @escaping (MovieProviding) -> Service,
        selectedMovieAction: @escaping (MovieProviding) -> Void
    ) {
        self.movieService = movieService
        self.paginationManager = paginationManager
        self.genericErrorViewConfiguration = genericErrorViewConfiguration
        self.imageResourceServiceProvider = imageResourceServiceProvider
        self.selectedMovie = selectedMovieAction
    }
}
