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
    var localStorage: ToDosDetailLocalStorageProtocol?
    var firebaseStorage: ServerDetailEditProtocol?

    func editTask(title: String?, descriprion: String?, date: Date?, color: UIColor, iconName: String) {
        guard let task = toDoItem else { return }
        let defaultData = self.getDefaultData()
        if title != nil && descriprion != nil && date != nil {
            localStorage?.editToDoObject(item: task,
                                        newTitle: title ?? defaultData.title,
                                        newDescription: descriprion ?? defaultData.description,
                                        newDate: date ?? defaultData.date,
                                        color: color,
                                        iconName: iconName)
            let category = TaskCategoryManager.manager.getCategory(from: color)
            let status = ProgressStatus.convertStatusForServer(task: task)
            let editTask = ToDoTask(title: title ?? defaultData.title, descriptionTitle: descriprion ?? defaultData.description,
                                    date: date ?? defaultData.date, category: category, status: status, id: task.id ?? UUID.init())
            firebaseStorage?.uploadChanges(task: editTask)
            presenter?.showAllert(with: .allSave)
        } else {
            presenter?.showAllert(with: .error)
        }
    }

    func deleteTask() {
        guard let task = toDoItem else { return }
        firebaseStorage?.deleteTaskFromServer(task.id?.uuidString ?? UUID().uuidString)
        localStorage?.deleteTask(task.id ?? UUID.init())
        presenter?.didDeleteToDo()
        NotificationCenter.default.post(name: NotificationNames.updateMainScreen.name, object: nil)
    }
}

fileprivate extension ToDosDetailInteractor {
    func getDefaultData() -> (title: String, description: String, date: Date) {
        let temponaryData: (title: String, description: String, date: Date) = (title: toDoItem?.title ?? "",
                                                                               description: toDoItem?.description ?? "", date: toDoItem?.date ?? Date.today)
        return temponaryData
    }
}
