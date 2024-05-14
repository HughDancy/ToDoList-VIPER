//
//  ToDosPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.03.2024.
//

import UIKit

final class ToDosPresenter: ToDosPresenterProtocol {
    weak var view:  ToDosViewProtocol?
    var interactor: ToDosInteractorInputProtocol?
    var router: ToDosRouterProtocol?
    var status: ToDoListStatus?
    
    func getToDos() {
        guard let statusDate = status else { return }
        interactor?.fetchFirstTasks(statusDate)
    }
    
    func fetchToDos(date: Date) {
        guard let status = self.status else { return }
        interactor?.fetchTask(date: date, status: status)
    }
    
    func updateToDosForDay(_ date: Date) {
        guard let status = self.status else { return }
        interactor?.fetchTask(date: date, status: status)
    }
    
    func doneToDo(_ task: ToDoObject) {
        interactor?.doneTask(task)
    }
    
    func deleteToDo(_ task: ToDoObject) {
        interactor?.deleteTask(task)
    }
    
    func goToTask(_ task: ToDoObject) {
        guard let view = view else { return }
        router?.goToTask(task, from: view)
    }
}

extension ToDosPresenter: ToDosInteractorOutputProtocol {
    func getTask(_ tasks: [ToDoObject]) {
        view?.showToDos(tasks)
    }
}
