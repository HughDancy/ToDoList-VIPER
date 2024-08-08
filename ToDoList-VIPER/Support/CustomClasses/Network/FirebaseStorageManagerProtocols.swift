//
//  FirebaseStorageManagerProtocols.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.08.2024.
//

import UIKit.UIImage

protocol LoginServerStorageProtocol: AnyObject {
    func loadTaskFromFirestore() async
    func chekOverdueToDos()
    func checkAvatar(avatar: UIImage, uid: String)
}

protocol MainScreenServerStorageProtocol: AnyObject {
    func newLoadAvatar(compelition: @escaping (_ imageUrl: URL?) -> Void)
}

protocol AddNewToDoServerStorageProtocol: AnyObject {
    func uploadTaskToServer(with task: ToDoTask)
}

protocol ToDoSDetailServerStorageProtocol: AnyObject {
    func uploadChanges(task: ToDoTask)
    func deleteTask(_ id: String)
}

protocol ToDosServerStorageProtocol: AnyObject {
    func makeTaskDone(_ id: UUID)
    func deleteToDoFromServer(_ id: String)
}

protocol UserAvatarSaveInServerProtocol: AnyObject {
   func saveImage(image: UIImage, name: String)
}
