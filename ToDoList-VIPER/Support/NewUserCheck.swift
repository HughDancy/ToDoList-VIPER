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
        return !(UserDefaults.standard.value(forKey: UserDefaults.Keys.isNewUser) != nil)
    }

    func setIsNotNewUser() {
        UserDefaults.standard.set(false, forKey: UserDefaults.Keys.isNewUser)
    }

    func isOnboardingFirstStart() -> Bool {
        return !UserDefaults.standard.bool(forKey: UserDefaults.Keys.firstStartOnboarding)
    }

    func setIsNotFirstStartOnboarding() {
        return UserDefaults.standard.setValue(true, forKey: UserDefaults.Keys.firstStartOnboarding)
    }

    func isLoginScreen() -> Bool {
        return !UserDefaults.standard.bool(forKey: UserDefaults.Keys.isLoginScreen)
    }

    func setIsLoginScrren() {
        return UserDefaults.standard.setValue(true, forKey:  UserDefaults.Keys.isLoginScreen)
    }
}
