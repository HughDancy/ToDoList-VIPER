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
    
    //VIEW -> PRESENTER
    func viewWillAppear()
    func editToDo(title: String?, descriprion: String?, date: Date?, color: UIColor, iconName: String)
    func whantDeleteToDo(_ toDo: ToDoObject)
}

protocol ToDosDetailInteractorInputProtocol: AnyObject {
    var presenter: ToDosDetailInteractorOutputProtocol? { get set }
    var toDoItem: ToDoObject? { get set }
    
    //PRESENTER -> INTERACTOR
    func editTask(title: String?, descriprion: String?, date: Date?, color: UIColor, iconName: String)
    func deleteTask(_ toDo: ToDoObject)
}

protocol ToDosDetailInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESTNER
    func deleteToDo(_ toDo: ToDoObject)
    func didDeleteToDo()
    func didEditToDo(_ toDo: ToDoObject)
    func showAllert(with status: ToDoDetailStatus)
}

protocol ToDosDetailRouterProtocol: AnyObject {
    var presenter: ToDosDetailInteractorOutputProtocol? { get set }
    static func createModule(with toDo: ToDoObject) -> UIViewController
    
    //PRESENTER -> ROUTER
    func showAllert(with view: ToDosDetailViewProtocol, status: ToDoDetailStatus, toDo: ToDoObject?)
    func goBackToTasks(with view: ToDosDetailViewProtocol)
}

enum ToDoDetailStatus {
    case allSave
    case error
    case delete
}
