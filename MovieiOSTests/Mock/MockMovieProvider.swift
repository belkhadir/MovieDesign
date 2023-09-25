//
//  MockMovieProvider.swift
//  MovieiOSTests
//
//  Created by Belkhadir Anas on 25/9/2023.
//

import Foundation
import MovieiOS

struct MockMovieProvider: MovieProviding {
    let id: Int
    let title: String
    let releaseDate: Date
    let voteAverage: Double
    let voteCount: Int
    
    init(id: Int, title: String, releaseDate: Date, voteAverage: Double, voteCount: Int) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
