//
//  MoviePosterComposition.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 26/9/2023.
//

import SwiftUI

public final class MoviePosterUIComposition {
    public func constructView(movieProvider: MovieProviding, imageResourceService: some ImageResourceService) -> some View {
        let moviePosterViewModel = MoviePosterViewModel(movieProvider: movieProvider)
        let imageViewModel = ImageViewModel(service: imageResourceService)
        let imageView = ImageView(viewModel: imageViewModel)
        return MoviePosterView(viewModel: moviePosterViewModel, imagePosterView: imageView)
    }
}
