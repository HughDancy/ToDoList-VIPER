//
//  ExecuteProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.11.2023.
//

import UIKit

protocol ExecuteToDoViewProtocol: AnyObject {
    var presenter: ExecuteToDoPresenterProtocol? { get set }

    func showExcuteToDos(_ toDo: [[ToDoObject]])
}

protocol ExecuteToDoPresenterProtocol: AnyObject {
    var view: ExecuteToDoViewProtocol? { get set }
    var interactor: ExecuteToDoInteractorInputProtocol? { get set }
    var router: ExecuteToDoRouterProtocol? { get set }

    // VIEW -> PRESENTER
    func viewWillAppear()
    func removeToDo(_ toDoItem: ToDoObject)
}

protocol ExecuteToDoInteractorInputProtocol: AnyObject {
    var presenter: ExecuteToDoInteractorOutputProtocol? { get set }

    // PRESENTER -> INTERACTOR
    func retriveToDos()
    func deleteToDo(_ toDoItem: ToDoObject)
}

protocol ExecuteToDoInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didRemoveToDo()
    func didRetriveToDos(_ toDoItems: [[ToDoObject]])

}

protocol ExecuteToDoRouterProtocol: AnyObject {
    static func createToDoListModule() -> UIViewController
}
