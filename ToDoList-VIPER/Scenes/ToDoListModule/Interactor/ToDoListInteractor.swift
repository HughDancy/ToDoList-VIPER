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
//    var toDoStore = ToDoStore.shared
//    var toDos: [ToDoItem] {
//        return toDoStore.toDos
//    }
    
    
    func retriveToDos() {
        let toDos = storage.fetchUsers()
        let plannedToDos = toDos.filter { $0.doneStatus == false}
        presenter?.didRetriveToDos(plannedToDos)
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
