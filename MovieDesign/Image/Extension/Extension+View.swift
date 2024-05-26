//
//  Extension+View.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 26/5/2024.
//

import SwiftUI

extension View {
    func imageShape(_ imageShape: ImageShape) -> some View {
        environment(\.imageShape, imageShape)
    }
}
