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
        await updateLoadingState(to: .loading)
        
        let page = await paginationManager.currentPage()
        service.retrieveResource(page: page) { [weak self] result in
            guard let self else { return }
            Task {
                switch result {
                case .success(let resource):
                    await self.paginationManager.setTotalPages(resource.totalPages)
                    await self.updateMovies(with: resource.moviesPorvider)
                    await self.updateLoadingState(to: .loaded)
                case .failure:
                    await self.updateLoadingState(to: .failed)
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

// MARK: - Helpers
private extension MoviesViewModel {
    @MainActor
    func updateMovies(with movies: [MovieProviding]) {
        self.moviesPorvider += movies
    }

    @MainActor
    func updateLoadingState(to state: LoadingState) {
        self.loadingState = state
    }
}
