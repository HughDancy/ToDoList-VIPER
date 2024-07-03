//
//  OptionsInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.07.2024.
//

import Foundation
import UIKit
import FirebaseAuth

final class OptionsInteractor: OptionsInputInteractorProtocol {
    //MARK: - Properties
    var presenter: OptionsOutputInteractorProtocol?
    let firebaseAuth = Auth.auth()
    private var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.string(forKey: "selectedTheme") ?? "light") ?? .light
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: "selectedTheme")
        }
    }
    
    //MARK: - Interactor Methods
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
        if self.theme == .light {
            self.theme = .dark
        } else {
            self.theme = .light
        }
    }
    
    func loggedOut() {
        do {
            try? firebaseAuth.signOut()
        } catch {
            print("Some error when logged out from Options screen")
        }
    }
    
}

enum Theme: String  {
   case light
   case dark
    
    func getUserInterfaceStyle() -> UIUserInterfaceStyle  {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
