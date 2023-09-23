//
//  MoviePosterView.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 20/9/2023.
//

import SwiftUI
import MovieCore

public struct MoviePosterView: View {
    public typealias ImagePosterView = () -> AnyView
    private let viewModel: MoviePosterViewModel
    private let imagePosterView: ImagePosterView
    
    public init(viewModel: MoviePosterViewModel, imagePosterView: @escaping ImagePosterView) {
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

// MARK: - Extension+Hashable
extension MoviePosterView: Hashable {
    public static func == (lhs: MoviePosterView, rhs: MoviePosterView) -> Bool {
        lhs.viewModel == rhs.viewModel
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(viewModel)
    }
}

struct MoviePosterView_Previews: PreviewProvider {
    static var previews: some View {
        let date = Date()
        let movie = Movie(id: 0, title: "The Matrix", releaseDate: date, imagePath: "", overview: "", voteAverage: 9.5, voteCount: 5000)
        let viewModel = MoviePosterViewModel(movie: movie)
        MoviePosterView(viewModel: viewModel, imagePosterView: {
                AnyView(ShimmerView())
            }
        )
    }
}
