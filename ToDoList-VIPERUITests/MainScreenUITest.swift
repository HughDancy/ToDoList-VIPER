//
//  MainScreenUITest.swift
//  ToDoList-VIPERUITests
//
//  Created by Борис Киселев on 06.08.2024.
//

import XCTest
import Foundation.NSDate

final class MainScreenUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testCircleButton() {
        let app = XCUIApplication()
        app.launch()
        if app.collectionViews["MainCollectionView"].waitForExistence(timeout: 2.0) {
            app.tabBars.buttons["CircleButton"].tap()
            XCTAssert(app.tables["CategoryTable"].waitForExistence(timeout: 2.0))
        }
    }

    func testOpenOptionModule() {
        let app = XCUIApplication()
        app.launch()
        if app.collectionViews["MainCollectionView"].waitForExistence(timeout: 2.0) {
            app.tabBars.buttons.element(boundBy: 1).tap()
            XCTAssert(app.tables["OptionsTable"].waitForExistence(timeout: 2.0))
        }
    }

    func testOpenTasks() {
        let app = XCUIApplication()
        app.launch()
        if app.collectionViews["MainCollectionView"].waitForExistence(timeout: 2.0) {
            self.openTasks(with: app, identifier: "Сегодня")
            self.openTasks(with: app, identifier: "Завтра")
            self.openTasks(with: app, identifier: "Просрочено")
            self.openTasks(with: app, identifier: "Завершено")
        }
    }

    // MARK: - Support method for open tasks method
    private func openTasks(with  app: XCUIApplication, identifier: String) {
        app.collectionViews["MainCollectionView"]/*@START_MENU_TOKEN@*/.cells/*[[".scrollViews.cells",".cells"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts[identifier].tap()
        XCTAssert(app.collectionViews["CalendarCollectionView"].waitForExistence(timeout: 3.0))
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }

    func testAddNewTasks() {
        let app = XCUIApplication()
        app.launch()
        if app.collectionViews["MainCollectionView"].waitForExistence(timeout: 2.0) {
            app.tabBars.buttons["CircleButton"].tap()
            app.textFields["Наименование задачи"].tap()
            app.textFields["Наименование задачи"].typeText("Name of task")
            let doneButton = app.keyboards.buttons["done"].waitForExistence(timeout: 2.0)
            doneButton ? app.keyboards.buttons["done"].tap() : app.keyboards.buttons["Готово"].tap()
            app.textViews["DescriptionTextView"].tap()
            app.textViews["DescriptionTextView"].typeText("Description of task")
            doneButton ? app.keyboards.buttons["done"].tap() : app.keyboards.buttons["Готово"].tap()
            app.tables["CategoryTable"].cells.element(boundBy: 0).tap()
            app.buttons["Добавить задачу"].tap()
            XCTAssert(app.collectionViews["MainCollectionView"].waitForExistence(timeout: 3.0))
        }
    }

    func testNotValidTask() {
        let app = XCUIApplication()
        app.launch()
        if app.collectionViews["MainCollectionView"].waitForExistence(timeout: 2.0) {
            app.tabBars.buttons["CircleButton"].tap()
            app.textViews["DescriptionTextView"].tap()
            app.textViews["DescriptionTextView"].typeText("Description of task")
            let doneButton = app.keyboards.buttons["done"].waitForExistence(timeout: 2.0)
            doneButton ? app.keyboards.buttons["done"].tap() : app.keyboards.buttons["Готово"].tap()
            app.tables["CategoryTable"].cells.element(boundBy: 0).tap()
            app.buttons["Добавить задачу"].tap()
            XCTAssert(app.staticTexts["Ошибка"].waitForExistence(timeout: 3.0))
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
