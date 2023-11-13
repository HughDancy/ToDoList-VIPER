//
//  ToDoDetailPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.11.2023.
//

import UIKit

class ToDoDetailPresenter: ToDoDetailPresenterProtocol {
    weak var view: ToDoDetailViewProtocol?
    var interactor: TodoDetailInteractorInputProtocol?
    var router: ToDoDetailRouterProtocol?
    
    
    func viewDidLoad() {
        if let toDoItem = interactor?.toDoItem {
            view?.showToDo(toDoItem)
        }
    }
    
    func editToDo(title: String, content: String) {
        interactor?.editToDo(title: title, content: content)
    }
    
    func deleteToDo() {
        interactor?.deleteToDo()
    }
}

extension ToDoDetailPresenter: TodoDetailInteractorOutputProtocol {
    func didDeleteToDo() {
        if let view = view {
            router?.navigateBackToListViewController(from: view)
        }
    }
    
    func didEditToDo(_ toDoItem: ToDoItem) {
        view?.showToDo(toDoItem)
    }
}
