//
//  MockMainScreenServerStorage.swift
//  ToDoList-VIPERTests
//
//  Created by Борис Киселев on 05.08.2024.
//

import Foundation
@testable import ToDoList_VIPER

final class MockMainScreenServerStorage: MainScreenServerStorageProtocol {
    func newLoadAvatar(compelition: @escaping (URL?) -> Void) { }
}
