//
//  MockLoginFirebaseStorageManager.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 08.08.2024.
//

import UIKit
@testable import ToDoList_VIPER

final class MockLoginFirebaseStorageManager: LoginServerStorageProtocol & UserAvatarSaveInServerProtocol {
    func loadTaskFromFirestore() async {}
    func chekOverdueToDos() {}
    func checkAvatar(avatar: UIImage, uid: String) {}
    func saveImage(image: UIImage, name: String) {}

}
