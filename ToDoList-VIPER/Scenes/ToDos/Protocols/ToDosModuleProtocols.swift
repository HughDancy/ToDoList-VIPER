//
//  ToDosModuleProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.03.2024.
//

import UIKit

protocol ToDosViewProtocol: AnyObject {
    var presenter: ToDosPresenterProtocol? { get set }
    
    func fetchToDos(date: Date)
    func showToDos(_ toDos: [ToDoObject])
}

protocol ToDosPresenterProtocol: AnyObject {
    var view: ToDosViewProtocol? { get set }
    var interactor: ToDosInteractorInputProtocol? { get set }
    var router: ToDosRouterProtocol? { get set }
    var status: ToDoListStatus? { get set }
    
    //VIEW -> PRESENTER
    func getToDos()
    func fetchToDos(date: Date)
    func updateToDosForDay(_ date: Date)
    func doneToDo(_ task: ToDoObject)
    func deleteToDo(_ task: ToDoObject)
    func goToTask(_ task: ToDoObject)
}

protocol ToDosInteractorInputProtocol: AnyObject {
    var presenter: ToDosInteractorOutputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func fetchFirstTasks(_ status: ToDoListStatus)
    func fetchTask(date: Date, status: ToDoListStatus)
    func doneTask(_ task: ToDoObject)
    func deleteTask(_ task: ToDoObject)
}

protocol ToDosInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    func getTask(_ tasks: [ToDoObject])
}

protocol ToDosRouterProtocol: AnyObject {
    static func createToDosModule(with status: ToDoListStatus) -> UIViewController
    
    //PRESENTER -> ROUTER
    func goToTask(_ task: ToDoObject, from view: ToDosViewProtocol)
}

enum ToDoListStatus {
    case today
    case tommorow
    case overdue
    case done
}
