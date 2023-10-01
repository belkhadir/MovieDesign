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
        paginationManager: PaginationManaging,
        imageResourceService: @escaping (MovieProviding
        ) -> ImageResourceService) -> some View {
        
        let viewModel = MoviesViewModel(service: service, paginationManager: paginationManager)
        return MoviesView(viewModel: viewModel, imageResourceService: imageResourceService)
    }
}
