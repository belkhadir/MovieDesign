//
//  MockMovieProvider.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 25/9/2023.
//

import Foundation
import MovieDesign

struct MockMovieProvider: MovieProviding, Equatable, Hashable {
    let id: Int
    let title: String
    let imagePath: String
    let releaseDate: Date
    let voteAverage: Double
    let voteCount: Int
    
    init(
        id: Int,
        title: String,
        imagePath: String,
        releaseDate: Date,
        voteAverage: Double,
        voteCount: Int
    ) {
        self.id = id
        self.title = title
        self.imagePath = imagePath
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    static func ==(lhs: MockMovieProvider, rhs: MockMovieProvider) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
