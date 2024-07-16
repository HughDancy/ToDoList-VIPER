//
//  NewUserCheck.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 15.01.2024.
//

import Foundation

final class NewUserCheck {
    static let shared = NewUserCheck()
    
    func isNewUser() -> Bool {
        return !(UserDefaults.standard.value(forKey: "isNewUser") != nil)
    }
    
    func setIsNotNewUser()  {
        UserDefaults.standard.set(false, forKey: "isNewUser")
    }
    
//    func setIsNewUser() {
//        UserDefaults.standard.set(false, forKey: "isNewUser")
//    }
    
    func isOnboardingFirstStart() -> Bool {
        return !UserDefaults.standard.bool(forKey: "firstStartOnboarding")
    }
    
    func setIsNotFirstStartOnboarding() {
        return UserDefaults.standard.setValue(true, forKey: "firstStartOnboarding")
    }
    
    func isLoginScreen() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isLoginScreen")
    }
    
    func setIsLoginScrren() {
        return UserDefaults.standard.setValue(true, forKey: "isLoginScreen")
    }
}
