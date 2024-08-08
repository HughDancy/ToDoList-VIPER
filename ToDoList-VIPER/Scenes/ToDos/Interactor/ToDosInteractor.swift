//
//  ToDosInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.03.2024.
//

import UIKit

final class ToDosInteractor: ToDosInteractorInputProtocol {
    weak var presenter: ToDosInteractorOutputProtocol?
    var storage: ToDosLocalStorageProtocol?
    var firebaseStorage: ToDosServerStorageProtocol?

    func fetchFirstTasks(_ status: ToDoListStatus) {
        self.fetchSortedToDos(with: status, and: nil)
    }

    func fetchTask(date: Date, status: ToDoListStatus) {
        self.fetchSortedToDos(with: status, and: date)
    }

    func fetchSortedToDos(with status: ToDoListStatus, and date: Date?) {
        let mockDate = Date.getDateFromStatus(status)

        switch status {
        case .today, .tommorow:
            guard let date = date else {
                var toDos = storage?.fetchConcreteToDos(with: mockDate)
                toDos = self.sortByDone(items: toDos)
                self.presenter?.getTask(toDos)
                return
            }
            var toDos = storage?.fetchConcreteToDos(with: date)
            toDos = self.sortByDone(items: toDos)
            self.presenter?.getTask(toDos)
        case .overdue:
            guard let date = date else {
                let overdueTasks = storage?.fetchOverdueToDos(with: mockDate)
                self.presenter?.getTask(overdueTasks)
                return
            }
            let overdueTasks = storage?.fetchOverdueToDos(with: date)
                presenter?.getTask(overdueTasks)
        case .done:
            guard let date = date else {
                let doneTasks = storage?.fetchDoneToDos(with: mockDate)
                self.presenter?.getTask(doneTasks)
                return
            }
            let doneTasks = storage?.fetchDoneToDos(with: date)
            presenter?.getTask(doneTasks)
        }
    }

    func doneTask(_ taskId: UUID) {
        storage?.doneToDo(taskId)
        firebaseStorage?.makeTaskDone(taskId)
    }

    func deleteTask(_ taskId: UUID) {
        firebaseStorage?.deleteToDoFromServer(taskId.uuidString)
        storage?.deleteToDo(taskId)
        NotificationCenter.default.post(name: NotificationNames.updateMainScreen.name, object: nil)
    }
}

fileprivate extension ToDosInteractor {
    private func sortByDone(items: [ToDoObject]?) -> [ToDoObject] {
        guard let items = items else { return [TaskStorageManager.instance.createMockObject()]}
        let doneItems = items.filter { $0.doneStatus == true }
        let notDoneItems  = items.filter { $0.doneStatus != true }
        let result = notDoneItems + doneItems
        return result
    }
}
