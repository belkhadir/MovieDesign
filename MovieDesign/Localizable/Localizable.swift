//
//  Localizable.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 2/10/2023.
//

protocol Localizable: CodingKey, BundleIdentifiable {
    var localized: String { get }
    
    func localized(arguments: CVarArg...) -> String
}

extension Localizable {
    var localized: String {
        stringValue.localized(bundleIdentifier: bundleIdentifier)
    }
    
    func localized(arguments: CVarArg...) -> String {
        withVaList(arguments) { argumentList in
            stringValue.localized(bundleIdentifier: bundleIdentifier, arguments: argumentList)
        }
    }
}
