//
//  ItemResourceService.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 20/6/2024.
//


public protocol ItemResourceService {
    associatedtype ItemsPaginatedProvider: ItemsPaginatedProviding
    typealias Result = Swift.Result<ItemsPaginatedProvider, Error>
    
    func retrieveResource(page: Int, completion: @escaping (Result) -> Void)
}

extension ItemResourceService {
    func retrieveResource(page: Int) async throws -> ItemsPaginatedProvider {
        return try await withCheckedThrowingContinuation { continuation in
            retrieveResource(page: page) { result in
                switch result {
                case .success(let items):
                    continuation.resume(returning: items)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
