//
//  ToDoDetailInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 13.11.2023.
//

import Foundation

class ToDoDetailInteractor: TodoDetailInteractorInputProtocol {
    weak var presenter: TodoDetailInteractorOutputProtocol?
    var storage = ToDoStorage.instance
    var toDoItem: ToDoObject?
    
    func deleteToDo() {
        guard let toDoItem = toDoItem else { return }
        storage.deleteToDoObject(item: toDoItem)
        presenter?.didDeleteToDo()
    }
    
    func editToDo(title: String, content: String) {
        guard let toDoItem = toDoItem else { return }
        toDoItem.title = title
        toDoItem.descriptionTitle = content
        presenter?.didEditToDo(toDoItem)
    }
    
    
}
