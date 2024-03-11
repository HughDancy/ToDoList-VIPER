//
//  AppConfigurator.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 01.02.2024.
//

import UIKit

final class AppConfigurator {
    static let configuator = AppConfigurator()
    
    func configureApp() -> UIViewController {
        let isNewUser = NewUserCheck.shared.isNewUser()
        
//        print("you is new user? - \(isNewUser)")
        
        switch isNewUser {
        case true:
            return AnimationLoadingRouter.createLoadingModule(startOnboardingModule())
        case false:
            return AnimationLoadingRouter.createLoadingModule(startMainModule())
           
            
        }
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
//            let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
//            appDelegate.window?.rootViewController = navLoginModule
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            sceneDelegate.window?.rootViewController = navLoginModule
            return navLoginModule
        } else {
            let onboardingModule = OnboardingRouter.createOnboardingModule()
            return onboardingModule
        }
    }
    
    private func startMainModule() -> UIViewController {
        let mainModule = HomeTabBarRouter.createHomeTabBar()
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = mainModule
        return mainModule
    }
}
