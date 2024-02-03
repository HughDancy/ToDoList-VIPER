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
        
        switch isNewUser {
        case true:
            return startOnboardingModule()
        case false:
            return startMainModule()
        }
    }
    
    private func startOnboardingModule() -> UIViewController {
        let onboardingState = UserDefaults.standard.string(forKey: "onboardingState")
        let firstLaunchOnboardingStatus = NewUserCheck.shared.isOnboardingFirstStart()
        print(onboardingState)
        if firstLaunchOnboardingStatus == true {
            UserDefaults.standard.setValue(OnboardingStates.welcome.rawValue, forKey: "onboardingState")
            NewUserCheck.shared.setIsNotFirstStartOnboarding()
        }
        
        if onboardingState == OnboardingStates.login.rawValue {
            let loginModule = LoginRouter.createLoginModule()
            return loginModule
        } else {
            let onboardingModule = OnboardingRouter.createOnboardingModule()
            return onboardingModule
        }
    }
    
    private func startMainModule() -> UIViewController {
        let mainModule = HomeTabBarRouter.createHomeTabBar()
        NewUserCheck.shared.setIsNotNewUser()
        return mainModule
    }
}
