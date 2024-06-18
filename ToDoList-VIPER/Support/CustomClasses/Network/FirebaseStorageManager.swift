//
//  FirebaseStorageManager.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 11.06.2024.
//

import Foundation
import UIKit.UIImage
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import Kingfisher

final class FirebaseStorageManager {
    static let shared = FirebaseStorageManager()
    
    private let storage = Storage.storage().reference()
    private let db = Firestore.firestore()
    private var authManager = AuthKeychainManager()
    
    init() { }
    
    func saveImage(image: UIImage, name: String) {
        guard let data = image.jpegData(compressionQuality: 8.0) else { return }
        let avatarRef = storage.child(name)
        avatarRef.putData(data, metadata: StorageMetadata(dictionary: ["contentType" : "image/jpeg"])) { (metaData, error) in
            guard metaData != nil else {
                print("Meta data not found or somehow another error")
                return
            }
        }
    }
    
    func loadAvatar() {
        guard let userId = authManager.id else { return  }
        let avatarRef = storage.child(userId)
        
        avatarRef.downloadURL { url, error in
            if error != nil {
                print("When download avatar url something went wrong")
            } else {
                print("LoadAvatar method avatar id is - \(url)")
                UserDefaults.standard.set(url, forKey: "UserAvatar")
            }
        }
    }
}

extension FirebaseStorageManager {
    func uploadTaskToServer(with task: ToDoTask) {
        let uid = Auth.auth().currentUser?.uid ?? UUID().uuidString
        do {
            try db.collection("toDos").document(uid).collection("tasks").addDocument(from: task)
        }
        catch {
            print(error)
        }
    }
}
