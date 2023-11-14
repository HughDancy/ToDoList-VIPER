//
//  ExecuteProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.11.2023.
//

import UIKit

protocol ExecuteToDoViewProtocol: AnyObject {
    var presenter: ExecuteToDoPresenterProtocol? { get set }
    
    func showExcuteToDos(_ toDo: [ToDoItem])
}

protocol ExecuteToDoPresenterProtocol: AnyObject {
    var view: ExecuteToDoViewProtocol? { get set }
    var interactor: ExecuteToDoInteractorInputProtocol? { get set }
    var router: ExecuteToDoRouterProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewWillAppear()
    func showToDoDetail(_ toDoItem: ToDoItem)
    func removeToDo(_ toDoItem: ToDoItem)
}

protocol ExecuteToDoInteractorInputProtocol: AnyObject {
    var presenter: ExecuteToDoInteractorOutputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func retriveToDos()
    func deleteToDo(_ toDoItem: ToDoItem)
}

protocol ExecuteToDoInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    func didRemoveToDo(_ toDoItem: ToDoItem)
    func didRetriveToDos(_ toDoItems: [ToDoItem])

}

protocol ExecuteToDoRouterProtocol: AnyObject {
    static func createToDoListModule() -> UIViewController
}
