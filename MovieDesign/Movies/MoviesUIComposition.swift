//
//  MoviesPaginatedUIComposition.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

import SwiftUI

public final class MoviesUIComposition {
    public static func construcView(dependencies: DependencyContainer) -> some View {
        
        let viewModel = MoviesViewModel(dependencies: dependencies)
        return MoviesView(
            viewModel: viewModel,
            imageResourceService: dependencies.imageResourceService,
            selectedMovie: dependencies.selectedMovie
        )
    }
}
