//
//  ManufacturersBusinessControllerTests.swift
//  AutoDemoTests
//
//  Created by Kadircan Türker on 20.09.2021.
//

import XCTest
@testable import AutoDemo

class ManufacturersBusinessControllerTests: XCTestCase {
    
    var sut: ManufacturerBusinessController!
    var networkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        networkManager = MockNetworkManager()
        sut = ManufacturerBusinessController(networkManager: networkManager)
    }
    
    override func tearDown() {
        networkManager = nil
        sut = nil
        super.tearDown()
    }
    
    func test_ShouldFetchDataSuccessfully() {
        // Given
        let fetchDataExpectation = expectation(description: "Fetch Data")
        var manufacturers: [ManufacturerModel] = []
        // When
        sut.fetchManufacturers { result in
            if case let .success(data) = result {
                manufacturers = data
            } else {
                XCTAssertTrue(false)
            }
            fetchDataExpectation.fulfill()
        }
        
        // Then
        wait(for: [fetchDataExpectation], timeout: 1)
        XCTAssertEqual(manufacturers.count, 1)
    }
    
    func test_ShouldReturnDataIfThereIsErrorOnNetwork() {
        // Given
        let fetchDataExpectation = expectation(description: "Error")
        networkManager.status = .error
        var errorMessage: String?
        
        // When
        sut.fetchManufacturers { result in
            if case let .failure(error) = result {
                errorMessage = error.localizedDescription
            } else {
                XCTAssertTrue(false)
            }
            fetchDataExpectation.fulfill()
        }
        
        // Then
        wait(for: [fetchDataExpectation], timeout: 1)
        XCTAssertEqual(errorMessage!, NetworkError.somethingWentWrong(nil).localizedDescription)
    }
}
