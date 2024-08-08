//
//  ToDoListsProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 08.11.2023.
//

import UIKit

protocol ToDoListViewProtocol: AnyObject {
    var presenter: ToDoListPresenterProtocol? { get set }

    func showToDos(_ toDos: [[ToDoObject]])
}

protocol ToDoListPresenterProtocol: AnyObject {
    var view: ToDoListViewProtocol? { get set }
    var interactor: ToDoListInteractorInputProtocol? { get set }
    var router: ToDoListRouterProtocol? { get set }

    // VIEW -> PRESENTER
    func viewWillAppear()
    func showToDoDetail(_ toDoItem: ToDoObject)
    func showAddToDo()
    func removeToDo(_ toDoItem: ToDoObject)
    func doneToDo(_ toDoItem: ToDoObject)
}

protocol ToDoListInteractorInputProtocol: AnyObject {
    var presenter: ToDoListInteractorOutputProtocol? { get set }

    // PRESENTER -> INTERACTOR
    func retriveToDos()
    func deleteToDo(_ toDoItem: ToDoObject)
    func doneToDo(_ toDoItem: ToDoObject)
}

protocol ToDoListInteractorOutputProtocol: AnyObject {

    // INTERACTOR -> PRESENTER
    func didRemoveToDo(_ toDoItem: ToDoObject)
    func didRetriveToDos(_ toDoItems: [[ToDoObject]])
}

protocol ToDoListRouterProtocol: AnyObject {
    static func createToDoListModule() -> UIViewController

    // PRESENTER->ROUTER
    func presentToDoDetailScreen(from view: ToDoListViewProtocol, for: ToDoObject)
    func goAddToDoScreen(from view: ToDoListViewProtocol)
}

protocol ToDoDoneProtocol: AnyObject {
    func doneToDo(with index: Int, and section: Int)
}
