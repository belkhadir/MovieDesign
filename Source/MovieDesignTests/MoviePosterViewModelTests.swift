//
//  MoviePosterViewModelTests.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 23/9/2023.
//

import XCTest
@testable import MovieDesign

final class MoviePosterViewModelTests: XCTestCase {
    func testGivenMovieWithLowerCaseTitle_WhenFetchingTitle_ThenReturnsCapitalizedTitle() {
        let sut = makeSUT(title: "any movie")
        let title = sut.title

        XCTAssertEqual(title, "Any Movie")
    }
}

// MARK: - Helpers
private extension MoviePosterViewModelTests {
    func makeSUT(
        title: String = "",
        releaseDate: Date = Date(),
        voteAverage: Double = 0,
        voteCount: Int = 0
    ) -> MoviePosterViewModel {
        let movieProvider = MockMovieProvider(
            id: 1,
            title: title, 
            imagePath: "",
            releaseDate: releaseDate,
            voteAverage: voteAverage,
            voteCount: voteCount
        )
        return MoviePosterViewModel(
            movieProvider: movieProvider,
            dateFormatter: DateFormatterMock(),
            voteFormatter: VoteFormatterMock()
        )
    }
}
