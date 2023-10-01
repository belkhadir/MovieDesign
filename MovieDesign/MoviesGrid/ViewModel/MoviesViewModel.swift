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
    
    func fetchMovies() async
    func loadMoreMovies() async
}

final class MoviesViewModel<ResourceProvider: MovieResourceService>: ObservableObject  {
    @Published private(set) var moviesPorvider: [MovieProviding] = []
    @Published private(set) var loadingState: LoadingState = .none
    
    private let service: ResourceProvider
    private let paginationManager: PaginationManaging
    
    init(service: ResourceProvider, paginationManager: PaginationManaging) {
        self.service = service
        self.paginationManager = paginationManager
    }
}

// MARK: - MoviesDiplayable
extension MoviesViewModel: MoviesDiplayable {
    func fetchMovies() async {
        guard loadingState != .loading else { return }
        loadingState = .loading
        
        let page = await paginationManager.currentPage()
        service.retrieveResource(page: page) { [weak self] result in
            guard let self else { return }
            Task {
                switch result {
                case .success(let resource):
                    await self.paginationManager.setTotalPages(resource.totalPages)
                    self.moviesPorvider += resource.moviesPorvider
                    self.loadingState = .loaded
                case .failure:
                    self.loadingState = .failed
                }
            }
        }
    }
    
    func loadMoreMovies() async {
        let canLoad = await paginationManager.canLoadMore()
        if canLoad {
            await paginationManager.incrementPage()
            await fetchMovies()
        }
    }
}
