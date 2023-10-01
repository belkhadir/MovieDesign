//
//  ImageViewModel.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

import Foundation

protocol ImageViewDisplayable {
    var imageProvider: ImageProviding? { get }
    var loadingState: LoadingState { get }
    
    func fetchImage() async
}

final class ImageViewModel<ResourceProvider: ImageResourceService>: ObservableObject  {
    @Published private(set) var imageProvider: ImageProviding?
    @Published private(set) var loadingState: LoadingState = .none
    
    private let service: ResourceProvider
    
    init(service: ResourceProvider) {
        self.service = service
    }
}

// MARK: - MoviesDiplayable
extension ImageViewModel: ImageViewDisplayable {
    func fetchImage() async {
        guard loadingState != .loading else { return }
        await updateState(state: .loading)
        
        service.retriveResouce { [weak self] result in
            guard let self else { return }
            Task {
                switch result {
                case .success(let imageProvider):
                    await self.updateImageProvider(with: imageProvider)
                    await self.updateState(state: .loaded)
                case .failure:
                    await self.updateState(state: .failed)
                }
            }
        }
    }
}

// MARK: - Helpers
private extension ImageViewModel {
    @MainActor
    func updateImageProvider(with imageProvider: ImageProviding) {
        self.imageProvider = imageProvider
    }
    
    @MainActor
    func updateState(state: LoadingState) {
        self.loadingState = state
    }
}
