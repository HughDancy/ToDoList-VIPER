//
//  MockUsersAvatrs.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 10.06.2024.
//

import Foundation

struct MockUsersAvatrs {
    var imageName: String
}

extension MockUsersAvatrs {
    static let collection = [
    MockUsersAvatrs(imageName: "mockUser_1"),
    MockUsersAvatrs(imageName: "mockUser_2"),
    MockUsersAvatrs(imageName: "mockUser_3"),
    MockUsersAvatrs(imageName: "mockUser_4")
    ]
}
