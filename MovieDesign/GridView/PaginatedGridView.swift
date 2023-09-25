//
//  PaginatedGridView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 21/9/2023.
//

import SwiftUI

public struct PaginatedGridView<Content>: View where Content: View {
    @Binding private var contents: [Content]
    private let loadMoreIfNeeded: () -> Void
    
    public init(contents: Binding<[Content]>, loadMoreIfNeeded: @escaping () -> Void) {
        self._contents = contents
        self.loadMoreIfNeeded = loadMoreIfNeeded
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(repeating: .init(.flexible()), count: 2),
                spacing: 20) {
                    ForEach(contents.indices, id: \.self) { index in
                        if isLastItem(index) {
                            contents[index].onAppear(perform: {
                                loadMoreIfNeeded()
                            })
                            .aspectRatio(0.75, contentMode: .fit)
                        } else {
                            contents[index]
                                .aspectRatio(0.75, contentMode: .fit)
                        }
                    }
            }.padding()
        }
    }
}


// MARK: - Helpers
private extension PaginatedGridView {
    func isLastItem(_ index: Int) -> Bool {
        return index == contents.count - 1
    }
}
