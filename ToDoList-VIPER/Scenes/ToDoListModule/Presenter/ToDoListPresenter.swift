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
    
    func showToDoDetail(_ toDoItem: ToDoItem) {
        guard let view = view  else { return }
        router?.presentToDoDetailScreen(from: view, for: toDoItem)
    }
    
    func showAddToDo() {
        guard let view = view else { return }
        router?.goAddToDoScreen(from: view)
    }
    
    func removeToDo(_ toDoItem: ToDoItem) {
        interactor?.deleteToDo(toDoItem)
    }
    
    func doneToDo(_ toDoItem: ToDoItem) {
        interactor?.doneToDo(toDoItem)
    }
}

extension ToDoListPresenter: ToDoListInteractorOutputProtocol {
    func didRemoveToDo(_ toDoItem: ToDoItem) {
        interactor?.retriveToDos()
    }
    
    func didRetriveToDos(_ toDoItems: [ToDoItem]) {
        view?.showToDos(toDoItems)
    }
}
