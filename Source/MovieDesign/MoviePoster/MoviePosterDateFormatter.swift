//
//  MoviePosterDateFormatter.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 15/6/2024.
//

import Foundation

struct MoviePosterDateFormatter: DateFormatting {
    private static let sharedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    func format(date: Date) -> String {
        return Self.sharedFormatter.string(from: date)
    }
}
