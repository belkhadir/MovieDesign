//
//  MoviesPaginationCache.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 3/10/2023.
//

public protocol MoviesPaginationCaching {
    /// Retrieves the pagination manager for a specific movie discovery category.
        /// - Parameter category: The movie discovery category.
        /// - Returns: The associated pagination manager, or nil if not found.
    func getPaginationManager(for category: MovieDiscovery) -> PaginationManaging?
    
    /// Marks a page as loaded for a specific movie discovery category.
        /// - Parameter category: The movie discovery category.
    func markPageAsLoaded(for category: MovieDiscovery)
    
    /// Checks if a page has been loaded for a specific movie discovery category.
        /// - Parameter category: The movie discovery category.
        /// - Returns: A Boolean indicating whether the page has been loaded.
    func isPageLoaded(for category: MovieDiscovery) -> Bool
}

public final class MoviesPaginationCache {
    private var pageCaching: [MovieDiscovery: (paginationManager: PaginationManaging, pageAlreadyLoaded: Bool)] = [:]
    
    /// Initializes a new instance of MoviesPaginationCache
        /// - Parameter defaultPaginationManager: A manager to handle pagination logic, which will be used for all movie discovery categories.
    init(paginationManager: PaginationManaging) {
        for movieDiscovery in MovieDiscovery.allCases {
            pageCaching[movieDiscovery] = (paginationManager, false)
        }
    }
}

// MARK: - MoviesPaginationCaching
extension MoviesPaginationCache: MoviesPaginationCaching {
    public func getPaginationManager(for category: MovieDiscovery) -> PaginationManaging? {
        return pageCaching[category]?.paginationManager
    }
    
    public func markPageAsLoaded(for category: MovieDiscovery) {
        pageCaching[category]?.pageAlreadyLoaded = true
    }
    
    public func isPageLoaded(for category: MovieDiscovery) -> Bool {
        return pageCaching[category]?.pageAlreadyLoaded ?? false
    }
}
