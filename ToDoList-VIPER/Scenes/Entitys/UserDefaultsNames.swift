//
//  UserDefaultsNames.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 05.08.2024.
//

import Foundation

public enum UserDefaultsNames: String {
    case userName = "UserName"
    case userAvatar = "UserAvatar"
    case isNewUser = "isNewUser"
    case firstStartOnboarding = "firstStartOnboarding"
    case isLoginScreen = "isLoginScreen"
    case onboardingState = "onboardingState"
    case selectedTheme = "selectedTheme"
    case lastOverdueRefresh = "lastOverdueRefresh"
    case firstWorkLaunch = "FirstWorkLaunch"

    var name: String {
        self.rawValue
    }
}
