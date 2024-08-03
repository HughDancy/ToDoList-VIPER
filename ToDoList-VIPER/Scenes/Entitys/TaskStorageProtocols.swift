//
//  TaskStorageProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.08.2024.
//

import UIKit

protocol AddNewToDoLocalStorageProtocol: AnyObject {
    func createNewToDo(title: String, content: String, date: Date, isOverdue: Bool, color: UIColor, iconName: String, doneStatus: Bool, uid: UUID)
}

protocol MainScreenLocalStorageProtocol: AnyObject {
    func fetchToDosCount(with status: ToDoListStatus) -> Int
}

protocol ToDosLocalStorageProtocol: AnyObject {
    func fetchConcreteToDos(with date: Date) -> [ToDoObject]
    func fetchDoneToDos(with date: Date) -> [ToDoObject]
    func fetchOverdueToDos(with date: Date) -> [ToDoObject]
    func doneToDo(_ id: UUID)
    func deleteToDo(_ uid: UUID)
}

protocol ToDosDetailLocalStorageProtocol: AnyObject {
    func editToDoObject(item: ToDoObject, newTitle: String, newDescription: String, newDate: Date, color: UIColor, iconName: String)
    func deleteTask(_ uid: UUID)
}
