//
//  ExecuteToDoPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.11.2023.
//

import UIKit

class ExecuteToDoPresenter: ExecuteToDoPresenterProtocol {
    weak var view: ExecuteToDoViewProtocol?
    var interactor: ExecuteToDoInteractorInputProtocol?
    var router: ExecuteToDoRouterProtocol?
    
    func viewWillAppear() {
        interactor?.retriveToDos()
    }
    
    func removeToDo(_ toDoItem: ToDoObject) {
        interactor?.deleteToDo(toDoItem)
    }
}

extension ExecuteToDoPresenter:  ExecuteToDoInteractorOutputProtocol {
    func didRemoveToDo(_ toDoItem: ToDoObject) {
        interactor?.deleteToDo(toDoItem)
    }
    
    func didRetriveToDos(_ toDoItems: [ToDoObject]) {
        view?.showExcuteToDos(toDoItems)
    }
    
    
}
