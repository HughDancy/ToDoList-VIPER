//
//  MockLocalStorage.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 03.08.2024.
//

import UIKit.UIColor
@testable import ToDoList_VIPER

final class MockLocalStorage: ToDosDetailLocalStorageProtocol {
    func editToDoObject(item: ToDoList_VIPER.ToDoObject, newTitle: String, newDescription: String, newDate: Date, color: UIColor, iconName: String) { }
    func deleteTask(_ uid: UUID) {}
}
