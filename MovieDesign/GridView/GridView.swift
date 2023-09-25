//
//  GridView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 21/9/2023.
//

import SwiftUI

public struct GridView<Content>: View where Content: View {
    private let views: () -> [Content]
    private let loadMoreIfNeeded: () -> Void
    
    public init(content: @escaping () -> [Content], loadMoreIfNeeded: @escaping () -> Void) {
        self.views = content
        self.loadMoreIfNeeded = loadMoreIfNeeded
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(repeating: .init(.flexible()), count: 2),
                spacing: 20) {
                    ForEach(0..<views().count, id: \.self) { index in
                        if isLastItem(index) {
                            views()[index].onAppear(perform: {
                                loadMoreIfNeeded()
                            })
                            .aspectRatio(0.75, contentMode: .fit)
                        } else {
                            views()[index]
                                .aspectRatio(0.75, contentMode: .fit)
                        }
                    }
            }.padding()
        }
    }
}

// MARK: - Helpers
private extension GridView {
    func isLastItem(_ index: Int) -> Bool {
        return index == views().count - 1
    }
}
