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
    
    func editToDo(title: String, content: String, date: Date) {
        guard let toDoItem = toDoItem else { return }
        storage.editToDoObject(item: toDoItem, newTitle: title, newDescription: content, newDate: date, color: "systemOrange")
        presenter?.didEditToDo(toDoItem)
    }
    
    
}
