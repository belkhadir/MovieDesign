//
//  ItemsPaginatedProviding.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 21/6/2024.
//

public protocol ItemsPaginatedProviding {
    associatedtype Item: Identifiable
    var items: [Item] { get }
    
    var page: Int { get }
    var totalPages: Int { get }
}
