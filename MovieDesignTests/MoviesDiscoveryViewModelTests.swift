//
//  MoviesDiscoveryViewModelTests.swift
//  MovieDesignTests
//
//  Created by Belkhadir Anas on 5/10/2023.
//

import XCTest
@testable import MovieDesign

final class MoviesDiscoveryViewModelTests: XCTestCase {
    func testGivenValidIndex_WhenSegmentIsSelected_ThenDelegateIsCalledWithCorrectCategory() {
        let (sut, delegate) = makeSUT()
        sut.selectedSegement(at: 0)
        
        XCTAssertEqual(delegate.lastSelectedCategory, .popular, "Expected to select the popular category, but got \(String(describing: delegate.lastSelectedCategory))")
    }
    
    func testGivenInvalidValidIndex_WhenSegmentIsSelected_ThenDelegateIsNotCalled() {
        let (sut, delegate) = makeSUT()
        let invalidIndex = 5
        sut.selectedSegement(at: invalidIndex)
        
        XCTAssertNil(delegate.lastSelectedCategory, "Expected a nil value because")
    }
    
    func test_GivenItemsLocalization_WhenGettingItems_ThenItemsIsCorrect() {
        let (sut, _) = makeSUT()
        let expectedItems = [localized("popular"), localized("top_rated"), localized("upcoming")]
        
        sut.items.enumerated().forEach { index, item in
            XCTAssertEqual(item, expectedItems[index])
        }
    }
}

// MARK: - Helpers
private extension MoviesDiscoveryViewModelTests {
    func makeSUT() -> (sut: MoviesDiscoveryViewModel, delegate:  MoviesDiscoveryDelegateMock) {
        let sut = MoviesDiscoveryViewModel() 
        let delegate = MoviesDiscoveryDelegateMock()
        sut.delegate = delegate
        return (sut, delegate)
    }
    
    func localized(_ key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
        let table = "Localizable"
        let bundle = Bundle(for: MoviesDiscoveryViewModel.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        }
        return value
    }
}
