//
//  MoviePosterViewModel.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 21/9/2023.
//

import Foundation
import MovieCore

final class MoviePosterViewModel {
    private let movie: Movie
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var releaseDate: String {
        dateFormatter.string(from: movie.releaseDate)
    }
    
    var title: String {
        movie.title.capitalized
    }
    
    var vote: String {
        "\(String(format: "%.1f", movie.voteAverage)) (\(movie.voteCount) votes)"
    }
}

extension MoviePosterViewModel: Hashable {
    static func == (lhs: MoviePosterViewModel, rhs: MoviePosterViewModel) -> Bool {
        lhs.movie.id == rhs.movie.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(movie.id)
    }
}
