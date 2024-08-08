//
//  ToDoDetailsProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.11.2023.
//

import UIKit

protocol ToDoDetailViewProtocol: AnyObject {
    var presenter: ToDoDetailPresenterProtocol? { get set }

    // PRESENTER -> VIEW
    func showToDo(_ toDo: ToDoObject)
}

protocol ToDoDetailPresenterProtocol: AnyObject {
    var view: ToDoDetailViewProtocol? { get set }
    var interactor: TodoDetailInteractorInputProtocol? { get set }
    var router: ToDoDetailRouterProtocol? { get set }

    // VIEW -> PRESENTER
    func viewDidLoad()
    func editToDo(title: String, content: String, date: Date)
    func deleteToDo()
}

protocol TodoDetailInteractorInputProtocol: AnyObject {
    var presenter: TodoDetailInteractorOutputProtocol? { get set }
    var toDoItem: ToDoObject? { get set }

    // PRESENTER -> INTERACTOR
    func deleteToDo()
    func editToDo(title: String, content: String, date: Date)
}

protocol TodoDetailInteractorOutputProtocol: AnyObject {

    // INTERACTOR -> PRESENTER
    func didDeleteToDo()
    func didEditToDo(_ toDoItem: ToDoObject)
}

protocol ToDoDetailRouterProtocol: AnyObject {
    static func createToDoDetailModule(with toDo: ToDoObject) -> UIViewController

    // PRESENTER -> ROUTER
    func navigateBackToListViewController(from view: ToDoDetailViewProtocol)
}
