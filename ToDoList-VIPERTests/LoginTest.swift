//
//  LoginTest.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 30.07.2024.
//

import XCTest
@testable import ToDoList_VIPER

final class LoginTest: XCTestCase {
    var loginView: LoginViewProtocol!
    var loginPresenter: (LoginPresenterProtocol & LoginInteractorOutputProtocol)!
    var loginViewInteractor: LoginInteractorInputProtocol!
    var loginRouter: LoginRouterProtocol!
    var authKeyChainManager: AuthKeychainManagerProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        loginView = LoginController()
        loginPresenter = LoginPresenter()
        loginViewInteractor = LoginInteractor()
        loginRouter = LoginRouter()
        authKeyChainManager = AuthKeychainManager()
    }

    override func tearDownWithError() throws {
        loginView = nil
        loginPresenter = nil
        loginViewInteractor = nil
        loginRouter = nil
        try  super.tearDownWithError()
    }

    func testEmptyField() {
        loginView.presenter?.chekTheLogin(login: "", password: "")
        let userUid = authKeyChainManager.id
//        XCTAssertNil(userUid)

    }

    func testNotEmptyField() {
        loginView.presenter?.chekTheLogin(login: "boba96@mail.ru", password: "qwerty")
        let usetUid = authKeyChainManager.id
        XCTAssertNotNil(usetUid)

    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
