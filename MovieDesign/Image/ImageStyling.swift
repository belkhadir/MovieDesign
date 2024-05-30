//
//  ImageStyling.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/5/2024.
//

import Foundation

public protocol ImageStyling {
    var frame: CGSize { get }
    var cornerRadius: Double { get }
    var shadowRadius: Double { get }
}
