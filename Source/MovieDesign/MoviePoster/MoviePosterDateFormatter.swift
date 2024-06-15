//
//  MoviePosterDateFormatter.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 15/6/2024.
//

import Foundation

struct MoviePosterDateFormatter: DateFormatting {
    func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
