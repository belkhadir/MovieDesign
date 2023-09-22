//
//  MovieGridView.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 21/9/2023.
//

import SwiftUI
import MovieCore

public struct MovieGridView: View {
    private let moviesPosterView: [MoviePosterView]
    
    public init(moviesPosterView: [MoviePosterView]) {
        self.moviesPosterView = moviesPosterView
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(repeating: .init(.flexible()),
                               count: 2)
                , spacing: 20) {
                    ForEach(moviesPosterView, id: \.self) { moviePosterView in
                        moviePosterView
                        .aspectRatio(0.75, contentMode: .fit)
                    }
            }.padding()
        }
    }
}

struct MovieGridView_Previews: PreviewProvider {
    static var previews: some View {
        let date = Date()
        let movie1 = Movie(id: 1, title: "The Matrix", releaseDate: date, imagePath: "", overview: "", voteAverage: 9.5, voteCount: 5000)
        let movie2 = Movie(id: 2, title: "Foufou", releaseDate: date, imagePath: "", overview: "", voteAverage: 9.5, voteCount: 5000)
        let movie3 = Movie(id: 3, title: "X man", releaseDate: date, imagePath: "", overview: "", voteAverage: 9.5, voteCount: 5000)
        let movie4 = Movie(id: 4, title: "TGO GO", releaseDate: date, imagePath: "", overview: "", voteAverage: 9.5, voteCount: 5000)
        
        let viewModel1 = MoviePosterViewModel(movie: movie1)
        let moviePosterView1 = MoviePosterView(viewModel: viewModel1, imagePosterView: {
            AnyView(ImageView(data: Data()))
            }
        )
        
        let viewModel2 = MoviePosterViewModel(movie: movie2)
        let moviePosterView2 = MoviePosterView(viewModel: viewModel2, imagePosterView: {
                AnyView(ImageView(data: Data()))
            }
        )
        
        let viewModel3 = MoviePosterViewModel(movie: movie3)
        let moviePosterView3 = MoviePosterView(viewModel: viewModel3, imagePosterView: {
            AnyView(ImageView(data: Data()))
            }
        )
        
        let viewModel4 = MoviePosterViewModel(movie: movie4)
        let moviePosterView4 = MoviePosterView(viewModel: viewModel4, imagePosterView: {
                AnyView(ShimmerView())
            }
        )
        MovieGridView(moviesPosterView: [moviePosterView1, moviePosterView2, moviePosterView3, moviePosterView4])
    }
}
