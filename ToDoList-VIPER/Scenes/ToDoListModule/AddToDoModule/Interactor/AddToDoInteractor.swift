//
//  AddToDoInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.11.2023.
//

import Foundation

class AddToDoInteractor: AddToDoInteractorInputProtocol {
    var presenter: AddToDoPresenterProtocol?
    var toDoStore = ToDoStore.shared
    var toDos: [ToDoItem] {
        return toDoStore.toDos
    }
    
    func saveToDo(_ toDoItem: ToDoItem) {
        toDoStore.addToDo(toDoItem)
        presenter?.addToDo(toDoItem)
    }
    
    
}
