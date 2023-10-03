//
//  String+Extension.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 2/10/2023.
//

import Foundation

extension String {
    var lolcalized: Self {
        NSLocalizedString(self, comment: "")
    }
    
    func localized(bundleIdentifier: String, tableName: String? = nil, arguments: CVaListPointer? = nil) -> Self {
        guard let bundle = Bundle(identifier: bundleIdentifier) else {
            return self
        }
        let localizedText = NSLocalizedString(self, tableName: tableName, bundle: bundle, comment: "")
        if let arguments = arguments {
            return NSString(format: localizedText, arguments: arguments) as String
        } else {
            return localizedText
        }
    }
}
