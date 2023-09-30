//
//  ImageViewModel.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 30/9/2023.
//

import Foundation

protocol ImageViewDisplayable {
    var imageProvider: ImageProviding? { get }
    
    func fetchImage()
}


final class ImageViewModel<ResourceProvider: ImageResourceService>: ObservableObject  {
    @Published private(set) var imageProvider: ImageProviding?
    
    private let service: ResourceProvider
    
    init(service: ResourceProvider) {
        self.service = service
    }
}

// MARK: - MoviesDiplayable
extension ImageViewModel: ImageViewDisplayable {
    func fetchImage() {
        service.retriveResouce { result in
            switch result {
            case .success(let imageProvider):
                self.imageProvider = imageProvider
            case .failure:
                break
            }
        }
    }
}
