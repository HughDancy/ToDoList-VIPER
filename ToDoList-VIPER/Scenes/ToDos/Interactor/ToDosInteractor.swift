//
//  ToDosInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.03.2024.
//

import UIKit

final class ToDosInteractor: ToDosInteractorInputProtocol {
   weak var presenter: ToDosInteractorOutputProtocol?
    
    func fetchFirstTasks(_ status: ToDoListStatus) {
        switch status {
        case .today:
            print("Today tasks")
        case .tommorow:
            print("Tommorow tasks")
        case .overdue:
            print("OverdueTasks")
        case .done:
            print("Done tasks")
        }
    }
    
    func fetchTask(date: Date) {
        print("d")
    }
    
    func doneTask(_ task: ToDoObject) {
        print("d")
    }
    
    func deleteTask(_ task: ToDoObject) {
        print("d")
    }
    
    
}
