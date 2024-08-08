//
//  AddNewToDoInteractorTest.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 02.08.2024.
//

import XCTest
@testable import ToDoList_VIPER

final class AddNewToDoInteractorTest: XCTestCase {

    var view: AddNewToDoViewProtocol!
    var presenter: AddNewToDoPresenterProtocol!
    var interactor: AddNewToDoInteractorProtocol!
    var router: AddNewToDoRouterProtocol!

    override func setUp() {
        super.setUp()
        view = AddNewToDoController()
        presenter = MockAddNewToDoPresenter()
        interactor = AddNewToDoInteractor()
        router = AddNewToDoRouter()
    }

    override func tearDown() {
        view = nil
        presenter = nil
        interactor = nil
        router = nil
        super.tearDown()
    }

    func testError() {
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        let testPresenter = presenter as! MockAddNewToDoPresenter
        view.presenter?.addNewToDo(with: "", description: "something", date: Date.today, colorCategory: .taskGreen, iconName: "person")
        let result = testPresenter.error
        XCTAssertTrue(result)
    }

    func testSucces() {
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        let testPresenter = presenter as! MockAddNewToDoPresenter
        view.presenter?.addNewToDo(with: "Doing Something", description: "something", date: Date.today, colorCategory: .taskGreen, iconName: "person")
        let result = testPresenter.succes
        XCTAssertTrue(result)
    }
}
