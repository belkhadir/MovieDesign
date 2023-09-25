//
//  MoviePosterViewModel.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 21/9/2023.
//

import Foundation

public protocol MoviePosterDisplayable {
    var title: String { get }
    var releaseDate: String { get }
    var vote: String { get }
}

public final class MoviePosterViewModel {
    private let movieProvider: MovieProviding
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    public init(movieProvider: MovieProviding) {
        self.movieProvider = movieProvider
    }
    
    public var title: String {
        movieProvider.title.capitalized
    }
    
    public var releaseDate: String {
        dateFormatter.string(from: movieProvider.releaseDate)
    }
    
    public var vote: String {
        "\(String(format: "%.1f", movieProvider.voteAverage)) (\(movieProvider.voteCount) votes)"
    }
}

// MARK: - MoviePosterDisplayable
extension MoviePosterViewModel: MoviePosterDisplayable {}
