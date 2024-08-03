//
//  FirebaseStorageManagerProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.08.2024.
//

import Foundation

protocol ServerDetailEditProtocol: AnyObject {
    func uploadChanges(task: ToDoTask)
    func deleteTask(_ id: String)
}

protocol ServerToDosProtocol: AnyObject {
    func makeTaskDone(_ id: UUID)
    func deleteToDoFromServer(_ id: String)
}
