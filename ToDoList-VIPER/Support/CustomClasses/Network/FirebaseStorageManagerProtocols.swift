//
//  FirebaseStorageManagerProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.08.2024.
//

import Foundation

protocol MainScreenServerStorageProtocol: AnyObject {
    func newLoadAvatar(compelition: @escaping (_ imageUrl: URL?) -> Void)
}

protocol ToDoSDetailServerStorageProtocol: AnyObject {
    func uploadChanges(task: ToDoTask)
    func deleteTask(_ id: String)
}

protocol ToDosServerStorageProtocol: AnyObject {
    func makeTaskDone(_ id: UUID)
    func deleteToDoFromServer(_ id: String)
}
