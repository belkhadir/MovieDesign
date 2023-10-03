//
//  MoviesViewModel.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

import Foundation

protocol MoviesDisplaying {
    var moviesProvider: [MovieProviding] { get }
    var loadingState: LoadingState { get }
    
    func refreshMovies() async
    func fetchMoreMovies() async
    func selectMovieCategory(at index: Int) async
}

final class MoviesViewModel<Service: MovieResourceService>: ObservableObject  {
    @Published private(set) var moviesProvider: [MovieProviding] = []
    @Published private(set) var loadingState: LoadingState = .none
    
    private let service: Service
    private let cache: MoviesPaginationCaching
    private var movieDiscovery: MovieDiscovery = .popular
    
    init(service: Service, cache: MoviesPaginationCaching) {
        self.service = service
        self.cache = cache
    }
}

// MARK: - MoviesDisplaying
extension MoviesViewModel: MoviesDisplaying {
    func refreshMovies() async {
        await selectMovieCategory(at: movieDiscovery.rawValue)
    }
    
    func fetchMoreMovies() async {
        guard loadingState != .loading, let paginationManager = cache.getPaginationManager(for: movieDiscovery) else {
            return
        }

        guard await paginationManager.canLoadMore(), !cache.isPageLoaded(for: movieDiscovery) else {
            return
        }

        await paginationManager.incrementPage()
        await loadMovies()
    }
    
    func selectMovieCategory(at index: Int) async {
        movieDiscovery = MovieDiscovery(rawValue: index) ?? .popular
        moviesProvider.removeAll()
        await loadMovies()
    }
}

// MARK: - Private Helpers
private extension MoviesViewModel {
    func loadMovies() async {
        guard loadingState != .loading, let paginationManager = cache.getPaginationManager(for: movieDiscovery) else {
            return
        }
        
        await updateLoadingState(to: .loading)
        
        let currentPage = await paginationManager.currentPage()
        service.retrieveResource(movieDiscovery: movieDiscovery, page: currentPage) { [weak self] result in
            guard let self = self else { return }
            Task {
                switch result {
                case .success(let resource):
                    await paginationManager.setTotalPages(resource.totalPages)
                    await self.appendMovies(resource.moviesProvider)
                    await self.updateLoadingState(to: .loaded)
                case .failure:
                    await self.updateLoadingState(to: .failed)
                }
                self.cache.markPageAsLoaded(for: self.movieDiscovery)
            }
        }
    }
    
    @MainActor
    func appendMovies(_ movies: [MovieProviding]) {
        moviesProvider += movies
    }

    @MainActor
    func updateLoadingState(to state: LoadingState) {
        loadingState = state
    }
}
