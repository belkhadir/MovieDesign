//
//  MovieResourceService.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

public protocol MovieResourceService {
    typealias Result = Swift.Result<MoviesPaginatedProviding, Error>
    
    func retrieveResource(movieDiscovery: MovieDiscovery, page: Int, completion: @escaping (Result) -> Void)
}
