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
        presenter = MockLoginPresenter()
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
        interactor.authManager = MockLoginAuthManager()
        interactor.firebaseStorage = MockLoginFirebaseStorageManager()
        let testPresenter = presenter as! MockLoginPresenter
        interactor.checkAutorizationData(login: "", password: "bobasport")
        let result = testPresenter.isLoginEmpty
        XCTAssertTrue((result))
    }

    func testEmptyPassword() {
        loginView.presenter = presenter
        presenter.view = loginView
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.authManager = MockLoginAuthManager()
        interactor.firebaseStorage = MockLoginFirebaseStorageManager()
        let testPresenter = presenter as! MockLoginPresenter
        interactor.checkAutorizationData(login: "user@mail.ru", password: "")
        let result = testPresenter.isEmptyPassword
        XCTAssertTrue(result)
    }

    func testNotValidEmail() {
        loginView.presenter = presenter
        presenter.view = loginView
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.authManager = MockLoginAuthManager()
        interactor.firebaseStorage = MockLoginFirebaseStorageManager()
        let testPresenter = presenter as! MockLoginPresenter
        interactor.checkAutorizationData(login: "str_mailru", password: "grekorome")
        let result = testPresenter.isEmailNotValid
        XCTAssertTrue(result)
    }

    func testWrongUserData() {
        loginView.presenter = presenter
        presenter.view = loginView
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.authManager = MockLoginAuthManager()
        interactor.firebaseStorage = MockLoginFirebaseStorageManager()
        let testPresenter = presenter as! MockLoginPresenter
        interactor.checkAutorizationData(login: "someDude@mail.com", password: "qWeRTy")
        let result = testPresenter.isDataWrong
        XCTAssertTrue(result)
    }

    func testCorrectUserData() {
        loginView.presenter = presenter
        presenter.view = loginView
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.authManager = MockLoginAuthManager()
        interactor.firebaseStorage = MockLoginFirebaseStorageManager()
        let testPresenter = presenter as! MockLoginPresenter
        interactor.checkAutorizationData(login: "user@mail.ru", password: "1234")
        let result = testPresenter.isSucces
        XCTAssertTrue(result)
    }
}
