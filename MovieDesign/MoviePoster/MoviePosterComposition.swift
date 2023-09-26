//
//  MoviePosterComposition.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 26/9/2023.
//

import SwiftUI

public final class MoviePosterUIComposition {
    public func constructView(movieProvider: MovieProviding, imagePosterView: some View) -> some View {
        let viewModel = MoviePosterViewModel(movieProvider: movieProvider)
        return MoviePosterView(viewModel: viewModel, imagePosterView: imagePosterView)
    }
}
