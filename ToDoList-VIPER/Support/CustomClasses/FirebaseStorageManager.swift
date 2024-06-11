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
//        let meta = StorageMetadata()
//        meta.contentType = "image/jpeg"
        guard let data = image.jpegData(compressionQuality: 8.0) else { return }
        let avatarRef = storage.child(name)
        let uploadTask = avatarRef.putData(data, metadata: nil) { (metaData, error) in
            guard let metadata = metaData else {
                print("Meta data not found or somehow another error")
                return
            }
//            
//            let size = metadata.size
            
            
        }
  
        
//
    
//        let path = "\()"
//        let something = storage.child(<#T##path: String##String#>).putData(data, metadata: <#T##StorageMetadata?#>)
    }
}
