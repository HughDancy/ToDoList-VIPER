//
//  ToDoListInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 09.11.2023.
//

import Foundation

class ToDoListInteractor: ToDoListInteractorInputProtocol {
    weak var presenter: ToDoListInteractorOutputProtocol?
    var storage = ToDoStorage.instance

    
    
    func retriveToDos() {
        var toDosToSend = [[ToDoObject]]()
        
        let todoay = DateFormatter.createMediumDate(from: Date.today)
        let tommorow = DateFormatter.createMediumDate(from: Date.tomorrow)
        
        let alltoDos = storage.fetchUsers().filter { $0.doneStatus == false}

        let toDayToDos = alltoDos.filter { $0.dateTitle == todoay }
        let tommorowToDos = alltoDos.filter { $0.dateTitle == tommorow }
        let anotherToDos = alltoDos.filter { $0.dateTitle != todoay && $0.dateTitle != tommorow && $0.date ?? Date() > Date.today}
        let sortedAnotherToDos = anotherToDos.sorted { $0.date?.compare($1.date ?? Date()) == .orderedAscending }
        toDosToSend.append(toDayToDos)
        toDosToSend.append(tommorowToDos)
        toDosToSend.append(sortedAnotherToDos)
        
        presenter?.didRetriveToDos(toDosToSend)
    }
    
    func deleteToDo(_ toDoItem: ToDoObject) {
        storage.deleteToDoObject(item: toDoItem)
        presenter?.didRemoveToDo(toDoItem)
    }
    
    func doneToDo(_ toDoItem: ToDoObject) {
        storage.doneToDo(item: toDoItem)
        presenter?.didRemoveToDo(toDoItem)
    }
}
