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
    func editToDo(title: String?, descriprion: String?, date: Date?, color: String)
    func deleteToDo(_ toDo: ToDoObject)
}

protocol ToDosDetailInteractorInputProtocol: AnyObject {
    var presenter: ToDosDetailInteractorOutputProtocol? { get set }
    var toDoItem: ToDoObject? { get set }
    
    //PRESENTER -> INTERACTOR
    func editTask(title: String?, descriprion: String?, date: Date?, color: String)
    func deleteTask(_ toDo: ToDoObject)
}

protocol ToDosDetailInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESTNER
    func didDeleteToDo()
    func didEditToDo(_ toDo: ToDoObject)
    func showAllert()
}

protocol ToDosDetailRouterProtocol: AnyObject {
    static func createModule(with toDo: ToDoObject) -> UIViewController
    
    //PRESENTER -> ROUTER
    func showAllert(with view: ToDosDetailViewProtocol)
    func goBackToTasks(with view: ToDosDetailViewProtocol)
}
