//
//  OverduePresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.11.2023.
//

import Foundation

final class OverduePresenter: OverduePresenterProtocol {
    weak var view: OverdueViewProtocol?
    var interactor: OverdueInteractorInputProtocol?
    var router: OverdueRouterProtocol?
    
    
    func viewWillAppear() {
        interactor?.retriveToDos()
    }
    
    func showToDetail(_ toDoItem: ToDoObject) {
        guard let view = view  else { return }
        router?.presentToDoDetailScreen(from: view, for: toDoItem)
    }
    
    func removeToDo(_ toDoItem: ToDoObject) {
        interactor?.deleteToDos(toDoItem)
    }
    
    func doneToDo(_ toDoItem: ToDoObject) {
        interactor?.doneToDo(toDoItem)
    }
}

extension OverduePresenter: OverdueInteractorOutputProtocol {
    func didRetriveToDos(_ toDos: [[ToDoObject]]) {
        view?.showToDos(toDos)
    }
    
    func didRemoveToDo() {
        interactor?.retriveToDos()
    }
    
    
}
