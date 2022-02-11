//
//  AppCoordinatorTests.swift
//  AutoDemoTests
//
//  Created by Kadircan Türker on 20.09.2021.
//

import XCTest
@testable import AutoDemo

class AppCoordinatorTest: XCTestCase {

    var sut: AppCoordinator!

    override func setUp() {
        super.setUp()
        sut = AppCoordinator(navigationController: UINavigationController())
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_ShouldStartCollectionsViewController() {
        // When
        sut.start()
        
        // Then
        XCTAssertTrue(sut.navigationController.children.first is ManufacturerViewController)
    }
    
}
