//
//  ToDosDetailProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.04.2024.
//

import UIKit

protocol ToDosDetailViewProtocol: AnyObject {
    var presenter: ToDosDetailPresenterProtocol? { get set }

    func showToDoItem(_ toDo: ToDoObject)
}

protocol ToDosDetailPresenterProtocol: AnyObject {
    var view: ToDosDetailViewProtocol? { get set }
    var interactor: ToDosDetailInteractorInputProtocol? { get set }
    var router: ToDosDetailRouterProtocol? { get set }

    // VIEW -> PRESENTER
    func getToDo()
    func editToDo(title: String?, descriprion: String?, date: Date?, color: UIColor, iconName: String)
    func whantDeleteToDo()
}

protocol ToDosDetailInteractorInputProtocol: AnyObject {
    var presenter: ToDosDetailInteractorOutputProtocol? { get set }
    var toDoItem: ToDoObject? { get set }

    // PRESENTER -> INTERACTOR
    func editTask(title: String?, descriprion: String?, date: Date?, color: UIColor, iconName: String)
    func deleteTask()
}

protocol ToDosDetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESTNER
    func deleteToDo()
    func didDeleteToDo()
    func showAllert(with status: ToDoDetailStatus)
}

protocol ToDosDetailRouterProtocol: AnyObject {
    var presenter: ToDosDetailInteractorOutputProtocol? { get set }

    // PRESENTER -> ROUTER
    func showAllert(with view: ToDosDetailViewProtocol, status: ToDoDetailStatus)
    func goBackToTasks(with view: ToDosDetailViewProtocol)
}

enum ToDoDetailStatus {
    case allSave
    case error
    case delete
}
