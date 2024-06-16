//
//  GenericErrorViewConfiguration.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 18/5/2024.
//

public struct GenericErrorViewConfiguration: GenericErrorViewConfigurable {
    public let message: String
    public let primaryCTATitle: String
    public let primaryCTAImage: String
    public let primaryCTAAction: () -> Void
    
    public init(
        message: String,
        primaryCTATitle: String, 
        primaryCTAImage: String,
        primaryCTAAction: @escaping () -> Void
    ) {
        self.message = message
        self.primaryCTATitle = primaryCTATitle
        self.primaryCTAImage = primaryCTAImage
        self.primaryCTAAction = primaryCTAAction
    }
}
