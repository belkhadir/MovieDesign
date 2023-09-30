//
//  ImageResourceService.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

public protocol ImageResourceService {
    typealias Result = Swift.Result<ImageProviding, Error>
    
    func retriveResouce(completion: @escaping (Result) -> Void)
}
