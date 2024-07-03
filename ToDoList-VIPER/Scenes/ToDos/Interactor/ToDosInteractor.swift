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
    let firebaseStorage = FirebaseStorageManager()
    
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
            var todayTasks = storage.fetchConcreteToDos(with: Date.today)
            todayTasks = self.sortByDone(items: todayTasks)
            self.presenter?.getTask(todayTasks)
            return
        }
            var todayTasks = storage.fetchConcreteToDos(with: date)
            todayTasks = self.sortByDone(items: todayTasks)
            presenter?.getTask(todayTasks)
        case .tommorow:
            guard let date = date else {
                var tommorowTasks = storage.fetchConcreteToDos(with: Date.tomorrow)
                tommorowTasks = self.sortByDone(items: tommorowTasks)
                self.presenter?.getTask(tommorowTasks)
                return
            }
            var tommorowTasks = storage.fetchConcreteToDos(with: date)
            tommorowTasks = self.sortByDone(items: tommorowTasks)
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
        let deletedTask = ToDoTask.convertToToDoTask(task: task)
        print("Converted task is -  \(deletedTask)")
        firebaseStorage.deleteTaskFromServer(deletedTask)
        storage.deleteToDoObject(item: task)
       
    }
}

extension ToDosInteractor {
    private func sortByDone(items: [ToDoObject]) -> [ToDoObject] {
        let doneItems = items.filter { $0.doneStatus == true }
        let notDoneItems  = items.filter { $0.doneStatus != true }
        let result = notDoneItems + doneItems
        return result
    }
}
