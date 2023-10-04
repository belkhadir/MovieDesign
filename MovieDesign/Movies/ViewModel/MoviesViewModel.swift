//
//  MoviesViewModel.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

import Foundation

protocol MoviesDisplaying {
    var moviesProvider: [MovieDiscovery: [MovieProviding]] { get }
    var loadingState: LoadingState { get }
    var movieDiscovery: MovieDiscovery { get }
    
    func refreshMovies() async
    func fetchMoreMovies() async
    func selectMovieCategory(at index: Int) async
}

final class MoviesViewModel<Service: MovieResourceService>: ObservableObject  {
    @Published private(set) var moviesProvider: [MovieDiscovery: [MovieProviding]] = [:]
    @Published private(set) var loadingState: LoadingState = .none
    @Published private(set) var movieDiscovery: MovieDiscovery = .popular
    
    private let service: Service
    private let cache: MoviesPaginationCaching
    
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
        guard await canLoadMoreMovies() else { return }
        await loadMovies()
    }
    
    func selectMovieCategory(at index: Int) async {
        movieDiscovery = MovieDiscovery(rawValue: index) ?? .popular
        await loadMovies()
    }
}

// MARK: - Private Helpers
private extension MoviesViewModel {
    func canLoadMoreMovies() async -> Bool {
        guard loadingState != .loading,
              let paginationManager = cache.getPaginationManager(for: movieDiscovery),
              await paginationManager.canLoadMore(),
              !cache.isPageLoaded(for: movieDiscovery)
        else { return false }
        
        await paginationManager.incrementPage()
        return true
    }
    
    func loadMovies() async {
        await updateLoadingState(to: .loading)
        
        let currentPage = await cache.getPaginationManager(for: movieDiscovery)?.currentPage() ?? 1
        service.retrieveResource(movieDiscovery: movieDiscovery, page: currentPage) { [weak self] result in
            guard let self = self else { return }
            Task {
                await self.handleServiceResult(result)
            }
        }
    }
    
    func handleServiceResult(_ result: Result<MoviesPaginatedProviding, Error>) async {
        // Replace `ResourceType` with the actual type returned in the service call.
        switch result {
        case .success(let resource):
            if let paginationManager = cache.getPaginationManager(for: movieDiscovery) {
                await paginationManager.setTotalPages(resource.totalPages)
            }
            await appendMovies(for: movieDiscovery, with: resource.moviesProvider)
            await updateLoadingState(to: .loaded)
        case .failure(let error):
            await handleServiceError(error)
        }
        cache.markPageAsLoaded(for: movieDiscovery)
    }
    
    func handleServiceError(_ error: Error) async {
        // Implement specific error handling here.
        await updateLoadingState(to: .failed)
    }
    
    @MainActor
    func appendMovies(for discovery: MovieDiscovery, with movies: [MovieProviding]) {
        if var existingMovies = moviesProvider[discovery] {
            existingMovies += movies
            moviesProvider[discovery] = existingMovies
        } else {
            moviesProvider[discovery] = movies
        }
    }

    @MainActor
    func updateLoadingState(to state: LoadingState) {
        loadingState = state
    }
}

