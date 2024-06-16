//
//  MoviePosterVoteFormatter.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 15/6/2024.
//

import Foundation

struct MoviePosterVoteFormatter: VoteFormatting {
    func formatte(voteAverage: Double, totalVote: Int) -> String {
        if totalVote == 0 {
            return "n/a"
        } else {
            return "\(String(format: "%.1f", voteAverage)) (\(totalVote) votes)"
        }
    }
}
