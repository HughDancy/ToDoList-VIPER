//
//  OnboardingUITest.swift
//  ToDoList-VIPERUITests
//
//  Created by Борис Киселев on 05.08.2024.
//

import XCTest


final class A_OnboardingUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOnboarding() throws {
        let app = XCUIApplication()
        app.launch()
        if app.images["OnboardingPicture"].waitForExistence(timeout: 5.0) {
            app.swipeLeft()
            app.swipeLeft()
            app.swipeLeft()
            app.swipeLeft()
            app.swipeLeft()
            app.buttons["Начать"].tap()
            XCTAssertTrue(app.buttons["Войти"].exists)
        }
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
