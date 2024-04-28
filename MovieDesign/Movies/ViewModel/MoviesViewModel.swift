//
//  MoviesViewModel.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

import Foundation

protocol MoviesDisplayable {
    var moviesProvider: [MovieProviding] { get }
    var loadingState: LoadingState { get }
    
    func fetchMovies() async
    func loadMoreMovies() async
}

final class MoviesViewModel: ObservableObject  {
    @Published private(set) var moviesProvider: [MovieProviding] = []
    @Published private(set) var loadingState: LoadingState = .none
    
    private let service: MovieResourceService
    private var movieDiscovery: MovieDiscovery = .popular // AS default Category
    private let cache: PaginationManaging?
    
    init(dependencies: DependencyContainer) {
        self.service = dependencies.movieService
        self.cache = dependencies.movieCache.getPaginationManager(for: movieDiscovery)
    }
}

// MARK: - MoviesDisplaying
extension MoviesViewModel: MoviesDisplayable {
    func fetchMovies() async {
        guard loadingState != .loading,
              let cache,
              await cache.canLoadMore() else {
            return
        }

        await updateLoadingState(to: .loading)
        let currentPage = await cache.currentPage()

        do {
            let resource = try await service.retrieveResource(movieDiscovery: movieDiscovery, page: currentPage)
            await cache.setTotalPages(resource.totalPages)
            await appendMovies(resource.moviesProvider)
            await updateLoadingState(to: .loaded)
        } catch {
            await updateLoadingState(to: .failed)
            print("Failed to fetch movies: \(error)")
        }
    }
    
    func loadMoreMovies() async {
        guard let cache else { return }
        await cache.incrementPage()
        guard await cache.canLoadMore() else { return }
        await fetchMovies()
    }
}

// MARK: - MoviesDiscoveryDelegate
extension MoviesViewModel: MoviesDiscoveryDelegate {
    func didSelectCategory(_ category: MovieDiscovery) {
        movieDiscovery = category
    }
}

// MARK: - Private Helpers
private extension MoviesViewModel {
    @MainActor
    func appendMovies(_ movies: [MovieProviding]) {
        moviesProvider += movies
    }

    @MainActor
    func updateLoadingState(to state: LoadingState) {
        loadingState = state
    }
}
