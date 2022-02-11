//
//  CarsViewControllerTests.swift
//  AutoDemoTests
//
//  Created by Kadircan Türker on 20.09.2021.
//

import XCTest
@testable import AutoDemo

class CarsViewControllerTests: XCTestCase {

    var sut: CarsViewController!
    var businessController: MockBusinessController!
    
    override func setUp() {
        super.setUp()
        businessController = MockBusinessController(networkManager: MockNetworkManager())
        sut = CarsViewController(businessController: businessController, dataSource: CarsDataSource(), manufacturer: ManufacturerModel(id: "", name: ""))
    }
    
    override func tearDown() {
        businessController = nil
        sut = nil
        super.tearDown()
    }
    
    func test_ShouldFetchCarTypesWhenViewDidLoadCalled() {
        // When
        _ = sut.view
        
        // Then
        XCTAssertTrue(businessController.didCallFetchCarTypes)
    }
    
    func test_ShouldInformDelegateWhenCellIsSelected() {
        // Given
        let mockDelegate = MockDelegate()
        
        // When
        _ = sut.view
        sut.delegate = mockDelegate
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(mockDelegate.didTapCar)
    }
    
    
    class MockBusinessController: CarsBusinessController {
        private(set) var didCallFetchCarTypes = false
        
        override func fetchCarTypes(with key: String, then handler: @escaping ((Result<[CarTypeModel], NetworkError>) -> Void)) {
            didCallFetchCarTypes = true
            handler(.success([CarTypeModel(id: "", carType: "")]))
        }
    }
    
    class MockDelegate: CarsViewControllerDelegate {
        private(set) var didTapCar = false
        
        func carsViewControllerDidTapCarType(_ carsViewController: CarsViewController, with carInfo: CarInfoModel) {
            didTapCar = true
        }
    }

}
