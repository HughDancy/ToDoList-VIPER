//
//  ToDoStore..swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 08.11.2023.
//

import Foundation

final class ToDoStore {

    private init() {}

    static let shared = ToDoStore()

    public private(set) var toDos: [ToDoItem] = [
        ToDoItem(title: "Focus", content: "Time: - 15:00", date: "14.11.2023"),
        ToDoItem(title: "Value", content: "Time: - 16:00", date: "14.11.2023"),
        ToDoItem(title: "Action", content: "Time: - 18:00", date: "14.11.2023")
    ]

    public private(set) var executeToDos: [ToDoItem] = []

    func addToDo(_ toDo: ToDoItem) {
        toDos.append(toDo)
    }

    func removeToDo(_ toDo: ToDoItem) {
        if let index = toDos.firstIndex(where: { $0 === toDo }) {
            toDos.remove(at: index)
        }
    }

    func doneToDo(_ toDo: ToDoItem) {
        if let index = toDos.firstIndex(where: { $0 === toDo }) {
            executeToDos.append(toDo)
            toDos.remove(at: index)
        }
    }

    func removeExecuteToDo(_ toDo: ToDoItem) {
        if let index = executeToDos.firstIndex(where: { $0 === toDo}) {
            executeToDos.remove(at: index)
        }
    }
}
