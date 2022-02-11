//
//  ManufacturersCoordinatorTests.swift
//  AutoDemoTests
//
//  Created by Kadircan Türker on 20.09.2021.
//

import XCTest
@testable import AutoDemo

class ManufacturersCoordinatorTests: XCTestCase {

    var sut: ManufacturerCoordinator!
    
    override func setUp() {
        super.setUp()
        let window = UIWindow(frame: .zero)
        let navigationController = MockNavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        sut = ManufacturerCoordinator(navigationController: navigationController)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_ShouldStartManufacturerViewController() {
        // When
        sut.start()
        
        // Then
        XCTAssertTrue(sut.navigationController.children.first is ManufacturerViewController)
    }

    func test_ShouldOpenCarTypesWhenDelegeteInformed() {
        // When
        sut.start()
        sut.manufacturerViewControllerDidTapManufacturer(getManufacturerViewController(), with: ManufacturerModel(id: "", name: ""))
        
        // Then
        XCTAssertTrue(sut.navigationController.children.last is CarsViewController)
    }
    
    func test_ShouldShowInfoAlertWhenDelegeteInformed() {
        // When
        sut.start()
        sut.carsViewControllerDidTapCarType(getCarsViewController(), with: CarInfoModel(manufacturer: "", carType: ""))
        // Then
        XCTAssertTrue(sut.navigationController.presentedViewController is UIAlertController)
    }
    
    
    func getManufacturerViewController() -> ManufacturerViewController {
        let businessController = ManufacturerBusinessController(networkManager: MockNetworkManager())
        let dataSource = ManufacturerDataSource()
        return ManufacturerViewController(businessController: businessController, dataSource: dataSource)
    }
    
    func getCarsViewController() -> CarsViewController {
        let businessController = CarsBusinessController(networkManager: MockNetworkManager())
        let dataSource = CarsDataSource()
        let manufacturer = ManufacturerModel(id: "", name: "")
        return CarsViewController(businessController: businessController, dataSource: dataSource, manufacturer: manufacturer)
    }
}
