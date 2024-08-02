//
//  MainScreenInteractorTest.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 02.08.2024.
//

import XCTest
@testable import ToDoList_VIPER

final class MainScreenInteractorTest: XCTestCase {

    var mainView: MainScreenViewProtocol!
    var mainPresenter: (MainScreenPresenterProtocol & MainScreenInteractorOutputProtocol)!
    var mainInteractor: MainScreenInteractorInputProtocol!
    var mainRouter: MainScreenRouterProtocol!

    override func setUp() {
        super.setUp()
        mainView = MainScreenController()
        mainPresenter = MockMainPresenter()
        mainInteractor = MainScreenInteractor()
        mainRouter = MainScreenRouter()
    }

    override func tearDown() {
        mainView = nil
        mainPresenter = nil
        mainInteractor = nil
        mainRouter = nil
        super.tearDown()
    }

    func testRetriveUserData()  {
        mainView.presenter = mainPresenter
        mainPresenter.view = mainView
        mainPresenter.interactor = mainInteractor
        mainPresenter.router = mainRouter
        mainInteractor.presenter = mainPresenter

        let testPresenter = mainPresenter as! MockMainPresenter

        mainView.presenter?.updateUserData()
        let nameResult = testPresenter.nameIsRetrive
        let avatarResult = testPresenter.userAvatarIsRetrive
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            XCTAssertTrue(nameResult)
            XCTAssert(avatarResult)
        })
    }

    func testRetriveToDosCount() {
        mainView.presenter = mainPresenter
        mainPresenter.view = mainView
        mainPresenter.interactor = mainInteractor
        mainPresenter.router = mainRouter
        mainInteractor.presenter = mainPresenter

        let testPresenter = mainPresenter as! MockMainPresenter
        mainView.presenter?.getToDosCount()
        let result = testPresenter.todosCoutnIsRetrive
        XCTAssertTrue(result)
    }
}
