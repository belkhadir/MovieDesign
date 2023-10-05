//
//  MoviesDiscoveryView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 5/10/2023.
//

import SwiftUI

struct MoviesDiscoveryView<ViewModel: ObservableObject & MoviesDiscoveryDisplayable & SegmentControlItemsProviding>: View {
    private let viewModel: ViewModel
    private let dependencies: DependencyContainer
    
    init(viewModel: ViewModel, dependencies: DependencyContainer) {
        self.viewModel = viewModel
        self.dependencies = dependencies
    }
    
    var body: some View {
        VStack(spacing: 20) {
            SegmentControlView(
                viewModel: viewModel) { selectedIndex in
                    viewModel.selectedSegement(at: selectedIndex)
                }
            MoviesUIComposition.construcView(dependencies: dependencies)
        }
    }
}
