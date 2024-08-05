//
//  ToDosInteractorTest.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 02.08.2024.
//

import XCTest
@testable import ToDoList_VIPER

final class ToDosInteractorTest: XCTestCase {

    var view: ToDosViewProtocol!
    var presenter: (ToDosPresenterProtocol & ToDosInteractorOutputProtocol)!
    var interactor: ToDosInteractorInputProtocol!
    var router: ToDosRouterProtocol!

    override func setUp() {
        super.setUp()
        view = ToDoController()
        presenter = MockToDosPresenter()
        interactor = ToDosInteractor()
        router = ToDosRouter()
    }

    override func tearDown() {
        view = nil
        presenter = nil
        interactor = nil
        router = nil
        super.tearDown()
    }

    func testFirstTasks() {
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        presenter.status = .today
        let testPresenter = presenter as! MockToDosPresenter
        interactor?.fetchFirstTasks(.today)
        let result = testPresenter.taskIsRerive
        XCTAssertTrue(result)
    }

    func testTommorowTasks() {
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        presenter.status = .tommorow
        let testPresenter = presenter as! MockToDosPresenter
        interactor?.fetchTask(date: Date.tomorrow, status: .tommorow)
        let result = testPresenter.taskIsRerive
        XCTAssertTrue(result)
    }

    func testDoneToDos() {
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        presenter.status = .done
        let testPresenter = presenter as! MockToDosPresenter
        view.presenter?.getToDos()
        let result = testPresenter.taskIsRerive
        XCTAssertTrue(result)
    }

    func testOverdueToDos() {
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        presenter.status = .overdue
        let testPresenter = presenter as! MockToDosPresenter
        view.presenter?.getToDos()
        let result = testPresenter.taskIsRerive
        XCTAssertTrue(result)
    }

    func testConcreteDateToDos() {
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        presenter.status = .tommorow
        let testPresenter = presenter as! MockToDosPresenter
        view.presenter?.fetchToDos(date: Date.tomorrow)
        let result = testPresenter.taskIsRerive
        XCTAssertTrue(result)
    }
}
