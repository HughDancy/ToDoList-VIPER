//
//  RegistrationUITest.swift
//  ToDoList-VIPERUITests
//
//  Created by Борис Киселев on 06.08.2024.
//

import XCTest

final class C_RegistrationUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmptyNameField() {
        let app = XCUIApplication()
        app.launch()
        if app.buttons["Войти"].waitForExistence(timeout:  5.0) {
            app.buttons["Зарегестрироваться"].tap()
            app.images["RegistrationUserAvatar"].tap()
            app.buttons["Галлерея"].tap()
            app.images.element(boundBy: 1).tap()
            app.buttons["Choose"].tap()
            app.buttons["Choose"].tap()
            app.textFields["Имя"].tap()
            app.textFields["Имя"].typeText("")
            let nextButton = app.keyboards.buttons["continue"].waitForExistence(timeout: 2.0)
//            nextButton ? app.keyboards.buttons["continue"].tap() : app.keyboards.buttons["Дальше"].tap()
            app.textFields["Email адресс"].tap()
            app.textFields["Email адресс"].typeText("bobr@kurva.pol")
            nextButton ? app.keyboards.buttons["continue"].tap() : app.keyboards.buttons["Дальше"].tap()
            app.textFields["Пароль"].typeText("japerdolle")
            let doneButton = app.keyboards.buttons["done"].waitForExistence(timeout: 2.0)
            doneButton ? app.keyboards.buttons["done"].tap() : app.keyboards.buttons["Готово"].tap()
            app.buttons["Зарегистрироваться"].tap()
            XCTAssert(app.alerts["Вы не заполнили обязательные для регистрации поля"].waitForExistence(timeout: 2.0))
        }
    }

    func testValidData() {
        let app = XCUIApplication()
        app.launch()
        if app.buttons["Войти"].waitForExistence(timeout:  5.0) {
            app.buttons["Зарегестрироваться"].tap()
            app.images["RegistrationUserAvatar"].tap()
            app.buttons["Галлерея"].tap()
            app.images.element(boundBy: 1).tap()
            app.buttons["Choose"].tap()
            app.buttons["Choose"].tap()
            app.textFields["Имя"].tap()
            app.textFields["Имя"].typeText("Bobre")
            let nextButton = app.keyboards.buttons["continue"].waitForExistence(timeout: 2.0)
            nextButton ? app.keyboards.buttons["continue"].tap() : app.keyboards.buttons["Дальше"].tap()
            app.textFields["Email адресс"].typeText("bobr@kurva.pol")
            nextButton ? app.keyboards.buttons["continue"].tap() : app.keyboards.buttons["Дальше"].tap()
            app.textFields["Пароль"].typeText("japerdolle")
            let doneButton = app.keyboards.buttons["done"].waitForExistence(timeout: 2.0)
            doneButton ? app.keyboards.buttons["done"].tap() : app.keyboards.buttons["Готово"].tap()
            app.buttons["Зарегистрироваться"].tap()
            XCTAssert(app.alerts["Регистрация прошла успешно!"].waitForExistence(timeout: 2.0))
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
