//
//  ToDoListsProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 08.11.2023.
//

import UIKit

protocol ToDoListViewProtocol: AnyObject {
    var presenter: ToDoListPresenterProtocol? { get set }
    
    func showToDos(_ toDos: [ToDoItem])
    func showErrorMessage(_ message: String)
}

protocol ToDoListPresenterProtocol: AnyObject {
    var view: ToDoListViewProtocol? { get set }
    var interactor: ToDoListInteractorInputProtocol? { get set }
    var router: ToDoListRouterProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewWillAppear()
    func showToDoDetail(_ toDoItem: ToDoItem)
    func showAddToDo()
    func addToDo(_ toDoItem: ToDoItem)
    func removeToDo(_ toDoItem: ToDoItem)
    func doneToDo(_ toDoItem: ToDoItem)
}


protocol ToDoListInteractorInputProtocol: AnyObject {
    var presenter: ToDoListInteractorOutputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func retriveToDos()
    func saveToDo(_ toDoItem: ToDoItem)
    func deleteToDo(_ toDoItem: ToDoItem)
    func doneToDo(_ toDoItem: ToDoItem)
    
}

protocol ToDoListInteractorOutputProtocol: AnyObject {
    
    //INTERACTOR -> PRESENTER
    func didAddToDo(_ toDoItem: ToDoItem)
    func didRemoveToDo(_ toDoItem: ToDoItem)
    func didRetriveToDos(_ toDoItems: [ToDoItem])
    func onError(_ error: String)
}

protocol ToDoListRouterProtocol: AnyObject {
    static func createToDoListModule() -> UIViewController
    
    //PRESENTER->ROUTER
    func presentToDoDetailScreen(from view: ToDoListViewProtocol, for: ToDoItem)
    func goAddToDoScreen(from view: ToDoListViewProtocol)
}

protocol ToDoDoneProtocol: AnyObject {
    func doneToDo(with index: Int)
}
