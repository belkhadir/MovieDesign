//
//  MoviesPaginatedProviding.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

public protocol MoviesPaginatedProviding {
    var moviesPorvider: [MovieProviding] { get }
    
    var page: Int { get }
    var totalPages: Int { get }
}
