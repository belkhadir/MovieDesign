//
//  ImageView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 20/9/2023.
//

import SwiftUI

struct ImageView<ViewModel: ImageViewDisplayable & ObservableObject>: View {
    @Environment(\.imageStyle) var imageStyle
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
                imageFromData
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
        imageFromData
            .resizable()
            .frame(width: imageStyle.frame.width, height: imageStyle.frame.height)
            .scaledToFit()
            .clipped()
            .cornerRadius(imageStyle.cornerRadius)
            .shadow(radius: imageStyle.shadowRadius)
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
