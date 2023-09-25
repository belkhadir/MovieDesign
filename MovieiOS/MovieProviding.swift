//
//  MovieProviding.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 24/9/2023.
//

import Foundation

public protocol MovieProviding {
    var id: Int { get }
    var title: String { get }
    var releaseDate: Date { get }
    var voteAverage: Double { get }
    var voteCount: Int { get }
}
