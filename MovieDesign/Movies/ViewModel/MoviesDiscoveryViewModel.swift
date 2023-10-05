//
//  SegementControlViewModel.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 2/10/2023.
//

import Foundation

protocol MoviesDiscoveryDisplayable {
    func selectedSegement(at index: Int)
}

final class MoviesDiscoveryViewModel {
    weak var delegate: (AnyObject & MoviesDiscoveryDelegate)?
}

// MARK: - SegmentControlItemsProviding
extension MoviesDiscoveryViewModel: SegmentControlItemsProviding {
    var items: [String] {
        Localization.allCases.map { $0.localized }
    }
}

// MARK: - MoviesDiscoveryDisplayable
extension MoviesDiscoveryViewModel: MoviesDiscoveryDisplayable {
    func selectedSegement(at index: Int) {
        guard let movieDiscovery = MovieDiscovery(rawValue: index) else { return }
        delegate?.didSelectCategory(movieDiscovery)
    }
}

// MARK: - Localizable
private extension MoviesDiscoveryViewModel {
    enum Localization: String, Localizable, CaseIterable {
        var bundleIdentifier: String {
            BundleIdentifier.identifier
        }
        
        case popular = "popular"
        case companyDetails = "top_rated"
        case upcoming = "upcoming"
    }
}
