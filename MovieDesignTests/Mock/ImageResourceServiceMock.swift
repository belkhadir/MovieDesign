//
//  ImageResourceServiceMock.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 5/10/2023.
//

import Foundation
import MovieDesign

final class ImageResourceServiceMock: ImageResourceService {
    var stubbedResult: Result<ImageProviding, Error>?
    
    // Intentionally create a property to retain the last closure
    var retainedClosure: ((Result<ImageProviding, Error>) -> Void)?
    
    func retriveResouce(completion: @escaping (Result<ImageProviding, Error>) -> Void) {
        retainedClosure = completion
        if let result = stubbedResult {
            completion(result)
        }
    }
}
