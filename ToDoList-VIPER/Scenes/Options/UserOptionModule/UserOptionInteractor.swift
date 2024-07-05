//
//  UserOptionInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 05.07.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class UserOptionInteractor: UserOptionInputInteractorProtocol {
    
  //MARK: - Properties
    var presenter: UserOptionOutputInteractorProtocol?
    private let db = Firestore.firestore()
    private var storageManager = FirebaseStorageManager.shared
    private var tempAvatar: UIImage? = nil
    
    //MARK: - Protocol Method's
    func saveUserInfo(name: String) {
        let userUid = Auth.auth().currentUser?.uid ?? UUID().uuidString
        UserDefaults.standard.set(name, forKey: NotificationNames.userName.rawValue)
        db.collection("users").document(userUid).setData(["displayName" : name, "name": name], merge: true)
        NotificationCenter.default.post(name: NotificationNames.updateUserData.name, object: nil)
        presenter?.dismiss()
    }
    
    func getUserInfo() {
        guard let userName = UserDefaults.standard.string(forKey: NotificationNames.userName.rawValue),
              let userAvatar = UserDefaults.standard.url(forKey: "UserAvatar") else {
            presenter?.loadUserData(("UserAvatar", nil))
            return
        }
        presenter?.loadUserData((userName, userAvatar))
    }
    
    func setTempAvatar(_ image: UIImage?) {
        self.tempAvatar = image
    }
}
