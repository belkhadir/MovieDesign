//
//  GenericErrorViewConfiguration.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 18/5/2024.
//

public struct GenericErrorViewConfiguration {
    let message: String
    let primaryCTATitle: String
    let primaryCTAImage: String
    let primaryCTAAction: () -> Void
    
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
