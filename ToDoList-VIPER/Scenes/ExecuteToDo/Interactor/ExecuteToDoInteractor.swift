//
//  ExecuteToDoInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.11.2023.
//

import UIKit

class ExecuteToDoInteractor: ExecuteToDoInteractorInputProtocol {
    var presenter: ExecuteToDoInteractorOutputProtocol?
    var toDoStore = ToDoStore.shared
    var toDos: [ToDoItem] {
        return toDoStore.executeToDos
    }
    
    
    func retriveToDos() {
        presenter?.didRetriveToDos(toDos)
    }
    
    func deleteToDo(_ toDoItem: ToDoItem) {
        presenter?.didRemoveToDo(toDoItem)
    }
}
