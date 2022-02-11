//
//  CarsDataSourceTests.swift
//  AutoDemoTests
//
//  Created by Kadircan Türker on 20.09.2021.
//

import XCTest
@testable import AutoDemo

class CarsDataSourceTests: XCTestCase {

    var sut: CarsDataSource!
    var tableView: UITableView!
    var carTypes: [CarTypeModel]!
    
    override func setUp() {
        super.setUp()
        tableView = UITableView()
        carTypes = [CarTypeModel(id: "", carType: "")]
        sut = CarsDataSource()
    }
    
    override func tearDown() {
        tableView = nil
        carTypes = nil
        sut = nil
        super.tearDown()
    }

    
    func test_ShouldRegisterCollectionsTableViewCell() {
        // Given
        sut.carTypes = carTypes
        sut.registerCells(to: tableView)
        let indexPath = IndexPath(item: 0, section: 0)

        // When
        let cell = sut.tableView(tableView, cellForRowAt: indexPath)

        //Then
        XCTAssertTrue(cell is CarTypeTableViewCell)
    }
    
    func test_ShouldConfigureCell() {
        // Given
        sut.carTypes = carTypes
        sut.registerCells(to: tableView)

        // When
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CarTypeTableViewCell
        
        //Then
        XCTAssertEqual(cell?.titleLabel.text, carTypes.first!.carType)
    }
    
    func test_NumberOfRowsShouldBeEqualToCollectionsCount() {
        //Given
        sut.carTypes = carTypes

        // When
        let numberOfRowsInSection = sut.tableView(tableView, numberOfRowsInSection: 0)

        //Then
        XCTAssertEqual(numberOfRowsInSection, sut.carTypes.count)
    }
}
