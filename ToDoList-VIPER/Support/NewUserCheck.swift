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
        return !(UserDefaults.standard.value(forKey: UserDefaultsNames.isNewUser.name) != nil)
    }

    func setIsNotNewUser() {
        UserDefaults.standard.set(false, forKey: UserDefaultsNames.isNewUser.name)
    }

    func isOnboardingFirstStart() -> Bool {
        return !UserDefaults.standard.bool(forKey: UserDefaultsNames.firstStartOnboarding.name)
    }

    func setIsNotFirstStartOnboarding() {
        return UserDefaults.standard.setValue(true, forKey: UserDefaultsNames.firstStartOnboarding.name)
    }

    func isLoginScreen() -> Bool {
        return !UserDefaults.standard.bool(forKey: UserDefaultsNames.isLoginScreen.name)
    }

    func setIsLoginScrren() {
        return UserDefaults.standard.setValue(true, forKey: UserDefaultsNames.isLoginScreen.name)
    }
}
