//
//  FirebaseStorageManager.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 11.06.2024.
//

import Foundation
import UIKit
import FirebaseStorage

final class FirebaseStorageManager {
    static let shared = FirebaseStorageManager()
    private init() { }
    
    private let storage = Storage.storage().reference()
    
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
    
    func loadAvatar(name: String) -> UIImage? {
        var image: UIImage? = UIImage()
        let avatarRef = storage.child(name)
        avatarRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Something went wrong when avatar has been load")
            } else {
                image = UIImage(data: data ?? Data())
            }
        }
        return image
    }
}
