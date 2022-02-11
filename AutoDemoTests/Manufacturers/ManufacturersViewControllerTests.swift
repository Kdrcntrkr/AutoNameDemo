//
//  ManufacturersViewControllerTests.swift
//  AutoDemoTests
//
//  Created by Kadircan Türker on 20.09.2021.
//

import XCTest
@testable import AutoDemo

class ManufacturersViewControllerTests: XCTestCase {
    
    var sut: ManufacturerViewController!
    var businessController: MockBusinessController!
    
    override func setUp() {
        super.setUp()
        businessController = MockBusinessController(networkManager: MockNetworkManager())
        sut = ManufacturerViewController(businessController: businessController, dataSource: ManufacturerDataSource())
    }
    
    override func tearDown() {
        sut = nil
        businessController = nil
        super.tearDown()
    }
    
    func test_ShouldFetchManufacturersWhenViewDidLoadCalled() {
        // When
        _ = sut.view
        
        // Then
        XCTAssertTrue(businessController.didCallFetchManufacturer)
    }
    
    func test_ShouldInformDelegateWhenCellIsSelected() {
        // Given
        let mockDelegate = MockDelegate()
        
        // When
        _ = sut.view
        sut.delegate = mockDelegate
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(mockDelegate.didTapManufacturer)
    }
    
    class MockBusinessController: ManufacturerBusinessController {
        private(set) var didCallFetchManufacturer = false
        
        override func fetchManufacturers(handler: @escaping ((Result<[ManufacturerModel], NetworkError>) -> Void)) {
            didCallFetchManufacturer = true
            return handler(.success([ManufacturerModel(id: "", name: ""), ManufacturerModel(id: "", name: ""), ManufacturerModel(id: "", name: ""), ManufacturerModel(id: "", name: ""), ManufacturerModel(id: "", name: ""), ManufacturerModel(id: "", name: ""), ManufacturerModel(id: "", name: ""), ManufacturerModel(id: "", name: ""), ManufacturerModel(id: "", name: ""), ManufacturerModel(id: "", name: "")]))
        }
    }
    
    class MockDelegate: ManufacturerViewControllerDelegate {
        private(set) var didTapManufacturer = false
        
        func manufacturerViewControllerDidTapManufacturer(_ manufacturerViewController: ManufacturerViewController, with manufacturer: ManufacturerModel) {
            didTapManufacturer = true
        }
    }

}
