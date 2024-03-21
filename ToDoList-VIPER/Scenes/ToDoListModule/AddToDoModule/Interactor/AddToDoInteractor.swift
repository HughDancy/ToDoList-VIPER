//
//  AddToDoInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.11.2023.
//

import Foundation

class AddToDoInteractor: AddToDoInteractorInputProtocol {
    
    var presenter: AddToDoPresenterProtocol?
    var storage = ToDoStorage.instance
//    var toDoStore = ToDoStore.shared
//    var toDos: [ToDoItem] {
//        return toDoStore.toDos
//    }
    
    func saveToDo(title: String, content: String, date: Date, done: Bool) {
//        storage.createNewToDo(title: title, content: content, date: date, done: done)
        presenter?.goBack()
    }
}


