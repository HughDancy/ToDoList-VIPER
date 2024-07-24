//
//  ToDosInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.03.2024.
//

import UIKit

final class ToDosInteractor: ToDosInteractorInputProtocol {
    weak var presenter: ToDosInteractorOutputProtocol?
    private let storage = TaskStorageManager.instance
    private let firebaseStorage = FirebaseStorageManager()
    
    func fetchFirstTasks(_ status: ToDoListStatus) {
        self.fetchSortedToDos(with: status, and: nil)
    }

    func fetchTask(date: Date, status: ToDoListStatus) {
        self.fetchSortedToDos(with: status, and: date)
    }
    
    //MAYBE REFACTOR
    func fetchSortedToDos(with status: ToDoListStatus, and date: Date?) {
        let mockDate = Date.getDateFromStatus(status)
        
        switch status {
        case .today, .tommorow:
            guard let date = date else {
                var toDos = storage.fetchConcreteToDos(with: mockDate)
                toDos = self.sortByDone(items: toDos)
                self.presenter?.getTask(toDos)
                return
            }
            var toDos = storage.fetchConcreteToDos(with: date)
            toDos = self.sortByDone(items: toDos)
            self.presenter?.getTask(toDos)
        case .overdue:
            guard let date = date else {
                let overdueTasks = storage.fetchOverdueToDos(with: mockDate)
                self.presenter?.getTask(overdueTasks)
                return
            }
            let overdueTasks = storage.fetchOverdueToDos(with: date)
                presenter?.getTask(overdueTasks)
        case .done:
            guard let date = date else {
                let doneTasks = storage.fetchDoneToDos(with: mockDate)
                self.presenter?.getTask(doneTasks)
                return
            }
            let doneTasks = storage.fetchDoneToDos(with: date)
            presenter?.getTask(doneTasks)
        }
    }
    
    func doneTask(_ task: ToDoObject) {
        let donedToDo = ToDoTask.convertToToDoTask(task: task)
        storage.doneToDo(item: task)
        firebaseStorage.makeToDoDone(donedToDo)
        
    }
    
    func deleteTask(_ task: ToDoObject) {
        let deletedTask = ToDoTask.convertToToDoTask(task: task)
        print("Converted task is -  \(deletedTask)")
        firebaseStorage.deleteTaskFromServer(deletedTask)
        storage.deleteToDoObject(item: task)
        NotificationCenter.default.post(name: NotificationNames.updateMainScreen.name, object: nil)
    }
}

fileprivate extension ToDosInteractor {
    private func sortByDone(items: [ToDoObject]) -> [ToDoObject] {
        let doneItems = items.filter { $0.doneStatus == true }
        let notDoneItems  = items.filter { $0.doneStatus != true }
        let result = notDoneItems + doneItems
        return result
    }
}
