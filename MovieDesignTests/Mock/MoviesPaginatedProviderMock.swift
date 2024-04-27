//
//  MoviesPaginatedProviderMock.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 9/10/2023.
//

import Foundation
import MovieDesign

struct MoviesPaginatedProviderMock: MoviesPaginatedProviding {
    let moviesProvider: [MovieProviding]
    let page: Int
    let totalPages: Int
    
    init(moviesProvider: [MovieProviding], page: Int, totalPages: Int) {
        self.moviesProvider = moviesProvider
        self.page = page
        self.totalPages = totalPages
    }
}
