//
//  OverdueProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.11.2023.
//

import UIKit

protocol OverdueViewProtocol: AnyObject {
    var presenter: OverduePresenterProtocol? { get set }
    func showToDos(_ toDos: [[ToDoObject]])
}

protocol OverduePresenterProtocol: AnyObject {
    var view: OverdueViewProtocol? { get set }
    var interactor: OverdueInteractorInputProtocol? { get set }
    var router: OverdueRouterProtocol? { get set }
    
    //MARK: View -> Presenter
    func viewWillAppear()
    func showToDetail(_ toDoItem: ToDoObject)
    func removeToDo(_ toDoItem: ToDoObject)
    func doneToDo(_ toDoItem: ToDoObject)
}

protocol OverdueInteractorInputProtocol: AnyObject {
    var presenter: OverduePresenterProtocol? { get set }
    
    //PRESENTER -> Intreractor
    func retriveToDos()
    func deleteToDos(_ toDo: ToDoObject)
    func doneToDo(_ toDo: ToDoObject)
}

protocol OverdueInteractorOutputProtocol: AnyObject {
    
    //INTERACTOR -> PRESENTER
    func didRetriveToDos(_ toDos: [[ToDoObject]])
    func didRemoveToDo()
}

protocol OverdueRouterProtocol: AnyObject {
    static func createOverdueModule() -> UIViewController
    
    //PRESENTER -> ROUTER
    func presentToDoDetailScreen(from view: OverdueViewProtocol, for: ToDoObject)
}
