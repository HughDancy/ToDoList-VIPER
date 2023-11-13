//
//  ToDoDetailInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.11.2023.
//

import Foundation

class ToDoDetailInteractor: TodoDetailInteractorInputProtocol {
    weak var presenter: TodoDetailInteractorOutputProtocol?
    var toDoStore = ToDoStore.shared
    var toDoItem: ToDoItem?
    
    func deleteToDo() {
        guard let toDoItem = toDoItem else { return }
        toDoStore.removeToDo(toDoItem)
        presenter?.didDeleteToDo()
    }
    
    func editToDo(title: String, content: String) {
        guard let toDoItem = toDoItem else { return }
        toDoItem.title = title
        toDoItem.content = content
        presenter?.didEditToDo(toDoItem)
    }
    
    
}
