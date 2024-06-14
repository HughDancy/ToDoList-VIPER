//
//  FirebaseStorageManager.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 11.06.2024.
//

import Foundation
import UIKit
import FirebaseStorage
import Kingfisher

final class FirebaseStorageManager {
    static let shared = FirebaseStorageManager()
    private let storage = Storage.storage().reference()
    private var authManager = AuthKeychainManager()
    
    private init() { }
    
    func saveImage(image: UIImage, name: String) {
        guard let data = image.jpegData(compressionQuality: 8.0) else { return }
        let avatarRef = storage.child(name)
        let uploadTask = avatarRef.putData(data, metadata: nil) { (metaData, error) in
            guard let metadata = metaData else {
                print("Meta data not found or somehow another error")
                return
            }
        }
    }
    
    func loadAvatar() -> URL? {
        guard let userId = authManager.id else {
            return nil}
        
        var imageUrl: URL? = URL(string: "")
        let avatarRef = storage.child(userId)
        
        avatarRef.downloadURL { url, error in
            if let error = error {
                print("When download avatar url something went wrong")
            } else {
                imageUrl = url
            }
        }
       return imageUrl
    }
}
