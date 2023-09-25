//
//  MoviePosterView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 20/9/2023.
//

import SwiftUI

public struct MoviePosterView<ImagePosterView>: View where ImagePosterView: View {
    private let viewModel: MoviePosterDisplayable
    private let imagePosterView: () -> ImagePosterView
    
    public init(viewModel: MoviePosterDisplayable, imagePosterView: @escaping () -> ImagePosterView) {
        self.viewModel = viewModel
        self.imagePosterView = imagePosterView
    }
    
    public var body: some View {
        VStack(spacing: 10) {
            imagePosterView()
            Text(viewModel.title)
                .font(.headline)
                .multilineTextAlignment(.center)
            Text(viewModel.releaseDate)
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: 15, height: 15)
                Text(viewModel.vote)
                    .font(.caption)
            }
        }
        .padding()
    }
}

struct MoviePosterView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MoviePosterViewModel(movieProvider: Movie())
        MoviePosterView(viewModel: viewModel, imagePosterView: {
                AnyView(ShimmerView())
            }
        )
    }
    
    private struct Movie: MovieProviding {
        var id: Int = 0
        var title: String = "The Matrix"
        var releaseDate: Date = Date()
        var voteAverage: Double = 9.5
        var voteCount: Int = 5000
    }
}
