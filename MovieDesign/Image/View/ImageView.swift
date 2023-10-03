//
//  ImageView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 20/9/2023.
//

import SwiftUI

struct ImageView<ViewModel: ImageViewDisplayable & ObservableObject>: View {
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    private var imageFromData: Image {
        if let data = viewModel.imageProvider?.data, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "exclamationmark.icloud")
        }
    }

    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading, .none:
                ShimmerView()
            case .loaded:
                imageFromData
                    .resizable()
                    .frame(width: 150, height: 200)
                    .scaledToFit()
                    .clipped()
                    .cornerRadius(10)
                    .shadow(radius: 5)
            case .failed:
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
        .task {
            await viewModel.fetchImage()
        }
    }
}
