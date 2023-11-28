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
    func addToDo(title: String, content: String, date: Date, done: Bool)
    func goBack()

}

protocol AddToDoInteractorInputProtocol: AnyObject {
    var presenter: AddToDoPresenterProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func saveToDo(title: String, content: String, date: Date, done: Bool)
}

protocol AddToDoInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    func backToMain()
}

protocol AddToDoRouterProtocol: AnyObject {
    static func createAddToDoModule(with parrentView: ToDoListViewProtocol) -> UIViewController
    func navigateBackToListViewController(from view: AddToDoViewProtocol)
}

