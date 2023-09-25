//
//  ConstructMoviePosterView.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 24/9/2023.
//

import SwiftUI

public final class ConstructMoviePosterView {
    public func constructView(movieProvider: MovieProviding, imagePosterView: @escaping ImagePosterView) -> some View {
        let viewModel = MoviePosterViewModel(movieProvider: movieProvider)
        let view = MoviePosterView(viewModel: viewModel, imagePosterView: imagePosterView)
        return view
    }
}
