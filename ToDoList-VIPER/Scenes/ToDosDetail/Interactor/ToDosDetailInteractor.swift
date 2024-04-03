//
//  ToDosDetailInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.04.2024.
//

import UIKit

final class ToDosDetailInteractor: ToDosDetailInteractorInputProtocol {
    weak var presenter: ToDosDetailInteractorOutputProtocol?
    var toDoItem: ToDoObject?
    var storage = ToDoStorage.instance
    
    func editTask(title: String?, descriprion: String?, date: Date?, color: String) {
        guard let task = toDoItem else { return }
        if title != nil && descriprion != nil && date != nil {
            storage.editToDoObject(item: task,
                                   newTitle: title ?? "Temp",
                                   newDescription: descriprion ?? "Temp",
                                   newDate: date ?? Date.today)
        } else {
            presenter?.showAllert()
        }
    }
    
    func deleteTask(_ toDo: ToDoObject) {
        guard let task = toDoItem else { return }
        storage.deleteToDoObject(item: task)
    }
    
}
