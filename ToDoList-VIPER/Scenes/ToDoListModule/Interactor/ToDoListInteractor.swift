//
//  ToDoListInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 09.11.2023.
//

import Foundation

class ToDoListInteractor: ToDoListInteractorInputProtocol {
    weak var presenter: ToDoListInteractorOutputProtocol?
    var storage = ToDoStorage.instance

    
    
    func retriveToDos() {
        let alltoDos = storage.fetchUsers().filter { $0.doneStatus == false}
        let sortedToDos = alltoDos.sorted { $0.date?.compare($1.date ?? Date()) == .orderedAscending }
        presenter?.didRetriveToDos(sortedToDos)
    }
    
    func deleteToDo(_ toDoItem: ToDoObject) {
        storage.deleteToDoObject(item: toDoItem)
        presenter?.didRemoveToDo(toDoItem)
    }
    
    func doneToDo(_ toDoItem: ToDoObject) {
        storage.doneToDo(item: toDoItem)
        presenter?.didRemoveToDo(toDoItem)
    }
}
