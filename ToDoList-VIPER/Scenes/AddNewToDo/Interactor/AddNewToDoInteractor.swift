//
//  AddNewToDoInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 18.03.2024.
//

import UIKit.UIColor

final class AddNewToDoInteractor: AddNewToDoInteractorProtocol {
    weak var presenter: AddNewToDoPresenterProtocol?
    var storage = ToDoStorage.instance
    
    func addNewToDo(with name: String?, description: String?, date: Date?, colorCathegory: UIColor) {
        let choosenDate = Calendar.current.startOfDay(for: date ?? Date.today)
        let compareDate = Calendar.current.startOfDay(for: Date.today)
        let overdueStatus: Bool = choosenDate >= compareDate ? false : true
        
       
        if name != "" {
            storage.createNewToDo(title: name ?? "Temp",
                                  content: self.cehckDescription(description ?? "Описание задачи"),
                                  date: date ?? Date.today,
                                  isOverdue: overdueStatus,
                                  color: colorCathegory)
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
