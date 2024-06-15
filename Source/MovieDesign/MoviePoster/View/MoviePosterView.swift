//
//  MoviePosterView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 20/9/2023.
//

import SwiftUI

struct MoviePosterView<Content: View>: View {
    private let viewModel: MoviePosterDisplayable
    private let imagePosterView: Content
    
    init(viewModel: MoviePosterDisplayable, imagePosterView: Content) {
        self.viewModel = viewModel
        self.imagePosterView = imagePosterView
    }
    
    var body: some View {
        VStack(spacing: 10) {
            imagePosterView
            Text(viewModel.title)
                .font(.headline)
                .multilineTextAlignment(.center)
            Text(viewModel.releaseDate)
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack {
                Image(systemName: viewModel.imageName)
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

#if DEBUG
#Preview {
    let viewModel = MoviePosterViewModel(
        movieProvider: Movie(),
        dateFormatter: MoviePosterDateFormatter(),
        voteFormatter: MoviePosterVoteFormatter()
    )
    return MoviePosterView(viewModel: viewModel, imagePosterView: EmptyView())
}

private struct Movie: MovieProviding {
    var id: Int = 0
    var title: String = "The Matrix"
    var imagePath: String = "/a.png"
    var releaseDate: Date = Date()
    var voteAverage: Double = 9.5
    var voteCount: Int = 5000
}
#endif
