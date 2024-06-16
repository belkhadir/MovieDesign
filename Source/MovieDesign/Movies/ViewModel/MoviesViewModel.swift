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
    
    func shouldDisplayOverlay() -> Bool
    func fetchMovies() async
    func loadMoreMovies() async
}

final class MoviesViewModel: ObservableObject  {
    @Published private(set) var moviesProvider: [MovieProviding] = []
    @Published private(set) var loadingState: LoadingState = .none
    
    private let service: MovieResourceService
    private let paginationManager: PaginationManaging
    
    
    init(service: MovieResourceService, paginationManager: PaginationManaging) {
        self.service = service
        self.paginationManager = paginationManager
    }
}

// MARK: - MoviesDisplaying
extension MoviesViewModel: MoviesDisplayable {
    func shouldDisplayOverlay() -> Bool {
        loadingState != .loading && moviesProvider.isEmpty
    }
    
    func loadMoreMovies() async {
        guard await paginationManager.canLoadMore() else { return }
        await fetchMovies()
    }
    
    func fetchMovies() async {
        guard loadingState != .loading else {
            return
        }

        await updateLoadingState(to: .loading)

        do {
            await paginationManager.incrementPage()
            
            let resource = try await service.retrieveResource(
                page: paginationManager.currentPage()
            )
            await paginationManager.setTotalPages(resource.totalPages)
            await appendMovies(resource.moviesProvider)
            await updateLoadingState(to: .loaded)
        } catch {
            await updateLoadingState(to: .failed)
            print("Failed to fetch movies: \(error)")
        }
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
