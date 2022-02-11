//
//  ManufacturersDataSourceTests.swift
//  AutoDemoTests
//
//  Created by Kadircan Türker on 20.09.2021.
//

import XCTest
@testable import AutoDemo

class ManufacturersDataSourceTests: XCTestCase {

    var sut: ManufacturerDataSource!
    var tableView: UITableView!
    var mockData: [ManufacturerModel]!
    
    override func setUp() {
        super.setUp()
        tableView = UITableView()
        mockData = [ManufacturerModel(id: "", name: "")]
        sut = ManufacturerDataSource()
    }
    
    override func tearDown() {
        tableView = nil
        mockData = nil
        sut = nil
        super.tearDown()
    }
    
    func test_ShouldRegisterCollectionsTableViewCell() {
        // Given
        sut.manufacturers = mockData
        sut.registerCells(to: tableView)
        let indexPath = IndexPath(item: 0, section: 0)

        // When
        let cell = sut.tableView(tableView, cellForRowAt: indexPath)

        //Then
        XCTAssertTrue(cell is TitleTableViewCell)
    }
    
    func test_ShouldConfigureCell() {
        // Given
        sut.manufacturers = mockData
        sut.registerCells(to: tableView)

        // When
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TitleTableViewCell
        
        //Then
        XCTAssertEqual(cell?.titleLabel.text, mockData.first!.name)
    }
    
    func test_NumberOfRowsShouldBeEqualToCollectionsCount() {
        //Given
        sut.manufacturers = mockData

        // When
        let numberOfRowsInSection = sut.tableView(tableView, numberOfRowsInSection: 0)

        //Then
        XCTAssertEqual(numberOfRowsInSection, sut.manufacturers.count)
    }


}
