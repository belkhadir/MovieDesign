//
//  MoviesDiscoveryDelegateMock.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 5/10/2023.
//

import Foundation
@testable import MovieDesign

class MoviesDiscoveryDelegateMock: MoviesDiscoveryDelegate {
    var lastSelectedCategory: MovieDiscovery?
    
    func didSelectCategory(_ category: MovieDiscovery) {
        lastSelectedCategory = category
    }
}
