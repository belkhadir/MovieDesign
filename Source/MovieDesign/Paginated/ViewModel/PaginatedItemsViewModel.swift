//
//  ItemViewModel.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 20/6/2024.
//

import Foundation

public protocol PaginatedItemsDisplayable {
    associatedtype Item: Identifiable
    var items: [Item] { get }
    var loadingState: LoadingState { get }
    
    func shouldDisplayOverlay() -> Bool
    func fetchItems() async
    func loadMoreItems() async
}

final public class PaginatedItemsViewModel<Item: Identifiable, Service: ItemResourceService>: ObservableObject where Service.ItemsPaginatedProvider.Item == Item {
    @Published private(set) public var items: [Item] = []
    @Published private(set) public var loadingState: LoadingState = .none
    
    private let service: Service
    private let paginationManager: PaginationManaging
    
    
    public init(service: Service, paginationManager: PaginationManaging) {
        self.service = service
        self.paginationManager = paginationManager
    }
}

// MARK: - MoviesDisplaying
extension PaginatedItemsViewModel: PaginatedItemsDisplayable {
    public func shouldDisplayOverlay() -> Bool {
        loadingState != .loading && items.isEmpty
    }
    
    public func fetchItems() async {
        guard loadingState != .loading else {
            return
        }

        await updateLoadingState(to: .loading)

        do {
            await paginationManager.incrementPage()
            
            let resource = try await service.retrieveResource(
                page: paginationManager.currentPage()
            )
            await paginationManager.setTotalPages(resource.totalPages)
            await appendItems(resource.items)
            await updateLoadingState(to: .loaded)
        } catch {
            await updateLoadingState(to: .failed)
            print("Failed to fetch movies: \(error)")
        }
    }
    
    public func loadMoreItems() async {
        guard await paginationManager.canLoadMore() else { return }
        await fetchItems()
    }
}


// MARK: - Private Helpers
private extension PaginatedItemsViewModel {
    @MainActor
    func appendItems(_ items: [Item]) {
        self.items += items
    }

    @MainActor
    func updateLoadingState(to state: LoadingState) {
        loadingState = state
    }
}
