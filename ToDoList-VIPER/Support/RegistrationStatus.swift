//
//  RegistrationStatus.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 22.02.2024.
//

import Foundation

enum RegistrationStatus {
    case complete
    case error
    case notValidEmail
    case connectionLost
    case emptyFields
}
