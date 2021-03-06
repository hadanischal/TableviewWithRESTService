//
//  FeedsDataSourceTests.swift
//  FactsFeedTests
//
//  Created by Nischal Hada on 6/3/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest
@testable import FactsFeed

class FeedsDataSourceTests: XCTestCase {
    var dataSource: FeedsDataSource!

    override func setUp() {
        super.setUp()
        dataSource = FeedsDataSource()
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func testEmptyValueInDataSource() {
        dataSource.data.value = []  // giving empty data value
        let tableView = UITableView()
        tableView.dataSource = dataSource
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
    }

    func testValueInDataSource() {
        let responseResults: [ListModel] = MockData().getFeedslist()
        let newArray = Array(responseResults[0..<2])
        dataSource.data.value = newArray
        let tableView = UITableView()
        tableView.dataSource = dataSource
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
    }

    func testValueCell() {
        dataSource.data.value = MockData().getFeedslist()
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(FeedsCell.self, forCellReuseIdentifier: "FeedsCell")
        let indexPath = IndexPath(row: 0, section: 0)
        guard let _ = dataSource.tableView(tableView, cellForRowAt: indexPath) as? FeedsCell else {
            XCTAssert(false, "Expected LandscapeTableViewCell class")
            return
        }
    }

}
