//
//  ImageView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 20/9/2023.
//

import SwiftUI

struct ImageView<ViewModel: ImageViewDisplayable & ObservableObject>: View {
    @Environment(\.imageShape) var imageShape
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading, .none:
                ShimmerView()
            case .loaded:
                image
            case .failed:
                retryLoadImage
            }
        }
        .task {
            await viewModel.fetchImage()
        }
    }
}

// MARK: - Helpers
private extension ImageView {
    var imageFromData: Image {
        let fallBackImage = Image(systemName: "exclamationmark.icloud")
        if let data = viewModel.imageProvider?.data {
            return Image(data: data)
        } else {
            return fallBackImage
        }
    }

    var image: some View {
        switch imageShape {
            case .poster:
                imageFromData
                    .resizable()
                    .frame(width: 150, height: 200)
                    .scaledToFit()
                    .clipped()
                    .cornerRadius(10)
                    .shadow(radius: 5)
        }
    }
    
    var retryLoadImage: some View {
        VStack(spacing: 10) {
            Image(systemName: "xmark.octagon")
                .frame(width: 150, height: 200)
            Button("Retry") {
                Task {
                    await viewModel.fetchImage()
                }
            }
            .buttonStyle(.bordered)
        }
    }
}
