//
//  MoviesViewModelTests.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 5/10/2023.
//

import XCTest
@testable import MovieDesign

final class MoviesViewModelTests: XCTestCase {
    func testGIVENNoInitialMovies_WHEN_fetchMoviesSucceeds_THEN_LoadingStateIsLoaded() async {
        let (sut, service) = makeSUT()
        let movies = [movieDummy(), movieDummy()]
        service.stubbedResult = .success(moviesPaginatedDummy(moviesProvider: movies))

        await sut.fetchMovies()

        XCTAssertEqual(sut.loadingState, .loaded, "Failed to set loading state to loaded")
        movies.enumerated().forEach { index, movie in
            XCTAssertTrue(movie.isEqual(movie: sut.moviesProvider[index]))
        }
    }

    func test_GIVEN_noInitialMovies_WHEN_fetchMoviesFails_THEN_setLoadingStateToFailed() async {
        let (sut, service) = makeSUT()
        service.stubbedResult = .failure(anyError())
        
        await sut.fetchMovies()
        
        XCTAssertTrue(sut.moviesProvider.isEmpty, "moviesProvider should be empty")
        XCTAssertEqual(sut.loadingState, .failed, "Failed to set loading state to failed")
    }
    
    func test_GIVEN_someMovies_WHEN_loadMoreMoviesSucceeds_THEN_appendMoreMoviesToProvider() async {
        let paginationManagerMock = PaginationManagerMock()
        let (sut, service) = makeSUT(mockManagerPagination: paginationManagerMock)
        let initialMovies = [movieDummy()]
    
        service.stubbedResult = .success(moviesPaginatedDummy(moviesProvider: initialMovies))
        
        await sut.fetchMovies()
        
        // Second Page
        paginationManagerMock.sttubedCanLoadMoreResult = true
        let secondPageMovies = [movieDummy(title: "Second page film")]
        service.stubbedResult = .success(moviesPaginatedDummy(moviesProvider: secondPageMovies))
        await sut.loadMoreMovies()
        
        XCTAssertEqual(sut.moviesProvider.count, 2, "Failed to append more movies to moviesProvider")
        
        
        // Third Page
        paginationManagerMock.sttubedCanLoadMoreResult = true
        let thirdPageMovies = [movieDummy(title: "third page film")]
        service.stubbedResult = .success(moviesPaginatedDummy(moviesProvider: thirdPageMovies))
        await sut.loadMoreMovies()

        XCTAssertEqual(sut.moviesProvider.count, 3, "Failed to append more movies to moviesProvider")
        
        // In the last Page no more movie to load
        paginationManagerMock.sttubedCanLoadMoreResult = false
        let fourthPageMovies = [movieDummy(title: "fourth page film")]
        service.stubbedResult = .success(moviesPaginatedDummy(moviesProvider: fourthPageMovies))
        await sut.loadMoreMovies()
        
        XCTAssertEqual(sut.moviesProvider.count, 3, "We're in the last page no need to load more movie")
    }

    func test_GIVEN_someMovies_WHEN_loadMoreMoviesFails_THEN_moviesProviderRemainsSameAndSetLoadingStateToFailed() async {
        let paginationManagerMock = PaginationManagerMock()
        let (sut, service) = makeSUT(mockManagerPagination: paginationManagerMock)
        let movies = [movieDummy(), movieDummy()]
        service.stubbedResult = .success(moviesPaginatedDummy(moviesProvider: movies))

        await sut.fetchMovies()
        
        XCTAssertEqual(sut.loadingState, .loaded, "Failed to set loading state to loaded")
        movies.enumerated().forEach { index, movie in
            XCTAssertTrue(movie.isEqual(movie: sut.moviesProvider[index]))
        }
        
        paginationManagerMock.sttubedCanLoadMoreResult = true
        service.stubbedResult = .failure(anyError())
        await sut.loadMoreMovies()
        
        XCTAssertEqual(sut.loadingState, .failed, "Failed to set loading state to failed")
    }
}

// MARK: - Helpers
private extension MoviesViewModelTests {
    func makeSUT(
        mockManagerPagination: PaginationManagerMock = PaginationManagerMock(),
        imageResourceService: @escaping (MovieProviding) -> ImageResourceService = { _ in return ImageResourceServiceMock()},
        selectedMovieAction: @escaping (MovieProviding) -> Void = { _ in }
    ) -> (sut: MoviesViewModel, service: MovieResourceServiceMock) {
        let mockMovieService = MovieResourceServiceMock()
        let dependencies = DependencyContainer(
            movieService: mockMovieService,
            movieDiscovery: .popular,
            paginationManager: mockManagerPagination,
            genericErrorViewConfiguration: GenericErrorViewConfigurationMock(),
            imageResourceService: { imageResourceService($0) },
            selectedMovieAction: { selectedMovieAction($0) }
        )
        let sut = MoviesViewModel(dependencies: dependencies)
        trackForMemoryLeaks(mockMovieService)
        trackForMemoryLeaks(mockManagerPagination)
        trackForMemoryLeaks(mockManagerPagination)
        trackForMemoryLeaks(sut)
        return (sut, mockMovieService)
    }
    
    func movieDummy(title: String = "A title") -> MovieProviding {
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
    
    func anyError() -> Error {
        NSError(domain: "Any error", code: 1)
    }
}

private extension MovieProviding {
    func isEqual(movie: MovieProviding) -> Bool {
        id == movie.id
    }
}
