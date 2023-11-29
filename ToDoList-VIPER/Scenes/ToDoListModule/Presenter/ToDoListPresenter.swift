//
//  ToDoListPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 09.11.2023.
//

import Foundation

final class ToDoListPresenter: ToDoListPresenterProtocol {
  
    //MARK: - Elemetns
    weak var view: ToDoListViewProtocol?
    var interactor: ToDoListInteractorInputProtocol?
    var router: ToDoListRouterProtocol?
    
    //MARK: - Protocol methods
    func viewWillAppear() {
        interactor?.retriveToDos()
    }
    
    func showToDoDetail(_ toDoItem: ToDoObject) {
        guard let view = view  else { return }
        router?.presentToDoDetailScreen(from: view, for: toDoItem)
    }
    
    func showAddToDo() {
        guard let view = view else { return }
        router?.goAddToDoScreen(from: view)
    }
    
    func removeToDo(_ toDoItem: ToDoObject) {
        interactor?.deleteToDo(toDoItem)
    }
    
    func doneToDo(_ toDoItem: ToDoObject) {
        interactor?.doneToDo(toDoItem)
    }
}

extension ToDoListPresenter: ToDoListInteractorOutputProtocol {
    func didRemoveToDo(_ toDoItem: ToDoObject) {
        interactor?.retriveToDos()
    }
    
    func didRetriveToDos(_ toDoItems: [[ToDoObject]]) {
        view?.showToDos(toDoItems)
    }
}
