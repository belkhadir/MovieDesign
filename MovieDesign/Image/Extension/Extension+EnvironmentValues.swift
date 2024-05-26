//
//  Extension+EnvironmentValues.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 26/5/2024.
//

import SwiftUI

extension EnvironmentValues {
    var imageShape: ImageShape {
        get { self[ImageShapeKey.self] }
        set { self[ImageShapeKey.self] = newValue }
    }
}
