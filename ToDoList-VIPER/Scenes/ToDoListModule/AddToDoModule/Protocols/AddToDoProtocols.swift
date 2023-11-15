//
//  AddToDoProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.11.2023.
//

import UIKit

protocol AddToDoViewProtocol: AnyObject {
    var presenter: AddToDoPresenterProtocol? { get set }
}

protocol AddToDoPresenterProtocol: AnyObject {
    var view: AddToDoViewProtocol? { get set }
    var interactor: AddToDoInteractorInputProtocol? { get set }
    var router: AddToDoRouterProtocol? { get set }
    
    //VIEW -> PRESENTER
    func addToDo(_ toDoItem: ToDoItem)

}

protocol AddToDoInteractorInputProtocol: AnyObject {
    var presenter: AddToDoInteractorOutputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func saveToDo(_ toDoItem: ToDoItem)
}

protocol AddToDoInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    func didAddToDo(_ toDoItem: ToDoItem)
}

protocol AddToDoRouterProtocol: AnyObject {
    static func createAddToDoModule() -> UIViewController
    
}
