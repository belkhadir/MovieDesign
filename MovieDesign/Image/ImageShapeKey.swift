//
//  ImageShapeKey.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 26/5/2024.
//

import SwiftUI

struct ImageStyleKey: EnvironmentKey {
    static var defaultValue: ImageStyling = ImagePoster()
}



struct ImagePoster: ImageStyling {
    var frame: CGSize {
        .init(width: 150.0, height: 200.0)
    }
    
    var cornerRadius: Double {
        10.0
    }
    
    var shadowRadius: Double {
        5.0
    }
}
