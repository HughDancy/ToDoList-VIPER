//
//  MockServerStorage.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 03.08.2024.
//

import Foundation
@testable import ToDoList_VIPER

final class MockServerStorage: ToDoSDetailServerStorageProtocol {
    func uploadChanges(task: ToDoList_VIPER.ToDoTask) {}
    
    func deleteTaskFromServer(_ id: String) {}
    
}
