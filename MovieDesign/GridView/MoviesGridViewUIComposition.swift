//
//  MoviesGridViewUIComposition.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 26/9/2023.
//

import SwiftUI

public final class MoviesGridViewUIComposition {
    public func constructView(moviesPosterView: [some View], loadMore: @escaping () -> Void) -> some View {
        PaginatedGridView(contents: moviesPosterView) {
            loadMore()
        }
    }
}
