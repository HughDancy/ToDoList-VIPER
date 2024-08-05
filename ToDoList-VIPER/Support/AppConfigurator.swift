//
//  AppConfigurator.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 01.02.2024.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

final class AppConfigurator {
    static let configuator = AppConfigurator()
    private let authManager = AuthKeychainManager()
    private let moduleBuilder = AssemblyBuilder()

    func configureApp() -> UIViewController {
        let isNewUser = NewUserCheck.shared.isNewUser()

        switch isNewUser {
        case true:
            return self.startOnboardingModule()
        case false:
            return self.startMainModule()
        }
    }

    func logOut() -> UIViewController {
         self.startOnboardingModule()
    }

    private func startOnboardingModule() -> UIViewController {
        let onboardingState = NewUserCheck.shared.isLoginScreen()
        let firstLaunchOnboardingStatus = NewUserCheck.shared.isOnboardingFirstStart()

        if firstLaunchOnboardingStatus == true {
            UserDefaults.standard.setValue(OnboardingStates.welcome.rawValue, forKey: UserDefaultsNames.onboardingState.name)
            NewUserCheck.shared.setIsNotFirstStartOnboarding()
        }

        if onboardingState == false {
            let loginModule = moduleBuilder.createLoginModule()
            let navLoginModule = UINavigationController(rootViewController: loginModule)
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.window?.rootViewController = navLoginModule
            return navLoginModule
        } else {
            let onboardingModule = moduleBuilder.createOnboardingModule()
            return onboardingModule
        }
    }

    private func startMainModule() -> UIViewController {
        let currentUser = Auth.auth().currentUser?.uid
        let googleSingInUser = GIDSignIn.sharedInstance.currentUser?.userID
        let currentId = authManager.id

        if currentUser == currentId && currentId != nil || currentId == googleSingInUser && currentId != nil && googleSingInUser != nil {
            let moduleBuilder = AssemblyBuilder()
            let mainScreen = UINavigationController(rootViewController: moduleBuilder.createMainScreenModule())
            let optionsScreen = moduleBuilder.createOptionsModule()
            let mainModule = moduleBuilder.createHomeTabBar(tabOne: mainScreen, tabTwo: optionsScreen)
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.window?.rootViewController = mainModule
            TaskStorageManager.instance.checkOverdueToDos()
            UserDefaults.standard.setValue(false, forKey: UserDefaultsNames.firstWorkLaunch.name)
            return mainModule
        } else {
            let loginModule = UINavigationController(rootViewController: moduleBuilder.createLoginModule())
            return loginModule
        }
    }
}
