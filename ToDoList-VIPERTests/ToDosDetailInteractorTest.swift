//
//  ToDosDetailInteractorTest.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 02.08.2024.
//

import XCTest
@testable import ToDoList_VIPER

final class ToDosDetailInteractorTest: XCTestCase {

    var view: ToDosDetailViewProtocol!
    var presenter: (ToDosDetailPresenterProtocol & ToDosDetailInteractorOutputProtocol)!
    var interactor: ToDosDetailInteractorInputProtocol!
    var router: ToDosDetailRouterProtocol!

    override func setUp()  {
        super.setUp()
        view = ToDosDetailController()
        presenter = MockToDosDetailPresenter()
        interactor = ToDosDetailInteractor()
        router = ToDosDetailMocRouter()
    }

    override  func tearDown() {
        view = nil
        presenter = nil
        interactor = nil
        router = nil
        super.tearDown()
    }

    func testEditToDo() {
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.toDoItem = TaskStorageManager.instance.createMockObject()
        let testPresenter = presenter as! MockToDosDetailPresenter
        view.presenter?.editToDo(title: "Bob", descriprion: "bob", date: Date.today, color: .taskGreen, iconName: "person")
        let result = testPresenter.status
        XCTAssertNotNil(result)
    }

    func testDeleteToDo() {
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.presenter = presenter
        interactor.toDoItem = TaskStorageManager.instance.createMockObject()
        let testPresenter = presenter as! MockToDosDetailPresenter
        view.presenter?.whantDeleteToDo()
        let result = testPresenter.deleteIsSucces
        XCTAssertTrue(result)
    }

    func testSuccesEditTask() {
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.presenter = presenter
        interactor.toDoItem = TaskStorageManager.instance.createMockObject()
        interactor.localStorage = MockLocalStorage()
        interactor.firebaseStorage = MockServerStorage()
        let testPresenter = presenter as! MockToDosDetailPresenter
        view.presenter?.editToDo(title: "som", descriprion: "grow", date: Date.today, color: .taskGreen, iconName: "person")
        let result = testPresenter.succes
        XCTAssertTrue(result)
    }
}
