//
//  ToDosPresenter.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.03.2024.
//

import UIKit

final class ToDosPresenter: ToDosPresenterProtocol {

    weak var view: ToDosViewProtocol?
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

    func doneToDo(_ taskId: UUID) {
        interactor?.doneTask(taskId)
    }

    func deleteToDo(_ taskId: UUID) {
        interactor?.deleteTask(taskId)
    }

    func goToTask(_ task: ToDoObject) {
        guard let view = view else { return }
        router?.goToTask(task, from: view)
    }
}

extension ToDosPresenter: ToDosInteractorOutputProtocol {
    func getTask(_ tasks: [ToDoObject]?) {
        guard let tasks = tasks else { return }
        view?.showToDos(tasks)
    }
}
