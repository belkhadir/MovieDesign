//
//  ImageView.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 20/9/2023.
//

import SwiftUI

public struct ImageView: View {
    private let data: Data

    public init(data: Data) {
        self.data = data
    }

    private var imageFromData: Image {
        if let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "exclamationmark.shield")
        }
    }

    public var body: some View {
        imageFromData
            .resizable()
            .frame(width: 150, height: 200)
            .scaledToFit()
            .clipped()
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(data: Data())
    }
}
