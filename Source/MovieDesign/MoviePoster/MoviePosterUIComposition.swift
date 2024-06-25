//
//  MoviePosterUIComposition.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 5/6/2024.
//

import ImageResourceAPI
import SwiftUI

final public class MoviePosterUIComposition<Service: ImageResourceServiceProviding> {
    static public func constructView(
        movieProvider: MovieProviding,
        imageServiceProvider: Service
    ) -> some View {
        let viewModel = MoviePosterViewModel(
            movieProvider: movieProvider,
            dateFormatter: MoviePosterDateFormatter(),
            voteFormatter: MoviePosterVoteFormatter()
        )
        let view = MoviePosterView(viewModel: viewModel, imagePosterView: imageServiceProvider.imageView())
        return view
    }
}
