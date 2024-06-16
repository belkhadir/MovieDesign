//
//  PaginationManager.swift
//  MovieDesign
//
//  Created by Belkhadir Anas on 3/10/2023.
//

public actor PaginationManager {
    private var _currentPage: Int
    private var _totalPages: Int
    
    public init(currentPage: Int = 1, totalPages: Int = 1) {
        self._currentPage = currentPage
        self._totalPages = max(totalPages, 1)
    }
}

// MARK: - PaginationManaging
extension PaginationManager: PaginationManaging {
    public func currentPage() async -> Int {
        return _currentPage
    }
    
    public func setTotalPages(_ totalPages: Int) async {
        self._totalPages = totalPages
    }
    
    public func canLoadMore() async -> Bool {
        return _currentPage < _totalPages
    }

    public func incrementPage() async {
        if _currentPage < _totalPages {
            _currentPage += 1
        }
    }
}
