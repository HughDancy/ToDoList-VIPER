//
//  OptionsInteractor.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 03.07.2024.
//

import Foundation
import UIKit
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

final class OptionsInteractor: OptionsInputInteractorProtocol {

    // MARK: - Properties
    weak var presenter: OptionsOutputInteractorProtocol?

    // MARK: - Interactor Methods
    func fetchOptionsData() {
        let optionsData = ["Сменить тему", "Обратная связь", "Выход"]
        presenter?.getOptionsData(optionsData)
    }

    func fetchUserData() {
        guard let userName = UserDefaults.standard.string(forKey: UserDefaultsNames.userName.name) else {
            presenter?.getUserName("Test User")
            return
        }
        guard let userAvatar = UserDefaults.standard.url(forKey: UserDefaultsNames.userAvatar.name) else {
            presenter?.getUserAvatar(nil)
            return
        }

        presenter?.getUserName(userName)
        presenter?.getUserAvatar(userAvatar)
    }

    func changeTheme(_ bool: Bool) {
        var toDoUserDefaults = ToDoThemeDefaults.shared
        if bool {
            toDoUserDefaults.theme = Theme(rawValue: "dark") ?? .dark
        } else {
            toDoUserDefaults.theme = Theme(rawValue: "light") ?? .light
        }

        let allScenes = UIApplication.shared.connectedScenes
        for scene in allScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            windowScene.windows.forEach({$0.overrideUserInterfaceStyle = ToDoThemeDefaults.shared.theme.getUserInterfaceStyle()})
        }
    }

    func loggedOut() {
        let firebaseAuth = Auth.auth()
        let authMangaer = AuthKeychainManager()
        do {
            try? firebaseAuth.signOut()
            authMangaer.clear()
            GIDSignIn.sharedInstance.disconnect()
            NewUserCheck.shared.setIsLoginScrren()
            NewUserCheck.shared.setIsNotFirstStartOnboarding()
            TaskStorageManager.instance.deleteAllEntities()
            UserDefaults.standard.removeObject(forKey: UserDefaultsNames.userAvatar.name)
        }
    }
}
