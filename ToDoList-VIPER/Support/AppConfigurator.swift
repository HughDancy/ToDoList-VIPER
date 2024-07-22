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
    
    func configureApp() -> UIViewController {
        let isNewUser = NewUserCheck.shared.isNewUser()
        
        switch isNewUser {
        case true:
            return AnimationLoadingRouter.createLoadingModule(startOnboardingModule())
        case false:
            return AnimationLoadingRouter.createLoadingModule(startMainModule())
        }
    }
    
    func logOut() -> UIViewController {
         self.startOnboardingModule()
    }
    
    private func startOnboardingModule() -> UIViewController {
        let onboardingState = NewUserCheck.shared.isLoginScreen()
        let firstLaunchOnboardingStatus = NewUserCheck.shared.isOnboardingFirstStart()

        if firstLaunchOnboardingStatus == true {
            UserDefaults.standard.setValue(OnboardingStates.welcome.rawValue, forKey: "onboardingState")
            NewUserCheck.shared.setIsNotFirstStartOnboarding()
        }
        
        if onboardingState == false {
            let loginModule = LoginRouter.createLoginModule()
            let navLoginModule = UINavigationController(rootViewController: loginModule)
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            sceneDelegate.window?.rootViewController = navLoginModule
            return navLoginModule
        } else {
            let onboardingModule = OnboardingRouter.createOnboardingModule()
            return onboardingModule
        }
    }
    
    private func startMainModule() -> UIViewController {
        let currentUser = Auth.auth().currentUser?.uid
        let googleSingInUser = GIDSignIn.sharedInstance.currentUser?.userID
        let currentId = authManager.id
        
        if currentUser == currentId && currentId != nil || currentId == googleSingInUser && currentId != nil && googleSingInUser != nil {
            print(" Start main module. CurrentId is - \(currentId), google id is - \(googleSingInUser). Current user is - \(currentUser)")
            let mainScreen = UINavigationController(rootViewController: MainScreenRouter.createMainScreenModule())
            let optionsScreen = OptionsRouter.createOptionsModule()
            let mainModule = HomeTabBarRouter.createHomeTabBar(tabOne: mainScreen, tabTwo: optionsScreen)
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            sceneDelegate.window?.rootViewController = mainModule
            TaskStorageManager.instance.checkOverdueToDos()
            return mainModule
        } else {
            let loginModule = UINavigationController(rootViewController: LoginRouter.createLoginModule())
            return loginModule
        }
    }
}
