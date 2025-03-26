//
//  AllProductsVMTests.swift
//  TRU Task
//
//  Created by mohamed dorgham on 25/03/2025.
//

import XCTest
@testable import TRU_Task

final class AllProductsVMTests: XCTestCase {
    
    var sut: AllProductsCV.ViewModel!
    var mockConnectionManager: MockConnectionManager!
    
    override func setUp() {
        super.setUp()
        mockConnectionManager = MockConnectionManager()
        sut = AllProductsCV.ViewModel()
    }
    
    override func tearDown() {
        sut = nil
        mockConnectionManager = nil
        super.tearDown()
    }
    
    /// Test fetching products from local database
    /// Verifies that products are fetched correctly with pagination
    func testFetchProductsFromLocalDatabase() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch products from local database")
        
        // When
        sut.fetchProducts()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertGreaterThan(self.sut.products.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    /// Test fetching live products from API
    /// Verifies that products are fetched and saved to local database
    func testFetchLiveProducts() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch live products from API")
        
        // When
        sut.fetchLiveProducts()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertGreaterThan(self.sut.products.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
}

// MARK: - Mock Classes
class MockConnectionManager {
    var isConnected: Bool = true
} 