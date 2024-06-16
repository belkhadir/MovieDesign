//
//  PaginationManaging.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 1/10/2023.
//

public protocol PaginationManaging {
    func currentPage() async -> Int
    func setTotalPages(_ totalPages: Int) async
    func canLoadMore() async -> Bool
    func incrementPage() async
}
