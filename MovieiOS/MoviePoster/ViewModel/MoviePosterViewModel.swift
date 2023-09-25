//
//  MoviePosterViewModel.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 21/9/2023.
//

import Foundation

protocol MoviePosterDisplayable {
    var title: String { get }
    var releaseDate: String { get }
    var vote: String { get }
}

final class MoviePosterViewModel {
    private let movieProvider: MovieProviding
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    init(movieProvider: MovieProviding) {
        self.movieProvider = movieProvider
    }
    
    var title: String {
        movieProvider.title.capitalized
    }
    
    var releaseDate: String {
        dateFormatter.string(from: movieProvider.releaseDate)
    }
    
    var vote: String {
        "\(String(format: "%.1f", movieProvider.voteAverage)) (\(movieProvider.voteCount) votes)"
    }
}

// MARK: - MoviePosterDisplayable
extension MoviePosterViewModel: MoviePosterDisplayable {}
