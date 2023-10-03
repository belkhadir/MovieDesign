//
//  SegementControlViewModel.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 2/10/2023.
//

final class MoviesDiscoveryViewModel: SegmentControlDisplayable {
    var items: [String] {
        Localization.allCases.map { $0.localized }
    }
}

// MARK: - Localizable
extension MoviesDiscoveryViewModel {
    enum Localization: String, Localizable, CaseIterable {
        var bundleIdentifier: String {
            BundleIdentifier.identifier
        }
        
        case popular = "popular"
        case companyDetails = "top_rated"
        case upcoming = "upcoming"
    }
}
