//
//  MoviePosterViewModelTests.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 23/9/2023.
//

import XCTest
@testable import MovieDesign

final class MoviePosterViewModelTests: XCTestCase {

    func testGivenMovieWithSpecificDate_WhenFormattingReleaseDate_ThenReturnsCorrectFormat() {
        let sut = makeSUT(releaseDate: Date(timeIntervalSince1970: 0))
        let formattedDate = sut.releaseDate

        XCTAssertEqual(formattedDate, "Jan 1, 1970")
    }

    func testGivenMovieWithLowerCaseTitle_WhenFetchingTitle_ThenReturnsCapitalizedTitle() {
        let sut = makeSUT(title: "any movie")
        let title = sut.title

        XCTAssertEqual(title, "Any Movie")
    }
    
    func testGivenMovieWithSpecificVote_WhenFormattingVote_ThenReturnsCorrectVoteString() {
        let sut = makeSUT(voteAverage: 4.5, voteCount: 10)
        let vote = sut.vote
        
        XCTAssertEqual(vote, "4.5 (10 votes)")
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
        return MoviePosterViewModel(movieProvider: movieProvider)
    }
}
