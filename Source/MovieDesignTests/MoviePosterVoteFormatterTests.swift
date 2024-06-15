//
//  MoviePosterVoteFormatterTests.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 15/6/2024.
//

import XCTest
@testable import MovieDesign

final class MoviePosterVoteFormatterTests: XCTestCase {
    func testFormatte_WhenCalledWithValidInputs_ReturnsFormattedString() {
        let expectedResult = "8.7 (1500 votes)"
        
        assertThat(8.7, 1500, expectedResult: expectedResult)
    }
    
    func testFormatte_WhenCalledWithZeroVotes_ReturnsNA() {
        let expectedResult = "n/a"
        
        assertThat(0.0, 0, expectedResult: expectedResult)
    }
}

// MARK: - Helpers
private extension MoviePosterVoteFormatterTests {
    func assertThat(_ voteAverage: Double, _ totalVote: Int, expectedResult: String, file: StaticString = #file, line: UInt = #line) {
        let formatter = MoviePosterVoteFormatter()
        let formattedVote = formatter.formatte(voteAverage: voteAverage, totalVote: totalVote)
        
        XCTAssertEqual(formattedVote, expectedResult, "The formatted vote string is incorrect")
    }
}
