//
//  MoviesViewModel.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

import Foundation

protocol MoviesDiplayable {
    var movies: [MovieProviding] { get }
    var loadingState: LoadingState { get }
    
    func fetchMovies()
    func loadMoreMovies()
}

final class MoviesViewModel<ResourceProvider: MovieResourceService>: ObservableObject  {
    @Published private(set) var movies: [MovieProviding] = []
    @Published private(set) var loadingState: LoadingState = .loading
    
    private var currentPage = 1
    private var totalPages = 1
    
    private let service: ResourceProvider
    
    init(service: ResourceProvider) {
        self.service = service
    }
}

// MARK: - MoviesDiplayable
extension MoviesViewModel: MoviesDiplayable {
    func fetchMovies() {
        loadingState = .loading
        service.retrieveResource(page: currentPage) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let resource):
                currentPage = resource.page
                totalPages = resource.totalPages
                movies += resource.items
                loadingState = .loaded
            case .failure:
                loadingState = .failed
            }
        }
    }
    
    func loadMoreMovies() {
        if currentPage <= totalPages {
            currentPage += 1
            fetchMovies()
        }
    }
}
