//
//  MoviesPaginatedUIComposition.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

import SwiftUI

public final class MoviesdUIComposition {
    public func construcView(service: some MovieResourceService, imageResourceService: @escaping (MovieProviding) -> ImageResourceService) -> some View {
        let viewModel = MoviesViewModel(service: service)
        return MoviesView(moviesviewModel: viewModel, imageResourceService: imageResourceService)
    }
}
