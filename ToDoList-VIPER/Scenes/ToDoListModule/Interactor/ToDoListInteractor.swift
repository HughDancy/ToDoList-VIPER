//
//  ToDoListInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 09.11.2023.
//

import Foundation

class ToDoListInteractor: ToDoListInteractorInputProtocol {
    weak var presenter: ToDoListInteractorOutputProtocol?
    var toDoStore = ToDoStore.shared
    var toDos: [ToDoItem] {
        return toDoStore.toDos
    }
    
    
    func retriveToDos() {
        presenter?.didRetriveToDos(toDos)
    }
    
    func saveToDo(_ toDoItem: ToDoItem) {
        toDoStore.addToDo(toDoItem)
        presenter?.didAddToDo(toDoItem)
    }
    
    func deleteToDo(_ toDoItem: ToDoItem) {
        toDoStore.removeToDo(toDoItem)
        presenter?.didRemoveToDo(toDoItem)
    }
    
    func doneToDo(_ toDoItem: ToDoItem) {
        toDoStore.doneToDo(toDoItem)
    }
}
