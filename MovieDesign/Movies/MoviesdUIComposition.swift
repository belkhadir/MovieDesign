//
//  MoviesPaginatedUIComposition.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

import SwiftUI

public final class MoviesdUIComposition {
    public static func construcView(
        service: some MovieResourceService,
        cache: MoviesPaginationCaching,
        imageResourceService: @escaping (MovieProviding) -> ImageResourceService,
        selectedMovie: @escaping (MovieProviding) -> Void
    ) -> some View {
        
        let viewModel = MoviesViewModel(
            service: service,
            cache: cache
        )
        let moviesDiscoveryViewModel = MoviesDiscoveryViewModel()
        return MoviesView(
            viewModel: viewModel, 
            movieDiscoveryViewModel: moviesDiscoveryViewModel,
            imageResourceService: imageResourceService,
            selectedMovie: selectedMovie
        )
    }
}
