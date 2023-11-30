//
//  OverdueInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 29.11.2023.
//

import Foundation

final class OverdueInteractor: OverdueInteractorInputProtocol {
    weak var presenter: OverdueInteractorOutputProtocol?
    var storage = ToDoStorage.instance
    
    func retriveToDos() {
        let allToDos = storage.fetchUsers().filter({ $0.doneStatus == false })
        let outputToDos = ToDoObjectSorter.sortByStatus(object: allToDos, and: .overdue)
        presenter?.didRetriveToDos(outputToDos)
    }
    
    func deleteToDos(_ toDo: ToDoObject) {
        storage.deleteToDoObject(item: toDo)
        presenter?.didRemoveToDo()
    }
    
    func doneToDo(_ toDo: ToDoObject) {
        storage.doneToDo(item: toDo)
        presenter?.didRemoveToDo()
    }
    
    
}
