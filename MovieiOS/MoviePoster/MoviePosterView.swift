//
//  MoviePosterView.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 20/9/2023.
//

import SwiftUI
import MovieCore

struct MoviePosterView: View {
    typealias ImagePosterView = () -> AnyView
    private let viewModel: MoviePosterViewModel
    private let imagePosterView: ImagePosterView
    
    init(viewModel: MoviePosterViewModel, imagePosterView: @escaping ImagePosterView) {
        self.viewModel = viewModel
        self.imagePosterView = imagePosterView
    }
    
    var body: some View {
        VStack(spacing: 10) {
            imagePosterView()
                .frame(width: 100, height: 200)

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

extension MoviePosterView: Hashable {
    static func == (lhs: MoviePosterView, rhs: MoviePosterView) -> Bool {
        lhs.viewModel == rhs.viewModel
    }
    
    func hash(into hasher: inout Hasher) {
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
