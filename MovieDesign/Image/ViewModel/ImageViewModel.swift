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
    
    func fetchImage()
}

final class ImageViewModel<ResourceProvider: ImageResourceService>: ObservableObject  {
    @Published private(set) var imageProvider: ImageProviding?
    @Published private(set) var loadingState: LoadingState = .loaded
    
    private let service: ResourceProvider
    
    init(service: ResourceProvider) {
        self.service = service
    }
}

// MARK: - MoviesDiplayable
extension ImageViewModel: ImageViewDisplayable {
    func fetchImage() {
        loadingState = .loading
        service.retriveResouce { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let imageProvider):
                self.imageProvider = imageProvider
                loadingState = .loaded
            case .failure:
                loadingState = .failed
            }
        }
    }
}
