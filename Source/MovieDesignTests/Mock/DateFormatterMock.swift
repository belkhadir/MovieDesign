//
//  DateFormatterMock.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 15/6/2024.
//

import Foundation
@testable import MovieDesign

final class DateFormatterMock: DateFormatting {

    var invokedFormat = false
    var invokedFormatCount = 0
    var invokedFormatParameters: (date: Date, Void)?
    var invokedFormatParametersList = [(date: Date, Void)]()
    var stubbedFormatResult: String! = ""

    func format(date: Date) -> String {
        invokedFormat = true
        invokedFormatCount += 1
        invokedFormatParameters = (date, ())
        invokedFormatParametersList.append((date, ()))
        return stubbedFormatResult
    }
}
