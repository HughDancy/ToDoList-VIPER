//
//  ExecuteToDoInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 14.11.2023.
//

import UIKit

class ExecuteToDoInteractor: ExecuteToDoInteractorInputProtocol {
    var presenter: ExecuteToDoInteractorOutputProtocol?
    var storage = ToDoStorage.instance

    func retriveToDos() {
        let doneToDos = storage.fetchToDos().filter { $0.doneStatus == true }
        let outputToDos = ToDoObjectSorter.sortByStatus(object: doneToDos, and: .completed)
        presenter?.didRetriveToDos(outputToDos)
    }

    func deleteToDo(_ toDoItem: ToDoObject) {
        storage.deleteToDoObject(item: toDoItem)
        presenter?.didRemoveToDo()
    }
}
