//
//  PaginatedItemsView.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 21/6/2024.
//

import SwiftUI
import ImageResourceAPI

public struct PaginatedItemsView<Item: Identifiable,
                          ViewModel: PaginatedItemsDisplayable & ObservableObject,
                          ItemView: View,
                          ErrorView: View>: View where ViewModel.Item == Item {
    @ObservedObject private var viewModel: ViewModel
    private let selectedItem: (Item) -> Void
    @ViewBuilder private let itemView: (Item) -> ItemView
    private let errorView: ErrorView
    
    public init(
        viewModel: ViewModel,
        selectedItem: @escaping (Item) -> Void,
        itemView: @escaping (Item) -> ItemView,
        errorView: ErrorView
    ) {
        self.viewModel = viewModel
        self.selectedItem = selectedItem
        self.itemView = itemView
        self.errorView = errorView
    }
    
    public var body: some View {
        ScrollView {
            CustomGrid {
                ForEach(viewModel.items, id: \.id) { item in
                    itemView(item)
                    .onTapGesture {
                        selectedItem(item)
                    }
                }
                if viewModel.loadingState == .loading {
                    ProgressView()
                        .frame(height: 50)
                }
                
                Color.clear
                    .frame(height: 1)
                    .onAppear {
                        Task {
                            await viewModel.loadMoreItems()
                        }
                    }
            }.padding()
        }.overlay(content: {
            if viewModel.shouldDisplayOverlay() {
                errorView
            }
        })
        .task {
            await viewModel.fetchItems()
        }
    }
}


public struct CustomGrid<Content: View>: View {
    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        content()
    }
}
