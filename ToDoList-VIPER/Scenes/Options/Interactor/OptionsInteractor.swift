//
//  OptionsInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.07.2024.
//

import Foundation

final class OptionsInteractor: OptionsInputInteractorProtocol {
    var presenter: OptionsOutputInteractorProtocol?
    
    func fetchOptionsData() {
        let optionsData = ["Сменить тему", "Обратная связь", "Выход"]
        presenter?.getOptionsData(optionsData)
    }
    
    func fetchUserData() {
        guard let userName = UserDefaults.standard.string(forKey: NotificationNames.userName.rawValue),
              let userAvatar = UserDefaults.standard.url(forKey: "UserAvatar") else {
            let url = URL(string: "")!
            presenter?.getUserData(("User", url))
            return
        }
        presenter?.getUserData((userName, userAvatar))
    }
    
    func changeTheme() {
        //TODO - Implement function
    }
    
    
    
}
