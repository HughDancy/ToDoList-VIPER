//
//  LoginScreenUITest.swift
//  ToDoList-VIPERUITests
//
//  Created by Борис Киселев on 06.08.2024.
//

import XCTest

final class LoginScreenUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNotValidEmail() {
        let app = XCUIApplication()
        app.launch()
        if app.buttons["Войти"].waitForExistence(timeout: 2.0) {
            app.textFields["Логин"].tap()
            app.textFields["Логин"].typeText("boba6@mailru")
            app.keyboards.buttons["next"].tap()
            XCUIApplication()/*@START_MENU_TOKEN@*/.secureTextFields["Пароль"]/*[[".scrollViews.secureTextFields[\"Пароль\"]",".secureTextFields[\"Пароль\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            XCUIApplication()/*@START_MENU_TOKEN@*/.secureTextFields["Пароль"]/*[[".scrollViews.secureTextFields[\"Пароль\"]",".secureTextFields[\"Пароль\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("qwerty")
            app.buttons["Войти"].tap()
            XCTAssertTrue(app.alerts["Ошибка"].waitForExistence(timeout: 2.0))
        }
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        if app.buttons["Войти"].waitForExistence(timeout: 2.0) {
            app.textFields["Логин"].tap()
            app.textFields["Логин"].typeText("boba96@mail.ru")
            app.keyboards.buttons["next"].tap()
            XCUIApplication()/*@START_MENU_TOKEN@*/.secureTextFields["Пароль"]/*[[".scrollViews.secureTextFields[\"Пароль\"]",".secureTextFields[\"Пароль\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            XCUIApplication()/*@START_MENU_TOKEN@*/.secureTextFields["Пароль"]/*[[".scrollViews.secureTextFields[\"Пароль\"]",".secureTextFields[\"Пароль\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("qwerty")
            app.buttons["Войти"].tap()
            XCTAssertTrue(app.collectionViews["MainCollectionView"].waitForExistence(timeout: 3.0))
        }
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
