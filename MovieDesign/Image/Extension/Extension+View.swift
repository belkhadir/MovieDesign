//
//  Extension+View.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 26/5/2024.
//

import SwiftUI

extension View {
    func imageStyle(_ style: ImageStyling) -> some View {
        environment(\.imageStyle, style)
    }
}
