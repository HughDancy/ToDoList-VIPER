//
//  ToDosUITest.swift
//  ToDoList-VIPERUITests
//
//  Created by Борис Киселев on 06.08.2024.
//

import XCTest

final class ToDosUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testToDosCalendar() {
        let app = XCUIApplication()
        app.launch()
        if app.collectionViews["MainCollectionView"].waitForExistence(timeout: 2.0) {
            app.collectionViews["MainCollectionView"].cells.element(boundBy: 0).tap()
            app.collectionViews["CalendarCollectionView"].swipeLeft()
            app.collectionViews["CalendarCollectionView"].swipeLeft()
            app.collectionViews["CalendarCollectionView"].swipeRight()
            app.collectionViews["CalendarCollectionView"].swipeRight()
        }
    }

    func testToDoTable() {
        let app = XCUIApplication()
        app.launch()
        if app.collectionViews["MainCollectionView"].waitForExistence(timeout: 2.0) {
            app.collectionViews["MainCollectionView"]/*@START_MENU_TOKEN@*/.cells/*[[".scrollViews.cells",".cells"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Сегодня"].tap()
            app.tables["ToDoTable"].swipeDown()
            app.tables["ToDoTable"].cells.element(boundBy: 0).tap()
            XCTAssert(app.textViews["DescriptionTextView"].waitForExistence(timeout: 2.0))
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
