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
    var localStorage = TaskStorageManager.instance
    var firebaseStorage = FirebaseStorageManager()
    
    
    func editTask(title: String?, descriprion: String?, date: Date?, color: UIColor, iconName: String) {
        guard let task = toDoItem else { return }
        let defaultData = self.getDefaultData()
        if title != nil && descriprion != nil && date != nil {
            print("Local saving method is work")
            localStorage.editToDoObject(item: task,
                                   newTitle: title ?? defaultData.title,
                                   newDescription: descriprion ?? defaultData.description,
                                   newDate: date ?? defaultData.date,
                                   color: color,
                                   iconName: iconName)
            print(title)
            print(descriprion)
            print(date)
            print(color)
            print(iconName)
            let category = TaskCategoryManager.manager.getCategory(from: color)
            let status = ProgressStatus.convertStatusForServer(task: task)
            let task = ToDoTask(title: title ?? defaultData.title, descriptionTitle: descriprion ?? defaultData.description, date: date ?? defaultData.date, category: category, status: status)
            firebaseStorage.uploadChanges(task: task)
            presenter?.showAllert(with: .allSave)
        } else {
            presenter?.showAllert(with: .error)
        }
    }
    
    func deleteTask(_ toDo: ToDoObject) {
        guard let task = toDoItem else { return }
        localStorage.deleteToDoObject(item: task)
        presenter?.didDeleteToDo()
        
    }
}


fileprivate extension ToDosDetailInteractor {
    func getDefaultData() -> (title: String, description: String, date: Date) {
        let temponaryData: (title: String, description: String, date: Date) = (title: toDoItem?.title ?? "", description: toDoItem?.description ?? "", date: toDoItem?.date ?? Date.today)
        return temponaryData
    }
}
