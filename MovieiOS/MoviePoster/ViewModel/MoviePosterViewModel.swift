//
//  MoviePosterViewModel.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 21/9/2023.
//

import Foundation
import MovieCore

public final class MoviePosterViewModel {
    private let movie: Movie
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    public init(movie: Movie) {
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
    public static func == (lhs: MoviePosterViewModel, rhs: MoviePosterViewModel) -> Bool {
        lhs.movie.id == rhs.movie.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(movie.id)
    }
}
