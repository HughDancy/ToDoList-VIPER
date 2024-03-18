//
//  AddNewToDosProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 18.03.2024.
//

import UIKit

protocol AddNewToDoViewProtocol: AnyObject {
    var presenter: AddNewToDoPresenterProtocol? { get set }

}

protocol AddNewToDoPresenterProtocol: AnyObject {
    var view: AddNewToDoViewProtocol? { get set }
    var interactor: AddNewToDoInteractorProtocol? { get set }
    var router: AddNewToDoRouterProtocol? { get set }
    
    //VIEW -> PRESENTER
    func addNewToDo(with name: String, description: String, date: Date, mark: String)
    func goBackToMain()
}

protocol AddNewToDoInteractorProtocol: AnyObject {
    var presenter: AddNewToDoPresenterProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func addNewToDo(with name: String, description: String, date: Date, mark: String)
}

protocol AddNewToDoRouterProtocol: AnyObject {
    static func createAddNewToDoModule() -> UIViewController
    
    //PRESENTER -> ROUTER
    func dismiss(from view: AddNewToDoViewProtocol)
}
