//
//  PaginationManagerMock.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 5/10/2023.
//

import MovieDesign

class PaginationManagerMock: PaginationManaging {
    // Variables to store the return values for your async methods
    var sttubedCanLoadMoreResult = false
    var sttubedCurrentPageResult = 1
    
    // Variables to check whether methods were called
    private(set) var setTotalPagesCalled = false
    private(set) var incrementPageCalled = false
    
    func canLoadMore() async -> Bool {
        return sttubedCanLoadMoreResult
    }
    
    func currentPage() async -> Int {
        return sttubedCurrentPageResult
    }
    
    func setTotalPages(_ pages: Int) async {
        setTotalPagesCalled = true
    }
    
    func incrementPage() async {
        incrementPageCalled = true
    }
}
