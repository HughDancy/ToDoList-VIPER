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
 
    //MARK: - Properties
    var presenter: OptionsOutputInteractorProtocol?
    let firebaseAuth = Auth.auth()
    private var toDoUserDefaults = ToDoUserDefaults.shares
    private var authMangaer = AuthKeychainManager()
    
    //MARK: - Interactor Methods
    func fetchOptionsData() {
        let optionsData = ["Сменить тему", "Обратная связь", "Выход"]
        presenter?.getOptionsData(optionsData)
    }
    
    func fetchUserData() {
        guard let userName = UserDefaults.standard.string(forKey: NotificationNames.userName.rawValue),
              let userAvatar = UserDefaults.standard.url(forKey: "UserAvatar") else {
            presenter?.getUserData(("User", nil))
            return
        }
        presenter?.getUserData((userName, userAvatar))
    }
    
    func changeTheme(_ bool: Bool) {
        if bool {
                 toDoUserDefaults.theme = Theme(rawValue: "dark") ?? .dark
             } else {
                 toDoUserDefaults.theme = Theme(rawValue: "light") ?? .light
             }
             
             let allScenes = UIApplication.shared.connectedScenes
             for scene in allScenes {
                 guard let windowScene = scene as? UIWindowScene else { continue }
                 windowScene.windows.forEach({$0.overrideUserInterfaceStyle = ToDoUserDefaults.shares.theme.getUserInterfaceStyle()})
             }
    }
    
    
    func loggedOut() {
        do {
            try? firebaseAuth.signOut()
            authMangaer.clear()
            GIDSignIn.sharedInstance.disconnect()
        } catch {
            print("Some error when logged out from Options screen")
        }
    }
    
}
