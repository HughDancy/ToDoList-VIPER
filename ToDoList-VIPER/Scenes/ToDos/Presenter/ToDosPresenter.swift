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
    var date: ToDoListStatus?
    
    func viewWillAppear() {
        guard let statusDate = date else { return }
        interactor?.fetchFirstTasks(statusDate)
    }
    
    func fetchToDos(date: Date) {
        interactor?.fetchTask(date: date)
    }
    
    func doneToDo(_ task: ToDoObject) {
        interactor?.doneTask(task)
    }
    
    func deleteToDo(_ task: ToDoObject) {
        interactor?.deleteTask(task)
    }
    
    func goToTask(_ task: ToDoObject) {
        router?.goToTask(task)
    }
}

extension ToDosPresenter: ToDosInteractorOutputProtocol {
    func getTask(_ tasks: [ToDoObject]) {
        view?.showToDos(tasks)
    }
}
