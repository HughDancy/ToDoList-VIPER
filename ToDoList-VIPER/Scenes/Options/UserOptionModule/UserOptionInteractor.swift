//
//  UserOptionInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 05.07.2024.
//

import UIKit

final class UserOptionInteractor: UserOptionInputInteractorProtocol {
    
  //MARK: - Properties
    var presenter: UserOptionOutputInteractorProtocol?
    private var tempAvatar: UIImage? = nil
    
    //MARK: - Protocol Method's
    func saveUserInfo(name: String) {
        print("all good")
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
