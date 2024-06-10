//
//  ImageResourceServiceProviderMock.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 8/6/2024.
//

import Foundation
import ImageResourceAPI

final class ImageResourceServiceProviderMock: ImageResourceServiceProviding {
    typealias ImageTypeView = ImageViewMock
    
    
    var invokedImageView = false
    var invokedImageViewCount = 0
    var stubbedImageViewResult: ImageTypeView!

    func imageView() -> ImageTypeView {
        invokedImageView = true
        invokedImageViewCount += 1
        return stubbedImageViewResult
    }
}
