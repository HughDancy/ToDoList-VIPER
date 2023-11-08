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
        ToDoItem(title: "Focus", content: "Decide on what you want to focus in your life"),
        ToDoItem(title: "Value", content: "Decide on what values are meaningful in your life"),
        ToDoItem(title: "Action", content: "Decide on what you should do to achieve empowering life")
    ]
    
    func addToDo(_ toDo: ToDoItem) {
        toDos.append(toDo)
    }
    
    func removeToDo(_ toDo: ToDoItem) {
        if let index = toDos.firstIndex(where: { $0 === toDo }) {
            toDos.remove(at: index)
        }
    }
}
