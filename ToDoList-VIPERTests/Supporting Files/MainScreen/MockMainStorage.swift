//
//  MockMainStorage.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 05.08.2024.
//

import UIKit
@testable import ToDoList_VIPER

final class MockMainStorage: MainScreenLocalStorageProtocol {
    func fetchToDosCount(with status: ToDoList_VIPER.ToDoListStatus) -> Int {
        switch status {
        case .done:
            return 5
        case .overdue:
            return 3
        case .today:
            return 4
        case .tommorow:
            return 6
        }
    }
}
