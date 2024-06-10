//
//  MovieResourceService.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

public protocol MovieResourceService {
    typealias Result = Swift.Result<MoviesPaginatedProviding, Error>
    
    func retrieveResource(page: Int, completion: @escaping (Result) -> Void)
}

extension MovieResourceService {
    func retrieveResource(page: Int) async throws -> MoviesPaginatedProviding {
        return try await withCheckedThrowingContinuation { continuation in
            retrieveResource(page: page) { result in
                switch result {
                case .success(let movies):
                    continuation.resume(returning: movies)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
