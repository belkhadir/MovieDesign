//
//  MovieResourceServiceMock.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 5/10/2023.
//

import Foundation
import MovieDesign

final class MovieResourceServiceMock: MovieResourceService {
    var stubbedResult: Result<MoviesPaginatedProviding, Error>?
    
    // Intentionally create a property to retain the last closure
    var retainedClosure: ((Result<MoviesPaginatedProviding, Error>) -> Void)?
    
    func retrieveResource(page: Int, completion: @escaping (Result<MoviesPaginatedProviding, Error>) -> Void) {
        retainedClosure = completion
        if let stubbedResult {
            completion(stubbedResult)
        }
    }
}
