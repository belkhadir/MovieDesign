//
//  MockMovieProvider.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 25/9/2023.
//

import Foundation
import MovieDesign

struct MockMovieProvider: MovieProviding {
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
}
