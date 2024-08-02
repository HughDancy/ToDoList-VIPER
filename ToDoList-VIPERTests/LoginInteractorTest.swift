//
//  LoginInteractorTest.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 02.08.2024.
//

import XCTest
@testable import ToDoList_VIPER

final class LoginInteractorTest: XCTestCase {
    
    var loginView: LoginViewProtocol!
    var presenter: (LoginPresenterProtocol & LoginInteractorOutputProtocol)!
    var interactor: LoginInteractorInputProtocol!
    var router: LoginRouterProtocol!

    override func setUp() {
        loginView = LoginController()
        presenter = LoginMockPresenter()
        interactor = LoginInteractor()
        router = LoginRouter()
        super.setUp()
    }

    override func tearDown() {
        loginView = nil
        presenter = nil
        interactor = nil
        router = nil
        super.tearDown()
    }

    func testEmptyLogin() {
        loginView.presenter = presenter
        presenter.view = loginView
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        let testPresenter = presenter as! LoginMockPresenter
        loginView.presenter?.chekTheLogin(login: "", password: "bobasport")
        let result = testPresenter.emptyLogin
        XCTAssertTrue((result))
    }

    func testEmptyPassword() {
        loginView.presenter = presenter
        presenter.view = loginView
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        let testPresenter = presenter as! LoginMockPresenter
        loginView.presenter?.chekTheLogin(login: "user@mail.ru", password: "")
        let result = testPresenter.emptyPass
        XCTAssertTrue(result)
    }

    func testNotValidEmail() {
        loginView.presenter = presenter
        presenter.view = loginView
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        let testPresenter = presenter as! LoginMockPresenter
        loginView.presenter?.chekTheLogin(login: "str_mailru", password: "grekorome")
        let result = testPresenter.notValidEmail
        XCTAssertTrue(result)
    }
}
