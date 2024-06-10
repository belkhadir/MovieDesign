//
//  GenericErrorViewConfigurable.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 18/5/2024.
//

public protocol GenericErrorViewConfigurable {
    var message: String { get }
    var primaryCTATitle: String { get }
    var primaryCTAImage: String { get }
    var primaryCTAAction: () -> Void { get }
}
