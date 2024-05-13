//
//  ToDosInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.03.2024.
//

import UIKit

final class ToDosInteractor: ToDosInteractorInputProtocol {
   weak var presenter: ToDosInteractorOutputProtocol?
    let storage = TaskStorageManager.instance
    
    func fetchFirstTasks(_ status: ToDoListStatus) {
        self.fetchSortedToDos(with: status, and: nil)
    }

    func fetchTask(date: Date, status: ToDoListStatus) {
        self.fetchSortedToDos(with: status, and: date)
    }
    
    //MAYBE REFACTOR
    func fetchSortedToDos(with status: ToDoListStatus, and date: Date?) {
        switch status {
        case .today:
        guard let date = date else {
            let todayTasks = storage.fetchConcreteToDos(with: Date.today)
            self.presenter?.getTask(todayTasks)
            return
        }
            let todayTasks = storage.fetchConcreteToDos(with: date)
            presenter?.getTask(todayTasks)
        case .tommorow:
            guard let date = date else {
                let tommorowTasks = storage.fetchConcreteToDos(with: Date.tomorrow)
                self.presenter?.getTask(tommorowTasks)
                return
            }
            let tommorowTasks = storage.fetchConcreteToDos(with: date)
            presenter?.getTask(tommorowTasks)
        case .overdue:
            //MARK: - Change methods
            guard let date = date else {
                let overdueTasks = storage.fetchOverdueToDos(with: Date.yesterday)
                self.presenter?.getTask(overdueTasks)
                return
            }
                let overdueTasks = storage.fetchOverdueToDos(with: date)
                presenter?.getTask(overdueTasks)
        case .done:
            guard let date = date else {
                let doneTasks = storage.fetchDoneToDos(with: Date.today)
                self.presenter?.getTask(doneTasks)
                return
            }
            let doneTasks = storage.fetchDoneToDos(with: date)
            presenter?.getTask(doneTasks)
        }
    }
    
    func doneTask(_ task: ToDoObject) {
        storage.doneToDo(item: task)
    }
    
    func deleteTask(_ task: ToDoObject) {
        storage.deleteToDoObject(item: task)
    }
}
