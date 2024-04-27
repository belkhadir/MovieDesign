//
//  MoviesDiscoveryUIComposition.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 27/4/2024.
//

import SwiftUI

public final class MoviesDiscoveryUIComposition {
    public static func constructView(dependencies: DependencyContainer) -> some View {
        let viewModel = MoviesDiscoveryViewModel()
        return MoviesDiscoveryView(viewModel: viewModel, dependencies: dependencies)
    }
}
