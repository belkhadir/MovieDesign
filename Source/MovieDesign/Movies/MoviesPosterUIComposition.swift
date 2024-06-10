//
//  MoviesPaginatedUIComposition.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

import SwiftUI
import ImageResourceAPI

public final class MoviesPosterUIComposition<Service: ImageResourceServiceProviding> {
    public static func construcView(dependencies: DependencyContainer<Service>) -> some View {
        let viewModel = MoviesViewModel(service: dependencies.movieService, paginationManager: dependencies.paginationManager)
        let errorView = GenericErrorView(configuration: dependencies.genericErrorViewConfiguration)
        let view = MoviesView(
            viewModel: viewModel,
            imageResourceServiceProvider: dependencies.imageResourceServiceProvider,
            selectedMovie: dependencies.selectedMovie,
            errorView: errorView
        )
        return view
    }
}
