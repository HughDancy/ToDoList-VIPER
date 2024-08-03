//
//  FirebaseStorageManagerProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.08.2024.
//

import Foundation

protocol ServerDetailEditProtocol: AnyObject {
    func uploadChanges(task: ToDoTask)
    func deleteTaskFromServer(_ id: String)
}
