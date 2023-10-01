//
//  MoviesViewModel.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

import Foundation

protocol MoviesDiplayable {
    var moviesPorvider: [MovieProviding] { get }
    var loadingState: LoadingState { get }
    
    func fetchMovies()
    func loadMoreMovies()
}

final class MoviesViewModel<ResourceProvider: MovieResourceService>: ObservableObject  {
    @Published private(set) var moviesPorvider: [MovieProviding] = []
    @Published private(set) var loadingState: LoadingState = .none
    
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
        guard loadingState != .loading else { return }
        loadingState = .loading
        service.retrieveResource(page: currentPage) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let resource):
                currentPage = resource.page
                totalPages = resource.totalPages
                moviesPorvider += resource.moviesPorvider.filter { newMovie in
                    !self.moviesPorvider.contains { $0.id == newMovie.id }
                }
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
