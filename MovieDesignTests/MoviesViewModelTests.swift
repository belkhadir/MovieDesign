//
//  MoviesViewModelTests.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 5/10/2023.
//

import XCTest
@testable import MovieDesign

final class MoviesViewModelTests: XCTestCase {
    
    // 1. When fetched result with .success then setTotalpages invoked and status is laoding and moviesProvider being appended
    func testGIVENNoInitialMovies_WHEN_fetchMoviesSucceeds_THEN_LoadingStateIsLoaded() async {
        let (sut, service) = makeSUT()
        let movies = [movieDummy(), movieDummy()]
        service.stubbedResult = .success(moviesPaginatedDummy(moviesProvider: movies))

        await sut.fetchMovies()

        await MainActor.run {
            XCTAssertEqual(sut.loadingState, .loaded, "Failed to set loading state to loaded")
            movies.enumerated().forEach { index, movie in
                XCTAssertTrue(movie.isEqual(movie: sut.moviesProvider[index]))
            }
        }
    }

//    // 2. when fetched result with .failure then loadingState is failure
//    func test_GIVEN_noInitialMovies_WHEN_fetchMoviesFails_THEN_setLoadingStateToFailed() async {
//        // GIVEN
//        let (sut, service) = makeSUT()
//        service.stubbedResult = .failure(DummyError())
//
//        // WHEN
//        await sut.fetchMovies()
//
//        // THEN
//        XCTAssertTrue(sut.moviesProvider.isEmpty, "moviesProvider should be empty")
//        XCTAssertEqual(sut.loadingState, .failed, "Failed to set loading state to failed")
//    }
//    // 3. simulate loading more movies with result .success
//    func test_GIVEN_someMovies_WHEN_loadMoreMoviesSucceeds_THEN_appendMoreMoviesToProvider() async {
//        // GIVEN
//        let (sut, service) = makeSUT()
//        let initialMovies = [movieDummy()]
//        let moreMovies = [movieDummy(), movieDummy()]
//        sut.moviesProvider = initialMovies
//        service.stubbedResult = .success(moreMovies)
//
//        // WHEN
//        await sut.loadMoreMovies()
//
//        // THEN
//        XCTAssertEqual(sut.moviesProvider, initialMovies + moreMovies, "Failed to append more movies to moviesProvider")
//    }
//
//    // 4. simulate loading more movies with result .failure
//    func test_GIVEN_someMovies_WHEN_loadMoreMoviesFails_THEN_moviesProviderRemainsSameAndSetLoadingStateToFailed() async {
//        let anyError = NSError(domain: "any error", code: 1)
//        let (sut, service) = makeSUT()
//        let initialMovies = [movieDummy()]
//        sut.moviesProvider = initialMovies
//        service.stubbedResult = .failure(anyError)
//
//        // WHEN
//        await sut.loadMoreMovies()
//
//        // THEN
//        XCTAssertEqual(sut.moviesProvider, initialMovies, "moviesProvider should remain the same")
//        XCTAssertEqual(sut.loadingState, .failed, "Failed to set loading state to failed")
//    }

    // 5. when didSelectCategory invoked fetch specific result with .success with category
}

// MARK: - Helpers
private extension MoviesViewModelTests {
    func makeSUT(
        imageResourceService: @escaping (MovieProviding) -> ImageResourceService = { _ in return ImageResourceServiceMock()},
        selectedMovieAction: @escaping (MovieProviding) -> Void = { _ in }
    ) -> (sut: MoviesViewModel, service: MovieResourceServiceMock) {
        let mockMovieService = MovieResourceServiceMock()
        let mockManagerPagination = PaginationManagerMock()
        let cache = MoviesPaginationCache(paginationManager: mockManagerPagination)
        let dependencies = DependencyContainer(
            movieService: mockMovieService,
            movieCache: cache,
            imageResourceService: { imageResourceService($0) },
            selectedMovieAction: { selectedMovieAction($0) }
        )
        let sut = MoviesViewModel(dependencies: dependencies)
        trackForMemoryLeaks(mockMovieService)
        trackForMemoryLeaks(mockManagerPagination)
        trackForMemoryLeaks(cache)
        trackForMemoryLeaks(sut)
        return (sut, mockMovieService)
    }
    
    func movieDummy() -> MovieProviding {
        MockMovieProvider(id: 0, title: "A title", imagePath: "An image", releaseDate: Date(), voteAverage: 1, voteCount: 1)
    }
    
    func moviesPaginatedDummy(
        moviesProvider: [MovieProviding] = [],
        page: Int = 0,
        totalPages: Int = 0
    ) -> MoviesPaginatedProviding {
        MoviesPaginatedProviderMock(
            moviesProvider: moviesProvider,
            page: page,
            totalPages: totalPages
        )
    }
}

private extension MovieProviding {
    func isEqual(movie: MovieProviding) -> Bool {
        id == movie.id
    }
}
