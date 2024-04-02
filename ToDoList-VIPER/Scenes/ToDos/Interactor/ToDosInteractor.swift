//
//  ToDosInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.03.2024.
//

import UIKit

final class ToDosInteractor: ToDosInteractorInputProtocol {
   weak var presenter: ToDosInteractorOutputProtocol?
    let storage = ToDoStorage.instance
    
    func fetchFirstTasks(_ status: ToDoListStatus) {
        switch status {
        case .today:
            let tasks = storage.fetchToDos()
            let todayTasks = tasks.filter { ($0.dateTitle) == DateFormatter.getStringFromDate(from: Date.today) }
            presenter?.getTask(todayTasks)
            print("Today tasks")
        case .tommorow:
            let tasks = storage.fetchToDos()
            let tomroowTasks = tasks.filter { ($0.dateTitle) == DateFormatter.getStringFromDate(from: Date.tomorrow) }
            presenter?.getTask(tomroowTasks)
            print("Tommorow tasks")
        case .overdue:
//            let overdueTask = tasks.filter { ($0.dateTitle) == DateFormatter.createMediumDate(from: Date.tomorrow) }
//            presenter?.getTask(tomroowTasks)
            print("OverdueTasks")
        case .done:
            let tasks = storage.fetchToDos()
            let doneTasks = tasks.filter { $0.doneStatus == true }
            presenter?.getTask(doneTasks)
            print("Done tasks")
        }
    }
    
    func fetchTask(date: Date) {
        let tasks = storage.fetchToDos()
        let outputTasks = tasks.filter { $0.dateTitle == DateFormatter.getStringFromDate(from: date) }
        presenter?.getTask(outputTasks)
    }
    
    func doneTask(_ task: ToDoObject) {
        storage.doneToDo(item: task)
    }
    
    func deleteTask(_ task: ToDoObject) {
        storage.deleteToDoObject(item: task)
    }
    
    
}
