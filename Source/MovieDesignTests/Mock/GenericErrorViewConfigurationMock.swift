//
//  GenericErrorViewConfigurationMock.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 18/5/2024.
//

import MovieDesign

final class GenericErrorViewConfigurationMock: GenericErrorViewConfigurable {

    var invokedMessageGetter = false
    var invokedMessageGetterCount = 0
    var stubbedMessage: String! = ""

    var message: String {
        invokedMessageGetter = true
        invokedMessageGetterCount += 1
        return stubbedMessage
    }

    var invokedPrimaryCTATitleGetter = false
    var invokedPrimaryCTATitleGetterCount = 0
    var stubbedPrimaryCTATitle: String! = ""

    var primaryCTATitle: String {
        invokedPrimaryCTATitleGetter = true
        invokedPrimaryCTATitleGetterCount += 1
        return stubbedPrimaryCTATitle
    }

    var invokedPrimaryCTAImageGetter = false
    var invokedPrimaryCTAImageGetterCount = 0
    var stubbedPrimaryCTAImage: String! = ""

    var primaryCTAImage: String {
        invokedPrimaryCTAImageGetter = true
        invokedPrimaryCTAImageGetterCount += 1
        return stubbedPrimaryCTAImage
    }

    var invokedPrimaryCTAActionGetter = false
    var invokedPrimaryCTAActionGetterCount = 0
    var stubbedPrimaryCTAAction: (() -> Void)! = {}

    var primaryCTAAction: () -> Void {
        invokedPrimaryCTAActionGetter = true
        invokedPrimaryCTAActionGetterCount += 1
        return stubbedPrimaryCTAAction
    }
}
