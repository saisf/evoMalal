//
//  LalalalaUITests.swift
//  LalalalaUITests
//
//  Created by Sai Leung on 5/19/22.
//

import XCTest

class LalalalaUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenUserTapTableViewCellNavigateToRelatedDetailView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let cell = app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Kendra Guthrie").element/*[[".cells.containing(.staticText, identifier:\"Kendra Guthrie\").element",".cells.containing(.staticText, identifier:\"$392.36\").element"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        cell.tap()
        let navBarTile = app.navigationBars.staticTexts["Kendra Guthrie"]
        XCTAssertTrue(navBarTile.exists)
    }
}
