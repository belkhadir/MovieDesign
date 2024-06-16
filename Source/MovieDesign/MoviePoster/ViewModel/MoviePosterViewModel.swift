//
//  MoviePosterViewModel.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 21/9/2023.
//

import Foundation

protocol MoviePosterDisplayable {
    var title: String { get }
    var releaseDate: String { get }
    var imageName: String { get }
    var vote: String { get }
}

final class MoviePosterViewModel {
    private let movieProvider: MovieProviding
    private let dateFormatter: DateFormatting
    private let voteFormatter: VoteFormatting
    
    init(
        movieProvider: MovieProviding,
        dateFormatter: DateFormatting,
        voteFormatter: VoteFormatting
    ) {
        self.movieProvider = movieProvider
        self.dateFormatter = dateFormatter
        self.voteFormatter = voteFormatter
    }
    
    var title: String {
        movieProvider.title.capitalized
    }
    
    var releaseDate: String {
        dateFormatter.format(date: movieProvider.releaseDate)
    }
    
    var imageName: String {
        "star.fill"
    }
    
    var vote: String {
        voteFormatter.formatte(voteAverage: movieProvider.voteAverage, totalVote: movieProvider.voteCount)
    }
}

// MARK: - MoviePosterDisplayable
extension MoviePosterViewModel: MoviePosterDisplayable {}
