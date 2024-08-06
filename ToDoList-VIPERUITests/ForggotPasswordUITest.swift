//
//  ForggotPasswordUITest.swift
//  ToDoList-VIPERUITests
//
//  Created by Борис Киселев on 06.08.2024.
//

import XCTest

final class ForggotPasswordUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGoToForggotPassword() {
        let app = XCUIApplication()
        app.launch()
        if app.buttons["Войти"].exists {
            app.buttons["Забыли пароль?"].tap()
        }
    }

    func testNotValidEmail() {
        let app = XCUIApplication()
        app.launch()
        if app.buttons["Войти"].waitForExistence(timeout: 2.0) {
            app.buttons["Забыли пароль?"].tap()
            app.textFields["ForggotenField"].tap()
            app.textFields["ForggotenField"].typeText("brokemail.ru")
            let doneButton = app.keyboards.buttons["done"].waitForExistence(timeout: 2.0)
            doneButton ? app.keyboards.buttons["done"].tap() : app.keyboards.buttons["Готово"].tap()
            app.buttons["Сбросить пароль"].tap()
            XCTAssert(app.staticTexts["Ошибка"].waitForExistence(timeout: 2.0))
        }
    }

    func testValidEmail() {
        let app = XCUIApplication()
        app.launch()
        if app.buttons["Войти"].waitForExistence(timeout: 2.0) {
            XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["Забыли пароль?"]/*[[".scrollViews.buttons[\"Забыли пароль?\"]",".buttons[\"Забыли пароль?\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.textFields["ForggotenField"].tap()
            app.textFields["ForggotenField"].typeText("boba@mail.ru")
            let doneButton = app.keyboards.buttons["done"].waitForExistence(timeout: 2.0)
            doneButton ? app.keyboards.buttons["done"].tap() : app.keyboards.buttons["Готово"].tap()
            app.buttons["Сбросить пароль"].tap()
            XCTAssert(app.staticTexts["Успешно!"].waitForExistence(timeout: 2.0))

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
