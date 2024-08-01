//
//  NotificationNames.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 07.05.2024.
//

import Foundation

public enum NotificationNames: String {
    case updateTables = "UpdateTables"
    case updateMainScreen = "UpdateMainScreenData"
    case updateUserData = "UpdateUserData"
    case doneToDo = "DoneTask"
    case tapEditButton = "TapEditButton"
    case googleSignIn = "GoogleSignIn"
    case userName = "UserName"

    var name: Notification.Name {
        Notification.Name(rawValue: rawValue)
    }
}
