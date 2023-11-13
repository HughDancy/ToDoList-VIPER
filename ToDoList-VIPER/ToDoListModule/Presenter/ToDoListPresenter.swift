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
    
    func addToDo(_ toDoItem: ToDoItem) {
        interactor?.saveToDo(toDoItem)
    }
    
    func removeToDo(_ toDoItem: ToDoItem) {
        interactor?.deleteToDo(toDoItem)
    }
}

extension ToDoListPresenter: ToDoListInteractorOutputProtocol {
    func didAddToDo(_ toDoItem: ToDoItem) {
        interactor?.retriveToDos()
    }
    
    func didRemoveToDo(_ toDoItem: ToDoItem) {
        interactor?.retriveToDos()
    }
    
    func didRetriveToDos(_ toDoItems: [ToDoItem]) {
        view?.showToDos(toDoItems)
    }
    
    func onError(_ error: String) {
        view?.showErrorMessage(error)
    }
    
    
}
