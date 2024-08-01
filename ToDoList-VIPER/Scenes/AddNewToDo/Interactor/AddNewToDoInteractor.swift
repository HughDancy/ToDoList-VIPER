//
//  AddNewToDoInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 18.03.2024.
//

import UIKit.UIColor

final class AddNewToDoInteractor: AddNewToDoInteractorProtocol {
    weak var presenter: AddNewToDoPresenterProtocol?

    // MARK: - Property's
    private var localStorage = TaskStorageManager.instance
    private var networkStorage = FirebaseStorageManager()
    private var categoryManger = TaskCategoryManager()

    func addNewToDo(with name: String?, description: String?, date: Date?, colorCategory: UIColor, iconName: String) {
        let choosenDate = Calendar.current.startOfDay(for: date ?? Date.today)
        let compareDate = Calendar.current.startOfDay(for: Date.today)
        let overdueStatus: Bool = choosenDate >= compareDate ? false : true
        let status = overdueStatus ? ProgressStatus.fail : ProgressStatus.inProgress
        let category = categoryManger.getCategory(from: colorCategory)
        let uid = UUID.init()

        if name != "" {
            localStorage.createNewToDo(title: name ?? "Temp",
                                       content: self.cehckDescription(description ?? "Описание задачи"),
                                       date: date ?? Date.today,
                                       isOverdue: overdueStatus,
                                       color: colorCategory,
                                       iconName: iconName,
                                       doneStatus: false,
                                       uid: uid)
            let newToDo = ToDoTask(title: name ?? "Temp", descriptionTitle: description ?? "Temp", date: date ?? Date.today,
                                   category: category, status: status, id: uid)
            networkStorage.uploadTaskToServer(with: newToDo)
            presenter?.goBackToMain()
        } else {
            presenter?.showAlert()
        }
    }

    // MARK: - Support function
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
