//
//  ToDoDetailsProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.11.2023.
//

import UIKit

protocol ToDoDetailViewProtocol: AnyObject {
    var presenter: ToDoDetailPresenterProtocol? { get set }
    
    //PRESENTER -> VIEW
    func showToDo(_ toDo: ToDoItem)
}

protocol ToDoDetailPresenterProtocol: AnyObject {
    var view: ToDoDetailViewProtocol? { get set }
    var interactor: TodoDetailInteractorInputProtocol? { get set }
    var router: ToDoDetailRouterProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func editToDo(title: String, content: String)
    func deleteToDo()
}

protocol TodoDetailInteractorInputProtocol: AnyObject {
    var presenter: TodoDetailInteractorOutputProtocol? { get set }
    var toDoItem: ToDoItem? { get set }
    
    //PRESENTER -> INTERACTOR
    func deleteToDo()
    func editToDo(title: String, content: String)
}

protocol TodoDetailInteractorOutputProtocol: AnyObject {
    
    //INTERACTOR -> PRESENTER
    func didDeleteToDo()
    func didEditToDo(_ toDoItem: ToDoItem)
}

protocol ToDoDetailRouterProtocol: AnyObject {
    static func createToDoDetailModule(with toDo: ToDoItem) -> UIViewController
    
    //PRESENTER -> ROUTER
    func navigateBackToListViewController(from view: ToDoDetailViewProtocol)
}
