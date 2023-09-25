//
//  MovieGridViewModel.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 24/9/2023.
//

import SwiftUI

protocol MovieGridDisplayable {
    var movies: [MovieProviding] { get }
    var imageData: Data { get }
    
    func loadMoreMovies()
}

class MovieGridViewModel: ObservableObject {
    private var currentPage: Int = 1
    let movies: [MovieProviding]
    
    init(movies: [MovieProviding]) {
        self.movies = movies
    }
    
    var imageData: Data {
        Data()
    }
}

extension MovieGridViewModel: MovieGridDisplayable {
    func loadMoreMovies() {
        
    }
}
