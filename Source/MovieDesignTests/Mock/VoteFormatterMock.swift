//
//  VoteFormatterMock.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 15/6/2024.
//

import Foundation
@testable import MovieDesign

final class VoteFormatterMock: VoteFormatting {
    var invokedFormatte = false
    var invokedFormatteCount = 0
    var invokedFormatteParameters: (voteAverage: Double, totalVote: Int)?
    var invokedFormatteParametersList = [(voteAverage: Double, totalVote: Int)]()
    var stubbedFormatteResult: String! = ""

    func formatte(voteAverage: Double, totalVote: Int) -> String {
        invokedFormatte = true
        invokedFormatteCount += 1
        invokedFormatteParameters = (voteAverage, totalVote)
        invokedFormatteParametersList.append((voteAverage, totalVote))
        return stubbedFormatteResult
    }
}
