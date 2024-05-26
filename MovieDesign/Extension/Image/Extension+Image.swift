//
//  Extension+Image.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 26/5/2024.
//

import SwiftUI

extension Image {
    init(data: Data, fallBack systemName: String = "exclamationmark.icloud") {
#if os(iOS)
if let uiImage = UIImage(data: data) {
    self = Image(uiImage: uiImage)
} else {
    self = Image(systemName: systemName)
}
#elseif os(macOS)
if let nsImage = NSImage(data: data) {
    self = Image(nsImage: nsImage)
} else {
    self = Image(systemName: systemName)
}
#endif
    }
}
