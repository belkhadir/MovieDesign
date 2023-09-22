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
        
        MovieGridView(moviesPosterView:   [movie1, movie2, movie3, movie4].map { movie in
            let movieViewModel = MoviePosterViewModel(movie: movie)
            return  MoviePosterView(viewModel: movieViewModel, imagePosterView: {
                AnyView(ImageView(data: Data()))
                }
            )
        })
    }
}
