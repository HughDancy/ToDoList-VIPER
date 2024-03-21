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
    
    func addNewToDo(with name: String?, description: String?, date: Date?, mark: String) {
        let currentDay = Date.today
        if name != "" {
            storage.createNewToDo(title: name ?? "Temp",
                                  content: self.cehckDescription(description ?? "Описание задачи"),
                                  date: date ?? currentDay,
                                  done: self.checkDoneDate(date ?? currentDay))
            presenter?.goBackToMain()
        } else {
            presenter?.showAlert()
        }
    }
    
    //MARK: - Support function
    private func cehckDescription(_ description: String) -> String {
        if description == "Описание задачи" {
            return "Описание задачи не установлено"
        } else {
            return description
        }
    }
    
    private func checkDoneDate(_ date: Date) -> Bool {
        let currentDate = Date.today
        if date >= currentDate {
            return false
        } else {
            return true
        }
    }
}
