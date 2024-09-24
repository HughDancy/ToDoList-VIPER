//
//  UserDefaults + EXT.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 24.09.2024.
//

import Foundation

extension UserDefaults {
    struct Keys {
    static let userName = "UserName"
    static let userAvatar = "UserAvatar"
    static let isNewUser = "isNewUser"
    static let firstStartOnboarding = "firstStartOnboarding"
    static let isLoginScreen = "isLoginScreen"
    static let onboardingState = "onboardingState"
    static let selectedTheme = "selectedTheme"
    static let lastOverdueRefresh = "lastOverdueRefresh"
    static let firstWorkLaunch = "FirstWorkLaunch"
    }
}
