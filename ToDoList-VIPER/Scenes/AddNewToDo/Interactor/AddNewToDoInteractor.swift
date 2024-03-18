//
//  AddNewToDoInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 18.03.2024.
//

import Foundation

final class AddNewToDoInteractor: AddNewToDoInteractorProtocol {
    weak var presenter: AddNewToDoPresenterProtocol?
    var storage = ToDoStorage.instance
    
    func addNewToDo(with name: String, description: String, date: Date, mark: String) {
        let currentDay = Date.today
        if date >= currentDay {
            storage.createNewToDo(title: name, content: description, date: date, done: false)
        } else {
            storage.createNewToDo(title: name, content: description, date: date, done: true)
        }
        presenter?.goBackToMain()
    }
}
