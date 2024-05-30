//
//  Extension+EnvironmentValues.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 26/5/2024.
//

import SwiftUI

extension EnvironmentValues {
    var imageStyle: ImageStyling {
        get { self[ImageStyleKey.self] }
        set { self[ImageStyleKey.self] = newValue }
    }
}
