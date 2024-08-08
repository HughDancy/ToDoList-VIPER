//
//  ToDosDetailUITest.swift
//  ToDoList-VIPERUITests
//
//  Created by Борис Киселев on 07.08.2024.
//

import XCTest

final class G_ToDosDetailUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEditToDo() {
        let app = XCUIApplication()
        app.launch()
        if app.collectionViews["MainCollectionView"].waitForExistence(timeout: 5.0) {
            app.collectionViews["MainCollectionView"]/*@START_MENU_TOKEN@*/.cells/*[[".scrollViews.cells",".cells"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Сегодня"].tap()
            app.tables["ToDoTable"].cells.element(boundBy: 0).tap()
            app.buttons["EditButton"].tap()
            app.textViews["TaskName"].tap()
            app.textViews["TaskName"].typeText("")
            app.textViews["TaskName"].typeText("Edited Task")
            let continueButton = app.keyboards.buttons["continue"].waitForExistence(timeout: 3.0)
            continueButton ? app.keyboards.buttons["continue"].tap() : app.keyboards.buttons["Дальше"].tap()
            app.textViews["DescriptionTextView"].typeText("Edited description of task")
            let doneButton = app.keyboards.buttons["Done"].waitForExistence(timeout: 3.0)
            doneButton ? app.keyboards.buttons["Done"].tap() : app.keyboards.buttons["готово"].tap()
            app.tables["CategoryTable"].cells.element(boundBy: 1).tap()
            app.buttons["EditButton"].tap()
            XCTAssert(app.staticTexts["Сохранено"].waitForExistence(timeout: 2.0))
        }
    }

    func testDeleteToDo() {
        let app = XCUIApplication()
        app.launch()
        if app.collectionViews["MainCollectionView"].waitForExistence(timeout: 5.0) {
            app.collectionViews["MainCollectionView"]/*@START_MENU_TOKEN@*/.cells/*[[".scrollViews.cells",".cells"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Сегодня"].tap()
            app.tables["ToDoTable"].cells.element(boundBy: 0).tap()
            app.buttons["DeleteButton"].tap()
            XCTAssert(app.staticTexts["Удалить"].waitForExistence(timeout: 2.0))
        }
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
