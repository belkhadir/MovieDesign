//
//  ImageView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 20/9/2023.
//

import SwiftUI

struct ImageView<ViewModel: ImageViewDisplayable & ObservableObject>: View {
    private let viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    private var imageFromData: Image {
        if let data = viewModel.imageProvider?.data, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "exclamationmark.shield")
        }
    }

    var body: some View {
        imageFromData
            .resizable()
            .frame(width: 150, height: 200)
            .scaledToFit()
            .clipped()
            .cornerRadius(10)
            .shadow(radius: 5)
            .onAppear(perform: {
                viewModel.fetchImage()
            })
    }
}
